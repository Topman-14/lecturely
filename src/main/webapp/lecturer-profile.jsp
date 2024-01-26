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
    Statement stmt = null;
    ResultSet rs = null;

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish a connection
        String url = "jdbc:mysql://localhost:3306/lecturely";
        conn = DriverManager.getConnection(url, "root", "");

        // Execute SQL query to fetch lecturer details based on ID
        stmt = conn.createStatement();
        String sql = "SELECT * FROM lecturers WHERE lecturer_id = '" + lecturerId + "'";
        rs = stmt.executeQuery(sql);

%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Lecturer Details | Lecturely</title>
    <link rel="stylesheet" type="text/css" href="./dash.css">
    <style>
        .details_wrapper{
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
        .field_group{
            font-size: 1.4em;
            font-weight: 700;
            display: flex;
            padding: 10px;
            line-height: 1.6em;
        }
        .field_group:nth-child(even){
            background: #ffe;
        }
        .field_group>p{
            width: 100%;
            margin: 0;
        }
        .action_btns{
            display: flex;
            gap: 15px;
            justify-content: flex-end;
        }
        .action_btns> button{
            border: none;
            border-radius: 7px;
            padding: 10px;
            font-size: 1.4em;
            cursor:pointer;
            font-family: "Trebuchet Ms";
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
        <%
            if (rs.next()) {
        %>
        <h2>Lecturer Details</h2>
        <div class="details_wrapper">
            <div class="details" >
                <div class="field_group">
                    <p>First Name:</p>
                    <p><%= rs.getString("first_name") %></p>
                </div>
                <div class="field_group">
                    <p>Last Name:</p>
                    <p><%= rs.getString("last_name") %></p>
                </div>
                <div class="field_group">
                    <p>Email:</p>
                    <p><%= rs.getString("email") %></p>
                </div>
                <div class="field_group">
                    <p>Phone Number:</p>
                    <p><%= rs.getString("phone_no") %></p>
                </div>
                <div class="field_group">
                    <p>Department:</p>
                    <p><%= rs.getString("department") %></p>
                </div>
            </div>
            <div class="action_btns">
                <button onclick="updateLecturer()" style="background: #4caf50; color: #fff">Update</button>
                <button onclick="deleteLecturer(<%= rs.getInt("lecturer_id") %>)" style="background: #990000; color: #fff">Delete</button>
            </div>
        </div>
        
        <%
            } else {
        // Handle the case where no lecturer with the given ID is found
        out.println("<p>No lecturer found with ID: " + lecturerId + "</p>");
    }
        %>
    </main>
    <script>
        function updateLecturer(){
            window.location.href = './edit-profile.jsp?lecturer_id=<%= rs.getInt("lecturer_id") %>';
        }
        
        function deleteLecturer(lecturerId){
            if (confirm("Are you sure you want to delete this Lecturer?")) {
                window.location.href = './delete-lecturer.jsp?lecturer_id=' + lecturerId;
            }
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
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException se) {
            se.printStackTrace();
        }
    }
%>
