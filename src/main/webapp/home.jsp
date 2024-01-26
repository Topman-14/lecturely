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
    String lecturerName = null;
    String lecturer_id = null;

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish a connection
        String url = "jdbc:mysql://localhost:3306/lecturely";
        conn = DriverManager.getConnection(url, "root", "");

        // Query to fetch the attributes of the lecturer with the given email
        String fetchLecturerQuery = "SELECT * FROM lecturers WHERE email = ?";
        pstmt = conn.prepareStatement(fetchLecturerQuery);
        pstmt.setString(1, userEmail);
        rs = pstmt.executeQuery();

        if (rs.next()) {
        lecturerName = rs.getString("first_name") + " " + rs.getString("last_name");
        lecturer_id = rs.getString("lecturer_id");
        } else {
            response.sendRedirect("./login.jsp");
            return;
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
        <title>Dashboard | Lecturely</title>
        <link rel="stylesheet" type="text/css" href="./dash.css">
    </head>
    <body>
        <aside>
            <div id="logo_div">
                <img alt="lecturely logo" src="./logo.png"/>
                <i>ecturely</i>
            </div>
            <div class='buttons'>
                <a href="./dashboard.jsp">Home</a>
                <hr />
<!--                <a href="./courses.jsp">Courses</a>
                <hr />-->
                <a href="./lecturer-profile.jsp?lecturer_id=<%=lecturer_id%>">Your Profile</a>
            </div>
            <button onclick="navigate('./')">Logout</button>
        </aside>
        <main>
            <h1>Dashboard</h1>
            <h2>Welcome Lecturer <%=lecturerName%> </h2>
            <div class="dash_panel_top">
                <a href="./lecturer-profile.jsp?lecturer_id=<%=lecturer_id%>" style="background: #6666ff">
                        <p>View your Profile</p>
                 </a>
                <a href="./edit-profile.jsp?lecturer_id=<%=lecturer_id%>" style="background: #28a745">
                        <p>Edit Profile</p>
                </a>
            </div>
        </main>
        <script>
            function navigate(url){
                 window.location.href = url;
            }
        </script>
    </body>
</html>
