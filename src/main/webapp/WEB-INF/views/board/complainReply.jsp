<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HAPPY HOUR</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <jsp:include page="../commons/head.jsp" />
</head>
    <header>
		<jsp:include page="../commons/header.jsp" />
	</header>  
<body>
<main>
<br>
<br>

<div class="container" style="margin-top: 30px">
<div class="m-5 p-3 text-center"
         style="border: 1px solid gray;border-radius:15px;background-color:white;" id="font2">
        <h1 class="card-title text-center" style="color:#E30F0C; font-family: 'Ubuntu', sans-serif;">REPLY</h1>
        <br>


         <form name="boardF" id="boardF" action="complainInsert"
            method="post" enctype="multipart/form-data">
    
         <input type="hidden" name="mode" value="reply">
         <input type="hidden" name="num" value="${board.num}">
         <input type="hidden" name="id" value="${loginUser.id}">
         <input type="hidden" name="name" value="${loginUser.name}">
         
         <!-- 
            mode   [1] 글쓰기 : insert
                   [2] 글수정 : edit
                   [3] 답글쓰기 : reply
          -->

            <table class="table table-bordered">
               <tr>
                  <th style="width: 20%">제목</th>
                  <td style="width: 80%"><input type="text" name="title"
                     id="title" placeholder=""
                     value="[RE]${board.title}" class="form-control">
                  </td>
               </tr>
               <tr>
                  <th style="width: 20%">첨부파일</th>
                  <td style="width: 80%"><input type="file" name="mfilename"
                     id="filename" placeholder="Attach File" class="form-control">
                  </td>
               </tr>
               <tr>
                  <th style="width: 20%">첨부파일</th>
                  <td style="width: 80%"><input type="file" name="mfilename2"
                     id="filename2" placeholder="Attach File" class="form-control">
                  </td>
               </tr>
               <tr>
                  <th style="width: 20%">글내용</th>
                  <td style="width: 80%"><textarea rows="10" cols="50"
                        name="content" id="content" placeholder=""
                        class="form-control"></textarea></td>
               </tr>
            </table>
			  <div align="center">
				  <button class="btn" id="btnInsert">글쓰기</button>
			 </div>
         </form>
      </div>
   </div>


</main>
	 <footer>
		<jsp:include page="../commons/footer.jsp"/>
	</footer>
	
<script type="text/javascript">
   $(function(){
      $('#btnInsert').on('click', function(e){
         e.preventDefault();
         var $title=$('#title');
         var $content=$('#content');
         
         if(!$title.val()){
            alert('제목을 입력하세요');
            $title.focus();
            return;
         }
         if(!$content.val()){
            alert('내용을 입력하세요');
            $content.focus();
            return;
         }

         $('#boardF').submit();
 
      })
   })
</script>
