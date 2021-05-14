<%@page import="sist.com.gallery.GalleryDao"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
		int del=Integer.parseInt(request.getParameter("delete"));//삭제 하고 싶은 데이터의 no 값
		String password=request.getParameter("password"); //텍스트에 적은 password
		
		String dbpw=GalleryDao.Sing().selectPassword(del);
		
		if(password.equals(dbpw)){
		
	    GalleryDao.Sing().delete(del);
	    response.sendRedirect("gallery.jsp");
		}else{
			response.sendRedirect("gallery.jsp");
		}
	%>
</body>
</html>