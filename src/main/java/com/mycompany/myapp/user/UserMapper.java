package com.mycompany.myapp.user;

import java.util.List;
import java.util.Map;

public interface UserMapper {

	public int userIdCheck(String id);

	public UserDTO findUser(UserDTO findUser);

	public Integer idCheck(String id);

	public Integer emailCheck(String email);

	public Integer telCheck(String tel);

	public int createUser(UserDTO user);
	
	
}
