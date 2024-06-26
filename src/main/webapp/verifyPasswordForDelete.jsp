<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="Board.BoardDAO" %>
<%@ page import="Board.Board" %>
<% request.setCharacterEncoding("UTF-8"); %>

<%
    String idStr = request.getParameter("id");
    String password = request.getParameter("pw");

    PrintWriter script = response.getWriter();

    try {
        // 입력 값 검증
        if (idStr == null || idStr.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            throw new IllegalArgumentException("유효하지 않은 요청입니다.");
        }

        int id = Integer.parseInt(idStr);

        BoardDAO dao = new BoardDAO();
        Board board = dao.getBoard(id);

        // 게시글 존재 여부 검증
        if (board == null) {
            throw new IllegalArgumentException("게시글이 존재하지 않습니다.");
        }

        String boardPw = board.getPw();

        // 비밀번호 일치 여부 검증
        if (boardPw == null || !boardPw.equals(password)) {
            throw new IllegalArgumentException("비밀번호가 일치하지 않습니다.");
        }

        // 비밀번호가 일치하면 삭제 페이지로 리다이렉트
        response.sendRedirect("deleteAction.jsp?id=" + id);

    } catch (NumberFormatException e) {
        script.println("<script>");
        script.println("alert('유효하지 않은 요청입니다.');");
        script.println("history.back();");
        script.println("</script>");

    } catch (IllegalArgumentException e) {
        script.println("<script>");
        script.println("alert('" + e.getMessage() + "');");
        script.println("history.back();");
        script.println("</script>");

    } catch (Exception e) {
        script.println("<script>");
        script.println("alert('오류가 발생했습니다. 다시 시도해주세요.');");
        script.println("history.back();");
        script.println("</script>");
    }
%>
