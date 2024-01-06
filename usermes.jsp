<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body{
            background-color: black;
            color: white;
        }
        center{
            padding: 100px;
        }
    </style>
</head>
<body>

    <a href="signin.html">Click Here to go to Sign In page</a>
    <br>
<%
  String phonenumber = request.getParameter("phonenumber");
  String password = request.getParameter("password");
  String confirmPassword = request.getParameter("confirmpassword");

  if (!password.equals(confirmPassword)) {
    out.println("Passwords do not match.");
  } 
  else {
    Connection con = null;
    PreparedStatement stmt = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/photographers", "root", "mani@2002");
      String query = "INSERT INTO users (phonenumber, password) VALUES (?, ?)";
      stmt = con.prepareStatement(query);
      stmt.setString(1, phonenumber);
      stmt.setString(2, password);

      // Execute the statement
      int rowsInserted = stmt.executeUpdate();

      if (rowsInserted > 0) {
        // Data successfully inserted into the database
        out.println("Sign Up done successfully.");
      } else {
        // Failed to insert data into the database
        out.println("Error registering user.");
      }

      // Close the database resources
      stmt.close();
      con.close();
    } catch (SQLException e) {
      // Handle any database errors
      e.printStackTrace();
    }
  }
%>
</body>
</html>
