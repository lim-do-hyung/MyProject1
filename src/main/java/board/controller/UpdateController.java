package board.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import board.dao.BoardDAO;
import board.dto.BoardDTO;
import fileupload.FileUtil;
import utils.JSFunction;

//수정처리를 위한 매핑
@WebServlet("/board/update.do")
public class UpdateController extends HttpServlet {
	
	//수정페이지로 진입
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		/*
		파라미터로 전달된 idx값을 받은 후 기존 게시물을 조회한다.
		조회된 결과를 수정페이지의 각 input태그에 value속성으로 삽입한다.
		<textarea>는 value속성이 없으므로 태그 사이에 값을 삽입한다.
		 */
		String idx= req.getParameter("idx");
		BoardDAO dao = new BoardDAO();
		BoardDTO dto = dao.selectView(idx);
		
		String user_id = (String)req.getSession().getAttribute("user_id");
		if(dto.getId().equals(user_id)) {
			req.setAttribute("dto", dto);
			req.getRequestDispatcher("/MyProjectSkin/update.jsp").forward(req, resp);
			return;
		}else {
			JSFunction.alertBack(resp, "작성자만 수정할 수 있습니다.");
			return;
		}
		
	}
	
	//게시물 수정처리 및 파일업로드
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		/*파일업로드 처리*/
		//디렉토리의 물리적 경로 얻어오기
		String saveDirectory = req.getServletContext().getRealPath("/Uploads");
		//web.xml에 기술한 컨텍스트 초기화 파라미터를 얻어온다.
		ServletContext application = this.getServletContext();
		int maxPostSize = Integer.parseInt(application.getInitParameter("maxPostSize"));
		//파일 업로드 처리. 객체 생성과 동시에 업로드는 완료된다.
		MultipartRequest mr = FileUtil.uploadFile(req, saveDirectory, maxPostSize);
		if(mr==null) {
			JSFunction.alertBack(resp, "제한용량초과 or 디렉토리 경로를 확인하세요.");
			return;
		}
		
		
		//파일 삭제를 위한 체크박스(항목이 1개이므로 getParameter()로 받을 수 있다.)
		String wtd = mr.getParameter("wtd");
		
		//파일을 제외한 나머지 폼값을 얻어온다.
		//hidden박스에 저장된 내용(게시물 수정 및 파일수정에 필요함)
		String idx= mr.getParameter("idx");
		String prevOfile = mr.getParameter("prevOfile");
		String prevSfile = mr.getParameter("prevSfile");
		
		//사용자가 직접 입력한 값
		String user_id = (String)req.getSession().getAttribute("user_id");
		String title = mr.getParameter("title");
		String content = mr.getParameter("content");
		/*
		패스워드의 경우 인증이 완료되었을 때 session영역에 저장해두었다.
		따라서 update쿼리 실행시 사용하기 위해 session영역에서 속성값을 가져온다.
		서블릿에서는 getSession()을 통해 얻어올 수 있다.
		 */
		
		//DTO에 폼값 저장
		BoardDTO dto = new BoardDTO();
		dto.setIdx(Integer.parseInt(idx));
		dto.setId(user_id);
		dto.setTitle(title);
		dto.setContent(content);
		
		
		
		
		
		/*첨부파일에 대한 처리(삭제,대체,유지)*/
		// 삭제
		if("chkd".equals(wtd)) {
            //업로드된 파일명을 지워준다.
            dto.setOfile(null);  
            dto.setSfile(null);  
            //새로운 파일이 등록되었으므로 기존 파일은 삭제한다.
            FileUtil.deleteFile(req, "/Uploads", prevSfile);
            
		}
		//대체or유지
		else {
			//수정페이지에서 첨부한 파일이 있는 경우 파일명을 변경한다.
			String fileName = mr.getFilesystemName("ofile");
			//대체
			if(fileName != null) {
				//날짜와 시간을 이용해서 파일명을 생성한다
				String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
				//파일의 확장자를 따낸다
				String ext=  fileName.substring(fileName.lastIndexOf("."));
				//파일명과 확장자를 합쳐서 새로운 파일명을 만든다.
				String newFileName = now +ext;
				//파일 객체 생성 후 파일명을 변경한다.
				File oldFile = new File(saveDirectory + File.separator + fileName);
				File newFile = new File(saveDirectory + File.separator + newFileName);
				oldFile.renameTo(newFile);
				
				//업로드된 파일명을 DTO에 저장한다
				dto.setOfile(fileName);  
				dto.setSfile(newFileName);  
				
				//새로운 파일이 등록되었으므로 기존 파일은 삭제한다.
				FileUtil.deleteFile(req, "/Uploads", prevSfile);
			}
			//유지
			else {
				//새로운 파일을 등록하지 않는 경우에는 기존파일을 저장한다.
				dto.setOfile(prevOfile);
				dto.setSfile(prevSfile);
			}
		}
		
		
		
		
		//DB연결 및 업데이트 처리
		BoardDAO dao =new BoardDAO();
		int result =dao.updatePost(dto);
		dao.close();
		if(result ==1) {
			//수정이 완료되었다면 session에 저장된 패스워드를 지운 후 상세보기 화면으로 이동한다.
			JSFunction.alertLocation(resp, "수정이 완료되었습니다.", "../board/view.do?idx=" + idx);
			//resp.sendRedirect("../board/view.do?idx=" + idx);
		}
		else {
			JSFunction.alertLocation(resp, "로그인 후 이용해주세요", "../board/list.do");
		}
		
		
	}
}
