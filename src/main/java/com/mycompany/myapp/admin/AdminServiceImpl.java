package com.mycompany.myapp.admin;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.myapp.user.UserDTO;


@Service("adminService")
public class AdminServiceImpl implements AdminService {
	
    @Autowired
    private SqlSessionTemplate sqlSession;

    @Autowired
    private AdminMapper adminMapper;
 
	@Autowired
	private AdminService adminService;

	@Override
	public int getUserCount(AdminPagingDTO paging) {
		return adminMapper.getUserCount(paging);
	}

	@Override
	public List<UserDTO> listUser(AdminPagingDTO paging) {
		return adminMapper.listUser(paging);
	}

	@Override
	public int deleteUser(Integer origin_num) {
		return adminMapper.deleteUser(origin_num);
	}

	@Override
	public String checkUser_dt(String id) {
		return adminMapper.checkUser_dt(id);
	}

	@Override
	public UserDTO getUserInfo(Integer origin_num) {
		return adminMapper.getUserInfo(origin_num);
	}

	@Override
	public int updateUser(UserDTO user) {
		return adminMapper.updateUser(user);
	}
	

}
