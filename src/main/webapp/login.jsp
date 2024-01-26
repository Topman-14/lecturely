<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>

<%
  if(("lecturer").equals(request.getParameter("account_type"))){
        out.println("<div class='toast success'>Lecturer Account Created Successfully!</div>");
    } else{
        if(("admin").equals(request.getParameter("account_type"))){
            out.println("<div class='toast success'>Admin added Successfully!</div>");
        }
    }
  if (request.getMethod().equalsIgnoreCase("post")) {
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    ServletContext ctx = getServletContext();
    ctx.setAttribute("dbUser", "root");
    ctx.setAttribute("dbPass", "");
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
      // Load the JDBC driver
      Class.forName("com.mysql.cj.jdbc.Driver");

      // Establish a connection
      String url = "jdbc:mysql://localhost:3306/lecturely";
      conn = DriverManager.getConnection(url, (String) ctx.getAttribute("dbUser"), (String) ctx.getAttribute("dbPass"));

      // Execute SQL query
      String sql = "SELECT * FROM admins WHERE email=?";
      pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, email);
      rs = pstmt.executeQuery();

      out.println("<div class='toast load'>loading...</div>");

      if (rs.next() && BCrypt.checkpw(password, rs.getString("password"))) {
        // Successful login for admin
        ctx.setAttribute("userEmail", email);
        out.println("<div class='toast success'>Admin Log in successful!</div>");
        response.sendRedirect("./dashboard.jsp");
      } else {
        sql = "SELECT * FROM lecturers WHERE email=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, email);
        rs = pstmt.executeQuery();
        
        if (rs.next() && BCrypt.checkpw(password, rs.getString("password"))) {
          // Successful login for lecturer
          ctx.setAttribute("userEmail", email);
          out.println("<div class='toast success'>Lecturer Log in successful!</div>");
          response.sendRedirect("./home.jsp");
        } else {
          out.println("<div class='toast error'>Invalid Credentials! Try again</div>");
        }
      }
    } catch (Exception e) {
      e.printStackTrace();
      out.println("<div class='toast error'>Error:" + e.getMessage() + "</div>");
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
    <meta charset="UTF-8">
    <title>Login Page</title>
    <link rel="stylesheet" type="text/css" href="./styles.css">
</head>
<body>
    <img alt="lecturely logo" src="./logo.png"/>
    <h1>Login to Lecturely</h1>
    <div class="login-container">   
        <form method="post">
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required >
            </div>
            <div class="form-group">
                <input type="submit" value="Login">
            </div>
        </form>
    </div>
</body>
</html>
