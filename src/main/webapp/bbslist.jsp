<%@page import="dto.BbsDto"%>
<%@page import="dao.BbsDao"%>
<%@page import="java.util.List"%>
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
<title>Insert title here</title>
</head>
<body>

<%
String choice = request.getParameter("choice");
String search = request.getParameter("search");

if(choice == null){
	choice = "";
}

if(search == null){
	search = "";
}

// BbsDao dao = BbsDao.getInstance();

// List<BbsDto> list = dao.getBbsList();
// List<BbsDto> list = dao.getBbsSearchList(choice, search);

%>

<h1>게시판</h1>

<div align="center">

<table border="1">
<col width="70"><col width="600"><col width="100"><col width="150">
<thead>
<tr>
	<th>번호</th><th>제목</th><th>조회수</th><th>작성자</th>
</tr>
</thead>

<tbody>

<%
if(list == null || list.size() == 0){
%>
	<tr>
		<td colspan="4">작성된 글이 없습니다</td>
	</tr>
<%
}else{
	for(int i = 0;i < list.size(); i++)
	{
		BbsDto dto = list.get(i);
	%>
	<tr>
		<th><%=i + 1 %></th>
		<td><%=dto.getTitle() %></td>
		<td><%=dto.getReadcount() %></td>
		<td><%=dto.getId() %></td>		
	</tr>
	<%
	}
}
%>

</tbody>
</table>

<br><br>

<select id="choice">
	<option value="">검색</option>
	<option value="title">제목</option>
	<option value="content">내용</option>
	<option value="wr">작성자</option>
	</select>
	
<input type="text" id="search" value="">

<button type="button" onclick="searchBtn()">검색</button>
<br>
<br>
<a href="bbswrite.jsp">글쓰기</a>
</div>

<script type="text/javascript">
function searchBtn() {
	let choice = document.getElementById('choice').value;
	let search = document.getElementById('search').value;
	// alert(choice);
	/* 
	if(choice == ""){
		alert("카테코리를 선택해 주십시오");
		return;
	} */
/* 	if(search.trim() == ""){
		alert("검색어를 선택해 주십시오");
		return;
	} */
	location.href = "bbslist.jsp?choice=" + choice + "&search=" + search;
		
}

</script>


</body>
</html>









