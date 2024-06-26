<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Board.BoardDAO" %>
<%@ page import="Board.Board" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<%
    int id = Integer.parseInt(request.getParameter("id"));
    String title = request.getParameter("title");
    String content = request.getParameter("content");

    BoardDAO dao = new BoardDAO();
    Board board = dao.getBoard(id);

    board.setTitle(title);
    board.setContent(content);

    int result = dao.updateBoard(board);
    PrintWriter script = response.getWriter();
    if (result > 0) {
    	script.println("<script>");
    	script.println("alert('게시글이 성공적으로 수정되었습니다.');");
    	script.println("location.href = 'bbs.jsp';");
    	script.println("</script>");
    } else {
    	script.println("<script>");
    	script.println("alert('게시글 수정에 실패하였습니다.');");
    	script.println("history.back();");
    	script.println("</script>");
    }
%>
