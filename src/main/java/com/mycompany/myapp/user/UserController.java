package com.mycompany.myapp.user;

import java.util.HashMap;
import java.util.Map;

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
	public String joinEnd(Model model, HttpSession session, @ModelAttribute("user") UserDTO user, BindingResult result, HttpServletRequest req){
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
        return util.addMsgLoc(model, str, loc);
	
	}
	
    @GetMapping(value = "/email_idt")
    public String email_idtAlter(Model m, @RequestParam("id") String id) {

        userService.email_idtAlter(id);

        return "user/joinSuccess";
    }
	
	
	
	@PostMapping("/login")
	public String login(Model model, HttpSession session, @ModelAttribute("user") UserDTO user) 
			throws NotUserException {
		
		/** 비밀번호 암호화*/
		String encryPassword = UserSha256.encrypt(user.getPassword());
		user.setPassword(encryPassword);

		UserDTO loginUser=userService.loginCheck(user.getId(), user.getPassword());
		String edt = userService.checkEmail_idt(user.getId());
		
		if(edt.equals("0")) {
			return util.addMsgLoc(model, "이메일 인증이 안된 회원입니다. 이메일 인증을 해주세요", "/happyhour");
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
    

}
