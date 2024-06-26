<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Board.BoardDAO" %>
<%@ page import="Board.Board" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #e9ecef;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }
    .container {
        width: 100%;
        max-width: 600px;
        background-color: #fff;
        border-radius: 12px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        padding: 30px;
        box-sizing: border-box;
    }
    .header {
        text-align: center;
        font-size: 24px;
        font-weight: bold;
        color: #495057;
        margin-bottom: 30px;
    }
    .form-group {
        display: grid;
        grid-template-columns: 1fr;
        gap: 20px;
        margin-bottom: 20px;
    }
    .form-group label {
        font-weight: bold;
        color: #495057;
    }
    .form-group input, .form-group textarea {
        padding: 12px;
        font-size: 16px;
        border: 1px solid #dee2e6;
        border-radius: 8px;
        width: 100%;
        box-sizing: border-box;
        transition: border-color 0.3s ease;
    }
    .form-group input:focus, .form-group textarea:focus {
        border-color: #74c0fc;
        outline: none;
    }
    .form-group textarea {
        height: 150px;
        resize: none;
    }
    .button {
        padding: 14px 20px;
        background-color: #00b894;
        color: white;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        font-size: 16px;
        font-weight: bold;
        width: 100%;
        box-sizing: border-box;
        transition: background-color 0.3s ease;
    }
    .button:hover {
        background-color: #6cc7b5;
    }
</style>
</head>
<body>
    <div class="container">
        <div class="header">게시글 수정</div>
        <%
            int id = Integer.parseInt(request.getParameter("id"));
            BoardDAO dao = new BoardDAO();
            Board board = dao.getBoard(id);
        %>
        <form action="doUpdate.jsp" method="post">
            <input type="hidden" name="id" value="<%= id %>">
            <div class="form-group">
                <label for="title">제목:</label>
                <input type="text" name="title" id="title" value="<%= board.getTitle() %>" required>
            </div>
            <div class="form-group">
                <label for="content">내용:</label>
                <textarea name="content" id="content" required><%= board.getContent() %></textarea>
            </div>
            <button type="submit" class="button">수정</button>
        </form>
    </div>
</body>
</html>
