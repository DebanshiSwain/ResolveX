<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
String msg = "";
String error = "";

if(request.getMethod().equals("POST")) {

   String username = request.getParameter("username");
   String pass = request.getParameter("password");
   String confirm = request.getParameter("confirm");

   try {
       Class.forName("org.postgresql.Driver");

       Connection con = DriverManager.getConnection(
           "jdbc:postgresql://localhost:5432/resolvex",
           "debanshiswain",
           "110606"
       );

       // 🔐 VALIDATION
       if(pass.length() < 6) {
           error = "Password must be at least 6 characters";
       }
       else if(!pass.matches(".*[A-Za-z].*") || !pass.matches(".*\\d.*")) {
           error = "Password must contain letters and digits";
       }
       else if(!pass.matches(".*[@#$%^&+=!].*")) {
           error = "Password must include at least one special character";
       }
       else if(!pass.equals(confirm)) {
           error = "Passwords do not match";
       }
       else {

           PreparedStatement check = con.prepareStatement(
               "SELECT * FROM admins WHERE username=?"
           );
           check.setString(1, username);

           ResultSet rs = check.executeQuery();

           if(rs.next()) {

               PreparedStatement ps = con.prepareStatement(
                   "UPDATE admins SET password=? WHERE username=?"
               );

               ps.setString(1, pass);
               ps.setString(2, username);

               ps.executeUpdate();

               msg = "Password updated successfully! Redirecting...";

%>
<script>
setTimeout(function(){
   window.location.href = "adminLogin.jsp";
}, 2000);
</script>
<%
           } else {
               error = "Username not found";
           }
       }

       con.close();

   } catch(Exception e) {
       error = "Error: " + e.getMessage();
   }
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Forgot Password - ResolveX</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600;700&family=Cinzel:wght@700&family=Pacifico&display=swap" rel="stylesheet">

<style>
body {
height: 100vh;
margin: 0;
display: flex;
justify-content: center;
align-items: center;
font-family: Poppins;

background: linear-gradient(135deg,
  #7fb3ff 0%,
  #a5ccff 25%,
  #dbeafe 50%,
  #a5ccff 75%,
  #7fb3ff 100%
);
}

body::before {
content: "";
position: absolute;
width: 500px;
height: 500px;
background: radial-gradient(circle, rgba(59,130,246,0.18), transparent);
top: 40%;
left: 50%;
transform: translate(-50%, -50%);
}

.card {
background: rgba(255,255,255,0.6);
padding: 50px 40px;
border-radius: 20px;
width: 380px;
text-align: center;
color: #1e3a8a;
backdrop-filter: blur(20px);
box-shadow: 0 25px 70px rgba(0,0,0,0.2);
z-index: 1;
}

/* LOGO */
.logo {
font-family: 'Cinzel', serif;
font-size: 30px;
margin-bottom: 8px;
font-weight: 700;
}

.logo span {
color: #2563eb;
}

/* SUBTITLE */
.tagline {
font-family: 'Pacifico', cursive;
font-size: 15px;
color: #2563eb;
margin-bottom: 18px;
}

/* INPUT */
input {
width:100%;
padding: 12px;
margin: 10px 0;
border: none;
border-radius: 10px;
background: rgba(255,255,255,0.9);
font-size: 14px;
}

/* BUTTON */
button {
width: 65%;
padding: 12px;
border: none;
border-radius: 15px;
background: linear-gradient(45deg, #3b82f6, #2563eb);
color: white;
font-size: 14px;
cursor: pointer;
margin-top: 8px;
}

/* MESSAGE */
.msg {
margin-top: 12px;
font-size: 13px;
}

/* LINK */
a {
display: block;
margin-top: 14px;
color: #2563eb;
text-decoration: none;
font-size: 13px;
}
</style>
</head>

<body>

<div class="card">

<div class="logo">Resolve<span>X</span></div>
<div class="tagline">Reset Password</div>

<form method="post">
  <input type="text" name="username" placeholder="Username" required>
  <input type="password" name="password" placeholder="New Password" required>
  <input type="password" name="confirm" placeholder="Confirm Password" required>

  <button type="submit">Reset Password</button>
</form>

<% if(!msg.equals("")) { %>
<p class="msg" style="color:green;"><%= msg %></p>
<% } %>

<% if(!error.equals("")) { %>
<p class="msg" style="color:red;"><%= error %></p>
<% } %>

<a href="adminLogin.jsp">← Back to Login</a>

</div>

</body>
</html>
