package com.mycompany.myapp.user;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mycompany.common.CommonUtil;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping(value = { "user", "" })
public class UserController {
	
	@Autowired
    private UserService userService;
	
	@Autowired
    private CommonUtil util;
	
	@GetMapping("/login")
    public String login() {

        return "user/login";
	}
	
	@GetMapping("/join")
    public String join() {

        return "user/join";
	}
	
    @RequestMapping("/terms")
    public void terms() {

    }
	
	@PostMapping("/join")
	public String joinEnd(Model m, HttpSession session, @ModelAttribute("user") UserDTO user, BindingResult result, HttpServletRequest req){
		if(result.hasErrors()) {			
			return "user/join";
		}
		
		/** 비밀번호 암호화 */
		String encryPassword = UserSha256.encrypt(user.getPassword());
		user.setPassword(encryPassword);
	
		int n = userService.createUser(user);
		
		if (n > 0) {
            session.setAttribute("authUser", user);
        }
		
		userService.mailSendKey(user.getEmail(), user.getId(), req);
		
		String str = (n > 0) ? "회원가입이 완료되었습니다. 이메일 인증을 해주세요." : "회원가입에 실패하였습니다. 관리자에게 문의해주세요.";
        String loc = (n > 0) ? "/happyhour" : "javascript:history.back()";
        return util.addMsgLoc(m, str, loc);
	
	}
	
    @GetMapping(value = "/email_idt")
    public String email_idtAlter(Model m, @RequestParam("id") String id) {

        userService.email_idtAlter(id);

        return "user/joinSuccess";
    }
	
	
	@PostMapping("/login")
	public String login(Model m, HttpSession session, @ModelAttribute("user") UserDTO user) throws NotUserException {
		
		/** 비밀번호 암호화*/
		String encryPassword = UserSha256.encrypt(user.getPassword());
		user.setPassword(encryPassword);

		UserDTO loginUser=userService.loginCheck(user.getId(), user.getPassword());
		String edt = userService.checkEmail_idt(user.getId());
		
		
		if(edt.equals("0")) {
			return util.addMsgLoc(m, "이메일 인증이 안된 회원입니다. 이메일 인증을 해주세요", "/happyhour");
		}
		
		String st = this.userService.checkUser_dt(user.getId());
		
        if (st.trim().equals("4")) {
            return util.addMsgLoc(m, "탈퇴회원입니다. 고객센터에 문의 바랍니다.", "/happyhour");
        }

		if(loginUser!=null) {
			session.setAttribute("loginUser", loginUser);
		}
		
		return "redirect:/";
	}//-----------------------------
	
    @GetMapping("/logout")
    public String logout(HttpSession ses) {
        // 세션 무효화
        ses.invalidate();
        return "redirect:/";
    }
    
    @GetMapping(value = "/idcheck", produces = "application/json")
    public @ResponseBody Map<String, String> idCheck(@RequestParam("id") String id) {
        boolean isUse = userService.idCheck(id);

        String msg = (isUse) ? id + "는 사용 가능합니다." : id + "는 이미 사용중입니다";
        int n = (isUse) ? 1 : -1;
        Map<String, String> map = new HashMap<>();
        map.put("idResult", msg);
        map.put("isUse", String.valueOf(n));
        return map;
    }
    
    @GetMapping(value = "/emailcheck", produces = "application/json")
    public @ResponseBody
    Map<String, String> emailCheck(@RequestParam("email") String email) {
        boolean isEma = userService.emailCheck(email);

        String msg = (isEma) ? "사용 가능한 이메일입니다." : "이미 등록된 이메일입니다.";
        int n = (isEma) ? 1 : -1;
        Map<String, String> map = new HashMap<>();
        map.put("emailResult", msg);
        map.put("isEma", String.valueOf(n));
        return map;
    }
    
    @GetMapping(value = "/telcheck", produces = "application/json")
    public @ResponseBody
    Map<String, String> telCheck(@RequestParam("tel") String tel) {
        boolean isTel = userService.telCheck(tel);

        String msg = (isTel) ? "사용 가능한 전화번호입니다." : "이미 등록된 전화번호입니다.";
        int n = (isTel) ? 1 : -1;
        Map<String, String> map = new HashMap<>();
        map.put("telResult", msg);
        map.put("isTel", String.valueOf(n));
        return map;
    }

    @GetMapping("/userSearch")
    public String userSearch() {

        return "user/userSearch";
    }
    
    @PostMapping("/userSearch")
    @ResponseBody
    public String userSearchEnd(@RequestParam("name") String name,
                                @RequestParam("email") String email) {

        String result = userService.searchId(name, email);

        return result;
    }
    
    @GetMapping("/pwdSearch")
    public String pwdSearch() {

        return "user/pwdSearch";
    }
    
    @GetMapping("/pwdSearchEnd")
    public String pwdSearchEnd(@RequestParam("id") String id,
                               @RequestParam("email") String email, HttpServletRequest req, Model m) throws NotUserException {
    	
        UserDTO user = userService.userCheck(id, email);

        if (user != null) {
            userService.mailSendPwd(id, email, req);
        }

        String str;
        String loc;
		if (user != null) {
			str = "임시비밀번호가 이메일로 전송되었습니다.";
		    loc = "/happyhour";
		}else {
			str = "임시비밀번호 전송에 실패하였습니다.";
		    loc = "javascript:history.back()";
       }
    
		return util.addMsgLoc(m, str, loc);
    }
    
    @ExceptionHandler(NotUserException.class)
    public String exceptionHandler(Exception ex) {
        return "user/errorAlert";
    }
    
    @GetMapping("/myInfo")
    public String myPageHome(Model m, @RequestParam Integer origin_num, HttpServletRequest req,
                             @RequestHeader("User-Agent") String userAgent,
                             @ModelAttribute("user") UserDTO user) {
    	
    	HttpSession ses = req.getSession();
        user = (UserDTO) ses.getAttribute("loginUser");
    	
		UserDTO Origin_num = userService.myOrigin_num(origin_num);
		
		if(Origin_num!=null) {
			user.setOrigin_num(origin_num);
		}
    	
    	origin_num = user.getOrigin_num();
    	
        if (origin_num == null)
            return util.addMsgLoc(m, "잘못된 접근입니다.", "/happyhour");

        
        // 정보검색
        user = userService.selectMy(origin_num);
        m.addAttribute("user", user);

        return "user/myPage";
    }
    
    @GetMapping("/edit")
    public String myPageEdit(Model m, HttpServletRequest req, @RequestParam("origin_num")Integer origin_num) {

    	HttpSession ses = req.getSession();
    	UserDTO loginUser = (UserDTO) ses.getAttribute("loginUser");
    	
    	if (loginUser == null)
            return util.addMsgLoc(m, "잘못된 접근입니다.", "/happyhour");
    	
    	UserDTO user = this.userService.selectMy(origin_num);
    	
    	 if (origin_num == null)
             return util.addMsgLoc(m, "잘못된 접근입니다.", "/happyhour");
        
        // 정보검색
        log.info("user = " +user);
        m.addAttribute("user", user);
  

        return "user/myPageEdit";
    }
    
    @PostMapping("/edit")
    public String mypageEditEnd(Model m,
                                HttpServletRequest req,  @RequestParam("origin_num") Integer origin_num, @ModelAttribute("user") UserDTO user) {
    	
    	if (user.getOrigin_num() == null)
            return "user/myinfo";

        // 비밀번호 암호화 로직 수행
        String encryPassword = null;
        if (!user.getPassword().trim().isEmpty()) {
            encryPassword = UserSha256.encrypt(user.getPassword());
            user.setPassword(encryPassword);
        }


        log.info("encryPassword = " + encryPassword);
        
        int n = this.userService.updateUser(user);
        
        String str = (n > 0) ? "수정이 완료 되었습니다." : "잘못된 접근입니다.";
        String loc = (n > 0) ? "/happyhour" : "javascript:history.back()";
        return util.addMsgLoc(m, str, loc);
    }
    
    /*비밀번호 체크*/
    @GetMapping(value="/pwdcheck",produces = "application/json")
    public @ResponseBody Map<String,String> pwdCheck(@RequestParam int origin_num, @RequestParam String password){

        String encryPassword = UserSha256.encrypt(password);

        boolean check = this.userService.pwdCheck(origin_num, encryPassword);

        String msg=(check)?"비밀번호 변경이 가능합니다.":"비밀번호가 일치하지 않습니다.";
        int n = (check)?1:-1;

        Map<String,String> map = new HashMap<>();
        map.put("okPwd", msg);
        map.put("check", String.valueOf(n));

        return map;
    }

    
    @PostMapping("/del")
    public String mypageDel(Model m, HttpServletRequest req, @RequestParam("origin_num") Integer origin_num) {
    	
    	HttpSession ses = req.getSession();
    	UserDTO loginUser = (UserDTO) ses.getAttribute("loginUser");
    	
    	if (loginUser == null)
            return util.addMsgLoc(m, "잘못된 접근입니다.", "/happyhour");
    	
        if (origin_num == null) {
            return util.addMsgLoc(m, " 잘못된 접근입니다.", "/happyhour");
        }
        
        int n = this.userService.leaveMember(origin_num);

        ses.invalidate();
        
        String str = (n > 0) ? "탈퇴 처리가 완료되었습니다." : "잘못된 접근입니다.";
        String loc = (n > 0) ? "/happyhour" : "javascript:history.back()";
        return util.addMsgLoc(m, str, loc);
    }
    
}
