<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.oreilly.servlet.*"%>
<!DOCTYPE html>
<jsp:useBean id="tdto" class="yb.toping.TopingDTO" scope="session"/>
<jsp:useBean id="tdao" class="yb.toping.TopingDAO"/>
<%
String savepath=tdao.TOPING_IMG;
try{
	MultipartRequest mr=
			new MultipartRequest(request,savepath,"utf-8");
	
	tdto.setToping_name("");
	tdto.setToping_price("");
	
	
	%>
	<script>
	window.alert('업로드 성공!');
	window.self.close();
	</script>
	<%
}catch(Exception e){
	e.printStackTrace();
	%>
	<script>
	window.alert('업로드 실패!');
	location.href='addToping.jsp';
	</script>
	<%
}

%>