package com.mycompany.myapp.board;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.mycompany.common.CommonUtil;
import com.mycompany.myapp.user.UserDTO;
import com.mycompany.myapp.user.UserService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class BoardController {

	@Autowired
	private BoardService boardService;

	@Autowired
	private UserService userService;

	@Autowired
	private CommonUtil util;

	// 리스트 불러오기
	@GetMapping("/complain")
	public String complain(Model model, HttpServletRequest req, @RequestHeader("User-Agent") String userAgent,
			@ModelAttribute("paging") PagingDTO paging,
			@RequestParam(value = "findKeyword", required = false) String findKeyword,
			@RequestParam(value = "findType", required = false) String findType) throws Exception {

		int totalCount = this.boardService.getTotalCount(paging);
		paging.setTotalCount(totalCount);
		paging.setPagingBlock(10);// 페이징 블럭 단위값 => 10
		paging.init(req.getSession());

		List<BoardDTO> boardList = this.boardService.selectBoardAll(paging);

		String myctx = req.getContextPath();
		String loc = "/complain";
		String pageNavi = paging.getPageNavi(myctx, loc, userAgent);

		model.addAttribute("boardList", boardList);
		model.addAttribute("pageNavi", pageNavi);

		return "board/complain";
	}

	// 글 조회하기
	@GetMapping("/view")
	public String boardView(Model model, @RequestParam(defaultValue = "0") Integer num, String id) {
		if (num == 0) {
			return "redirect:list";
		}
		// 1. 조회수 증가
		this.boardService.updatehits(num);

		// 2. 글번호로 해당 글 가져오기
		BoardDTO board = boardService.selectBoardByNum(num);

		model.addAttribute("board", board);
		model.addAttribute("commentDTO", new CommentDTO());

		return "board/complainView";
	}

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

	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String complainInsertEnd(Model model, HttpServletRequest req, HttpSession ses,
			@RequestParam("mfilename") MultipartFile mfilename, @RequestParam("mfilename2") MultipartFile mfilename2,
			@ModelAttribute("board") BoardDTO board, @ModelAttribute("user") UserDTO user) {

		UserDTO loginUser = (UserDTO) ses.getAttribute("loginUser");
		String str = "";
		String loc;

		if (loginUser == null) {
			str = "로그인 후 글쓰기가 가능합니다.";
			loc = "redirect:complain";
			return util.addMsgLoc(model, str, loc);
		} else {
			String name = loginUser.getName();
			String id = loginUser.getId();
			board.setName(name);
			board.setId(id);
		}

		// 1. 업로드 디렉토리의 절대경로 얻기
		ServletContext app = req.getServletContext();
		String upDir = app.getRealPath("/Upload");

		File dir = new File(upDir);
		if (!dir.exists()) {
			dir.mkdirs(); // 디렉토리 생성
		}

		// 파일을 첨부했다면
		if (!mfilename.isEmpty()) {
			// 1. 먼저 첨부파일명 알아내자.
			String originFile = mfilename.getOriginalFilename(); // 파일이름

			// 동일한 파일명일 경우 덮어쓰기 방지를 위해서
			// 물리적 파일명을 "랜덤한문자열_원본파일명"
			UUID uuid = UUID.randomUUID();
			String filename = uuid.toString() + "_" + originFile;

			board.setOrigin_filename(originFile); // 원본파일명
			board.setFilename(filename); // 물리적 파일명

			// 2.업로드 처리
			try {
				mfilename.transferTo(new File(dir, filename));
				// <==업로드를 진행함
			} catch (IOException e) {
				log.error("파일 업로드 중 에러 발생 : " + e);
			}
		}

		if (!mfilename2.isEmpty()) {

			String originFile2 = mfilename2.getOriginalFilename();

			UUID uuid = UUID.randomUUID();
			String filename2 = uuid.toString() + "_" + originFile2;

			board.setOrigin_filename2(originFile2); // 원본파일명
			board.setFilename2(filename2); // 물리적 파일명

			// 2.업로드 처리
			try {
				mfilename2.transferTo(new File(dir, filename2));
				// <==업로드를 진행함
			} catch (IOException e) {
				log.error("파일 업로드 중 에러 발생 : " + e);
			}
		}

		log.info("boardService==" + boardService);
		String mode = board.getMode();
		int n = 0;
		if (mode.equals("insert")) {

			Integer maxNum = boardService.selectBoardNumMax(board);
			int refer = maxNum != null ? maxNum + 1 : 1;
			board.setRefer(refer);

			n = boardService.insertBoard(board);
			str = "게시글 작성이";
		} else if (mode.equals("edit")) {
			n = boardService.updateBoard(board);
			str = "게시글 수정이";
		} else if (mode.equals("reply")) {
			n = boardService.replyBoard(board);
			str = "답변글 쓰기가";
		}

		str += (n > 0) ? " 완료 되었습니다." : " 실패 되었습니다.";
		loc = (n > 0) ? "complain" : "javascript:history.back()";

		model.addAttribute("msg", str);
		model.addAttribute("loc", loc);

		return "message";
	}

	// 글 수정
	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public String complainEdit(Model model, HttpServletRequest req) {
		int num = Integer.parseInt(req.getParameter("num"));
		if (num == 0) {
			return "redirect:complain";
		}

		BoardDTO board = this.boardService.selectBoardByNum(num);

		model.addAttribute("board", board);

		return "board/complainEdit";
	}

	@RequestMapping("/reply")
	public String rewirteForm(Model model, HttpSession ses, @RequestParam(defaultValue = "0") int num,
			@RequestParam(defaultValue = "") String title, @ModelAttribute("board") BoardDTO board) {

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

		if (board.getName() == null || board.getTitle() == null || board.getName().trim().isEmpty()) {
			str = "로그인 후 이용이 가능합니다.";
			loc = "redirect:/";
			return util.addMsgLoc(model, str, loc);
		}

		model.addAttribute("num", num);
		model.addAttribute("subject", title);
		return "board/complainReply";
	}

	@PostMapping("/delete")
	public String complainDelete(Model model, @RequestParam(defaultValue = " ") int num) {
		if (num == 0) {
			return "redirect:complain";
		}
		// db 삭제
		int n = boardService.deleteBoard(num);
		String str = (n > 0) ? "게시글이 삭제되었습니다" : "게시글이 삭제되지 않았습니다";
		return util.addMsgLoc(model, str, "complain");
	}// ----------------------------------------

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

	// 내가 쓴 글 조회하기
	@GetMapping("/myboard")
	public String myboard(Model model, HttpServletRequest req, HttpSession ses,
			@RequestHeader("User-Agent") String userAgent, @ModelAttribute("paging") PagingDTO paging,
			@RequestParam(value = "findKeyword", required = false) String findKeyword,
			@RequestParam(value = "findType", required = false) String findType) throws Exception {

		UserDTO loginUser = (UserDTO) ses.getAttribute("loginUser");

		String id = loginUser.getId();
		paging.setId(id);

		if (id == null)
			return util.addMsgLoc(model, "잘못된 접근입니다.", "/happyhour");

		int total = boardService.getMyBoardTotal(paging);
		paging.setTotalCount(total);
		paging.setPagingBlock(10);// 페이징 블럭 단위값 => 10
		paging.init(req.getSession());

		List<BoardDTO> boardList = boardService.myBoardselectAll(paging);

		String myctx = req.getContextPath();
		String loc = "/myBoard";
		String pageNavi = paging.getPageNavi(myctx, loc, userAgent);

		model.addAttribute("boardList", boardList);
		model.addAttribute("pageNavi", pageNavi);

		return "board/myBoard";
	}
	
	@ResponseBody
	@RequestMapping(value = "/selectCommentAll", method = RequestMethod.POST)
	public List<CommentDTO> getReplyList(@RequestParam("num") int num) throws Exception {

		return boardService.selectCommentAll(num);

	}
	
	@ResponseBody
	@RequestMapping(value = "/insertComment", method = RequestMethod.POST)
	public Map<String, Object> insertComment(@RequestBody CommentDTO comment) throws Exception {
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

	@RequestMapping(value = "/updateComment", method =  RequestMethod.POST)
	public Map<String, Object> updateComment(@RequestBody CommentDTO comment) throws Exception {
	   Map<String, Object> result = new HashMap<>();

		try {
			boardService.updateComment(comment);
			result.put("status", "OK");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("status", "False");
		}
		return result;
	}
	
	@RequestMapping(value = "/deleteComment", method = RequestMethod.POST)

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

}
