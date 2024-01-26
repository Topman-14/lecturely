<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>


<%
  if (request.getMethod().equalsIgnoreCase("post")) {
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String email = request.getParameter("email");
    String phoneNo = request.getParameter("phoneNo");
    String department = request.getParameter("department");
    String password = request.getParameter("password");
    String cPassword = request.getParameter("cpassword");
    
    if(cPassword == null || !cPassword.equals(password)){
        out.println("<div class='toast error'>Password and confirm password must be the same! Try again</div>");
    }else{

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
        out.println("<div class='toast success'>Lecturer Sign Up successful!</div>");
        response.sendRedirect("./login.jsp?account_type=lecturer");
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
  }
%>


<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Lecturer Management App | Signup</title>
  <link rel="stylesheet" type="text/css" href="./styles.css">
  <style>
      body{
          height: auto;
          padding: 50px 0;
      }
  </style>
</head>
<body>
    <img alt="lecturely logo" src="./logo.png"/>
  <h1>Create your Lecturer Account!</h1>
  <div class="login-container">
    <form method="post">
      <div class="form-group">
        <label for="firstName">First Name:</label>
        <input type="text" id="firstName" name="firstName" required>
      </div>
      <div class="form-group">
        <label for="lastName">Last Name:</label>
        <input type="text" id="lastName" name="lastName" required>
      </div>
      <div class="form-group">
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required placeholder="example@email.com">
      </div>
      <div class="form-group">
        <label for="phoneNo">Phone Number:</label>
        <input type="tel" id="phoneNo" name="phoneNo" required>
      </div>
      <div class="form-group">
        <label for="department">Department:</label>
        <input type="text" id="department" name="department" required>
      </div>
      <div class="form-group">
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required minlength="8" placeholder="Minimum of 8 characters">
      </div>
      <div class="form-group">
        <label for="cpassword">Confirm Password:</label>
        <input type="password" id="cpassword" name="cpassword">
      </div>
      <div class="form-group">
        <input type="submit" value="Sign Up">
      </div>
    </form>
  </div>
</body>
</html>