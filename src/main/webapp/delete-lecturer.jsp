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

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish a connection
        String url = "jdbc:mysql://localhost:3306/lecturely";
        conn = DriverManager.getConnection(url, "root", "");

        // Execute SQL query to delete lecturer based on ID
        String deleteQuery = "DELETE FROM lecturers WHERE lecturer_id = ?";
        pstmt = conn.prepareStatement(deleteQuery);
        pstmt.setString(1, lecturerId);
        pstmt.executeUpdate();

        // Redirect back to view-lecturers.jsp after successful deletion
        response.sendRedirect("./view-lecturers.jsp");

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h2>Delete failed.</h2>");
        out.println("<p>An error occurred while processing your delete request.</p>");
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException se) {
            se.printStackTrace();
        }
    }
%>
