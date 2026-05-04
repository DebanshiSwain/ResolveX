<%@ page import="java.sql.*" %>
<%
String id = request.getParameter("id");
String filter = request.getParameter("filter");

/* ✅ SAFETY */
if(filter == null) filter = "all";

try {
    if(id != null) {

        Class.forName("org.postgresql.Driver");

        Connection con = DriverManager.getConnection(
            "jdbc:postgresql://localhost:5432/resolvex",
            "debanshiswain",
            "110606"
        );

        PreparedStatement ps = con.prepareStatement(
            "DELETE FROM complaints WHERE id=?"
        );

        ps.setInt(1, Integer.parseInt(id));
        ps.executeUpdate();

        con.close();
    }

} catch(Exception e) {
    out.println("<p style='color:red;text-align:center;'>Error: " + e.getMessage() + "</p>");
}

response.sendRedirect("adminDashboard.jsp?filter=" + filter);
%>
