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
</html>