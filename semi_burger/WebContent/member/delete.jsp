<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="mdao" class="member.MemberDAO" scope="session"/>

<%
	request.setCharacterEncoding("utf-8");

	String sid = (String)session.getAttribute("sid");
%>
	<script>
		var confirm = window.confirm('탈퇴하시겠습니까?');
		
		if(comfirm){
			<%
			String confirm = "yes";
			%>
		} else {
			<%
			confirm = "no";
			%>
		}
	</script>
<%
	int result = mdao.DelMember(sid);

	if(result>0){
		if(confirm.equals("yes")){
			%>
			<script>
			window.alert('탈퇴되었습니다');
			<%
			session.invalidate();
			%>
			location.href='/semi_burger/index.jsp';
			</script>
			<%
		} else{
			%>
			<script>
			window.alert('고객센터로 문의 바랍니다');
			location.href='/semi_burger/member/updateinfo.jsp';
			</script>
			<%
		}
	} else{
		%>
		<script>
		window.alert('고객센터로 문의 바랍니다');
		location.href='/semi_burger/member/updateinfo.jsp';
		</script>
		<%
	}

%>












