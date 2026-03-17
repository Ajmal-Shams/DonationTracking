<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="DonationTracking.SQLconnection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Connection con = SQLconnection.getconnection();
    Statement st = con.createStatement();

    // 1. Counts for overview
    ResultSet r1 = st.executeQuery("SELECT COUNT(*) AS cnt FROM donor_reg");
    r1.next(); int totalDonors = r1.getInt("cnt");

    Statement st2 = con.createStatement();
    ResultSet r2 = st2.executeQuery("SELECT COUNT(*) AS cnt FROM charity_reg");
    r2.next(); int totalCharities = r2.getInt("cnt");

    Statement st3 = con.createStatement();
    ResultSet r3 = st3.executeQuery("SELECT COUNT(*) AS cnt FROM campaign");
    r3.next(); int totalCampaigns = r3.getInt("cnt");

    Statement st4 = con.createStatement();
    ResultSet r4 = st4.executeQuery("SELECT COUNT(*) AS cnt FROM `transaction`");
    r4.next(); int totalTransactions = r4.getInt("cnt");

    // 2. Donations by status (for pie chart)
    Statement st5 = con.createStatement();
    ResultSet r5 = st5.executeQuery("SELECT donationStatus, COUNT(*) AS cnt FROM `transaction` GROUP BY donationStatus");
    StringBuilder statusLabels = new StringBuilder();
    StringBuilder statusData = new StringBuilder();
    boolean first = true;
    while (r5.next()) {
        if (!first) { statusLabels.append(","); statusData.append(","); }
        statusLabels.append("\"").append(r5.getString("donationStatus")).append("\"");
        statusData.append(r5.getInt("cnt"));
        first = false;
    }

    // 3. Donations by district (for bar chart)
    Statement st6 = con.createStatement();
    ResultSet r6 = st6.executeQuery("SELECT p.district, COUNT(t.id) AS cnt, COALESCE(SUM(CAST(t.amount AS DECIMAL(10,2))),0) AS total_amt FROM `transaction` t LEFT JOIN panchayat p ON t.panchayat_id = p.id WHERE p.district IS NOT NULL AND p.district != '' GROUP BY p.district ORDER BY total_amt DESC");
    StringBuilder distLabels = new StringBuilder();
    StringBuilder distCountData = new StringBuilder();
    StringBuilder distAmtData = new StringBuilder();
    first = true;
    while (r6.next()) {
        if (!first) { distLabels.append(","); distCountData.append(","); distAmtData.append(","); }
        distLabels.append("\"").append(r6.getString("district")).append("\"");
        distCountData.append(r6.getInt("cnt"));
        distAmtData.append(r6.getDouble("total_amt"));
        first = false;
    }

    // 4. Campaign goal vs collected (for horizontal bar)
    Statement st7 = con.createStatement();
    ResultSet r7 = st7.executeQuery("SELECT campName, Amount, AmountCol FROM campaign ORDER BY Amount DESC LIMIT 10");
    StringBuilder campLabels = new StringBuilder();
    StringBuilder campGoal = new StringBuilder();
    StringBuilder campCollected = new StringBuilder();
    first = true;
    while (r7.next()) {
        if (!first) { campLabels.append(","); campGoal.append(","); campCollected.append(","); }
        String name = r7.getString("campName");
        if (name.length() > 20) name = name.substring(0, 20) + "...";
        campLabels.append("\"").append(name.replace("\"", "\\\"")).append("\"");
        campGoal.append(r7.getDouble("Amount"));
        campCollected.append(r7.getDouble("AmountCol"));
        first = false;
    }

    // 5. Monthly donation trend (for line chart)
    Statement st8 = con.createStatement();
    ResultSet r8 = st8.executeQuery("SELECT DATE_FORMAT(STR_TO_DATE(TofPayement, '%Y/%m/%d %H:%i:%s'), '%Y-%m') AS mon, COUNT(*) AS cnt, COALESCE(SUM(CAST(amount AS DECIMAL(10,2))),0) AS total_amt FROM `transaction` WHERE TofPayement IS NOT NULL GROUP BY mon ORDER BY mon");
    StringBuilder monthLabels = new StringBuilder();
    StringBuilder monthCount = new StringBuilder();
    StringBuilder monthAmt = new StringBuilder();
    first = true;
    while (r8.next()) {
        String mon = r8.getString("mon");
        if (mon == null || mon.isEmpty()) continue;
        if (!first) { monthLabels.append(","); monthCount.append(","); monthAmt.append(","); }
        monthLabels.append("\"").append(mon).append("\"");
        monthCount.append(r8.getInt("cnt"));
        monthAmt.append(r8.getDouble("total_amt"));
        first = false;
    }

    // 6. Charities per district (for doughnut)
    Statement st9 = con.createStatement();
    ResultSet r9 = st9.executeQuery("SELECT p.district, COUNT(c.id) AS cnt FROM charity_reg c LEFT JOIN panchayat p ON c.panchayat_id = p.id WHERE p.district IS NOT NULL AND p.district != '' GROUP BY p.district ORDER BY cnt DESC");
    StringBuilder charDistLabels = new StringBuilder();
    StringBuilder charDistData = new StringBuilder();
    first = true;
    while (r9.next()) {
        if (!first) { charDistLabels.append(","); charDistData.append(","); }
        charDistLabels.append("\"").append(r9.getString("district")).append("\"");
        charDistData.append(r9.getInt("cnt"));
        first = false;
    }

    // 7. Payment method breakdown (for polar area)
    Statement st10 = con.createStatement();
    ResultSet r10 = st10.executeQuery("SELECT payment, COUNT(*) AS cnt FROM `transaction` GROUP BY payment");
    StringBuilder payLabels = new StringBuilder();
    StringBuilder payData = new StringBuilder();
    first = true;
    while (r10.next()) {
        if (!first) { payLabels.append(","); payData.append(","); }
        payLabels.append("\"").append(r10.getString("payment")).append("\"");
        payData.append(r10.getInt("cnt"));
        first = false;
    }
%>
<!DOCTYPE html>
<html class="no-js">
<head>
    <meta charset="utf-8">
    <title>DONATION TRACKING SYSTEM - Analytics</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,700' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Dosis:400,700' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <script src="assets/js/modernizr-2.6.2.min.js"></script>
    <style>
        .stat-box { background: #fff; border-radius: 8px; padding: 20px; text-align: center; box-shadow: 0 2px 10px rgba(0,0,0,0.1); margin-bottom: 20px; }
        .stat-box h2 { font-size: 36px; margin: 0; font-weight: 700; }
        .stat-box p { margin: 5px 0 0; color: #777; font-size: 14px; }
        .stat-box .fa { font-size: 28px; margin-bottom: 10px; }
        .chart-box { background: #fff; border-radius: 8px; padding: 20px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); margin-bottom: 30px; }
        .chart-box h4 { text-align: center; margin-bottom: 15px; color: #333; }
        .stat-donors { color: #3498db; }
        .stat-charities { color: #e74c3c; }
        .stat-campaigns { color: #f39c12; }
        .stat-transactions { color: #27ae60; }
    </style>
</head>
<body>
    <header class="main-header">
        <nav class="navbar navbar-static-top">
            <div class="navbar-top">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-6 col-xs-12">
                            <ul class="list-unstyled list-inline header-contact">
                                <li><i class="fa fa-phone"></i> <a href="tel:">+61 123456789</a></li>
                                <li><i class="fa fa-envelope"></i> <a href="#">contact@DONATION.org</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="navbar-main">
                <div class="container">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand" href="Admin_home.jsp">DONATION TRACKING SYSTEM</a>
                    </div>
                    <div id="navbar" class="navbar-collapse collapse pull-right">
                        <ul class="nav navbar-nav">
                            <li><a href="Admin_home.jsp">HOME</a></li>
                            <li><a href="Donor_Details.jsp">Donor Details</a></li>
                            <li><a href="Charity_Details.jsp">Charity Details</a></li>
                            <li><a href="Donations_Details.jsp">Donations</a></li>
                            <li><a href="Campaigns_Details.jsp">Campaigns</a></li>
                            <li><a href="ATransactions.jsp">Transactions</a></li>
                            <li><a class="is-active" href="Graph.jsp">Graph</a></li>
                            <li><a href="logout.jsp">Logout</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </nav>
    </header>

    <div class="page-heading text-center">
        <div class="container">
            <h1 class="page-title">Analytics Dashboard<span class="title-under"></span></h1>
        </div>
    </div>

    <div class="main-container">
        <div class="container">

            <!-- Overview Stats -->
            <div class="row">
                <div class="col-md-3 col-sm-6">
                    <div class="stat-box">
                        <i class="fa fa-users stat-donors"></i>
                        <h2 class="stat-donors"><%=totalDonors%></h2>
                        <p>Total Donors</p>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="stat-box">
                        <i class="fa fa-heart stat-charities"></i>
                        <h2 class="stat-charities"><%=totalCharities%></h2>
                        <p>Total Charities</p>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="stat-box">
                        <i class="fa fa-bullhorn stat-campaigns"></i>
                        <h2 class="stat-campaigns"><%=totalCampaigns%></h2>
                        <p>Total Campaigns</p>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="stat-box">
                        <i class="fa fa-exchange stat-transactions"></i>
                        <h2 class="stat-transactions"><%=totalTransactions%></h2>
                        <p>Total Transactions</p>
                    </div>
                </div>
            </div>

            <!-- Row 1: Donation Status Pie + Payment Method Polar -->
            <div class="row">
                <div class="col-md-6">
                    <div class="chart-box">
                        <h4>Donation Status Breakdown</h4>
                        <canvas id="statusPieChart"></canvas>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="chart-box">
                        <h4>Payment Methods</h4>
                        <canvas id="paymentChart"></canvas>
                    </div>
                </div>
            </div>

            <!-- Row 2: Donations by District Bar -->
            <div class="row">
                <div class="col-md-12">
                    <div class="chart-box">
                        <h4>Donation Amount by District</h4>
                        <canvas id="districtBarChart" height="100"></canvas>
                    </div>
                </div>
            </div>

            <!-- Row 3: Campaign Progress + Monthly Trend -->
            <div class="row">
                <div class="col-md-6">
                    <div class="chart-box">
                        <h4>Top 10 Campaigns - Goal vs Collected</h4>
                        <canvas id="campaignBarChart"></canvas>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="chart-box">
                        <h4>Monthly Donation Trend</h4>
                        <canvas id="monthlyLineChart"></canvas>
                    </div>
                </div>
            </div>

            <!-- Row 4: Charities per District Doughnut + Transaction Count by District -->
            <div class="row">
                <div class="col-md-6">
                    <div class="chart-box">
                        <h4>Charities per District</h4>
                        <canvas id="charityDoughnutChart"></canvas>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="chart-box">
                        <h4>Transaction Count by District</h4>
                        <canvas id="districtCountChart"></canvas>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <footer class="main-footer">
        <div class="footer-bottom">
            <div class="container text-right">DONATION TRACKING SYSTEM</div>
        </div>
    </footer>

    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script>window.jQuery || document.write('<script src="assets/js/jquery-1.11.1.min.js"><\/script>')</script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/js/main.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>
    <script>
        var colors = ['#3498db','#e74c3c','#f39c12','#27ae60','#9b59b6','#1abc9c','#e67e22','#2c3e50','#d35400','#c0392b','#16a085','#8e44ad','#2980b9','#f1c40f'];

        // 1. Donation Status Pie
        new Chart(document.getElementById('statusPieChart'), {
            type: 'pie',
            data: {
                labels: [<%=statusLabels.toString()%>],
                datasets: [{
                    data: [<%=statusData.toString()%>],
                    backgroundColor: colors
                }]
            },
            options: { responsive: true, plugins: { legend: { position: 'bottom' } } }
        });

        // 2. Payment Method Polar Area
        new Chart(document.getElementById('paymentChart'), {
            type: 'polarArea',
            data: {
                labels: [<%=payLabels.toString()%>],
                datasets: [{
                    data: [<%=payData.toString()%>],
                    backgroundColor: colors.map(function(c){ return c + 'CC'; })
                }]
            },
            options: { responsive: true, plugins: { legend: { position: 'bottom' } } }
        });

        // 3. District Bar Chart (Amount)
        new Chart(document.getElementById('districtBarChart'), {
            type: 'bar',
            data: {
                labels: [<%=distLabels.toString()%>],
                datasets: [{
                    label: 'Total Donation Amount ($)',
                    data: [<%=distAmtData.toString()%>],
                    backgroundColor: '#3498db',
                    borderRadius: 4
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { display: false } },
                scales: { y: { beginAtZero: true, ticks: { callback: function(v){ return '$' + v; } } } }
            }
        });

        // 4. Campaign Goal vs Collected (Horizontal Bar)
        new Chart(document.getElementById('campaignBarChart'), {
            type: 'bar',
            data: {
                labels: [<%=campLabels.toString()%>],
                datasets: [
                    { label: 'Goal ($)', data: [<%=campGoal.toString()%>], backgroundColor: '#bdc3c7', borderRadius: 4 },
                    { label: 'Collected ($)', data: [<%=campCollected.toString()%>], backgroundColor: '#27ae60', borderRadius: 4 }
                ]
            },
            options: {
                indexAxis: 'y',
                responsive: true,
                plugins: { legend: { position: 'top' } },
                scales: { x: { beginAtZero: true, ticks: { callback: function(v){ return '$' + v; } } } }
            }
        });

        // 5. Monthly Donation Trend (Line)
        new Chart(document.getElementById('monthlyLineChart'), {
            type: 'line',
            data: {
                labels: [<%=monthLabels.toString()%>],
                datasets: [
                    {
                        label: 'Amount ($)',
                        data: [<%=monthAmt.toString()%>],
                        borderColor: '#e74c3c',
                        backgroundColor: 'rgba(231,76,60,0.1)',
                        fill: true,
                        tension: 0.3,
                        yAxisID: 'y'
                    },
                    {
                        label: 'No. of Transactions',
                        data: [<%=monthCount.toString()%>],
                        borderColor: '#3498db',
                        backgroundColor: 'rgba(52,152,219,0.1)',
                        fill: true,
                        tension: 0.3,
                        yAxisID: 'y1'
                    }
                ]
            },
            options: {
                responsive: true,
                plugins: { legend: { position: 'top' } },
                scales: {
                    y: { beginAtZero: true, position: 'left', ticks: { callback: function(v){ return '$' + v; } } },
                    y1: { beginAtZero: true, position: 'right', grid: { drawOnChartArea: false } }
                }
            }
        });

        // 6. Charities per District (Doughnut)
        new Chart(document.getElementById('charityDoughnutChart'), {
            type: 'doughnut',
            data: {
                labels: [<%=charDistLabels.toString()%>],
                datasets: [{
                    data: [<%=charDistData.toString()%>],
                    backgroundColor: colors
                }]
            },
            options: { responsive: true, plugins: { legend: { position: 'bottom' } } }
        });

        // 7. Transaction Count by District (Radar-style bar)
        new Chart(document.getElementById('districtCountChart'), {
            type: 'radar',
            data: {
                labels: [<%=distLabels.toString()%>],
                datasets: [{
                    label: 'No. of Transactions',
                    data: [<%=distCountData.toString()%>],
                    backgroundColor: 'rgba(155,89,182,0.2)',
                    borderColor: '#9b59b6',
                    pointBackgroundColor: '#9b59b6'
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { position: 'top' } },
                scales: { r: { beginAtZero: true } }
            }
        });
    </script>
</body>
</html>
