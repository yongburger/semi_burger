<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ page import="board.notice.*"%>
<jsp:useBean id="ddao" class="board.notice.noticeDAO" />
<%
String idx_s=request.getParameter("NOTICE_NO");
if(idx_s==null||idx_s.equals("")){
	idx_s="0";
}
int idx=Integer.parseInt(idx_s);
noticeDTO dto=ddao.noticeContent(idx);
if(dto==null){
	%>
<script>
	window.alert('잘못된 접근방식 또는 삭제된 게시글 입니다.');
	location.href='notice.jsp';
	</script>
<%
	return;
}
%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Yong Burger</title>
<link rel="stylesheet" type="text/css"
	href="/semi_burger/css/mainLayout.css">
<style type="text/css">
#button {
	text-align: right;
}

th div{
	height:0px;

	border-bottom:20px solid #DFDFDF;

}
td{
	width: 160px;
	padding-left:0px;
	padding-top:0px;
	padding-bottom:0px;
	text-align:left;
	
}

</style>
<script>
function noticewrite(){
	document.noticeW.submit();
}
</script>
</head>
</head>
<body>
	<div id="container">
		<div id="header">
			<%@include file="/header.jsp"%>
		</div>
				<div style="background:url(/semi_burger/introduce/img/sub_top_bg02.jpg) 50% 50% no-repeat;opacity: 0.85;">
			<br>
			<h2 style="color:white;" id="burgerevent">&nbsp;&nbsp;공 지 사 항</h2>
			<br>
			</div>
			
		<%@include file="../sideMenuBar.jsp" %>
		<br>
		<div id="contnet">

			<form name="noticeW" action="noticeWrite_ok.jsp">
			
				<table>
					<tr>
						<th><div>제목</div></th>
						<td colspan="3" align="left"><input type="text"	name="subject" placeholder="제목을 입력하세요." /></td>
					</tr>
					<tr height="100%">
						<td colspan="4" align="left" valign="top"><textarea rows="15" cols="110" name="content" placeholder="내용을 입력하세요."></textarea></td>
					</tr>
				</table>
				<div align="center">
				<br>
				<div class="ol_div" style="width:70px; text-align: center;"><a href="notice.jsp">취소</a></div>
				<div class="ol_div" style="width:70px; text-align: center;"><a href="javascript:noticewrite()">완료</a></div>
				
				</div>
			</form>
		</div>
		</div>

	<div id="footer">
	<br>
		<%@include file="/footer.jsp"%>
	</div>
</body>
</html>
