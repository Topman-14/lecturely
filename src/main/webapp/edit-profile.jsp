<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>

<%
    // Retrieve lecturer ID from request parameters
    String lecturerId = request.getParameter("lecturer_id");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish a connection
        String url = "jdbc:mysql://localhost:3306/lecturely";
        conn = DriverManager.getConnection(url, "root", "");

        // Execute SQL query to fetch lecturer details based on ID
        String sql = "SELECT * FROM lecturers WHERE lecturer_id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, lecturerId);
        rs = pstmt.executeQuery();

        if (rs.next()) {
%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Update Lecturer | Lecturely</title>
    <link rel="stylesheet" type="text/css" href="./dash.css">
    <style>
        .details_wrapper {
            background: #fff;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
            border-radius: 25px;
            color: #1a1a1a;
            height: calc(100% - 200px);
            padding: 20px;
            display: flex;
            justify-content: space-between;
            flex-direction: column;
        }

        .form_group {
            font-size: 1.4em;
            font-weight: 700;
            display: flex;
            padding: 10px;
            line-height: 1.6em;
        }

        .form_group>label, .form_group>input {
            width: 100%;
            margin: 0;
        }

        .form_group> input {
            border: 0;
            border-radius: 7px;
            background: antiquewhite;
            transition: 0.25s;
            border-bottom: 2px solid transparent;
            padding-left: 7px;
        }

        .form_group> input:focus {
            border-bottom: 2px solid maroon;
            outline: none;
        }

        .save_btn {
            border: none;
            border-radius: 12px;
            padding: 10px;
            font-size: 1.4em;
            cursor: pointer;
            font-family: "Trebuchet Ms";
            background: #4caf50;
            color: #fff;
            margin: 0 10px 0 auto;
            display: block;
        }
    </style>
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
        <a href="./lecturer-profile.jsp?lecturer_id=<%=lecturerId%>">Your Profile</a>
    </div>
    <button onclick="navigate('./')">Logout</button>
    </aside>
<main>
    <h2>Update Lecturer</h2>
    <div class="details_wrapper">
        <form method="post" action="">
            <div class="form_group">
                <label>First Name</label>
                <input type="text" name="first_name" value="<%= rs.getString("first_name") %>" required/>
            </div>
            <div class="form_group">
                <label>Last Name</label>
                <input type="text" name="last_name" value="<%= rs.getString("last_name") %>" required/>
            </div>
            <div class="form_group">
                <label>Email</label>
                <input type="email" name="email" value="<%= rs.getString("email") %>" required/>
            </div>
            <div class="form_group">
                <label>Phone Number</label>
                <input type="tel" name="phone_no" value="<%= rs.getString("phone_no") %>" required/>
            </div>
            <div class="form_group">
                <label>Department</label>
                <input type="text" name="department" value="<%= rs.getString("department") %>" required/>
            </div>
            <input type="hidden" name="lecturer_id" value="<%= lecturerId %>"/>
            <input type="submit" value="Save" class="save_btn"/>
        </form>
    </div>

    <%
    } else {
        // Handle the case where no lecturer with the given ID is found
        out.println("<p>No lecturer found with ID: " + lecturerId + "</p>");
    }
    %>

    </main>
    <script>
        function navigate(url){
             window.location.href = url;
        }
    </script>
    </body>
    </html>

    <%
    } catch (Exception e) {
        e.printStackTrace();
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
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>

<%
    if (request.getMethod().equalsIgnoreCase("post")) {
        String lecturerIdPost = request.getParameter("lecturer_id");
        String firstName = request.getParameter("first_name");
        String lastName = request.getParameter("last_name");
        String email = request.getParameter("email");
        String phoneNo = request.getParameter("phone_no");
        String department = request.getParameter("department");

        Connection connPost = null;
        PreparedStatement pstmtPost = null;

        try {
            // Load the JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish a connection
            String url = "jdbc:mysql://localhost:3306/lecturely";
            connPost = DriverManager.getConnection(url, "root", "");

            // Update the lecturer details in the database
            String updateQuery = "UPDATE lecturers SET first_name=?, last_name=?, email=?, phone_no=?, department=? WHERE lecturer_id=?";
            pstmtPost = connPost.prepareStatement(updateQuery);
            pstmtPost.setString(1, firstName);
            pstmtPost.setString(2, lastName);
            pstmtPost.setString(3, email);
            pstmtPost.setString(4, phoneNo);
            pstmtPost.setString(5, department);
            pstmtPost.setString(6, lecturerIdPost);
            pstmtPost.executeUpdate();

            // Redirect back to view-lecturers.jsp after successful update
            response.sendRedirect("./lecturer-profile.jsp?lecturer_id=" + lecturerIdPost);

        } catch (Exception e) {
            e.printStackTrace();
            out.println("Update failed. An error occurred while processing the update request.");
        } finally {
            try {
                if (pstmtPost != null) pstmtPost.close();
                if (connPost != null) connPost.close();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
    }
%>
