<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>

<%
if (request.getMethod().equalsIgnoreCase("post")) {
    String fullname = request.getParameter("fullname");
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    Connection conn = null;
    PreparedStatement pstmtCheck = null;
    PreparedStatement pstmtInsert = null;

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish a connection
        String url = "jdbc:mysql://localhost:3306/lecturely";
        conn = DriverManager.getConnection(url, "root", "");

        // Check if the email already exists
        String checkEmailQuery = "SELECT * FROM admins WHERE email = ?";
        pstmtCheck = conn.prepareStatement(checkEmailQuery);
        pstmtCheck.setString(1, email);
        ResultSet rs = pstmtCheck.executeQuery();

        if (rs.next()) {
            // Email already exists, show an error message
            out.println("<div class='toast error'>Email already exists. Use another one!</div>");
        } else {
            // Email is unique, proceed with inserting the new admin
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

            // Use prepared statement to prevent SQL injection
            String insertQuery = "INSERT INTO admins (fullname, email, password) VALUES (?, ?, ?)";
            pstmtInsert = conn.prepareStatement(insertQuery);
            pstmtInsert.setString(1, fullname);
            pstmtInsert.setString(2, email);
            pstmtInsert.setString(3, hashedPassword);
            pstmtInsert.executeUpdate();

            // Display success message
            out.println("<div class='toast success'>Admin added successfully!</div>");
            response.sendRedirect("./login.jsp?account_type=admin");
        }

    } catch (Exception e) {
        response.sendRedirect("./home.jsp");
        e.printStackTrace();
        out.println("<h2>Signup failed.</h2>");
        out.println("<p>An error occurred while processing your signup request.</p>");
    } finally {
        try {
            if (pstmtCheck != null) pstmtCheck.close();
            if (pstmtInsert != null) pstmtInsert.close();
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
    <title>Lecturer Management App | Signup</title>
    <link rel="stylesheet" type="text/css" href="./styles.css">
</head>
<body>
<div class="login-container">
    <h2>Administrator Signup</h2>
    <form method="post">
        <div class="form-group">
            <label for="fullname">Full Name:</label>
            <input type="text" id="fullname" name="fullname" required>
        </div>
        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>
        </div>
        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div class="form-group">
            <input type="submit" value="Sign Up">
        </div>
    </form>
</div>
</body>
</html>
