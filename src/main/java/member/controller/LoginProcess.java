package member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.dao.MemberDAO;
import member.dto.MemberDTO;

@WebServlet("/member/loginProcess.do")
public class LoginProcess extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String user_id = req.getParameter("user_id");
		String user_pass = req.getParameter("user_pass");
		MemberDAO dao = new MemberDAO();
		MemberDTO dto = dao.loginMember(user_id, user_pass);
		dao.close();
		
		if(dto.getId()!=null) {
			req.getSession().setAttribute("user_id", dto.getId());
	        req.getSession().setAttribute("user_name", dto.getName());
			resp.sendRedirect("../board/list.do");
			return;
		}
		else {
			req.getSession().setAttribute("LoginErrMsg", "아이디와 비밀번호를 확인해주세요.");
			resp.sendRedirect("../member/login.do");
			return;
		}
		
		
	}
}
