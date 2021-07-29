package com.mycompany.myapp.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public interface UserService {

	UserDTO loginCheck(String id, String password) throws NotUserException;

	UserDTO findUser(UserDTO findUser) throws NotUserException;

	boolean idCheck(String id);

	boolean emailCheck(String email);

	boolean telCheck(String tel);

	int createUser(UserDTO user);

	void mailSendKey(String email, String id, HttpServletRequest req);

	int email_idtAlter(String id);

	String checkEmail_idt(String id);

	String searchId(String name, String email);

	UserDTO userCheck(String id, String email) throws NotUserException;

	void mailSendPwd(String id, String email, HttpServletRequest req);
	
	//마이페이지
	
	UserDTO selectMy(Integer origin_num);

	UserDTO myOrigin_num(Integer origin_num);

	int leaveMember(Integer origin_num);

	String checkUser_dt(String id);

	int updateUser(UserDTO user);

	boolean pwdCheck(Integer origin_num, String password);


}
