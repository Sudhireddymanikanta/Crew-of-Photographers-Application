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
  <a href="home.html">Click Here to go to home page</a>
  <br>
<%
  String name = request.getParameter("name");
  String mobileNumber = request.getParameter("mobile_number");
  String alternatemobileNumber = request.getParameter("Alternate mobile_number");
  String email = request.getParameter("email");
  String password = request.getParameter("password");
  String confirmPassword = request.getParameter("confirm_password");
  String address = request.getParameter("address");

  if (!password.equals(confirmPassword)) {
    out.println("Passwords do not match.");
  } 
  else {
    Connection con = null;
    PreparedStatement stmt = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/photographers", "root", "mani@2002");
      String query = "INSERT INTO photographers (Photographers_name, Mobile_Number, Alternate_MobileNumber,  Email, Password, Address) VALUES (?, ?, ?, ?, ?, ?)";
      stmt = con.prepareStatement(query);
      stmt.setString(1, name);
      stmt.setString(2, mobileNumber);
      stmt.setString(3, alternatemobileNumber);
      stmt.setString(4, email);
      stmt.setString(5, password);
      stmt.setString(6, address);

      // Execute the statement
      int rowsInserted = stmt.executeUpdate();

      if (rowsInserted > 0) {
        // Data successfully inserted into the database
        out.println("Data successfully inserted into the database.");
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
