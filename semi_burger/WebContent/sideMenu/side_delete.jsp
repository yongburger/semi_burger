<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8">
<%
request.setCharacterEncoding("UTF-8");
%>
<title>Insert title here</title>
</head>
<body>
<section>
	<article>
	
		<fieldset>
			<legend align="center">사이드 메뉴 삭제하기</legend>
			<form name="side_delete" action="side_delete_ok.jsp">
			<table>
				<tr>
					<th>사이드번호:</th>
					<td><input type="text" name="sideitem_num"></td>
				</tr>
				<tr>
					<td colspan="2"><input type="reset" value="다시작성">
					<input type="submit" value="메뉴삭제">
					</td>
				</tr>
			</table>
			</form>
		</fieldset>
	</article>
</section>
</body>
</html>