<%@page import="DonationTracking.SQLconnection,java.sql.*,java.text.*,java.util.*" %>
    <% String[] h=null; try { h=new String[] { "did" , "dname" , "campid" , "cid" , "cname" , "request_donation.jsp"
        , "?SessionError" , "?Cooldown=" , "?Sent" , "?InsertFailed" , "?CampaignNotFound" , "?DBConnectionError"
        , "?Error="
        , "SELECT\u0020COUNT(*)\u0020AS\u0020total,\u0020MAX(reqTime)\u0020AS\u0020last\u0020FROM\u0020donation_req\u0020WHERE\u0020cid='"
        , "'\u0020AND\u0020did='" , "'" , "yyyy/MM/dd\u0020HH:mm:ss" , "total" , "last"
        , "SELECT\u0020*\u0020FROM\u0020campaign\u0020WHERE\u0020id='" , "campName" , "Amount"
        , "INSERT\u0020INTO\u0020donation_req(cid,cname,campid,campname,amount,did,dname,reqStatus,reqTime)\u0020VALUES('"
        , "Waiting" , "','" , "')" , "Amount" , "AmountCol" }; String did=request.getParameter(h[0]); String
        dname=request.getParameter(h[1]); String campid=request.getParameter(h[2]); Object
        cidO=session.getAttribute(h[3]); Object cnameO=session.getAttribute(h[4]); if (cidO==null || cnameO==null) {
        response.sendRedirect(h[5] + h[6]); return; } String cid=cidO.toString(); String cname=cnameO.toString();
        java.sql.Connection con=DonationTracking.SQLconnection.getconnection(); if (con !=null) { java.sql.Statement
        st=con.createStatement(); int reqC=0; String lastT="" ; java.sql.ResultSet crs=st.executeQuery(h[13] + cid +
        h[14] + did + h[15]); if (crs.next()) { reqC=crs.getInt(h[17]); lastT=crs.getString(h[18]); } if (reqC> 0 &&
        lastT != null && !lastT.isEmpty()) {
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(h[16]);
        java.util.Date lastD = sdf.parse(lastT);
        long dMs = (new java.util.Date()).getTime() - lastD.getTime();
        long dMin = dMs / (60L * 1000L);
        int wMin = 5;
        if (reqC == 2) wMin = 10;
        else if (reqC >= 3) wMin = 20;

        if (dMin < (long) wMin) { response.sendRedirect(h[5] + h[7] + (wMin - (int) dMin)); return; } }
            java.sql.ResultSet rs=st.executeQuery(h[19] + campid + h[15]); if (rs.next()) { int tot=rs.getInt(h[26]);
            int col=rs.getInt(h[27]); if (tot>0 && col>=tot) { response.sendRedirect(h[5] + "?GoalReached"); return; }
            String cN=rs.getString(h[20]); String a=rs.getString(h[21]); java.text.SimpleDateFormat df=new
            java.text.SimpleDateFormat(h[16]); String t=df.format(new java.util.Date()); String iq=h[22] + cid + h[24] +
            cname + h[24] + campid + h[24] + cN + h[24] + a + h[24] + did + h[24] + dname + h[24] + h[23] + h[24] + t +
            h[25]; int i=st.executeUpdate(iq); if (i !=0) { response.sendRedirect(h[5] + h[8]); } else {
            response.sendRedirect(h[5] + h[9]); } } else { response.sendRedirect(h[5] + h[10]); } } else {
            response.sendRedirect(h[5] + h[11]); } } catch (Exception ex) { ex.printStackTrace(); String em=(h !=null &&
            ex.getMessage() !=null) ? java.net.URLEncoder.encode(ex.getMessage()) : "" ; if (h !=null)
            response.sendRedirect(h[5] + h[12] + em); } %>