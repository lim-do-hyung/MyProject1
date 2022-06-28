<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<%@ include file="./commons/header.jsp" %>
<body>





<!-- https://tworab.tistory.com/79 샘플게시판 -->
<!-- 테이블 -->
<div class="container mt-3">
	<%@ include file="./commons/top.jsp" %>
  	
 	<table class="table table-hover">
 	<colgroup>
      <col style="width:7%">
      <col>
      <col style="width:18%">
      <col style="width:10%">
      <col style="width:6%">
      <col style="width:8%">
    </colgroup>
   	<thead>
    <tr>
	    <th>번호</th>
	    <th>제목</th>
	    <th>글쓴이</th>
	    <th>작성일</th>
	    <th>조회수</th>
	    <th>첨부파일</th>
    </tr>
    </thead>
    <tbody>
    <c:choose>
    	<c:when test="${empty boardLists }">
    		<tr>
    			<td colspan="6">
    				등록된 게시물이 없습니다.
    			</td>
    		</tr>
    	
    	
    	</c:when>
    <c:otherwise>
    	<c:forEach items="${boardLists }" var="row" varStatus="loop">
			<tr>
				<td>${ map.totalCount - (((map.pageNum-1) * map.pageSize) + loop.index)}</td>
                <td class="text-start"><a href="../board/view.do?idx=${ row.idx }">${row.title }</a></td>
                <td>${ row.id }</td>
                <td>${ row.postdate }</td>
                <td>${ row.visitcount }</td>
                <c:if test="${ not empty row.ofile }">
                <td><i class="bi-pin-angle-fill" style="font-size: 1rem;"><a href="../board/download.do?ofile=${ row.ofile }&sfile=${ row.sfile }&idx=${ row.idx }">[Down]</a></i></td>
                </c:if>
			</tr>	    	
    	
    	</c:forEach>
    </c:otherwise>
    </c:choose>
    </tbody>
  </table>
  
  <!-- 페이징 -->
  <ul class="pagination justify-content-center">
  	${ map.pagingImg }
  </ul>
  
  
  <div class="col d-flex justify-content-end">
	<button type="button" class="btn btn-primary" onclick="location.href='../board/write.do';">글쓰기</button>
  </div>
</div>



<div class="row">
                <form method="get">
                
                
                    <div class="input-group mb-3" style="width: 600px; margin-left: 37%;">
                        <select name="searchField" class="form-control">
                            <option value="title">제목</option>
                            <option value="content">내용</option>
                            <option value="id">작성자</option>
                        </select>
                        <input type="text" class="form-control" name="searchWord" placeholder="Search" style="width: 200px;">
                        <button class="btn btn-success" type="submit">
                            검색
                        </button>
                    </div>
                    
                    
                    
                </form>
            </div>


</body>
=======
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
>>>>>>> refs/remotes/origin/main
</html>