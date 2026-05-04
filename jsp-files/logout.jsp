<%@ page contentType="text/html;charset=UTF-8" %>

<%
/* invalidate session safely */
if(session != null) {
    session.removeAttribute("admin");
    session.invalidate();
}

/* prevent back button caching */
response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires", 0);

/* redirect */
response.sendRedirect("adminLogin.jsp");
%>
