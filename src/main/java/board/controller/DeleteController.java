package board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.dao.BoardDAO;
import board.dto.BoardDTO;
import utils.JSFunction;

@WebServlet("/board/delete.do")
public class DeleteController extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String idx= req.getParameter("idx");
		BoardDAO dao = new BoardDAO();
		BoardDTO dto = dao.selectView(idx);
		
		String user_id = (String)req.getSession().getAttribute("user_id");
		if(user_id.equals(dto.getId())) {
			//삭제
			dao.deletePost(idx);
			JSFunction.alertLocation(resp, "삭제가 완료되었습니다.", "../board/list.do");
			return;
		}else {
			JSFunction.alertBack(resp, "작성자만 삭제할 수 있습니다.");
			return;
		}
		
		
		
	}
}
