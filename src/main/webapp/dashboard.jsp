<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>

<%
    ServletContext ctx = getServletContext();
    String userEmail = (String) ctx.getAttribute("userEmail");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String adminName = null;
    String adminId = null;

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish a connection
        String url = "jdbc:mysql://localhost:3306/lecturely";
        conn = DriverManager.getConnection(url, "root", "");

        // Query to fetch the attributes of the lecturer with the given email
        String fetchLecturerQuery = "SELECT * FROM admins WHERE email = ?";
        pstmt = conn.prepareStatement(fetchLecturerQuery);
        pstmt.setString(1, userEmail);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            adminName = rs.getString("fullname");
            adminId = rs.getString("admin_id");
        } else {
            out.println("<div class='toast error'>Error: Not Authorized, Admin Priviledges required</div>");
            response.sendRedirect("./login.jsp");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<div class='toast error'>A server error occurred.</div>");
        response.sendRedirect("./login.jsp");
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException se) {
            se.printStackTrace();
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin | Lecturely</title>
        <link rel="stylesheet" type="text/css" href="./dash.css">
    </head>
    <body>
        <aside>
            <div id="logo_div">
                <img alt="lecturely logo" src="./logo.png"/>
                <i>ecturely</i>
            </div>
            <div class='buttons'>
                <a href="./dashboard.jsp">Dashboard</a>
                <hr />
                <a href="./view-lecturers.jsp">View Lecturers</a>
                <hr />
                <a href="./new-lecturer.jsp">Add New Lecturer</a>
            </div>
            <button onclick="navigate('./')">Logout</button>
        </aside>
        <main>
            <h1>Administrator Dashboard</h1>
            <h2>Welcome <%=adminName%>!</h2>
            <div class="dash_panel_top">
                <a href="./view-lecturers.jsp" style="background: #28a745">
                        <p>View Registered Lecturers</p>
                </a>
                <a href="./new-lecturer.jsp" style="background: #6666ff">
                        <p>Add Lecturer</p>
                 </a>
            </div>
            <h3>Stats</h3>
            <div class="dash_panel_bottom">
                <div onclick="navigate('./admin-signup.jsp')" style="background: yellow; cursor: pointer">
                    <p>Add New Administrator</p>
                </div>
                <div>
                    <p>10 Registered Admins</p>
                </div>
            </div>
        </main>
        <script>
            function navigate(url){
                 window.location.href = url;
            }
        </script>
    </body>
</html>
