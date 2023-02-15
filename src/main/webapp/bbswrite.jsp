<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 <%
 	MemberDto login = (MemberDto)session.getAttribute("login");		// object이기 때문에 memberdto로 캐스트변환
 	if(login == null){
 		%>
 		<script>
 		alert('로그인 해 주십시오');
 		location.href = "login.jsp";
 		</script>
 		<% 		
 	}
 %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bbs write</title>
</head>
<body>

<h1>글쓰기</h1>

<div align="center">

<form action="bbswriteAf.jsp" method="post">
<table border="1">
<col width="200"><col width="400">

	<tr>
	<th>아이디</th>
	<td>
		<input type="text" name="id" size="50px" value="<%=login.getId() %>" readonly="readonly">
	</td>
<%-- 	<td name="id"><%=login.getId() %></td> --%>
	</tr>


	<tr>		<!--  서버에 값을 전송할때는 name 사용 -->
		<th>제목</th>
		<td>
			<input type="text" name="title" size="50px" placeholder="제목을 입력하세요" > 
		</td>
	</tr>
	<tr>
		<th>내용</th>
		<td >
		<textarea name="content" rows="30" cols="80" style="resize: none;" placeholder="내용을 입력하세요"></textarea> 
		</td>
	</tr>
	<tr>
	<td colspan="2">
		<!-- <input type="submit" value="글쓰기"> -->
		<button type="submit">글쓰기</button>
	</td>
	</tr>

</table>
<!-- <br>
<input type="submit" value="글쓰기">
 -->
</form>
</div>



</body>
</html>