<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="org.apache.commons.fileupload.DiskFileUpload"%>
<%@page import="org.apache.commons.fileupload.FileUpload"%>
<%@page import="sist.com.gallery.Gallery"%>
<%@page import="java.util.List"%>
<%@page import="sist.com.gallery.GalleryDao"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="gallery" class="sist.com.gallery.Gallery" scope="session"></jsp:useBean>
<jsp:setProperty property="*" name="gallery"/> 
</head>
<body>

<%
	String pathValue="C:\\workspace2\\jdbc\\webGallery\\WebContent\\upload\\";
    boolean isMultipart= FileUpload.isMultipartContent(request); //�̰� ���Ͼ��ε尡 �������� true,false�� ������, �׷��� form���� �����ٶ�
                                                                 //enctype="multipart/form-data"�� ����߸� true�� �ǰ� 
                                                                 //������ ���� ���ָ� usebean�� ���� null�� ����.
    Gallery g=new Gallery();
    String fileName = "";
    
    if(isMultipart){
    	DiskFileUpload upload=new DiskFileUpload();
    	upload.setRepositoryPath(pathValue);
    	upload.setSizeMax(1224 * 1024 * 3);
    	List<FileItem> list=upload.parseRequest(request);
    	for (FileItem f : list) {
    		/* String fieldName = f.getFieldName();
    		if (fieldName.equals("password")) {
    			out.print(f.getString("EUC-KR"));//password value�� �ҷ��´�.
			} */
    		//out.print(f.getContentType());//null,null,null,null,image/png ����
    		//out.print(f.getFieldName());//name,email,password,contents,fileName ����
    		//out.print(f.getName());//null,null,null,null,���庰.png
    		//out.print(f.getSize()); 
    		if(f.getFieldName().equals("name")){
    			g.setName(f.getString("euc-kr"));
    			
    		}
    		if(f.getFieldName().equals("email")){
    			g.setEmail(f.getString("euc-kr"));
    			
    		}
    		if(f.getFieldName().equals("password")){
    			g.setPassword(f.getString("euc-kr"));
    			
    		}
    		if(f.getFieldName().equals("contents")){
    			g.setContents(f.getString("euc-kr"));
    			
    		}
    		if (!f.isFormField()) {//���ε�Ǵ� ������ text�������� �ٸ� �������� üũ,�̹��� �����̸� false�ε� !�������� �Ͽ� �̹����� ��������.
							out.print(!f.isFormField());		   
					if (f.getName() != null && f.getName().length() > 0) {
					    						 
						fileName += f.getName();
						out.print(fileName);
					    			
						File file = new File(pathValue + f.getName());//���⼭ �־����� ��ο� �̹��� �̸��� �־���.
						try {						
							f.write(file);//���Ⱑ upload���� �ȿ� �̹����� �־��ִ� �������� ����,File �������� �־������.					
						} catch (Exception e) {
							
						} 
				}
    	    }
    	}//for
    	g.setFileName(fileName);
    	out.print(g);
    	GalleryDao.Sing().insert(g);
    	response.sendRedirect("gallery.jsp");
    }
%>
  
	
	
</body>
</html>