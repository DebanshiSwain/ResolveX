<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
String id = request.getParameter("id");
String filter = request.getParameter("filter");
if(filter == null) filter = "all";

Connection con = null;
int deptId = 0;
String title = "";
String deptName = "";
Timestamp complaintDate = null;

try {
    if(id != null) {

        Class.forName("org.postgresql.Driver");

        con = DriverManager.getConnection(
            "jdbc:postgresql://localhost:5432/resolvex",
            "debanshiswain",
            "110606"
        );

        PreparedStatement ps = con.prepareStatement(
            "SELECT * FROM complaints WHERE id=?"
        );

        ps.setInt(1, Integer.parseInt(id));
        ResultSet rs = ps.executeQuery();

        if(rs.next()) {
            title = rs.getString("title");
            deptId = rs.getInt("department_id");
            complaintDate = rs.getTimestamp("created_at");
        }

        PreparedStatement psDept = con.prepareStatement(
            "SELECT name FROM departments WHERE id=?"
        );

        psDept.setInt(1, deptId);
        ResultSet d = psDept.executeQuery();

        if(d.next()) deptName = d.getString("name");
    }

} catch(Exception e) {
    out.println("<p style='color:red;text-align:center;'>Error: " + e.getMessage() + "</p>");
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Assign Slot - ResolveX</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600;700&display=swap" rel="stylesheet">

<style>
body {
margin: 0;
font-family: Poppins;
padding: 30px;
background: linear-gradient(135deg,#7fb3ff,#a5ccff,#dbeafe,#a5ccff,#7fb3ff);
color: #1e3a8a;
}

h2 { text-align:center; }

.section {
margin:20px auto;
width:80%;
background:rgba(255,255,255,0.6);
padding:20px;
border-radius:15px;
}

table {
width:90%;
margin:auto;
border-collapse:collapse;
background:rgba(255,255,255,0.6);
}

th, td {
padding:10px;
text-align:center;
}

.form-box {
margin:30px auto;
width:50%;
background:rgba(255,255,255,0.6);
padding:25px;
border-radius:15px;
}

input {
width:100%;
padding:10px;
margin:8px 0;
border:none;
border-radius:8px;
}

button {
width:100%;
padding:10px;
border:none;
border-radius:10px;
background:#2563eb;
color:white;
cursor:pointer;
}

.back {
background:#94a3b8;
margin-top:10px;
}
</style>
</head>

<body>

<h2>Assign Slot</h2>

<div class="section">
<b>ID:</b> <%= id %><br>
<b>Title:</b> <%= title %><br>
<b>Department:</b> <%= deptName %><br>
<b>Date:</b> <%= complaintDate %>
</div>

<h3 style="text-align:center;">Department Workload</h3>

<table>
<tr>
<th>ID</th>
<th>SIC</th>
<th>Title</th>
<th>Status</th>
<th>Slot</th>
</tr>

<%
try {

    PreparedStatement psSlots = con.prepareStatement(
        "SELECT * FROM complaints WHERE department_id=? AND status!='Resolved'"
    );

    psSlots.setInt(1, deptId);
    ResultSet rsSlots = psSlots.executeQuery();

    while(rsSlots.next()) {
%>

<tr>
<td><%= rsSlots.getInt("id") %></td>
<td><%= rsSlots.getString("sic") %></td>
<td><%= rsSlots.getString("title") %></td>
<td><%= rsSlots.getString("status") %></td>

<td>
<%
Timestamp s = null;

try {
    s = rsSlots.getTimestamp("slot");   // ✅ SAFE FETCH
} catch(Exception e) {
    s = null;
}

if(s != null){
    String formatted = new java.text.SimpleDateFormat("dd-MM-yyyy HH:mm").format(s);
    out.print(formatted);
} else {
    out.print("Not Assigned");
}
%>
</td>

</tr>

<%
    }

} catch(Exception e) {
    out.println("<tr><td colspan='5'>Error loading data</td></tr>");
}
%>

</table>

<div class="form-box">

<h3>Assign Slot</h3>

<form method="post" action="saveSlot.jsp" accept-charset="UTF-8">
<input type="hidden" name="id" value="<%= id %>">
<input type="hidden" name="filter" value="<%= filter %>">  <!-- ✅ FIX -->

<label>Date:</label>
<input type="date" name="date" required>

<label>Time:</label>
<input type="time" name="time" required>

<button type="submit">Assign Slot</button>
</form>

<a href="adminDashboard.jsp?filter=<%= filter %>">  <!-- ✅ FIX -->
<button class="back">Back to Dashboard</button>
</a>

</div>

</body>
</html>
