<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="tdao" class="yb.toping.TopingDAO"/>
<!DOCTYPE html>
<%
String key_s=request.getParameter("select");
int key=Integer.parseInt(key_s);
int result=tdao.showToping(key,"show");

if(result>0){
	%>
	<script>
		window.opener.location.href='selfBurger.jsp';
		location.href='showTop.jsp';
	</script>
	<%
}else{
	%>
	<script>
		window.alert('다시 시도해 주세요.');	
		location.href='showTop.jsp';
	</script>
	<%
}
%>