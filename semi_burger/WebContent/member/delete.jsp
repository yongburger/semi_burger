<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="mdao" class="member.MemberDAO" scope="session"/>

<%
	request.setCharacterEncoding("utf-8");

	String sid = (String)session.getAttribute("sid");
	
	int result = mdao.DelMember(sid);
	String confirm = %> <script> window.confirm('탈퇴하시겠습니까?'); </script>
		
	<%
	if(result>0){
		if(confirm!=null){
			%>
			<script>
			window.alert('탈퇴되었습니다');
			location.href='/semi_burger/index.jsp';
			</script>
			<%
		} else{
			%>
			<script>
			window.alert('고객센터로 연락바랍니다');
			location.href='/semi_burger/member/updateinfo.jsp';
			</script>
			<%
		}
	} else{
		%>
		<script>
		window.alert('고객센터로 연락바랍니다');
		location.href='/semi_burger/member/updateinfo.jsp';
		</script>
		<%
	}
%>

