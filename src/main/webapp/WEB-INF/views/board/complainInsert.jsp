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
    <div class="row">

        <div class="col-sm-12 text-center">
            <h1 class="text-center">건의사항</h1>

            <form name="boardF" id="boardF" action="insert" method="post"
                  enctype="multipart/form-data">

                <input type="hidden" name="mode" value="insert">
                <input type="hidden" name="id" value="${loginUser.id}">
                <table class="table table-bordered">
                    <tr>
                        <th style="width: 20%">제목</th>
                        <td style="width: 80%"><input type="text" name="title"
                                                      id="title" placeholder="" class="form-control"></td>
                    </tr>
                    <tr>
                        <th style="width: 20%">첨부파일</th>
                        <td style="width: 40%">
                        <input type="file" name="mfilename"
                            id="filename" placeholder="Attach File" class="form-control" style="margin-bottom: 0.5rem;">
                        <input type="file" name="mfilename2"
                            id="filename2" placeholder="Attach File" class="form-control"> 
                        </td>
                    </tr>
                    <tr>
                        <th style="width: 20%">글내용</th>
                        <td style="width: 80%"><textarea rows="10" cols="50"
                                                         name="content" id=content placeholder=""
                                                         class="form-control"></textarea></td>
                    </tr>
                </table>
                <div align="center">
                   <button class="btn" id="btnInsert">글쓰기</button>
                   <button type="reset" class="btn" id="btnReset">다시쓰기</button>
                </div>
            </form>
            <div class="container">
                <h6 class='text-right'>
                    <button class="btn btn-success" style="width: 100px;"
                            name="btnList" id="btnList" onclick="history.back()">목록</button>
                </h6>

            </div>

        </div>
    </div>
</div>
</main>
	 <footer>
		<jsp:include page="../commons/footer.jsp"/>
	</footer>
	
<script type="text/javascript">
    $(function() {
        $('#btnInsert').on('click', function(e) {
            e.preventDefault();
            var $title = $('#title');
            var $content = $('#content');
            if (!$title.val()) {
                alert('제목을 입력하세요');
                $title.focus();
                return;
            }
            if (!$content.val()) {
                alert('내용을 입력하세요');
                $content.focus();
                return;
            }

            $('#boardF').submit();
        })
 
    })
</script>