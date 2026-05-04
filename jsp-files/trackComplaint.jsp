<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<title>Track Complaint - ResolveX</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600;700&display=swap" rel="stylesheet">

<style>
* {
margin: 0;
padding: 0;
box-sizing: border-box;
font-family: 'Poppins', sans-serif;
}

body {
min-height: 100vh;
background: linear-gradient(135deg,#7fb3ff,#a5ccff,#dbeafe,#a5ccff,#7fb3ff);
display: flex;
justify-content: center;
padding: 40px;
color: #1e3a8a;
}

.card {
background: rgba(255,255,255,0.6);
padding: 30px;
border-radius: 20px;
width: 750px;
backdrop-filter: blur(20px);
box-shadow: 0 20px 50px rgba(0,0,0,0.2);
}

h2 {
text-align: center;
margin-bottom: 20px;
}

input {
width: 100%;
padding: 12px;
border-radius: 10px;
margin-bottom: 12px;
border: none;
}

button {
width: 100%;
padding: 12px;
border-radius: 15px;
background: linear-gradient(45deg, #3b82f6, #2563eb);
color: white;
border: none;
cursor: pointer;
}

table {
width: 100%;
margin-top: 20px;
border-collapse: collapse;
}

th, td {
padding: 12px;
text-align: center;
border-bottom: 1px solid rgba(0,0,0,0.1);
}

.status {
font-weight: 700;
}

a {
display: block;
margin-top: 20px;
text-align: center;
color: #2563eb;
text-decoration: none;
}
</style>
</head>

<body>

<div class="card">

<h2>Track Your Complaint</h2>

<form method="post">
<input type="text" name="sic" placeholder="Enter your SIC" required>
<button type="submit">Search</button>
</form>

<%
if("POST".equalsIgnoreCase(request.getMethod())) {

String sic = request.getParameter("sic");
if(sic != null) sic = sic.trim();

try {

    Class.forName("org.postgresql.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:postgresql://localhost:5432/resolvex",
        "debanshiswain",
        "110606"
    );

    PreparedStatement ps = con.prepareStatement(
        "SELECT title, category, description, status, slot FROM complaints WHERE sic=?"
    );

    ps.setString(1, sic);

    ResultSet rs = ps.executeQuery();

    if(!rs.isBeforeFirst()) {
%>
<p style="color:red; text-align:center; margin-top:15px;">
❌ SIC not found
</p>
<%
    } else {
%>

<table>
<tr>
<th>Title</th>
<th>Category</th>
<th>Description</th>
<th>Status</th>
<th>Slot</th>
</tr>

<%
    while(rs.next()) {

    String status = rs.getString("status");

    Timestamp slot = null;

    try {
        slot = rs.getTimestamp("slot");   // ✅ SAFE
    } catch(Exception e) {
        slot = null;
    }
%>

<tr>
<td><%= rs.getString("title") %></td>
<td><%= rs.getString("category") %></td>
<td><%= rs.getString("description") %></td>
<td class="status"><%= status %></td>

<td>
<%
if(slot != null){
    String formatted = new java.text.SimpleDateFormat("dd-MM-yyyy HH:mm").format(slot);
    out.print(formatted);
} else {
    out.print("Awaiting Slot Assignment");
}
%>
</td>

</tr>

<%
    }
%>

</table>

<%
    }

    rs.close();
    ps.close();
    con.close();

} catch(Exception e) {
%>
<p style="color:red; text-align:center;">
Error: <%= e.getMessage() %>
</p>
<%
}
}
%>

<a href="dashboard.jsp">← Back to Dashboard</a>

</div>

</body>
</html>
