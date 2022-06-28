<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<h3>JavaProject</h3>
	<div class="btn-group btn-group-lg" style="float: right;" >
    <c:if test="${not empty user_name }">
    	<span style="padding-top: 15px;"><a href="#">${user_name }</a>님 환영합니다.</span>
    </c:if>
    <button type="button" class="btn btn-light" onclick="location.href='../notimp/main.do';">메인</button>
    <button type="button" class="btn btn-light" onclick="location.href='../board/list.do';">자유게시판</button>
    <button type="button" class="btn btn-light" onclick="location.href='../notimp/weeklyBest.do';">주간베스트</button>
    <button type="button" class="btn btn-light" onclick="location.href='../notimp/notice.do';">공지사항</button>
    <c:if test="${empty user_name }">
	    <button type="button" class="btn btn-light" onclick="location.href='../member/login.do';">로그인</button>
    </c:if>
    <c:if test="${not empty user_name }">
    	<button type="button" class="btn btn-light" onclick="location.href='../member/logout.do';">로그아웃</button>
    </c:if>
  	</div>
  	
  	
  	<div>
    <h2>자유 게시판</h2>
  	</div>