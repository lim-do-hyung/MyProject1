<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
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
        <form class="validation-form" novalidate method="post" action="../member/regist.do">
        
        
        
        
        <div class="row">
            <div class="col-md-6 mb-3">
              <label for="id">아이디</label>
              <input type="text" name="id" class="form-control" id="id" placeholder="" value="" required>
              <div class="invalid-feedback">
                아이디를 입력해주세요.
              </div>
            </div>
            
            <div class="col-md-6 mb-3" style="padding-top: 37px; ">
             <label for="id"></label>
              <input type="button" class="" id="nickname" placeholder="" value="아이디중복검사" onclick="" style="width: 150px;" required>
            </div>
            
            
            
        </div>
        
        
        
            <div class="mb-3">
              <label for="pass">비밀번호</label>
              <input type="password" name="pass" class="form-control" id="pass" placeholder="" value="" required>
              <div class="invalid-feedback">
                비밀번호을 입력해주세요.
              </div>
            </div>
          
            <div class="mb-3">
             <label for="password">비밀번호 재확인</label>
            <input type="password" class="form-control" id="password" required>
            <div class="invalid-feedback">
              비밀번호을 입력해주세요.
            </div>
            </div>
          
          
            <div class="mb-3">
              <label for="name1">이름</label>
              <input type="text" name="name1" class="form-control" id="name1"  required>
              <div class="invalid-feedback">
                이름을 입력해주세요.
              </div>
            </div>
            
             <div class="mb-3">
              <label for="birth">생년월일</label>
              <input type="date" class="form-control" name="birth" id="birth" placeholder="19920415" value="" required>
              <div class="invalid-feedback">
                생년월일을 입력해주세요.
              </div>
            </div>
            
            <div class="mb-3">
              <label for="gender">성별</label>
              <select class="form-control" id="gender" name="gender">
              <option selected>성별</option>
			  <option value="M">남자</option>
              <option value="F">여자</option>
              <option value="U">선택 안함</option>
			</select>	
              <div class="invalid-feedback">
                성별을 입력해주세요.
              </div>
            </div>
          
          <div class="mb-3">
            <label for="email">본인 확인 이메일</label>
            <input type="email" class="form-control" name="email" id="email" placeholder="you@example.com" required>
            <div class="invalid-feedback">
              이메일을 입력해주세요.
            </div>
          </div>
          
          
          <div class="mb-3">
            <label for="phoneNum">휴대전화</label>
            <input type="text" class="form-control" name="phoneNum" id="phoneNum" placeholder="01011112222" required>
            <div class="invalid-feedback">
              전화번호를 입력해주세요.
            </div>
          </div>
          
          


          <hr class="mb-4">
          <div class="custom-control custom-checkbox">
            <input type="checkbox" class="custom-control-input" id="aggrement" required>
            <label class="custom-control-label" for="aggrement">개인정보 수집 및 이용에 동의합니다.</label>
          </div>
          <div class="mb-4"></div>
          <button class="btn btn-primary btn-lg btn-block" type="submit">가입하기</button>
        </form>
      </div>
    </div>
  </div>
  <script>
    window.addEventListener('load', () => {
      const forms = document.getElementsByClassName('validation-form');

      Array.prototype.filter.call(forms, (form) => {
        form.addEventListener('submit', function (event) {
          if (form.checkValidity() === false) {
            event.preventDefault();
            event.stopPropagation();
          }

          form.classList.add('was-validated');
        }, false);
      });
    }, false);
    
    $('.selectpicker').selectpicker();
  </script>
</body>
</html>