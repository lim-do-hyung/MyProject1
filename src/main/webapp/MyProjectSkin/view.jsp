<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
     <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<%@ include file="./commons/header.jsp" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container mt-3">
<%@ include file="./commons/top.jsp" %>


        <!-- Left메뉴영역 -->
        <!-- Contents영역 -->
            <h3>게시판 내용보기 - <small>자유게시판</small></h3>
            
            <form>
                <table class="table table-bordered">
                <colgroup>
                    <col width="20%"/>
                    <col width="30%"/>
                    <col width="20%"/>
                    <col width="*"/>
                </colgroup>
                <tbody>
                    <tr>
                        <th class="text-center" 
                            style="vertical-align:middle;">작성자</th>
                        <td colspan="3">
                            ${dto.id }
                        </td>
                        
                    </tr>
                    <tr>
                        <th class="text-center" 
                            style="vertical-align:middle;">작성일</th>
                        <td>
                            ${dto.postdate }
                        </td>
                        <th class="text-center" 
                            style="vertical-align:middle;">조회수</th>
                        <td>
                            ${dto.visitcount }
                        </td>
                    </tr>
                    <tr>
                        <th class="text-center" 
                            style="vertical-align:middle;">제목</th>
                        <td colspan="3">
                            ${dto.title }
                        </td>
                    </tr>
                    <tr>
                        <th class="text-center" 
                            style="vertical-align:middle;">내용</th>
                        <td colspan="3">
                            ${dto.content }
                            <br />
                            <br />
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <th class="text-center" 
                            style="vertical-align:middle;">첨부파일</th>
                        <td colspan="1">
                            <c:if test="${not empty dto.ofile }">
				            	${dto.ofile }
				            	<a href="../board/download.do?ofile=${dto.ofile }&sfile=${dto.sfile}&idx=${dto.idx}">[다운로드]</a>
			            	</c:if>
                        </td>
                        <th class="text-center" 
                            style="vertical-align:middle;">다운로드수</th>
                        <td style="vertical-align:middle;">${dto.downcount }</td>
                    </tr>
                </tbody>
                </table>
	
                <!-- 각종버튼 -->
                <div class="row mb-3">
                    <div class="col d-flex justify-content-end">
                        <button type="button" class="btn btn-secondary" onclick="location.href='../board/update.do?idx=${ param.idx }';">수정하기</button>
                        <button type="button" class="btn btn-success" onclick="location.href='../board/delete.do?&idx=${ param.idx }';">삭제하기</button>
                        <button type="button" class="btn btn-warning" onclick="location.href='../board/list.do';">목록보기</button>
                    </div>
                </div>
            </form>





</div>
</body>
</html>