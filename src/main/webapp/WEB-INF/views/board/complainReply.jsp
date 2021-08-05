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

<div class="container" style="margin-top: 30px">
   <div class="row">
      <div class="col-sm-9 text-center">
         <h1 class="text-center">답글쓰기</h1>


         <form name="boardF" id="boardF" action="insert"
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

               <tr>
                  <td colspan="2" class="text-center">
                     <button class="btn btn-success" id="btnInsert">글쓰기</button>
                     <button type="reset" class="btn btn-warning" id="btnReset">다시쓰기</button>
                  </td>
               </tr>
            </table>

         </form>
      </div>
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
