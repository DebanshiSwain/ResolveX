<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<title>Admin Login - ResolveX</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600;700&display=swap" rel="stylesheet">

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
padding: 50px 40px;   /* 🔥 more inner spacing */
border-radius: 20px;
width: 400px;
text-align: center;
color: #1e3a8a;
backdrop-filter: blur(20px);
box-shadow: 0 25px 70px rgba(0,0,0,0.2);
z-index: 1;
}

h2 {
font-size: 26px;
font-weight: 700;
margin-bottom: 30px;
}

/* FORM LAYOUT */
form {
display: flex;
flex-direction: column;
align-items: center;
gap: 18px;   /* 🔥 spacing between fields */
}

/* INPUT */
input {
width: 85%;
padding: 12px;
border: none;
border-radius: 10px;
background: rgba(255,255,255,0.9);
font-size: 14px;
}

/* LOGIN BUTTON */
button {
width: 65%;
padding: 12px;
border: none;
border-radius: 15px;
background: linear-gradient(45deg, #3b82f6, #2563eb);
color: white;
font-size: 14px;
cursor: pointer;
}

/* FORGOT PASSWORD */
a {
display: block;
margin-top: 15px;
font-size: 13px;
color:#2563eb;
text-decoration:none;
}

/* BACK BUTTON */
.back-btn {
width: 65%;
margin: 15px auto 0;
padding: 12px;
border-radius: 15px;
background: #e3f2fd;
color: #1e3a8a;
cursor: pointer;
border: none;
font-size: 14px;
}

.msg {
margin-top: 10px;
font-size: 13px;
}
</style>
</head>

<body>

<div class="card">

<h2>Admin Login</h2>

<form method="post">
<input type="text" name="username" placeholder="Username" required>
<input type="password" name="password" placeholder="Password" required>
<button type="submit">Login</button>
</form>

<a href="forgotPassword.jsp">
   Forgot Password?
</a>

<a href="index.jsp">
<button type="button" class="back-btn">⬅ Back to Home</button>
</a>

<%
boolean isPost = request.getMethod().equals("POST");

if(isPost) {

String username = request.getParameter("username");
String password = request.getParameter("password");
boolean found = false;

try {
    Class.forName("org.postgresql.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:postgresql://localhost:5432/resolvex",
        "debanshiswain",
        "110606"
    );

    PreparedStatement ps = con.prepareStatement(
        "SELECT username FROM admins WHERE username=? AND password=?"
    );

    ps.setString(1, username.trim());
    ps.setString(2, password.trim());

    ResultSet rs = ps.executeQuery();

    if(rs.next()) {
        found = true;
        session.setAttribute("admin", rs.getString("username"));
    }

    con.close();

} catch(Exception e) {
%>
<p class="msg" style="color:red;">
Database Error: <%= e.getMessage() %>
</p>
<%
}

if(found) {
%>
<p class="msg" style="color:green;">
Welcome <%= session.getAttribute("admin") %>!
</p>

<script>
setTimeout(function(){
window.location.href = "adminDashboard.jsp";
}, 1000);
</script>

<%
} else {
%>
<p class="msg" style="color:red;">
Authentication Failed
</p>
<%
}

}
%>

</div>

</body>
</html>
