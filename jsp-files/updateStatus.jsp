<%@ page import="java.sql.*" %>

<%
String id = request.getParameter("id");
String action = request.getParameter("action");
String filter = request.getParameter("filter");   // ✅ NEW

if(id == null || action == null) {
    out.println("<p style='color:red;text-align:center;'>Invalid request</p>");
    return;
}

if(filter == null) filter = "all";   // ✅ SAFETY

try {
    Class.forName("org.postgresql.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:postgresql://localhost:5432/resolvex",
        "debanshiswain",
        "110606"
    );

    PreparedStatement ps = con.prepareStatement(
        "UPDATE complaints SET status=? WHERE id=?"
    );

    ps.setString(1, action);
    ps.setInt(2, Integer.parseInt(id));

    int i = ps.executeUpdate();

    con.close();

    if(i > 0) {
        // ✅ FIX: preserve filter after action
        response.sendRedirect("adminDashboard.jsp?filter=" + filter);
    } else {
        out.println("<p style='color:red;text-align:center;'>Update failed</p>");
    }

} catch(Exception e) {
    out.println("<p style='color:red;text-align:center;'>Error: " + e.getMessage() + "</p>");
}
%>
