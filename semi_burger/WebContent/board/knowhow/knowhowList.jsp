<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@page import="board.knowhow.*"%>
<jsp:useBean id="fdao" class="board.knowhow.knowhowDAO" />
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Yong Burger</title>
<link rel="stylesheet" type="text/css" href="/semi_burger/css/mainLayout.css">

<%
	int totalCnt = fdao.getTotalCnt();//총 게시물 수
	int listSize = 6;//보여줄 리스트 수
	int pageSize = 5;//보여줄 페이지 수
	String cp_s = request.getParameter("cp");
	if (cp_s == null || cp_s.equals("")) {
		cp_s = "1";
	}
	int cp = Integer.parseInt(cp_s); //현재 위치 
	int totalPage = totalCnt / listSize + 1;
	if (totalCnt % listSize == 0){
		totalPage--;
	}
	int userGroup = cp / pageSize;
	if (cp % pageSize == 0) {
		userGroup--;
	}

%>


</head>
<body>
<div id="container">
		<div id="header">
			<%@include file="/header.jsp"%>
		</div>
				<div style="background:url(/semi_burger/introduce/img/sub_top_bg02.jpg) 50% 50% no-repeat;opacity: 0.85;">
			<br>
			<h2 style="color:white;" id="burgerevent">&nbsp;&nbsp;My Burger</h2>
			<br>
			</div>
			
		<%@include file="../sideMenuBar.jsp" %>
		<br>
		<div id="content">
		
   
   
						<%
						ArrayList<knowhowDTO> adto = fdao.knowhowList(cp, listSize);
						if (adto == null || adto.size() == 0) {
						%>
							<br />
								<center>등록된 게시물이 없습니다</center>
							<br />
						<%
						} else {
							%>
							
							<table >
								<tr>
							
							<%
							for (int i = 0; i < adto.size(); i++) {
									%>
								
								<td align="center" ><img src="<%= pageContext.getServletContext().getContextPath() %>/<%=adto.get(i).getMy_img_url() %>" width="250" height="250" alt="" onclick="onView('<%=adto.get(i).getKnowhow_no()%>');" />
										<br><%=adto.get(i).getSubject()%><br><%=adto.get(i).getBoard_count()%>
								</td>				
									
									<% if((i+1)%3 == 0) { %>
									</tr>
						<%			}
								}
							}
						%>	
							</tr>
							</table>
						<div align="center">
						<%
								if (userGroup != 0) {
							%><a
							href="noticejsp?cp=<%=(userGroup - 1) * pageSize + pageSize%>">&lt;&lt;</a>
							<%
								}
								for (int i = userGroup * pageSize + 1; i <= userGroup * pageSize + pageSize; i++) {
							%> &nbsp;&nbsp;<a href="knowhowList.jsp?cp=<%=i%>"><%=i%></a>&nbsp;&nbsp;<%
 	if (i == totalPage) {
 			break;
 		}
 	}
 	if (userGroup != ((totalPage / pageSize) - (totalPage % pageSize == 0 ? 1 : 0))) {
 %> <a href="knowhowList.jsp?cp=<%=((userGroup + 1) * pageSize + 1)%>">&gt;
								&gt;</a> <%
 	}
 %>
						</div>
					
						<div align="right">
				<%
					if (sname != null) {
				%>
				<br>
				<input type="button" value="글쓰기"
					onclick="location.href='knowhowWrite.jsp'">
				<%
					}
				%>
				</div>
			</div>
						
						

	</div>
		<div id="footer">
		<br>
			<%@include file="/footer.jsp"%>
		</div>
	
</div>
</body><%-- 
<dt ><span style="font-size:16px;color:#1a1a1a;font-weight:bold;"><%=adto.get(i).getSubject() %>}</span></dt>
									<dd >
											<span class="price-prdc"><%=adto.get(i).getBoard_count() %></span>&nbsp;조회수<br>
											<%=adto.get(i).getInsert_date()%>
									</dd> --%>

<script type="text/javascript">

var onView = function(no){
	location.href='knowhowContent.jsp?KNOWHOW_NO='+no;
};
</script>
</html>				