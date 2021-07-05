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
		
		String str = (n > 0) ? "회원가입이 완료되었습니다. 이메일 인증을 해주세요." : "회원가입 실패";
        String loc = (n > 0) ? "/myapp" : "javascript:history.back()";
        return util.addMsgLoc(model, str, loc);
	
	}
	
	@PostMapping("/login")
	public String login(Model model, HttpSession session, @ModelAttribute("user") UserDTO user) 
			throws NotUserException {
		
		/** 비밀번호 암호화*/
		String encryPassword = UserSha256.encrypt(user.getPassword());
		user.setPassword(encryPassword);

		UserDTO loginUser=userService.loginCheck(user.getId(), user.getPassword());

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

        String msg = (isTel) ? "사용 가능한 전화번호입니다." : "이미 존재하는 전화번호입니다.";
        int n = (isTel) ? 1 : -1;
        Map<String, String> map = new HashMap<>();
        map.put("telResult", msg);
        map.put("isTel", String.valueOf(n));
        return map;
    }
    

    
    @ExceptionHandler(NotUserException.class)
    public String exceptionHandler(Exception ex) {
        return "user/errorAlert";
    }

}
