<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="Board.BoardDAO" %>
<%@ page import="Board.Board" %>
<% request.setCharacterEncoding("UTF-8"); %>

<%
    // 파라미터에서 ID와 비밀번호를 가져오기
    String idStr = request.getParameter("id");
    String password = request.getParameter("pw");

    PrintWriter script = response.getWriter();

    try {
        // ID가 null이거나 비어 있는 경우 예외 처리
        if (idStr == null || idStr.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            throw new IllegalArgumentException("유효하지 않은 요청입니다.");
        }

        int id = Integer.parseInt(idStr);

        // DAO를 통해 해당 ID의 게시글 가져오기
        BoardDAO dao = new BoardDAO();
        Board board = dao.getBoard(id);

        // 게시글이 없는 경우
        if (board == null) {
            throw new IllegalArgumentException("게시글이 존재하지 않습니다.");
        }

        // 게시글의 비밀번호 가져오기
        String boardPw = board.getPw();

        // 게시글의 비밀번호가 null이거나 비밀번호가 일치하지 않는 경우
        if (!boardPw.equals(password)) {
            throw new IllegalArgumentException("비밀번호가 일치하지 않습니다.");
        }

        // 비밀번호가 일치하면 수정 페이지로 Redirect
        response.sendRedirect("update.jsp?id=" + id);
    } catch (Exception e) {
        // 예외가 발생한 경우 스크립트를 통해 경고 메시지를 표시하고 뒤로 가기
        script.println("<script>");
        script.println("alert('" + e.getMessage() + "');");
        script.println("history.back();");
        script.println("</script>");
    }
%>
