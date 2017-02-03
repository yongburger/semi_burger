<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@page import="board.notice.*"%>
<jsp:useBean id="bdao" class="board.notice.noticeDAO" />
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8>
<title>Yong Burger</title>
<link rel="stylesheet" type="text/css" href="css/mainLayout.css">
<%
	int totalCnt = bdao.getTotalCnt();//총 게시물 수
	int listSize = 5;//보여줄 리스트 수
	int pageSize = 5;//보여줄 페이지 수
	String cp_s = request.getParameter("cp");
	if (cp_s == null || cp_s.equals("")) {
		cp_s = "1";
	}
	int cp = Integer.parseInt(cp_s); //현재 위치 
	int totalPage = totalCnt / listSize + 1;
	if (totalCnt % listSize == 0)
		totalPage--;

	int userGroup = cp / pageSize;
	if (cp % pageSize == 0)
		userGroup--;
%> 
</head>
<body>
<div id="container">
<div id="header">
<%@include file="header.jsp" %>
	<img src="./img/main_img.jpg" width="100%" height="300px">
	
</div>


				<div id="mainnotice">
					<table>
						<thead>
							<tr >
								<th>공지사항</th>
							</tr>
						</thead>
						<tfoot>
							<tr>
								<td colspan="3" align="center">
									<%
						if(userGroup!=0) {
							%><a href="notice.jsp?cp=<%=(userGroup-1)*pageSize+pageSize%>">&lt;&lt;</a>
									<%
							 }
						for(int i=userGroup*pageSize+1; i<=userGroup*pageSize+pageSize; i++) {
							%> &nbsp;&nbsp;<a href="notice.jsp?cp=<%=i%>"><%=i%></a>&nbsp;&nbsp;<%
							if(i==totalPage) {
								break;
								}
							}
						if(userGroup!=((totalPage/pageSize)-(totalPage%pageSize==0?1:0))) {
							%> <a href="notice.jsp?cp=<%=((userGroup+1)*pageSize+1)%>">&gt;
										&gt;</a> <%
							}
						%>
								</td>
							</tr>
						</tfoot>
						<tbody>
							<%
					ArrayList<noticeDTO> adto = bdao.noticeList(cp, listSize);
					if (adto == null || adto.size() == 0) {
							%>
							<tr>
								<td colspan="4" align="center">등록된 게시글이 없습니다.</td>
							</tr>
							<%
					} else {
						for (int i = 0; i < adto.size(); i++) {
								%>
							<tr>
								<td><%=adto.get(i).getNotice_no()%></td>
								<td colspan="2"><a
									href="./board/notice/noticeContent.jsp?NOTICE_NO=<%=adto.get(i).getNotice_no()%>"><%=adto.get(i).getSubject() %></a></td>
							</tr>
							<%
							}
						}
					%>
						</tbody>
					</table>
				</div>

				<div id="maincenter">여긴 내가 만든 시그니처 버거가 들어갈 예정ddd</div>
				
				<div id="footer">
					<%@include file="footer.jsp"%>
				</div>
			</div>
			</div>
			
			</body>
</html>