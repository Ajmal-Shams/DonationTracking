<%@page import="DonationTracking.SQLconnection" %>
    <%@page import="java.sql.*" %>
        <%@page import="java.io.*" %>
            <%@page import="java.util.Base64" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <title>B64</title>
                </head>

                <body>
                    <h1>Base64 v2</h1>
                    <% String id=request.getParameter("id"); if(id==null) id="3" ; out.println("ID: " + id + " <br>");

                        Connection con = null;
                        try {
                        con = SQLconnection.getconnection();
                        Statement st = con.createStatement();
                        String q = "select CampPic from "
                        + "campaign where id='" + id + "'";
                        ResultSet rs = st.executeQuery(q);

                        if(rs.next()){
                        Blob b = rs.getBlob("CampPic");
                        if(b!=null){
                        int len = (int)b.length();
                        byte[] d = b.getBytes(1, len);
                        String b64 = Base64.getEncoder()
                        .encodeToString(d);
                        out.println("Img bytes: " + len + "<br>");
                        %>
                        <img src="data:image/jpeg;base64,<%=b64%>" style="border:2px solid red;width:300px" />
                        <% } else { out.println("Blob NULL<br>");
                            }
                            } else {
                            out.println("No Row<br>");
                            }
                            } catch(Exception e){
                            e.printStackTrace(new PrintWriter(out));
                            } finally {
                            try{if(con!=null)con.close();}catch(Exception e){}
                            }
                            %>
                </body>

                </html>