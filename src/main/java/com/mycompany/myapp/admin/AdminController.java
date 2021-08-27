package com.mycompany.myapp.admin;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mycompany.common.CommonUtil;
import com.mycompany.myapp.board.BoardDTO;
import com.mycompany.myapp.board.BoardService;
import com.mycompany.myapp.board.CommentDTO;
import com.mycompany.myapp.board.PagingDTO;
import com.mycompany.myapp.user.UserDTO;
import com.mycompany.myapp.user.UserService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping(value = { "admin", "" })
public class AdminController {

	@Autowired
	private AdminService adminService;
	
	@Autowired
	private BoardService boardService;

	@Autowired
	private UserService userService;

	@Autowired
	private CommonUtil util;

	@GetMapping("/admin")
	public String adminHome(Model m, HttpSession ses) {

		UserDTO loginUser = (UserDTO) ses.getAttribute("loginUser");
		String str = "";
		String loc;

		if (loginUser == null) {
			str = "로그인 후 이용이 가능합니다.";
			loc = "/happyhour";
			return util.addMsgLoc(m, str, loc);
		}

		return "admin/adminHome";
	}

	@GetMapping("/userList")
	public String userList(Model m, HttpServletRequest req, @RequestHeader("User-Agent") String userAgent,
			@ModelAttribute("paging") AdminPagingDTO paging, HttpSession ses) {

		UserDTO loginUser = (UserDTO) ses.getAttribute("loginUser");
		String str = "";
		String loc;

		if (loginUser == null) {
			str = "로그인 후 이용이 가능합니다.";
			loc = "/happyhour";
			return util.addMsgLoc(m, str, loc);
		}

		int totalUser = this.adminService.getUserCount(paging);

		paging.setTotalCount(totalUser);
		paging.setPagingBlock(5);
		paging.init(req.getSession());

		List<UserDTO> userList = adminService.listUser(paging);

		String myctx = req.getContextPath();

		loc = "/userList";
		String pageNavi = paging.getPageNavi(myctx, loc, userAgent);

		m.addAttribute("userList", userList);
		m.addAttribute("totalCount", totalUser);
		m.addAttribute("pageNavi", pageNavi);

		return "admin/userList";
	}

	 @RequestMapping("/userEdit/{origin_num}")
	 public String adminEdit(Model m, HttpServletRequest req, @PathVariable("origin_num") Integer origin_num, HttpSession ses) {

		UserDTO loginUser = (UserDTO) ses.getAttribute("loginUser");
		String str = "";
		String loc;

		if (loginUser == null) {
			str = "로그인 후 이용이 가능합니다.";
			loc = "/happyhour";
			return util.addMsgLoc(m, str, loc);
		}
		 
		if (origin_num == null) {
			return util.addMsgLoc(m, "오류가 발생하였습니다.", "/happyhour");
		}

		UserDTO user = this.adminService.getUserInfo(origin_num);
		m.addAttribute("user", user);

		return "admin/userEdit";
	}

	
	  @RequestMapping(value="/{origin_num}/userEdit", method = RequestMethod.POST)
	  public String adminEditEnd(Model m, @ModelAttribute("user") UserDTO user, HttpSession ses) {
		  
		UserDTO loginUser = (UserDTO) ses.getAttribute("loginUser");
		String str = "";
		String loc;

		if (loginUser == null) {
			str = "로그인 후 이용이 가능합니다.";
			loc = "/happyhour";
			return util.addMsgLoc(m, str, loc);
		}
	  
	  System.out.println(user); int n = this.adminService.updateUser(user);
	  
	  str = (n > 0) ? "수정되었습니다." : "오류가 발생하였습니다."; 
	  loc = (n > 0) ? "/happyhour/admin/userList" : "javascript:history.back()"; 
	  return util.addMsgLoc(m, str, loc); 
	  
	  }
	  
	 
	@PostMapping("/userDelete")
	public String adminDel(Model m, @RequestParam Integer origin_num, HttpSession ses) {
		
		UserDTO loginUser = (UserDTO) ses.getAttribute("loginUser");
		String str = "";
		String loc;

		if (loginUser == null) {
			str = "로그인 후 이용이 가능합니다.";
			loc = "/happyhour";
			return util.addMsgLoc(m, str, loc);
		}
		

		if (origin_num == null) {
			return util.addMsgLoc(m, "오류가 발생하였습니다.", "/happyhour");
		}

		int n = adminService.deleteUser(origin_num);

		System.out.println(n);
		str = (n > 0) ? "해당 회원의 탈퇴 처리가 완료되었습니다." : "오류가 발생하였습니다.";
		loc = (n > 0) ? "/happyhour/admin/userList" : "javascript:history.back()";

		return util.addMsgLoc(m, str, loc);
	}
	
	@GetMapping("/boardList")
	public String boardList(Model m, HttpServletRequest req, @RequestHeader("User-Agent") String userAgent,
			@ModelAttribute("paging") PagingDTO paging,
			@RequestParam(value = "findKeyword", required = false) String findKeyword,
			@RequestParam(value = "findType", required = false) String findType, HttpSession ses) throws Exception {
		
		UserDTO loginUser = (UserDTO) ses.getAttribute("loginUser");
		String str = "";
		String loc;

		if (loginUser == null) {
			str = "로그인 후 이용이 가능합니다.";
			loc = "/happyhour";
			return util.addMsgLoc(m, str, loc);
		}
		
		
		int totalCount = this.boardService.getTotalCount(paging);
		paging.setTotalCount(totalCount);
		paging.setPagingBlock(10);// 페이징 블럭 단위값 => 10
		paging.init(req.getSession());

		List<BoardDTO> boardList = this.boardService.selectBoardAll(paging);

		String myctx = req.getContextPath();
		loc = "/boardList";
		String pageNavi = paging.getPageNavi(myctx, loc, userAgent);

		m.addAttribute("totalCount", totalCount);
		m.addAttribute("boardList", boardList);
		m.addAttribute("pageNavi", pageNavi);

		return "admin/boardList";
	}
	
	@GetMapping("/view")
	public String boardView(Model m, @RequestParam(defaultValue = "0") Integer num, String id, HttpSession ses) {
		
		UserDTO loginUser = (UserDTO) ses.getAttribute("loginUser");
		String str = "";
		String loc;

		if (loginUser == null) {
			str = "로그인 후 이용이 가능합니다.";
			loc = "/happyhour";
			return util.addMsgLoc(m, str, loc);
		}
		
		
		if (num == 0) {
			return "redirect:boardList";
		}
		// 1. 조회수 증가
		this.boardService.updatehits(num);

		// 2. 글번호로 해당 글 가져오기
		BoardDTO board = boardService.selectBoardByNum(num);

		m.addAttribute("board", board);
		m.addAttribute("commentDTO", new CommentDTO());

		return "board/boardView";
	}


	@PostMapping("/delete")
	public String complainDelete(Model m, @RequestParam(defaultValue = " ") int num, HttpSession ses) {
		
		UserDTO loginUser = (UserDTO) ses.getAttribute("loginUser");
		String str = "";
		String loc;

		if (loginUser == null) {
			str = "로그인 후 이용이 가능합니다.";
			loc = "/happyhour";
			return util.addMsgLoc(m, str, loc);
		}
		
		if (num == 0) {
			return "redirect:complain";
		}
		// db 삭제
		int n = boardService.deleteBoard(num);
		str = (n > 0) ? "게시글이 삭제되었습니다" : "게시글이 삭제되지 않았습니다";
		return util.addMsgLoc(m, str, "boardList");
	}// ----------------------------------------
	
	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	public String complainInsert(Model model, HttpServletRequest req, HttpSession ses,
			@ModelAttribute("board") BoardDTO board) {

		UserDTO loginUser = (UserDTO) ses.getAttribute("loginUser");
		String str = "";
		String loc;

		if (loginUser == null) {
			str = "로그인 후 글쓰기가 가능합니다.";
			loc = "javascript:history.back()";
			return util.addMsgLoc(model, str, loc);
		} else {
			String name = loginUser.getName();
			String id = loginUser.getId();
			board.setName(name);
			board.setId(id);
		}

		return "board/complainInsert";
	}
	
	
	@PostMapping(value = "/fileDown", produces = "application/octet-stream")
	@ResponseBody
	public ResponseEntity<org.springframework.core.io.Resource> download(HttpServletRequest req,
			@RequestHeader("User-Agent") String userAgent, @RequestParam("fname") String fname,
			@RequestParam("origin_fname") String origin_fname) {

		// 업로드된 디렉토리의 절대경로 얻기
		ServletContext app = req.getServletContext();
		String upDir = app.getRealPath("/Upload");
		String filePath = upDir + File.separator + fname;
		log.info("filePath===" + filePath);

		org.springframework.core.io.Resource resource = new FileSystemResource(filePath);

		if (!resource.exists()) {
			return new ResponseEntity(HttpStatus.NOT_FOUND);
		}
		// 브라우저 유형 별 인코딩
		boolean checkIE = (userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") > -1);
		String downloadName = null;
		try {
			if (checkIE) {
				// IE인 경우
				downloadName = URLEncoder.encode(origin_fname, "UTF-8").replaceAll("\\+", " ");
			} else {
				downloadName = new String(origin_fname.getBytes("UTF-8"), "ISO-8859-1");
			}

		} catch (UnsupportedEncodingException e) {
			log.error("파일 다운로드 중 error: " + e);
		}

		// HttpHeaders객체 생성해서 헤더 정보 설정
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Disposition", "attachment; filename=" + downloadName);

		return new ResponseEntity<>(resource, headers, HttpStatus.OK);
	}// ----------------------------------------

	@PostMapping(value = "/fileDown2", produces = "application/octet-stream")
	@ResponseBody
	public ResponseEntity<org.springframework.core.io.Resource> download2(HttpServletRequest req,
			@RequestHeader("User-Agent") String userAgent, @RequestParam("fname2") String fname2,
			@RequestParam("origin_fname2") String origin_fname2) {

		// 업로드된 디렉토리의 절대경로 얻기
		ServletContext app = req.getServletContext();
		String upDir = app.getRealPath("/Upload");
		String filePath = upDir + File.separator + fname2;
		log.info("filePath===" + filePath);

		org.springframework.core.io.Resource resource = new FileSystemResource(filePath);

		if (!resource.exists()) {
			return new ResponseEntity(HttpStatus.NOT_FOUND);
		}
		// 브라우저 유형 별 인코딩
		boolean checkIE = (userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") > -1);
		String downloadName = null;
		try {
			if (checkIE) {
				// IE인 경우
				downloadName = URLEncoder.encode(origin_fname2, "UTF-8").replaceAll("\\+", " ");
			} else {
				downloadName = new String(origin_fname2.getBytes("UTF-8"), "ISO-8859-1");
			}

		} catch (UnsupportedEncodingException e) {
			log.error("파일 다운로드 중 error: " + e);
		}

		// HttpHeaders객체 생성해서 헤더 정보 설정
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Disposition", "attachment; filename=" + downloadName);

		return new ResponseEntity<>(resource, headers, HttpStatus.OK);
	}// ----------------------------------------
	
	@RequestMapping(value = "/admin/deleteComment", method = RequestMethod.POST)

	public Map<String, Object> deleteComment(@RequestParam("cnum") int cnum) throws Exception {
       Map<String, Object> result = new HashMap<>();
		
         try {
			boardService.deleteComment(cnum);
			result.put("status", "OK");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("status", "False");
		}
		return result;
	}	
	
	@ResponseBody
	@RequestMapping(value = "/admin/insertComment", method = RequestMethod.POST)
	public Map<String, Object> insertComment(Model m,@RequestBody CommentDTO comment) throws Exception {
		
		Map<String, Object> result = new HashMap<>();
		
		Integer maxNum = boardService.selectCommentCNumMax(comment);
		int crefer = maxNum != null ? maxNum + 1 : 1;
		comment.setCrefer(crefer);
		
		try {
			boardService.insertComment(comment);
			result.put("status", "OK");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("status", "False");
		}
		return result;
	}

	


}
