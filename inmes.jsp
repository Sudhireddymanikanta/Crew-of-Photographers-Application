<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sign In</title>
</head>
<body>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    Connection con = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish a connection
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/photographers", "root", "mani@2002");

        // Create a prepared statement to execute the SQL query
        String query = "SELECT * FROM users WHERE phonenumber = ? AND password = ?";
        stmt = con.prepareStatement(query);
        stmt.setString(1, username);
        stmt.setString(2, password);

        // Execute the query
        rs = stmt.executeQuery();

        // Check if the user exists
        if (rs.next()) {
            // User exists, do something (e.g., set session variables, redirect to a welcome page)
            out.println("Welcome,User");
        } else {
            // User does not exist or incorrect credentials
            out.println("Invalid username or password. Please try again.");
        }
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    } finally {
        // Close resources in the reverse order of their creation
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (con != null) con.close();
    }
%>
<br>
<button onclick="redirect()">Click here to go to main Menu</button>
    <script>
        function redirect() {
          window.location.href = "menu.jsp";
        }
      </script>
</body>
</html>
