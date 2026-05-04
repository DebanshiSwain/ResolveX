<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Dashboard - ResolveX</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600;800&family=Cinzel:wght@700&family=Playfair+Display:ital@1&display=swap" rel="stylesheet">

<style>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'Poppins', sans-serif;
}

body {
  min-height: 100vh;
  background: linear-gradient(135deg,
    #7fb3ff 0%,
    #a5ccff 25%,
    #dbeafe 50%,
    #a5ccff 75%,
    #7fb3ff 100%
  );
  overflow-x: hidden;
}

/* FIX:  */
body::before {
  content: "";
  position: fixed;
  width: 520px;
  height: 520px;
  background: radial-gradient(circle, rgba(59,130,246,0.18), transparent);
  top: -100%;   
  left: -100%;
  transform: translate(-50%, 0);
  z-index: 0;
}

/* NAVBAR */
.navbar {
  width: 100%;
  padding: 15px 40px;
  background: rgba(255,255,255,0.55);
  backdrop-filter: blur(18px);
  display: flex;
  justify-content: space-between;
  align-items: center;
}

/* MAIN */
.main {
  padding: 35px 40px;
  position: relative;
  z-index: 2;
}

/* HEADER */
.header h1 {
  font-size: 48px;
  font-weight: 800;
  color: #1e3a8a;
}

.header p {
  font-size: 20px;
  font-family: 'Playfair Display', serif;
  font-style: italic;
  color: #334155;
}

/* GRID  */
.grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 40px;
  margin-top: 20px;
}

/* CARD  */
.card {
  background: rgba(255,255,255,0.6);
  padding: 35px;
  border-radius: 20px;
  backdrop-filter: blur(18px);
  box-shadow: 0 20px 45px rgba(0,0,0,0.12);
  text-align: center;
  transition: all 0.25s ease;
  z-index: 2;
}

.card:hover {
  transform: translateY(-10px);
  box-shadow: 0 30px 70px rgba(0,0,0,0.18);
}

/* ICON */
.icon {
  font-size: 34px;
  margin-bottom: 12px;
}

/* TITLE  */
.card h3 {
  font-size: 32px;
  font-weight: 900;
  margin-bottom: 10px;
  color: #1e3a8a;
}

/* DESCRIPTION  */
.card p {
  font-size: 18px;
  font-family: 'Playfair Display', serif;
  font-style: italic;
  color: #475569;
  margin-bottom: 22px;
}

/* BUTTON */
button {
  padding: 12px;
  width: 100%;
  border: none;
  border-radius: 30px;
  background: linear-gradient(45deg, #3b82f6, #2563eb);
  color: white;
  cursor: pointer;
  transition: 0.3s;
}

button:hover {
  transform: scale(1.05);
}

/* FOOTER */
.footer {
  text-align: center;
  margin-top: 40px;
}

.footer a {
  color: #2563eb;
  text-decoration: none;
  font-size: 14px;
}
</style>
</head>

<body>

<div class="navbar">
  <h2>ResolveX</h2>
</div>

<div class="main">

  <div class="header">
     <h1>Student Dashboard</h1>
     <p>Manage your complaints efficiently</p>
  </div>

  <div class="grid">

     <div class="card">
        <div class="icon">📝</div>
        <h3>Raise Complaint</h3>
        <p>Submit a new issue quickly and easily.</p>
        <button onclick="location.href='raiseComplaint.jsp'">Open</button>
     </div>

     <div class="card">
        <div class="icon">📊</div>
        <h3>Track Complaint</h3>
        <p>Monitor the progress of your complaint.</p>
        <button onclick="location.href='trackComplaint.jsp'">Open</button>
     </div>

  </div>

  <div class="footer">
     <a href="index.jsp">← Back to Home</a>
  </div>

</div>

</body>
</html>
