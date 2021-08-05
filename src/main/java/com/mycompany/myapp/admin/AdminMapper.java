package com.mycompany.myapp.admin;

import java.util.List;

import com.mycompany.myapp.user.UserDTO;

public interface AdminMapper {

	int getUserCount(AdminPagingDTO paging);

	List<UserDTO> listUser(AdminPagingDTO paging);

	int deleteUser(Integer origin_num);

	String checkUser_dt(String id);

	UserDTO getUserInfo(Integer origin_num);

	int updateUser(UserDTO user);

}
