<%@page import="sist.com.gallery.GalleryDao"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@page import="sist.com.gallery.Gallery"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("euc-kr");
		int no=Integer.parseInt(request.getParameter("modifyNo"));
		String name=request.getParameter("modname");
		String email=request.getParameter("modemail");
		String password=request.getParameter("modpassword");
		String contents=request.getParameter("modcontents");
		
		Gallery gallery=new Gallery();
		gallery.setNo(no);
		gallery.setName(name);
		gallery.setEmail(email);
		gallery.setPassword(password);
		gallery.setContents(contents);
		
		GalleryDao.Sing().modify(gallery);
		
		response.sendRedirect("gallery.jsp");
	%>

</body>
</html>