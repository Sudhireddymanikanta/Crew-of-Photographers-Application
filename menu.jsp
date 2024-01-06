<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Photographers List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        header {
            background-color: #333;
            color: #fff;
            padding: 20px;
            text-align: center;
        }

        header a {
            color: #fff;
            text-decoration: none;
            margin: 0 10px;
        }

        .container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            text-align: center;
        }

        input[type="text"] {
            width: 80%;
            padding: 10px;
            margin-bottom: 10px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #333;
            color: #fff;
        }
    </style>
</head>
<body>
<header>
    <a href="home.html">Home</a>
    <a href="signin.html">User Sign In</a>
</header>

<div class="container">
    <h2>Photographers List</h2>
    <form method="post" action="">
        <input type="text" name="search" placeholder="Search by Address">
        <input type="submit" value="Search">
    </form>

    <table>
        <thead>
            <tr>
                <th>Photographer Name</th>
                <th>Mobile Number</th>
                <th>Alternate Mobile Number</th>
                <th>Email</th>
                <th>Address</th>
            </tr>
        </thead>
        <tbody>
            <%
                String search = request.getParameter("search");

                Connection con = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    // Load the JDBC driver
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    // Establish a connection
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/photographers", "root", "mani@2002");

                    // Create a statement to execute the SQL query
                    stmt = con.createStatement();

                    // Build the SQL query based on the search input
                    String query = "SELECT * FROM photographers";
                    if (search != null && !search.isEmpty()) {
                        query += " WHERE Address LIKE '%" + search + "%'";
                    }

                    // Execute the query
                    rs = stmt.executeQuery(query);

                    // Display the results in the table
                    while (rs.next()) {
                        out.println("<tr>");
                        
                        out.println("<td>" + rs.getString("Photographers_name") + "</td>");
                        out.println("<td>" + rs.getString("Mobile_Number") + "</td>");
                        out.println("<td>" + rs.getString("Alternate_MobileNumber") + "</td>");
                        out.println("<td>" + rs.getString("Email") + "</td>");
                        out.println("<td>" + rs.getString("Address") + "</td>");
                        out.println("</tr>");
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
        </tbody>
    </table>
</div>
</body>
</html>
