<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
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
        background-color: #6cc7b5;;
    }
</style>
</head>
<body>
    <div class="container">
        <div class="header">글쓰기</div>
        <form method="post" action="writeAction.jsp">
            <div class="form-group">
                <label for="title">글 제목</label>
                <input type="text" id="title" name="title" placeholder="제목을 입력하세요" maxlength="50">
            </div>
            <div class="form-group">
                <label for="name">작성자</label>
                <input type="text" id="name" name="name" placeholder="작성자를 입력하세요" maxlength="20">
            </div>
            <div class="form-group">
                <label for="pw">비밀번호</label>
                <input type="password" id="pw" name="pw" placeholder="비밀번호를 입력하세요" maxlength="20">
            </div>
            <div class="form-group">
                <label for="content">글 내용</label>
                <textarea id="content" name="content" placeholder="글 내용을 입력하세요" maxlength="500"></textarea>
            </div>
            <button type="submit" class="button">글쓰기</button>
        </form>
    </div>
</body>
</html>
