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
    boolean isMultipart= FileUpload.isMultipartContent(request); //이건 파일업로드가 가능한지 true,false를 보여줌, 그래서 form으로 보내줄때
                                                                 //enctype="multipart/form-data"를 해줘야만 true가 되고 
                                                                 //문제는 저걸 써주면 usebean에 값이 null이 들어간다.
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
    			out.print(f.getString("EUC-KR"));//password value를 불러온다.
			} */
    		//out.print(f.getContentType());//null,null,null,null,image/png 나옴
    		//out.print(f.getFieldName());//name,email,password,contents,fileName 나옴
    		//out.print(f.getName());//null,null,null,null,고흐별.png
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
    		if (!f.isFormField()) {//업로드되는 파일이 text형태인지 다른 형태인지 체크,이미지 파일이면 false인데 !부정으로 하여 이미지만 들어오게함.
							out.print(!f.isFormField());		   
					if (f.getName() != null && f.getName().length() > 0) {
					    						 
						fileName += f.getName();
						out.print(fileName);
					    			
						File file = new File(pathValue + f.getName());//여기서 넣어지는 경로와 이미지 이름을 넣어줌.
						try {						
							f.write(file);//여기가 upload파일 안에 이미지를 넣어주는 최종적인 아이,File 형식으로 넣어줘야함.					
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