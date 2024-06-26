<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="Board.BoardDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>

<%
    int id = Integer.parseInt(request.getParameter("id"));

    PrintWriter script = response.getWriter();

    try {
        BoardDAO dao = new BoardDAO();
        int result = dao.deleteBoard(id);

        if (result == 1) {
            script.println("<script>");
            script.println("alert('게시글이 삭제되었습니다.');");
            script.println("location.href = 'bbs.jsp';");
            script.println("</script>");
        } else {
            throw new IllegalArgumentException("게시글 삭제에 실패했습니다.");
        }
    } catch (Exception e) {
        script.println("<script>");
        script.println("alert('" + e.getMessage() + "');");
        script.println("history.back();");
        script.println("</script>");
    }
%>
