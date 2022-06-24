<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<title>Insert title here</title>
</head>
<body>




<!-- https://tworab.tistory.com/79 샘플게시판 -->
<!-- 테이블 -->
<div class="container mt-3">
	<h3>JavaProject</h3>
	<div class="btn-group btn-group-lg" style="float: right;" >
    <button type="button" class="btn btn-light">메인</button>
    <button type="button" class="btn btn-light">자유게시판</button>
    <button type="button" class="btn btn-light">공사 중</button>
    <button type="button" class="btn btn-light">주간베스트</button>
    <button type="button" class="btn btn-light">Contact Us</button>
    <button type="button" class="btn btn-light" onclick="location.href='../member/login.do';">로그인</button>
  	</div>
  	
  	<div>
    <h2>자유 게시판</h2>
  	</div>
  	
 	<table class="table table-hover">
   	<thead>
    <tr>
	    <th>번호</th>
	    <th>제목</th>
	    <th>작성자</th>
	    <th>날짜</th>
	    <th>조회수</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td>12345</td>
        <td>제목입니다</td>
        <td>admin</td>
        <td>2022-06-22</td>
        <td>13</td>
    </tr>
    <tr>
        <td>12345</td>
        <td>제목입니다</td>
        <td>admin</td>
        <td>2022-06-22</td>
        <td>13</td>
    </tr>
    <tr>
        <td>12345</td>
        <td>제목입니다</td>
        <td>admin</td>
        <td>2022-06-22</td>
        <td>13</td>
    </tr>
    </tbody>
  </table>
  
  <ul class="pagination justify-content-center">
    <li class="page-item"><a class="page-link" href="javascript:void(0);">Previous</a></li>
    <li class="page-item"><a class="page-link" href="javascript:void(0);">1</a></li>
    <li class="page-item"><a class="page-link" href="javascript:void(0);">2</a></li>
    <li class="page-item"><a class="page-link" href="javascript:void(0);">Next</a></li>
  </ul>
  
</div>



</body>
</html>