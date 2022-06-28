<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<title>Insert title here</title>
 <style>
    body {
      min-height: 100vh;
	  
      background: -webkit-gradient(linear, left bottom, right top, from(#92b5db), to(#1d466c));
      background: -webkit-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
      background: -moz-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
      background: -o-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
      background: linear-gradient(to top right, #92b5db 0%, #1d466c 100%);
    }

    .input-form {
      max-width: 580px;

      margin-top: 80px;
      padding: 32px;

      background: #fff;
      -webkit-border-radius: 10px;
      -moz-border-radius: 10px;
      border-radius: 10px;
      -webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
      -moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
      box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15)
    }
    $('.selectpicker').selectpicker({
      style: 'btn-info',
      size: 4
 	 });
  </style>
</head>
<body>
<div class="container">
    <div class="input-form-backgroud row">
      <div class="input-form col-md-12 mx-auto">
        <h4 class="mb-3">회원가입</h4>
        <form  class="validation-form" novalidate method="post" action="../member/regist.do" onsubmit="return validateForm(this);">
        
        
        
        
        <div class="row">
            <div class="col-md-6 mb-3">
              <label for="id">아이디</label>
              <c:if test="${ not empty dupchkid }">
              <input type="text" name="id" class="form-control" id="id" placeholder="" value="${ dupchkid }" required>
              </c:if>
              <input type="text" name="id" class="form-control" id="id" placeholder="" value="" required>
            </div>
            
            <div class="col-md-6 mb-3" style="padding-top: 37px; ">
             <label for="id"></label>
              <input type="button" class="" id="nickname" placeholder="" value="아이디중복검사" onclick="registerCheckFunction();" style="width: 150px;">
            </div>
            
            
            
        </div>
        
        
        
            <div class="mb-3">
              <label for="pass">비밀번호</label>
              <input type="password" name="pass" class="form-control" id="pass" placeholder="" value="" required>
            </div>
          
            <div class="mb-3">
             <label for="password">비밀번호 재확인</label>
            <input type="password" class="form-control" name="passchk" id="password" required>
            </div>
          
          
            <div class="mb-3">
              <label for="name">이름</label>
              <input type="text" name="name" class="form-control" id="name"  required>
              <div class="invalid-feedback">
                이름을 입력해주세요.
              </div>
            </div>
            
             <div class="mb-3">
              <label for="birth">생년월일</label>
              <input type="date" class="form-control" name="birth" id="birth" value="" required>
            </div>
            
            <div class="mb-3">
              <label for="gender">성별</label>
              <select class="form-control" id="gender" name="gender">
              <option selected>성별</option>
			  <option value="M">남자</option>
              <option value="F">여자</option>
              <option value="U">선택 안함</option>
			</select>	
            </div>
          
          <div class="mb-3">
            <label for="email">본인 확인 이메일</label>
            <input type="email" class="form-control" name="email" id="email" placeholder="you@example.com" required>
          </div>
          
          
          <div class="mb-3">
            <label for="phoneNum">휴대전화</label>
            <input type="text" class="form-control" name="phoneNum" id="phoneNum" placeholder="01011112222" required>
            <div class="invalid-feedback">
              전화번호를 입력해주세요.
            </div>
          </div>
          
          


          <hr class="mb-4">
          <button class="btn btn-primary btn-lg btn-block" type="submit">가입하기</button>
        </form>
      </div>
    </div>
  </div>
  <script>
var dupchkid = <%= request.getParameter("dupchkid") %>;
var idDupChk = false;
var chkId	 = '';
(function (){
if(dupchkid!=null) {
	idDupChk = true;
	chkId = dupchkid
}
}());

function validateForm(form) {  // 폼 내용 검증
    if (form.id.value == "") {
        alert("아이디를 입력하세요.");
        form.id.focus();
        return false;
    }
    if(idDupChk==false || form.id.value !=chkId ) {
        alert("중복체크를 해주세요");
        return false;
    }
    if (form.pass.value !=form.passchk.value ) {
        alert("비밀번호를 확인하세요.");
        form.pass.focus();
        return false;
    }
    if (form.passchk.value == "") {
        alert("비밀번호를 입력하세요.");
        form.passchk.focus();
        return false;
    }
    if (form.name.value == "") {
        alert("이름을 입력하세요.");
        form.name.focus();
        return false;
    }
    if (form.birth.value == "") {
        alert("생년월일을 입력하세요.");
        form.birth.focus();
        return false;
    }
    if (form.gender.value == "") {
        alert("성별을 선택해주세요.");
        form.gender.focus();
        return false;
    }
    if (form.email.value == "") {
        alert("이메일을 입력해주세요.");
        form.email.focus();
        return false;
    }
    if (form.phoneNum.value == "") {
        alert("전화번호를 입력해주세요.");
        form.phoneNum.focus();
        return false;
    }
}   

function registerCheckFunction() {
	var id = $('#id').val();
	if(id !=null || id.equals("")) {
		$.ajax({
			type: 'POST', 
			url: './dupchk.do',
			data: {id : id},
			success : function(result) {
				if(result ==0) {
					idDupChk = true;
					chkId	 = $('#id').val();
					$('#checkMessage').html('사용할 수 있는 아이디입니다.');
					$('#checkType').attr('class', 'modal-content panel-success');
				}
				else if(result ==1) {
					$('#checkMessage').html('사용할 수 없는 아이디입니다.');
					$('#checkType').attr('class', 'modal-content panel-warning');
				}
				else {
					$('#checkMessage').html('에러 발생.');
					
				}
				$('#checkModal').modal("show");
			},
		});
	}
} 
    
    
    
  </script>
  	<div class="container">

  <!-- The Modal -->
  <div class="modal" id="checkModal">
    <div class="modal-dialog">
      <div class="modal-content" id="checkType">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">확인 메세지</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body" id="checkMessage">
         
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
  
</div>
</body>
</html>