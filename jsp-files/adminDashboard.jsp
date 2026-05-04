<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
String admin = (String) session.getAttribute("admin");
if(admin == null) {
    response.sendRedirect("adminLogin.jsp");
    return;
}

String filter = request.getParameter("filter");
if(filter == null) filter = "all";
%>

<!DOCTYPE html>
<html>
<head>
<title>ResolveX - Admin Dashboard</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600;700&display=swap" rel="stylesheet">

<style>
body {
  margin: 0;
  padding: 40px;
  font-family: Poppins;
  background: linear-gradient(135deg,#7fb3ff,#dbeafe,#7fb3ff);
  color: #1e3a8a;
}
h2 { text-align:center; }

.topbar {
  position:absolute;
  top:20px;
  right:30px;
}
.profile-btn {
  background: rgba(255,255,255,0.6);
  border:none;
  padding:10px 15px;
  border-radius:50px;
  cursor:pointer;
}
.dropdown {
  display:none;
  position:absolute;
  right:0;
  top:45px;
  background:white;
  border-radius:10px;
}
.dropdown a {
  display:block;
  padding:10px;
  text-decoration:none;
  color:black;
}
.dropdown a:hover { background:#eee; }

.stats {
  display:flex;
  justify-content:center;
  gap:20px;
  margin:20px;
}
.box {
  background:rgba(255,255,255,0.6);
  padding:15px 25px;
  border-radius:12px;
}

.filter-bar {
  text-align:center;
  margin-bottom:20px;
}
select {
  padding:10px;
  border-radius:10px;
}

table {
  width:100%;
  border-collapse:collapse;
  background:rgba(255,255,255,0.6);
}
th,td {
  padding:10px;
  text-align:center;
}

.pending-row { background: rgba(255, 99, 99, 0.2); }
.escalated-row { background: rgba(255, 193, 7, 0.3); }
.slot-row { background: rgba(59,130,246,0.25); }
.resolved-row { background: rgba(34,197,94,0.3); }

.actions {
  display:flex;
  gap:5px;
  justify-content:center;
}
button {
  border:none;
  padding:6px 10px;
  border-radius:6px;
  cursor:pointer;
}
.resolve { background:#22c55e; color:white; }
.escalate { background:#f59e0b; color:white; }
.slot { background:#3b82f6; color:white; }
.delete { background:#ef4444; color:white; }
</style>
</head>

<body>

<div class="topbar">
  <button class="profile-btn" onclick="toggleMenu()">👤 <%= admin %></button>
  <div class="dropdown" id="menu">
      <a href="logout.jsp">Logout</a>
  </div>
</div>

<h2>Admin Dashboard</h2>

<%
int pending=0, resolved=0, escalated=0;

Connection con = null;

try {
  Class.forName("org.postgresql.Driver");
  con = DriverManager.getConnection(
      "jdbc:postgresql://localhost:5432/resolvex",
      "debanshiswain",
      "110606"
  );

/* COUNT QUERY */
String countQuery = "SELECT status FROM complaints";
PreparedStatement countPs;

if(filter.equals("management") || filter.equals("hod")) {
    countQuery += " WHERE status='Escalated'";
    countPs = con.prepareStatement(countQuery);
}
else if(!filter.equals("all")) {
    countQuery += " WHERE category=?";
    countPs = con.prepareStatement(countQuery);
    countPs.setString(1, filter);
}
else {
    countPs = con.prepareStatement(countQuery);
}

ResultSet countRs = countPs.executeQuery();

while(countRs.next()) {
    String s = countRs.getString(1);
    if("Pending".equals(s)) pending++;
    else if("Resolved".equals(s)) resolved++;
    else if("Escalated".equals(s)) escalated++;
}
%>

<div class="stats">
  <div class="box">Pending: <%= pending %></div>
  <div class="box">Resolved: <%= resolved %></div>
  <div class="box">Escalated: <%= escalated %></div>
</div>

<div class="filter-bar">
<form method="get">
<select name="filter" onchange="this.form.submit()">

<option value="all" <%= filter.equals("all")?"selected":"" %>>All</option>
<option value="management" <%= filter.equals("management")?"selected":"" %>>Management</option>
<option value="hod" <%= filter.equals("hod")?"selected":"" %>>HOD</option>

<option value="IT Support" <%= filter.equals("IT Support")?"selected":"" %>>IT Support</option>
<option value="Hostel Management" <%= filter.equals("Hostel Management")?"selected":"" %>>Hostel</option>
<option value="Academic Office" <%= filter.equals("Academic Office")?"selected":"" %>>Academic</option>
<option value="Library" <%= filter.equals("Library")?"selected":"" %>>Library</option>
<option value="Examination Cell" <%= filter.equals("Examination Cell")?"selected":"" %>>Exam</option>
<option value="Accounts / Fees" <%= filter.equals("Accounts / Fees")?"selected":"" %>>Accounts</option>
<option value="Transport" <%= filter.equals("Transport")?"selected":"" %>>Transport</option>
<option value="Maintenance" <%= filter.equals("Maintenance")?"selected":"" %>>Maintenance</option>
<option value="Placement Cell" <%= filter.equals("Placement Cell")?"selected":"" %>>Placement</option>
<option value="Administration" <%= filter.equals("Administration")?"selected":"" %>>Admin</option>
<option value="Security" <%= filter.equals("Security")?"selected":"" %>>Security</option>
<option value="Mental Health" <%= filter.equals("Mental Health")?"selected":"" %>>Mental</option>
<option value="Physical Health" <%= filter.equals("Physical Health")?"selected":"" %>>Physical</option>

</select>
</form>
</div>

<%
String query = "SELECT * FROM complaints";
PreparedStatement ps;

if(filter.equals("management") || filter.equals("hod")) {
    query += " WHERE status='Escalated'";
    ps = con.prepareStatement(query);
}
else if(!filter.equals("all")) {
    query += " WHERE category=?";
    ps = con.prepareStatement(query);
    ps.setString(1, filter);
}
else {
    ps = con.prepareStatement(query);
}

ResultSet rs = ps.executeQuery();
boolean hasData = false;
%>

<table>
<tr>
<th>ID</th>
<th>SIC</th>
<th>Title</th>
<th>Category</th>
<th>Status</th>
<th>Slot</th>
<th>Actions</th>
</tr>

<%
while(rs.next()) {
hasData = true;

int id = rs.getInt("id");
String status = rs.getString("status");

/* ✅ FIXED SLOT */
Timestamp slotTs = null;
try {
    slotTs = rs.getTimestamp("slot");
} catch(Exception e) {
    slotTs = null;
}

String slot;
if(slotTs != null){
    slot = new java.text.SimpleDateFormat("dd-MM-yyyy HH:mm").format(slotTs);
} else {
    slot = "Not Assigned";
}

/* ✅ AUTO ESCALATION */
if(slotTs != null && !status.equals("Resolved")) {
    try {
        java.time.LocalDateTime slotTime = slotTs.toLocalDateTime();
        if(java.time.LocalDateTime.now().isAfter(slotTime)) {

            PreparedStatement up = con.prepareStatement(
                "UPDATE complaints SET status='Escalated' WHERE id=?"
            );
            up.setInt(1, id);
            up.executeUpdate();

            status = "Escalated";
        }
    } catch(Exception e){}
}

/* COLOR */
String rowClass = "";
if("Resolved".equals(status)) rowClass="resolved-row";
else if("Escalated".equals(status)) rowClass="escalated-row";
else if(slotTs != null) rowClass="slot-row";
else rowClass="pending-row";
%>

<tr class="<%= rowClass %>">
<td><%= id %></td>
<td><%= rs.getString("sic") %></td>
<td><%= rs.getString("title") %></td>
<td><%= rs.getString("category") %></td>
<td><%= status %></td>
<td><%= slot %></td>

<td>
<div class="actions">

<form method="post" action="updateStatus.jsp">
<input type="hidden" name="id" value="<%= id %>">
<input type="hidden" name="filter" value="<%= filter %>">
<button class="resolve" name="action" value="Resolved">Resolved</button>
</form>

<form method="post" action="updateStatus.jsp">
<input type="hidden" name="id" value="<%= id %>">
<input type="hidden" name="filter" value="<%= filter %>">
<button class="escalate" name="action" value="Escalated">Escalate</button>
</form>

<form method="get" action="assignSlot.jsp">
<input type="hidden" name="id" value="<%= id %>">
<input type="hidden" name="filter" value="<%= filter %>">
<button class="slot">Slot</button>
</form>

<form method="post" action="deleteComplaint.jsp"
onsubmit="return confirm('Delete this complaint?');">
<input type="hidden" name="id" value="<%= id %>">
<input type="hidden" name="filter" value="<%= filter %>">
<button class="delete">Delete</button>
</form>

</div>
</td>
</tr>

<%
}

if(!hasData) {
%>
<tr>
<td colspan="7" style="padding:20px;">No complaints found</td>
</tr>
<%
}

con.close();
%>

</table>

<%
} catch(Exception e) {
%>
<p style="color:red;text-align:center;">
Error: <%= e.getMessage() %>
</p>
<%
}
%>

<script>
function toggleMenu() {
 var menu = document.getElementById("menu");
 menu.style.display = (menu.style.display === "block") ? "none" : "block";
}
</script>

</body>
</html>
