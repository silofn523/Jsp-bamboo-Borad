<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="Board.Board" %>
<%@ page import="Board.BoardDAO" %>
<%@ page import="Comment.Comment" %>
<%@ page import="Comment.CommentDAO" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 보기</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f5f5f5;
        margin: 0;
        padding: 0;
    }
    .container {
        width: 90%;
        margin: 0 auto;
        padding: 20px;
    }
    .header {
        background-color: #00b894;
        color: white;
        padding: 15px 0;
        text-align: center;
        font-size: 24px;
    }
    .post-view {
        background-color: white;
        padding: 20px;
        border: 1px solid #ddd;
        border-radius: 8px;
        margin-bottom: 20px;
    }
    .post-view-input {
    	padding-top: 50px;
    }
    .comment-section {
        background-color: white;
        padding: 20px;
        border: 1px solid #ddd;
        border-radius: 8px;
        margin-top: 20px;
    }
    .comment-form {
        display: flex;
        flex-direction: column;
    }
    .comment-form input, .comment-form textarea {
        margin-bottom: 10px;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
    }
    .comment-form button {
        padding: 10px;
        background-color: #00b894;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
    .comment-form-2 {
    	padding-left: -100px;
    }
    .comment-form-2 input, .comment-form-2 textarea {
        margin-bottom: 7px;
        padding: 7px;
        border: 1px solid #ccc;
        border-radius: 4px;
    }
    .comment-form-2 button {
    
        padding: 7px;
        background-color: #00b894;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
    .comment {
        border-bottom: 1px solid #ddd;
        padding: 10px 0;
    }
    .comment:last-child {
        border-bottom: none;
    }
    
    .button {
    	padding: 10px;
        background-color: #00b894;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        text-decoration: none;
    }
</style>
</head>
<body>
    <div class="header">
        <h1>게시글 보기</h1>
    </div>
    <div class="container">
        <div class="post-view">
            <%
                int id = 0;
                if(request.getParameter("id") != null) {
                    id = Integer.parseInt(request.getParameter("id"));
                }
                if(id == 0) {
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("alert('유효하지 않은 글입니다')");
                    script.println("location.href = 'bbs.jsp'");
                    script.println("</script>");
                    return;
                }
                Board board = new BoardDAO().getBoard(id);
            %>
            
            <h2><%= board.getTitle() %></h2>
            <p style="font-weight: bold; font-size: 1.1rem">작성자: <%= board.getName() %></p>
            <p style="font-weight: bold;"><%= board.getContent() %></p>
            <p style="color: #858585; font-size: 0.9rem">작성일: <%= board.getCreateTime() %></p>
            
            <div class="post-view-input">
            	 <div class="comment-form-2">
	            	<form action="verifyPassword.jsp" method="post">
			            <input type="hidden" name="id" value="<%= board.getId() %>">
			            <label for="pw"></label>
			            <input type="password" id="pw" name="pw" required placeholder="비밀번호 입력">
			            <button type="submit">게시글 수정</button>
			        </form>
			        <form action="verifyPasswordForDelete.jsp" method="post">
			            <input type="hidden" name="id" value="<%= board.getId() %>">
			            <label for="pw"></label>
			            <input type="password" id="pw" name="pw" required placeholder="비밀번호 입력">
			            <button type="submit" style="background: red">게시글 삭제</button>
			        </form>
	            </div>
            </div>
        </div>
        
        <a href="bbs.jsp" class="button">목록</a><br><br/>
        <div class="comment-section">
        	<form class="comment-form" action="view.jsp?id=<%= id %>" method="post">
                <input type="hidden" name="boardId" value="<%= id %>">
                <input type="text" name="title" placeholder="내용을 입력하세요" required>
                <input type="password" name="pw" placeholder="비밀번호" required>
                <button type="submit">댓글 작성</button>
            </form>
            <h3>댓글</h3>
            <%
                CommentDAO commentDAO = new CommentDAO();
                if (request.getMethod().equalsIgnoreCase("POST")) {
                    String title = request.getParameter("title");
                    String pw = request.getParameter("pw");
                    Comment newComment = new Comment();
                    newComment.setBoard_id(id);
                    newComment.setTitle(title);
                    newComment.setPw(pw);
                    commentDAO.addComment(newComment);
                    response.sendRedirect("view.jsp?id=" + id);
                }
                ArrayList<Comment> comments = commentDAO.getComments(id);
                for (Comment comment : comments) {
            %>
            <div class="comment">
			    <p style="font-weight: bold;"><%= comment.getTitle() %></p>
			    <p style="color: #858585; font-size: 0.9rem">작성일: <%= comment.getCreateTime() %></p>
			    <form action="verifyPasswordForCommentDelete.jsp" method="post" class="comment-form">
			        <input type="hidden" name="id" value="<%= comment.getId() %>">
			        <input type="password" id="pw" name="pw" required placeholder="비밀번호" class="comment-input">
			        <button type="submit" class="comment-button" >삭제</button>
			    </form>
			</div>
            <%
                }
            %>
        </div>
    </div>
</body>
</html>
