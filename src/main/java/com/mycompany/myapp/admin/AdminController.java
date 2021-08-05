package com.mycompany.myapp.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mycompany.common.CommonUtil;
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
	public String adminEdit(Model m, HttpServletRequest req, @PathVariable("origin_num") Integer origin_num) {

		if (origin_num == null) {
			return util.addMsgLoc(m, "오류가 발생하였습니다.", "/happyhour");
		}

		UserDTO user = this.adminService.getUserInfo(origin_num);
		m.addAttribute("user", user);

		return "admin/userEdit";
	}

	
	  @PostMapping("/userEdit") public String adminEditEnd(Model m,@ModelAttribute("user") UserDTO user) {
	  
	  System.out.println(user); int n = this.adminService.updateUser(user);
	  
	  String str = (n > 0) ? "수정되었습니다." : "오류가 발생하였습니다."; 
	  String loc = (n > 0) ? "/happyhour/admin/userList" : "javascript:history.back()"; 
	  return util.addMsgLoc(m, str, loc); 
	  
	  }
	  
	 
	@PostMapping("/userDelete")
	public String adminDel(Model m, @RequestParam Integer origin_num) {

		if (origin_num == null) {
			return util.addMsgLoc(m, "오류가 발생하였습니다.", "/happyhour");
		}

		int n = adminService.deleteUser(origin_num);

		System.out.println(n);
		String str = (n > 0) ? "해당 회원의 탈퇴 처리가 완료되었습니다." : "오류가 발생하였습니다.";
		String loc = (n > 0) ? "/happyhour/admin/userList" : "javascript:history.back()";

		return util.addMsgLoc(m, str, loc);
	}

}
