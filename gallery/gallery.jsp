
<%@page import="sist.com.gallery.Gallery"%>
<%@page import="java.util.List"%>
<%@page import="sist.com.gallery.GalleryDao"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>°¶·¯¸®</title>
<%request.setCharacterEncoding("EUC-KR");%>

<script type="text/javascript">
   function create(){
      var obj=document.frm;
      if(!obj.name.value||!obj.email.value||!obj.password.value||!obj.contents.value||!obj.fileName.value){
         alert("Check please !");
      }else{
         obj.submit();   
      }
   }
   function detail(imgAdd){
      var con = document.getElementById("detail");
      var img = document.getElementById("detailImg");
      var writer=document.getElementById("writer"); //»ó¼¼ÆäÀÌÁö¿¡¼­ ÀÛ¼ºÀÚ·Î ¾²¿©Áö´Â <b>ÀÇ idÀÌ´Ù.
      var no=document.getElementById("no"); //»ó¼¼ÆäÀÌÁö¿¡¼­ ÀÛ¼ºÀÚÀ§¿¡ no¸¦ ³Ö´Â <b>¸¦ ºÒ·¯¿À´Â°÷ÀÌ´Ù.
      var regdate=document.getElementById("regdate");
      var email=document.getElementById("email");
      var jspString=imgAdd.alt;//alt¿¡ no¿Í regdate¿Í emailÀÌ ´ã°ÜÀÖ´Ù.
      var jspSplit=jspString.split("#"); //alt¿¡ no¿Í regdate¿Í email ±¸ºÐÀ» #À¸·Î ±¸ºÐÇÑ´Ù.
                                         //jspSplit[0]Àº no°¡ ´ã°ÜÀÖ°í jspSplit[1]Àº regdate°¡ ´ã°ÜÀÖ°í jspSplit[2]Àº emailÀÌ ´ã°ÜÀÖ´Ù. 
                                         
      con.style.display="block";//±×¸²À» Å¬¸¯ÇÏ¸é Å©°Ô È­¸éÀ» ¶ç¾îÁØ´Ù.
      img.src=imgAdd.src;//»ó¼¼ÆäÀÌÁö¿¡ Ã£Àº ±×¸²À» ³Ö¾îÁØ´Ù
      writer.innerHTML=imgAdd.id+"´Ô";//»ó¼¼ÆäÀÌÁö¿¡ Ã£Àº ÀÛ¼ºÀÚ¸¦ ³Ö¾îÁØ´Ù
      no.innerHTML=jspSplit[0];
      regdate.innerHTML=jspSplit[1];
      email.innerHTML=jspSplit[2];
      
      var textArea=document.getElementById("textArea");//»ó¼¼ÆäÀÌÁö¿¡¼­ contentsºÎºÐÀÌ´Ù
      textArea.innerHTML=imgAdd.name;//contents¸¦ imgAdd.nameÀ¸·Î »©¿Í¼­ ³Ö¾îÁØ´Ù.
      
      var mod=document.getElementById("modifyNo");
      var del=document.getElementById("delete");
      
      mod.value=jspSplit[0];//»ó¼¼ÆäÀÌÁö¿¡ ÀÖ´Â modify ¹öÆ°¿¡ no¸¦ ³Ö¾îÁØ´Ù.
      del.value=jspSplit[0];//»ó¼¼ÆäÀÌÁö¿¡ ÀÖ´Â delete ¹öÆ°¿¡ no¸¦ ³Ö¾îÁØ´Ù.
      
      /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      
      var modname=document.getElementById("modname");
      var modemail=document.getElementById("modemail");
      var modcontents=document.getElementById("modcontents");
      var modpassword=document.getElementById("modpassword");
      var modfileName=document.getElementById("modfileName");
      
      modname.value=imgAdd.id;//¼öÁ¤ ÆäÀÌÁö¿¡ ÀÌ¸§À» ºÙ¿©ÁØ´Ù.
      modemail.value=jspSplit[2];//¼öÁ¤ ÆäÀÌÁö¿¡ ÀÌ¸ÞÀÏÀ» ºÙ¿©ÁØ´Ù.
      modcontents.value=imgAdd.name;//¼öÁ¤ ÆäÀÌÁö¿¡ ÄÁÅÙÃ÷¸¦ ºÙ¿©ÁØ´Ù.
      modpassword.value=jspSplit[3];//¼öÁ¤ ÆäÀÌÁö¿¡ ºñ¹Ð¹øÈ£¸¦ ºÙ¿©ÁØ´Ù.
     /*  modfileName.value=jspSplit[4];//¼öÁ¤ ÆäÀÌÁö¿¡ ÀÌ¹ÌÁöÆÄÀÏ ÀÌ¸§À» ºÙ¿©ÁØ´Ù. */
   }
   function out(){//»ó¼¼±×¸²¿¡¼­ x¹öÆ°
      var con = document.getElementById("detail");
      con.style.display="none";
      
      var auction2=document.getElementById("rightPan2");//°æ¸ÅÂÊ x¹öÆ°
      auction2.style.display="none";
      
      var auction=document.getElementById("rightPan");
      auction.style.animation="paused";
   }
   function modOut(){//modify¿¡¼­ x¹öÆ°
	   var modWindow=document.getElementById("modifyWindow");
	   modWindow.style.display="none";
   }
   function delOut(){//delete¿¡¼­ x¹öÆ°
	   var delWindow=document.getElementById("deleteWindow");
	   delWindow.style.display="none";
	   
	   document.getElementById("password").value="";
   }
   function opa(number){
      var opa=document.getElementById("detailImg");
      if(number==0){
      opa.style.opacity="1";
      }else{
         opa.style.opacity="1";
      }
   }
   function mod(){//¼öÁ¤ÇÏ´Â div¸¦ º¸¿©ÁÜ
	  var modWindow=document.getElementById("modifyWindow");
	  modWindow.style.display="block";
	  
   }
   function modifyDB(){//DB·Î ¼öÁ¤À» ÇÑ ³»¿ëÀ» ³¯¸®¸é¼­ UPDATEÇØÁØ´Ù
	   var obj=document.getElementById("frmMod");
	   obj.submit();
   }
   function del(){//password¸¦ È®ÀÎÇÏ´Â div¸¦ º¸¿©ÁÜ
	   var delWindow=document.getElementById("deleteWindow");
	   delWindow.style.display="block";   
   }
   function deleteDB(){//DB·Î delete¸¦ ³¯¸®´Â°÷
	   var obj=document.getElementById("frmDel");
       
   	   if(!obj.password.value){
   		   alert("Password Check !");
   	   }else{
	       obj.submit(); 
   	   }
   }
   function auction(){//°æ¸Å ¹öÆ° ´©¸£¸é È­¸é ¹Ù²Ù±â
	   var auction=document.getElementById("rightPan");
	   auction.style.animation="ani 2s forwards";
	   var auction2=document.getElementById("rightPan2");
	   /* auction2.style.animation="ani2 2s reverse forwards"; */
	   auction2.style.display="block";
	   auction2.style.animation="ani2 3s forwards";
   }
   
   
</script>
<style type="text/css">
	
	@keyframes ani{	
	  
	  100%{
		   transform:rotateY(180deg);
		   backface-visibility:hidden;  		
	      }	
	}
	@keyframes ani2{	
	 
	  100%{		
		    transform: translateX(-708px);
		   
	      }	
	}
	
</style>
</head>
<body >
<%   
   List<Gallery> list=GalleryDao.Sing().selectAll();
%>

   
    <div style="position:fixed; box-shadow:12px 12px 2px 1px #999; float: left; width:250px; height: 630px; background-image: url(/webGallery/upload/mint.jpg); background-size: 100% 100%;">
      <div style=" float:left; margin-left:80px; margin-top: 30px; width: 140px; height: 70px;">
         <img alt="·Î°í" src="logo.png">
      </div>
      <div style="box-shadow:4px 4px 3px 1px #999; border-radius:10px 10px 10px 10px; background-color: white; width:55px; float: left; margin-top: 30px; margin-left: 95px;">
         <a href="javascript:create()" style="text-decoration: none; "><b style=" color: black; font-style: oblique;">Create</b></a>
      </div>
      <div style="float: left;">
         <form name="frm" action="gallery-usebean.jsp" method="post" enctype="multipart/form-data">
            <b style="color: black; font-style: oblique; float: left; margin-top: 10px; margin-left: 30px; ">Name</b>
            <input name="name" style="border-radius:10px 10px 10px 10px; margin-left:22px; margin-top: 0px; float: left; width: 200px; height: 30px;" type="text">
            <b style="color: black; font-style: oblique; float: left; margin-top: 10px; margin-left: 30px; ">Email</b>
            <input name="email" style="border-radius:10px 10px 10px 10px; margin-left:22px; margin-top: 0px; float: left; width: 200px; height: 30px;" type="text">
            <b style="color: black; font-style: oblique; float: left; margin-top: 10px; margin-left: 30px; ">Password</b>
            <input name="password" style="border-radius:10px 10px 10px 10px; margin-left:22px; margin-top: 0px; float: left; width: 200px; height: 30px;" type="text">
            <b style="color: black; font-style: oblique; float: left; margin-top: 10px; margin-left: 30px; ">Contents</b>
            <input name="contents" style="border-radius:10px 10px 10px 10px; margin-left:22px; margin-top: 0px; float: left; width: 200px; height: 30px;" type="text">
            <label style="cursor:pointer; box-shadow: 7px 7px 3px 1px #999; border-color:pink; border-radius:10px 10px 10px 10px; padding:5px 45px 5px 45px;
             float: left; margin-left: 22px; margin-top: 20px; background: white; display: block; font-weight: 600;">upload picture 
               <input name="fileName" type="file" style="display: none;">
            </label>
            <a href="javascript:create()" style="text-decoration:none;"><b style="box-shadow:7px 7px 3px 1px #999; border-radius:10px 10px 10px 10px; color:black; 
            float: left; margin-left: 22px; margin-top: 20px; background: white; padding: 8px 40px 8px 40px;">Put up a picture</b></a>
         </form>
      </div>
    </div>
    
    <div style=" background-color: white; float: left; width:1000px; height: 630px; margin-left: 280px;"><!--¿À¸¥ÂÊ ±×¸²µéÀÌ ÀÖ´Â°÷ -->  
      <% for(int i=0; i<list.size() ; i++){ 
      %>
      <div style=" float: left; margin-left: 40px; margin-top: 80px;">
         <a href="#" style="color: black;"><img name="<%= list.get(i).getContents()%>" id="<%= list.get(i).getName() %>" onclick="detail(this)" 
         alt="<%=list.get(i).getNo()%>#<%=list.get(i).getRegdate()%>#<%=list.get(i).getEmail()%>#<%=list.get(i).getPassword()%>#<%=list.get(i).getFileName()%>" src="/webGallery/upload/<%= list.get(i).getFileName() %>" width="150px" height="200px;" border="0px;" style="box-shadow: 15px 20px 4px 4px #999;"></a>      
      </div>
      <%
      }
      %>
    </div>
    
   
   <form action="gallery-modify.jsp" method="post" name="frmDetail" id="frmDetail">
     <div id="detail"  style="position: absolute; top: 20px; left: 200px; display:none; box-shadow: rgba(142, 136, 136, 0.68) 0px 60px 10px 30px;">
      <img id="detailImg" width="700px" height="600px" src="" style="float:left;"  onmouseover="opa(0)" onmouseout="opa(1)"> 
      <div id="rightPan" style="float:left; width: 300px; height: 600px; background-color: #fff8f8;">
          <div style="float: left; width: 300px; height: 20px;">
            <b id="no" style="font-size:14px; float: left; margin-left: 25px; margin-top: 11px;"></b>
            <a href="#"><img alt="" src="/webGallery/upload/close.png" width="30px" height="30px" style=" float: left; margin-left: 220px;" onclick="out(),delOut(),modOut()" ></a>
          </div>     
          <div style="float: left; width: 300px; height: 50px;">
            <b id="writer" style="color:black; font-family:serif; font-size:18px; font-weight: bold; float: left; margin-left: 24px; margin-top: 19px;"></b>
            <b id="email" style="font-size:13px; float: left; margin-left: 40px; margin-top: 17px;"></b>
          </div>
          <div style="float: left; width: 300px;">
            <a href="javascript:mod()" style="text-decoration:none;" ><b  style="margin-left:20px; box-shadow:5px 5px 3px 1px #999; border-radius:10px 10px 10px 10px; color:black; 
            float: left;background: white; padding: 3px 8px 3px 8px; font-size: 14px;">Modify</b>
              <!-- <input type="hidden" id="modify" name="modify" value=""> -->
            </a>
           <a href="javascript:del()" style="text-decoration:none;" ><b  style="margin-left:20px; box-shadow:5px 5px 3px 1px #999; border-radius:10px 10px 10px 10px; color:black; 
            float: left;background: white; padding: 3px 8px 3px 8px; font-size: 14px;">Delete</b>
              <!-- <input type="hidden" id="delete" name="delete" value=""> -->
            </a>
          </div>
          <div style="margin-left:25px; margin-top: 120px; width: 250px;">
             <hr style="">
          </div>
          <div style="margin-left:10px; width: 300px;">
             <b id="regdate" style="float: left; margin-left: 18px; font-size: 14px; color: red;"></b>
          </div>
          <div style="float: left; margin-left: 6px; margin-top: 20px;">
             <textarea id="textArea" rows="10" cols="31" readonly="readonly" style="padding-left:20px; resize: none; font-size: 15px; font-weight: bold; background-color: #fff8f8; border: none; "></textarea>
          </div>
          <div style="float: left; margin-top: 180px; width: 300px;height: 70px;">
          	 <a id="auction" href="javascript:auction()" style="color:black; box-shadow:5px 5px 3px 1px #999; float:left; margin-top:10px; padding:6px 20px 8px 20px; text-decoration: none; border-radius:20px 20px 20px 20px;"><b style="font-size: 16px;">Auctioneering</b></a>
          </div>
      </div>
     </div>
   </form>
   
    <div id="modifyWindow" style="position:absolute; display:none; top:10px; left:640px; border-radius:20px 20px 20px 20px; box-shadow:rgba(142, 136, 136, 0.68) 0px 51px 20px 26px;; 
    width:250px; height: 630px; background-image: url(/webGallery/upload/mintT.jpg); background-size: 100% 100%;">
      <a href="#"><img alt="" src="/webGallery/upload/close.png" width="30px" height="30px" style=" float: right; margin-right: 8px; margin-top:8px;" onclick="modOut()" ></a>   
      <div style=" float:left; margin-left:80px; margin-top: 50px; height: 80px;"><!--·Î°í-->
      	<img alt="·Î°í" src="logo.png">
      </div>
      <div style="padding:5px 5px 5px 5px; box-shadow:4px 4px 3px 1px #999; border-radius:10px 10px 10px 10px; background-color: white; width:55px; float: left; margin-top: 25px; margin-left: 90px;">
         <a href="javascript:" style="text-decoration: none; "><b style=" color: black; font-style: oblique;">Modify</b></a>
      </div>
      <div style="float: left;">
         <form id="frmMod" name="frmMod" action="gallery-modify.jsp" method="post">
           <input type="hidden" id="modifyNo" name="modifyNo" value="">
            <b style="color: black; font-style: oblique; float: left; margin-top: 10px; margin-left: 30px; ">Name</b>
            <input id="modname" name="modname" style="border-radius:10px 10px 10px 10px; margin-left:22px; margin-top: 0px; float: left; width: 200px; height: 30px;" type="text">
            <b style="color: black; font-style: oblique; float: left; margin-top: 10px; margin-left: 30px; ">Email</b>
            <input id="modemail" name="modemail" style="border-radius:10px 10px 10px 10px; margin-left:22px; margin-top: 0px; float: left; width: 200px; height: 30px;" type="text">
            <b style="color: black; font-style: oblique; float: left; margin-top: 10px; margin-left: 30px; ">Contents</b>
            <input id="modcontents" name="modcontents" style="border-radius:10px 10px 10px 10px; margin-left:22px; margin-top: 0px; float: left; width: 200px; height: 30px;" type="text">
            <b style="color: black; font-style: oblique; float: left; margin-top: 10px; margin-left: 30px; ">Password</b>
            <input id="modpassword" name="modpassword" style="border-radius:10px 10px 10px 10px; margin-left:22px; margin-top: 0px; float: left; width: 200px; height: 30px;" type="text">
            <label style="cursor:pointer; box-shadow: 7px 7px 3px 1px #999; border-color:pink; border-radius:10px 10px 10px 10px; padding:5px 37px 5px 37px;
             float: left; margin-left: 22px; margin-top: 20px; background: white; display: block; font-weight: 600;">exchange picture 
               <input name="modfileName" type="file" style="display: none;">
            </label>
            <a href="javascript:modifyDB()" style="text-decoration:none;"><b style="box-shadow:7px 7px 3px 1px #999; border-radius:10px 10px 10px 10px; color:black; 
            float: left; margin-left: 22px; margin-top: 20px; background: white; padding: 8px 46px 8px 46px;">Modify picture</b></a>
         </form>
      </div>
    </div>
    
    <div id="deleteWindow" style="position:absolute; display:none; top:90px; left:1080px; border-radius:20px 20px 20px 20px; box-shadow:rgba(142, 136, 136, 0.68) 25px 26px 18px 3px; 
    width:250px; height: 230px; background-image: url(/webGallery/upload/som.jpeg); background-size: 100% 100%;">
      <a href="#"><img alt="" src="/webGallery/upload/close.png" width="30px" height="30px" style=" float: right; margin-right: 8px; margin-top:8px;" onclick="delOut()" ></a>   
      <div style="background-color:pink; float:left; margin-left:20px; margin-top: 10px;"><!--·Î°í-->
      	
      </div>
      <div style="float: left;">
         <form id="frmDel" name="frmDel" action="gallery-delete.jsp" method="post">
            <b style="color: black; font-style: oblique; float: left; margin-top: 10px; margin-left: 30px; ">Password</b>
            <input type="hidden" id="delete" name="delete" value="">
            <input name="password" id="password" style="border-radius:10px 10px 10px 10px; margin-left:22px; margin-top: 0px; float: left; width: 200px; height: 30px;" type="password">
            <a href="javascript:deleteDB()" style="text-decoration:none;"><b style="box-shadow:7px 7px 3px 1px #999; border-radius:10px 10px 10px 10px; color:black; 
            float: left; margin-left: 22px; margin-top: 20px; background: white; padding: 8px 40px 8px 40px;">Password Check</b></a>
         </form>
      </div>
    </div>
    
    <div id="rightPan2" style="display:none; position:absolute; margin-top:11px; margin-left:1600px;  float:left; width: 300px; height: 600px; background-color: #fff8f8;">
          <div style="float: left; width: 300px; height: 20px;">
            <b id="no2" style="font-size:14px; float: left; margin-left: 25px; margin-top: 11px;"></b>
            <a href="#"><img alt="" src="/webGallery/upload/close.png" width="30px" height="30px" style=" float: left; margin-left: 245px;" onclick="out(),delOut(),modOut()" ></a>
          </div>     
          <div style="float: left; width: 300px; height: 50px;">
            <b id="writer2" style="color:black; font-family:serif; font-size:18px; font-weight: bold; float: left; margin-left: 24px; margin-top: 19px;"></b>
            <b id="email2" style="font-size:13px; float: left; margin-left: 40px; margin-top: 17px;"></b>
          </div>
          <div style="float: left; width: 300px;">
            <a href="#" style="text-decoration:none;" ><b  style="margin-left:20px; box-shadow:5px 5px 3px 1px #999; border-radius:10px 10px 10px 10px; color:black; 
            float: left;background: white; padding: 3px 8px 3px 8px; font-size: 14px;">Modify</b>
              <input type="hidden" id="modify2" name="modify2" value="">
            </a>
           <a href="#" style="text-decoration:none;" ><b  style="margin-left:20px; box-shadow:5px 5px 3px 1px #999; border-radius:10px 10px 10px 10px; color:black; 
            float: left;background: white; padding: 3px 8px 3px 8px; font-size: 14px;">Delete</b>
              <input type="hidden" id="delete2" name="delete2" value="">
            </a>
          </div>
          <div style="margin-left:25px; margin-top: 120px; width: 250px;">
             <hr style="">
          </div>
          <div style="margin-left:10px; width: 300px;">
             <b id="regdate2" style="float: left; margin-left: 18px; font-size: 14px; color: red;"></b>
          </div>
          <div style="float: left; margin-left: 6px; margin-top: 20px;">
             <textarea id="textArea2" rows="10" cols="31" readonly="readonly" style="padding-left:20px; resize: none; font-size: 15px; font-weight: bold; background-color: #fff8f8; border: none; "></textarea>
          </div>
          <div style="float: left; margin-top: 180px; width: 300px;height: 90px;">
          	 <a id="" href="javascript:()" style="background-color:white; margin-left:6%;margin-top:40px; box-shadow:5px 5px 3px 1px #999; float:left; padding:6px 20px 8px 20px; text-decoration: none; border-radius:20px 20px 20px 20px; color:black;"><b style="font-size: 18px;">ÀÔÂûÇÏ±â</b></a>
          	 <a id="" href="javascript:()" style="background-color:white;margin-left:9%;margin-top:40px; box-shadow:5px 5px 3px 1px #999; float:left;  padding:6px 20px 8px 20px; text-decoration: none; border-radius:20px 20px 20px 20px; color:black;"><b style="font-size: 18px;">Áï½Ã±¸¸Å</b></a>
          </div>
      </div> 
    
</body>
</html>