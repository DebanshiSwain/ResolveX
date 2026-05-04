<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
String msg = "";
boolean success = false;

if(request.getMethod().equals("POST")) {

    String sic = request.getParameter("sic");
    String name = request.getParameter("name");
    String category = request.getParameter("category");
    String title = request.getParameter("title");
    String description = request.getParameter("description");

    // ✅ BASIC VALIDATION
    if(sic == null || sic.trim().isEmpty() ||
       name == null || name.trim().isEmpty() ||
       category == null || category.trim().isEmpty() ||
       title == null || title.trim().isEmpty() ||
       description == null || description.trim().isEmpty()) {

        msg = "All fields are required!";
    }
    else {

        try {
            Class.forName("org.postgresql.Driver");

            Connection con = DriverManager.getConnection(
                "jdbc:postgresql://localhost:5432/resolvex",
                "debanshiswain",
                "110606"
            );

            // ✅ GET DEPARTMENT ID
            PreparedStatement psDept = con.prepareStatement(
                "SELECT id FROM departments WHERE name=?"
            );
            psDept.setString(1, category);

            ResultSet rsDept = psDept.executeQuery();

            int deptId = 1; // fallback

            if(rsDept.next()) {
                deptId = rsDept.getInt("id");
            }

            // ✅ INSERT COMPLAINT
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO complaints(sic, name, category, title, description, status, slot, department_id) VALUES(?,?,?,?,?,'Pending','Not Assigned',?)"
            );

            ps.setString(1, sic.trim());
            ps.setString(2, name.trim());
            ps.setString(3, category);
            ps.setString(4, title.trim());
            ps.setString(5, description.trim());
            ps.setInt(6, deptId);

            int i = ps.executeUpdate();

            if(i > 0) {
                success = true;
                msg = "Complaint Submitted Successfully!";
            }

            con.close();

        } catch(Exception e) {
            msg = "Error: " + e.getMessage();
        }
    }
}
%>

<!DOCTYPE html>
<html>
<head>
<title>ResolveX</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600;700;800&family=Playfair+Display:ital@1&display=swap" rel="stylesheet">

<style>
body {
margin: 0;
font-family: Poppins;
height: 100vh;
display: flex;
justify-content: center;
align-items: center;
background: linear-gradient(135deg,
  #7fb3ff 0%,
  #a5ccff 25%,
  #dbeafe 50%,
  #a5ccff 75%,
  #7fb3ff 100%
);
color: #1e3a8a;
overflow: hidden;
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
z-index: 0;
}

.card {
background: rgba(255,255,255,0.65);
padding: 35px;
border-radius: 20px;
width: 400px;
backdrop-filter: blur(20px);
box-shadow: 0 20px 50px rgba(0,0,0,0.18);
z-index: 1;
position: relative;
}

h2 {
text-align: center;
margin-bottom: 20px;
color: #1e3a8a;
font-size: 28px;
font-weight: 800;
}

label {
display: block;
font-size: 14px;
margin-bottom: 6px;
color: #475569;
font-weight: 500;
}

input, select, textarea {
width: 100%;
padding: 12px;
border: none;
border-radius: 10px;
outline: none;
font-family: Poppins;
font-size: 14px;
background: rgba(255,255,255,0.88);
}

textarea {
height: 85px;
resize: none;
font-size: 13px;
}

button {
width: 100%;
padding: 12px;
border: none;
border-radius: 15px;
background: linear-gradient(45deg, #3b82f6, #2563eb);
color: white;
cursor: pointer;
margin-top: 10px;
font-size: 14px;
font-weight: 500;
}

.back-btn {
background: linear-gradient(45deg, #60a5fa, #3b82f6);
}

.msg {
text-align: center;
margin-bottom: 10px;
font-size: 13px;
}
</style>
</head>

<body>

<div class="card">

<h2>Raise Complaint</h2>

<% if(success) { %>

<p class="msg" style="color:green;"><%= msg %></p>

<a href="dashboard.jsp">
    <button type="button">Go to Dashboard</button>
</a>

<script>
setTimeout(function(){
    window.location.href = "dashboard.jsp";
}, 2000);
</script>

<% } else { %>

<form method="post">

<label>SIC</label>
<input type="text" name="sic" required>

<label>Name</label>
<input type="text" name="name" required>

<label>Issue Type</label>
<select name="category" required>
    <option value="">Select Issue Type</option>
    <option value="IT Support">IT / Network Issue</option>
    <option value="Hostel Management">Hostel Issue</option>
    <option value="Academic Office">Academic Issue</option>
    <option value="Library">Library Issue</option>
    <option value="Examination Cell">Exam Issue</option>
    <option value="Accounts / Fees">Fees Issue</option>
    <option value="Transport">Transport Issue</option>
    <option value="Maintenance">Maintenance Issue</option>
    <option value="Placement Cell">Placement Issue</option>
    <option value="Administration">General Issue</option>
    <option value="Security">Security Issue</option>
    <option value="Mental Health">Mental Health Issue</option>
    <option value="Physical Health">Physical Health Issue</option>
</select>

<label>Title</label>
<input type="text" name="title" required>

<label>Description</label>
<textarea name="description" required></textarea>

<button type="submit">Submit Complaint</button>

</form>

<a href="dashboard.jsp">
<button type="button" class="back-btn">← Back to Dashboard</button>
</a>

<p class="msg" style="color:red;"><%= msg %></p>

<% } %>

</div>

</body>
</html>
