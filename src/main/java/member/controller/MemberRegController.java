package member.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.dao.MemberDAO;
import member.dto.MemberDTO;

public class MemberRegController extends HttpServlet {
	
	//회원가입 페이지 진입
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/MyProjectSkin/SignUpForm.jsp").forward(req, resp);
	}
	
	// 회원가입 처리
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		ServletContext application = getServletContext();
		
		
		MemberDTO dto = new MemberDTO();

		//추가로 set 할거 
		dto.setId(req.getParameter("id"));
		dto.setPass(req.getParameter("pass"));
		dto.setName(req.getParameter("name"));
		dto.setBirthday(Date.valueOf(req.getParameter("birth")));
		dto.setGender(req.getParameter("gender"));
		dto.setEmail(req.getParameter("email"));
		dto.setPhonenum(req.getParameter("phoneNum"));
		
		
		
		
		MemberDAO dao = new MemberDAO();
		int result = dao.insertMember(dto);
		
		dao.close();
		
		if (result == 1) {        	
        	//insert에 성공하면 로그인폼으로 이동한다.
			req.getSession().setAttribute("RegSuccess", "회원가입에 성공했습니다.");
            resp.sendRedirect("../member/login.do");
        }
        else {
        	//insert에 실패하면 작성페이지로 다시 이동한다.
            resp.sendRedirect("../member/regist.do");
        }
		
	}
	
	
}
