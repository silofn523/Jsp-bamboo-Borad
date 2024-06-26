<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Board.BoardDAO" %>
<%@ page import="Board.Board" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f5f5f5;
        margin: 0;
        padding: 0;
    }
    .container {
        width: 74%;
        margin: auto;
        padding: 0 0 0 100px;
        margin-top: 40px;
    }
    .header {
        background-color: #00b894;
        color: white;
        padding: 15px 0;
        text-align: center;
        font-size: 24px;
    }
    .search-form {
        margin-bottom: 40px;
        display: flex;
        justify-content: center;
    }
    .search-form input[type="text"] {
        padding: 10px;
        margin-right: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        flex: 1;
    }
    .search-form button {
        padding: 10px 20px;
        background-color: #00b894;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
    
    .post-list {
	    display: flex;
	    flex-wrap: wrap;
	    gap: 20px;
	}
	
	.post-item {
	    background-color: white;
	    width: 220px; 
	    margin-bottom: 20px;
	    padding: 15px;
	    border: 1px solid #ddd;
	    border-radius: 8px;
	    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	    display: flex;
	    flex-direction: column;
	}
	
	@media (max-width: 1200px) {
	    .post-item {
	        width: calc(25% - 20px); 
	    }
	}
	
	@media (max-width: 900px) {
	    .post-item {
	        width: calc(33.33% - 20px);
	    }
	}
	
	@media (max-width: 600px) {
	    .post-item {
	        width: 100%; 
	    }
	}
    
    
    .post-item a {
        text-decoration: none;
        color: #00b894;
        font-size: 18px;
        font-weight: bold;
    }
    .post-item p {
        margin: 5px 0;
        color: #333;
    }
    .pagination {
        text-align: center;
        margin: 20px 0;
        margin: auto;
        padding-bottom: 50px;
    }
    .pagination a {
        padding: 10px 20px;
        margin: 0 5px;
        background-color: #00b894;
        color: white;
        text-decoration: none;
        border-radius: 4px;
    }
    
    .paginationA {
    	text-align: center;
        margin: 20px 0;
        margin: auto;
        padding-bottom: 50px;
    }
    
    .paginationA a {
    	padding: 10px 20px;
        margin: 0 5px;
        background-color: #00b894;
        color: white;
        text-decoration: none;
        border-radius: 4px;
    }
    
    .write-btn {
        display: block;
        width: 100px;
        margin: 20px auto;
        padding: 10px;
        text-align: center;
        background-color: #00b894;
        color: white;
        text-decoration: none;
        border-radius: 4px;
    }
    @media (max-width: 600px) {
        .post-item {
            width: 100%;
        }
    }
</style>
</head>
<body>
	<%
		int pageNumber = 1;
		String searchTitle = request.getParameter("searchTitle") != null ? request.getParameter("searchTitle") : "";
	    String searchName = request.getParameter("searchName") != null ? request.getParameter("searchName") : "";
	
		if(request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
		
		BoardDAO DAO = new BoardDAO();
        ArrayList<Board> list = DAO.getList(pageNumber);
        
        if (searchTitle.isEmpty() && searchName.isEmpty()) {
            list = DAO.getList(pageNumber);
        } else {
            list = DAO.searchBoard(searchTitle, searchName);
        }
	%>
	<div class="header">
        <h1>대나무숲 커뮤니티</h1>
    </div>
    
	<div class="container">
		<form action="bbs.jsp" method="get" class="search-form">
            <label for="searchTitle"></label>
            <input type="text" id="searchTitle" name="searchTitle" value="<%= searchTitle %>" placeholder="제목으로 검색">
            <br><br/>
            <label for="searchName"></label>
            <input type="text" id="searchName" name="searchName" value="<%= searchName %>" placeholder="작성자명으로 검색">
            <button type="submit">검색</button>
        </form>
		<div class="search-form">
			<div class="post-list">
			    <% for(int i = 0; i < list.size(); i++) {
			            Board board = list.get(i);
			    %>
			        <div class="post-item">
			            <a href="view.jsp?id=<%= board.getId() %>"><%= board.getTitle() %></a><br/>
			            <p style="font-weight: bold; font-size: 1.1rem">작성자: <%= board.getName() %></p>
			            <p style="
			            	width: 200px; 
			            	display: block;
        					text-overflow: ellipsis;
        					overflow: hidden;
        					white-space: nowrap; 
        					font-weight: bold;"
        				><%= board.getContent() %></p><br/>
			            <p style="color: #858585; font-size: 0.9rem">작성일: <%= board.getCreateTime() %></p>
			        </div>
			    <% } %>
			</div>
			
		</div>
		<div class="pagination">
            <% if (pageNumber > 1) { %>
                <a href="bbs.jsp?pageNumber=<%= pageNumber - 1 %>">이전</a><br/>
            <% } %>
            <% if (DAO.nextPage(pageNumber)) { %>
                <a href="bbs.jsp?pageNumber=<%= pageNumber + 1 %>">다음</a><br/>
            <% } %>
     
        </div>
        <div class="paginationA">
        	<a href="write.jsp" >글쓰기</a>
        </div>
	</div>
	<%@ include file="footer.jsp"%>
</body>
</html>