<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>

<%
    String searchName = request.getParameter("searchName");
    if(searchName == null){
        searchName = "";
    }
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish a connection
        String url = "jdbc:mysql://localhost:3306/lecturely";
        conn = DriverManager.getConnection(url, "root", "");

        // Execute SQL query to fetch lecturers based on search criteria
        stmt = conn.createStatement();
        String sql;
        if (searchName != null && !searchName.isEmpty()) {
            sql = "SELECT * FROM lecturers WHERE first_name LIKE '%" + searchName + "%' OR last_name LIKE '%" + searchName + "%'";
        } else {
            sql = "SELECT * FROM lecturers";
        }
        rs = stmt.executeQuery(sql);
        
        String currentLecturerId = "";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dashboard | Lecturely</title>
        <style>
            body{
                margin: 0;
                border: 0;
                display: flex;
                background: #ffcf9c;
                color: #1a1a1a;
                font-family: "Trebuchet Ms"
            }
            aside{
                position: sticky;
                top: 0;
                right: 0;
                background: #ffffff;
                height: calc(100vh - 40px);
                width: 300px;
                padding: 20px;
                border-bottom-right-radius: 25px;
                border-top-right-radius: 25px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
                display: flex;
                justify-content: space-between;
                flex-direction: column;
            }
            aside hr{
                width: calc(100% - 20px);
            }
            .buttons{
                display: flex;
                flex-direction: column;
                justify-content: center;
                gap: 8px;
                padding: 0 10px;
            }
            .buttons a{
                width: calc(100% - 20px);
                padding: 10px;
                transition: 0.2s;
                border-radius:10px;
                color: #1a1a1a;
                text-decoration: none;
                font-weight: 700;
                font-size: 1.2em;
            }
            .buttons a:hover{
                background: #ffcf9c;
            }
            aside> button{
                width: 100%;
                border-radius: 10px;
                border: none;
                cursor: pointer;
                background: #eb6134;
                padding: 8px;
                font-weight: 800;
                font-family: "Trebuchet MS";
                color: #fff;
                font-size: 1.1em;
            }
            #logo_div{
                display: flex;
                align-items: center;
            }
            #logo_div>img{
                height: 50px;
            }
            #logo_div>i{
                font-size: 1.25em;
                margin-left: -5px;
            }
            main{
                padding: 20px;
                width: 100%;
            }
            .dash_panel_top, .dash_panel_bottom{
                width: 100%;
                height: 220px;
                display: flex;
                gap: 20px;
            }
            .dash_panel_top a, .dash_panel_bottom div{
                width: 100%;
                height: 100%;
                padding: 10px;
                background: #fff;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
                border-radius: 25px;
                display: flex;
                justify-content: center;
                align-items: center;
                text-decoration: none;
                color: #1a1a1a;
            }
            .dash_panel_top a p{
                font-size: 1.4em;
                font-weight: 700;
                color: #fff;
            }
            .dash_panel_bottom p{
                font-size: 1.6em;
                font-weight: 700;
            }
            main> h1{
                font-size: 1.3em;
            }
            main> h2{
                font-size: 2em;
                font-weight: 800;
            }
            main> h3{
                font-size: 1.6em;
                font-weight: 800;
                margin: 30px 0 15px 0;
            }
            .search_bar{
                display: flex;
                gap: 10px;
                margin: 100px 0 30px 10px; 
            }
            .search_bar> input{
                border: none;
                border-radius: 2px;
                padding: 8px;
                width: 350px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
            }
             .search_bar> input[type="submit"]{
               background: #28a745;
               color: #fff;
               cursor: pointer;
               width: fit-content;
            }
            .table_wrapper{
                margin-top: 50px;
                width: 100%;
            }
            .table_wrapper> table{
                border-collapse: separate;
                border-spacing: 10px;
                width: 100%;
            }
            tr{
                background: #fff;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
                border-radius: 8px;
                border-bottom: 1px solid #ddd;
                margin-bottom: 10px;
                transition: 0.25s;
                cursor: pointer
            }
            tr:hover{
                transform: translateY(-2px);
                background: #f7e0cd;
            }
            th,td{
                padding: 8px;
                border-radius: 7px;
            }
            th{
                background: #eb6134;
                color: #fff;
            }
            #refresh{
                color: #fff;
                background: #990000;
                border-radius: 1px;
                font-size: 0.8em;
                cursor: pointer;
                padding: 7px;
                font-weight: 700;
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
                <a href="./dashboard.jsp">Dashboard</a>
                <hr />
                <a href="./view-lecturers.jsp">View Lecturers</a>
                <hr />
                <a href="./new-lecturer.jsp">Add New Lecturer</a>
            </div>
            <button onclick="navigate('./')">Logout</button>
        </aside>
        <main>
            <h2>View Lecturers</h2>
            <p>Click on a table row for more details</p>
            
            <form method="get" class="search_bar">
                    <input type="text" id="searchName" placeholder="Search by Name..." name="searchName" value="<%= searchName %>">
                    <input type="submit" value="Go!">
                    <div id="refresh" onclick="navigate('./view-lecturers.jsp')"> Refresh </div>
            </form>
                    
            <div class="table_wrapper">
                <table>
                    <tr>
                        <th>Full Name</th>
                        <th>Email</th>
                        <th>Department</th>
                    </tr>
                    <% while (rs.next()) { %>
                        <tr onclick="viewDetails('<%= rs.getString("lecturer_id") %>')">
                            <td><%= rs.getString("first_name") + " " + rs.getString("last_name") %></td>
                            <td><%= rs.getString("email") %></td>
                            <td><%= rs.getString("department") %></td>
                        </tr>
                    <% } %>
                </table>
            </div>
        </main>
    </body>
    <script>
        function viewDetails(lecturerId){
            window.location.href = "./lecturer-details.jsp?lecturer_id=" + lecturerId;
        }
        
        function navigate(url){
             window.location.href = url;
        }

    </script>
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