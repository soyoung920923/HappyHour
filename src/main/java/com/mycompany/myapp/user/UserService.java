package com.mycompany.myapp.user;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public interface UserService {

	UserDTO loginCheck(String id, String password) throws NotUserException;

	UserDTO findUser(UserDTO findUser) throws NotUserException;

	boolean idCheck(String id);

	boolean emailCheck(String email);

	boolean telCheck(String tel);

	int createUser(UserDTO user);


}
