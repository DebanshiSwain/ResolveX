<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>ResolveX</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;800&family=Cinzel:wght@700&family=Playfair+Display:ital@1&family=Pacifico&display=swap" rel="stylesheet">
<style>
* {
margin: 0;
padding: 0;
box-sizing: border-box;
font-family: 'Poppins', sans-serif;
}
/* 🌟 SOFT LIGHT BLUE + WHITE BACKGROUND */
body {
height: 100vh;
background:
 linear-gradient(rgba(255,255,255,0.6), rgba(147,197,253,0.55)),
 url('background.png');
background-size: cover;
background-position: center;
display: flex;
justify-content: center;
align-items: center;
position: relative;
overflow: hidden;
}
/* 🌟 VERY SOFT NEUTRAL GLOW (no strong blue) */
body::before {
content: "";
position: absolute;
width: 420px;
height: 420px;
background: radial-gradient(circle, rgba(255,255,255,0.4), transparent 70%);
top: 40%;
left: 50%;
transform: translate(-50%, -50%);
filter: blur(80px);
z-index: 0;
}
body::after {
content: "";
position: absolute;
width: 300px;
height: 300px;
background: radial-gradient(circle, rgba(255,255,255,0.3), transparent 70%);
top: 20%;
left: 60%;
filter: blur(90px);
z-index: 0;
}
/* 🌟 CONTENT (raised properly) */
.content {
text-align: center;
transform: translateY(-90px);
z-index: 1;
}
/* 🌟 LOGO */
.logo {
font-family: 'Cinzel', serif;
font-size: 78px;
font-weight: 800;
color: #1e3a8a;
text-shadow: 0 5px 20px rgba(0,0,0,0.1);
}
.logo span {
color: #2563eb;
}
/* 🌟 TAGLINE */
.tagline {
font-family: 'Pacifico', cursive;
font-size: 34px;
color: #2563eb;
margin: 15px 0 25px;
}
/* 🌟 QUOTE */
.quote {
font-family: 'Playfair Display', serif;
font-style: italic;
font-size: 17px;
color: #334155;
margin-bottom: 30px;
}
/* 🌟 BUTTON */
button {
padding: 14px 40px;
border: none;
border-radius: 30px;
background: linear-gradient(45deg, #3b82f6, #2563eb);
color: white;
cursor: pointer;
font-size: 16px;
transition: 0.3s;
}
button:hover {
transform: scale(1.05);
box-shadow: 0 12px 25px rgba(37,99,235,0.25);
}
/* 🌟 LINK */
a {
display: block;
margin-top: 15px;
color: #1e3a8a;
text-decoration: none;
font-weight: 500;
}
a:hover {
text-decoration: underline;
}
</style>
</head>
<body>
<div class="content">
<div class="logo">Resolve<span>X</span></div>
<div class="tagline">We’re here to help you</div>
<div class="quote">
  “Every complaint deserves attention and timely resolution”
</div>
<button onclick="goDashboard()">Get Started</button>
<a href="adminLogin.jsp">Admin Login</a>
</div>
<script>
function goDashboard() {
window.location.href = "dashboard.jsp";
}
</script>
</body>
</html>
