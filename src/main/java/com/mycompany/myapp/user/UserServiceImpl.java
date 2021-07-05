package com.mycompany.myapp.user;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service("userService")
public class UserServiceImpl implements UserService {

    @Autowired
    private SqlSessionTemplate sqlSession;

    @Autowired
    private UserMapper userMapper;
 
	@Autowired
	private UserService userService;
	
	
	@Override
	 public int createUser(UserDTO user) {
	      return this.userMapper.createUser(user);
	    }

	 @Override
	 public UserDTO loginCheck(String id, String password) throws NotUserException {
		   UserDTO user = new UserDTO();
	        user.setId(id);
	        user.setPassword(password);

	        UserDTO dbUser = this.findUser(user); 
	       
	        if (dbUser != null) {
	            if (dbUser.getPassword().equals(user.getPassword())) {
	                return dbUser;
	            }

	            throw new NotUserException("비밀번호가 일치하지 않습니다.");
	        }
	        return null;
	    }
	 
	@Override
	public UserDTO findUser(UserDTO findUser) throws NotUserException {
	      UserDTO user = this.userMapper.findUser(findUser);
	        if (user == null) {
	            throw new NotUserException("존재하지 않는 아이디입니다.");
	        }      
	        return user;
	}

	@Override
	public boolean idCheck(String id) {
		 Integer origin_num = userMapper.idCheck(id);
	      //아이디로 회원번호 받아오기
	      if(origin_num == null) {
	         //해당 아이디는 사용자가 없음
	         return true;
	      }else {
	         //이미 해당아이디는 사용 중
	         return false;
	      }
	   }

	@Override
    public boolean emailCheck(String email) {
        Integer origin_num = userMapper.emailCheck(email);
        if (origin_num == null) {
            return true;
        } else {
            return false;
        }
	}
	
	@Override
    public boolean telCheck(String tel) {
        Integer idx = userMapper.telCheck(tel);
        if (idx == null) {
            return true;
        } else {
            return false;
        }
    }
}




