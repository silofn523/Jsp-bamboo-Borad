<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Board.BoardDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="Board" class="Board.Board" scope="request" />
<jsp:setProperty property="title" name="Board"/>
<jsp:setProperty property="content" name="Board"/>
<jsp:setProperty property="name" name="Board"/>
<jsp:setProperty property="pw" name="Board"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		if(Board.getTitle() == null || Board.getContent() == null || Board.getName() == null || Board.getPw() == null) {
			PrintWriter script = response.getWriter();
			
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다')");
			script.println("history.back()");
			script.println("</script>");
			
		} else {
			BoardDAO DAO = new BoardDAO();
			int result = DAO.write(Board);
			
			if(result == -1) {
				PrintWriter script = response.getWriter();
				
				script.println("<script>");
				script.println("alert('글쓰기에 실패 했습니다')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				PrintWriter script = response.getWriter();
				
				script.println("<script>");
				script.println("alert('글을 등록 했습니다')");
				script.println("location.href = 'bbs.jsp'");
				script.println("</script>");
			}
		}
	
	%>
</body>
</html>