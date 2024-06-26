<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Comment.CommentDAO" %>
<%@ page import="Comment.Comment" %>

<%
    // 댓글 ID와 비밀번호 파라미터 가져오기
    int commentId = Integer.parseInt(request.getParameter("id"));
    String pw = request.getParameter("pw");
    
    // Comment 객체 생성
    Comment comment = new Comment();
    comment.setId(commentId);
    comment.setPw(pw);

    // CommentDAO 객체 생성
    CommentDAO commentDAO = new CommentDAO();

    // 댓글 삭제 처리
    int result = commentDAO.deleteComment(comment);

    if (result == 1) {
        // 삭제 성공 시 처리
        out.println("<script>");
        out.println("alert('댓글을 삭제했습니다.');");
        out.println("history.back();");
        out.println("</script>");
    } else {
        // 삭제 실패 시 처리
        out.println("<script>");
        out.println("alert('댓글 삭제에 실패했습니다.');");
        out.println("history.back();");
        out.println("</script>");
    }
%>
