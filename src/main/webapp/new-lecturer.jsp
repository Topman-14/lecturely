<%@ page import="java.sql.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>

<%
  if (request.getMethod().equalsIgnoreCase("post")) {
    String firstName = request.getParameter("first_name");
    String lastName = request.getParameter("last_name");
    String email = request.getParameter("email");
    String phoneNo = request.getParameter("phone_no");
    String department = request.getParameter("department");
    String password = request.getParameter("password");
    String cPassword = request.getParameter("cpassword");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
      // Load the JDBC driver
      Class.forName("com.mysql.cj.jdbc.Driver");

      // Establish a connection
      String url = "jdbc:mysql://localhost:3306/lecturely";
      conn = DriverManager.getConnection(url, "root", "");

      // Check if the email already exists
      String checkEmailQuery = "SELECT * FROM lecturers WHERE email = ?";
      pstmt = conn.prepareStatement(checkEmailQuery);
      pstmt.setString(1, email);
      rs = pstmt.executeQuery();

      if (rs.next()) {
        // Email already exists, show an error message
        out.println("<div class='toast error'>Email already exists. Use another one!</div>");
      } else {
        // Hash the password using bcrypt
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        // Execute SQL query to insert new lecturer
        String insertQuery = "INSERT INTO lecturers (first_name, last_name, email, phone_no, department, password) VALUES (?, ?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(insertQuery);
        pstmt.setString(1, firstName);
        pstmt.setString(2, lastName);
        pstmt.setString(3, email);
        pstmt.setString(4, phoneNo);
        pstmt.setString(5, department);
        pstmt.setString(6, hashedPassword);
        pstmt.executeUpdate();

        // Display success message
        out.println("<div class='toast success'>User added successfully</div>");
        response.sendRedirect("./view-lecturers.jsp");
      }

    } catch (Exception e) {
      e.printStackTrace();
      out.println("<div class='toast error'>A server error occurred while processing your request.</div>");
      
    } finally {
      try {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
      } catch (SQLException se) {
        se.printStackTrace();
      }
     }
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add New Lecturer | Lecturely</title>
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
                <a href="./dashboard.jsp">Dashboard</a>
                <hr />
                <a href="./view-lecturers.jsp">View Lecturers</a>
                <hr />
                <a href="./new-lecturer.jsp">Add New Lecturer</a>
            </div>
            <button onclick="navigate('./')">Logout</button>
        </aside>
        <main>
            <div class="details_wrapper">
                <form method="post" action="">
                    <div class="form_group">
                        <label>First Name</label>
                        <input type="text" name="first_name" required/>
                    </div>
                    <div class="form_group">
                        <label>Last Name</label>
                        <input type="text" name="last_name" required/>
                    </div>
                    <div class="form_group">
                        <label>Email</label>
                        <input type="email" name="email" required/>
                    </div>
                    <div class="form_group">
                        <label>Phone Number</label>
                        <input type="tel" name="phone_no" required/>
                    </div>
                    <div class="form_group">
                        <label>Department</label>
                        <input type="text" name="department" required/>
                    </div>
                    <div class="form_group">
                        <label for="password">Password:</label>
                        <input type="password" id="password" name="password" required minlength="8" placeholder="Minimum of 8 characters">
                      </div>
                    <input type="submit" value="Save" class="save_btn"/>
                </form>
            </div>
        </main>
        <script>
            function navigate(url){
                 window.location.href = url;
            }
        </script>
    </body>
</html>
