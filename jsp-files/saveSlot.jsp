<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
request.setCharacterEncoding("UTF-8");

String id = request.getParameter("id");
String date = request.getParameter("date");
String time = request.getParameter("time");
String filter = request.getParameter("filter");

if(filter == null) filter = "all";

try {

    if(id != null && date != null && time != null &&
       !date.trim().isEmpty() && !time.trim().isEmpty()) {

        Class.forName("org.postgresql.Driver");

        Connection con = DriverManager.getConnection(
            "jdbc:postgresql://localhost:5432/resolvex",
            "debanshiswain",
            "110606"
        );

        // ✅ SAFE timestamp creation
        String dateTime = date + " " + time + ":00";
        Timestamp slot = Timestamp.valueOf(dateTime);

        PreparedStatement ps = con.prepareStatement(
            "UPDATE complaints SET slot=? WHERE id=?"
        );

        ps.setTimestamp(1, slot);
        ps.setInt(2, Integer.parseInt(id));

        ps.executeUpdate();
        con.close();
    }

    // ✅ PRESERVE FILTER
    response.sendRedirect("adminDashboard.jsp?filter=" + filter);

} catch(Exception e) {
    out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
}
%>
