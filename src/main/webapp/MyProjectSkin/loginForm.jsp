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

    }

    .input-form {
      max-width: 420px;

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
  </style>
</head>
<body>
<div class="container">
    <div class="input-form-backgroud row">
      <div class="input-form col-md-12 mx-auto">
        <h4 class="mb-3">로그인</h4>
        <form class="validation-form" novalidate>
             <div class="mb-3">
              <label for="name">아이디</label>
              <input type="text" class="form-control" id="name" placeholder="" value="" required>
            <div class="invalid-feedback">
              아이디를 입력해주세요.
            </div>
            </div>
           <div class="mb-3">
            <label for="password">비밀번호</label>
            <input type="password" class="form-control" id="password"  required>
            <div class="invalid-feedback">
              비밀번호를 입력해주세요.
            </div>
          </div>

          <div class="row">
          </div>
          <button class="btn btn-primary btn-lg btn-block" type="submit">로그인</button>
        </form>
      </div>
      <br /><br />

    </div>
  </div>
		<ul class="nav justify-content-center">
    <li class="nav-item">
      <a class="nav-link" href="#">비밀번호 찾기</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">아이디 찾기</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="../member/regist.do">회원가입</a>
    </li>
  </ul>
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
  </script>
</body>
</html>