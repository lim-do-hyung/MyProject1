package member.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.dao.MemberDAO;
import utils.JSFunction;

@WebServlet("/member/dupchk.do")
public class DuplicateCheckComtroller extends HttpServlet {
	
	
	
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MemberDAO dao = new MemberDAO();
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		String id = req.getParameter("id");
		map.put("id", id);
		
		resp.getWriter().write(dao.duplicateCheck(map)+"");
		
		
		
	}
}
