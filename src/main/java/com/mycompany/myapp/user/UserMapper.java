package com.mycompany.myapp.user;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

public interface UserMapper {

	public int userIdCheck(String id);

	public UserDTO findUser(UserDTO findUser);

	public Integer idCheck(String id);

	public Integer emailCheck(String email);

	public Integer telCheck(String tel);

	public int createUser(UserDTO user);

	public int email_idtAlter(String id);

	public String checkEmail_idt(String id);

	public String searchId(@Param("name")String name, @Param("email")String email);

	public void searchPwd(String id, String email, String key);

	public UserDTO selectMy(Integer origin_num);

	public UserDTO myOrigin_num(Integer origin_num);

	public int leaveMember(Integer myOrigin_num);

	public String checkUser_dt(String id);

	public int updateUser(UserDTO user);

}

