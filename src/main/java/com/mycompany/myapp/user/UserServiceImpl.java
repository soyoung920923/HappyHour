package com.mycompany.myapp.user;

import java.util.Random;

import javax.mail.Message.RecipientType;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;


@Service("userService")
public class UserServiceImpl implements UserService {

    @Autowired
    private SqlSessionTemplate sqlSession;

    @Autowired
    private UserMapper userMapper;
 
	@Autowired
	private UserService userService;
	
	@Autowired
    private JavaMailSender mailSender;
	
	
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

	@Override
	public void mailSendKey(String email, String id, HttpServletRequest req) {
		MimeMessage mail = mailSender.createMimeMessage();
		String htmlStr = "<h2></h2>안녕하세요 HappyHour입니다.<br><br>"
				+ "<h3>" + id + "님</h3>" + "<p>인증하기 버튼을 누르면 로그인 하실 수 있습니다 : "
				+ "<a href='http://localhost:8080" + req.getContextPath() + "/user/email_idt?id=" + id + "'>인증하기</a></p>";
		try {
			mail.setSubject("[HappyHour] 본인인증을 해주세요." , "utf-8");
			mail.setText(htmlStr, "utf-8", "html");
			mail.addRecipient(RecipientType.TO, new InternetAddress(email));
		
		}catch (MessagingException e) {
			e.printStackTrace();
		}
		mailSender.send(mail);
	}

	@Override
	public int email_idtAlter(String id) {
		return userMapper.email_idtAlter(id);
	}

	@Override
	public String checkEmail_idt(String id) {
		return userMapper.checkEmail_idt(id);
	}
	
    public String searchId(String name, String email) {

        String result = "";

        try {
            result = userMapper.searchId(name, email);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

	@Override
	public UserDTO userCheck(String id, String email) throws NotUserException{
		UserDTO user = new UserDTO();
		user.setId(id);
		user.setEmail(email);
		
		UserDTO dbUser = findUser(user); 
		
		if(dbUser!=null) {
			if(dbUser.getEmail().equals(user.getEmail())) {
				return dbUser; 
			}
			throw new NotUserException("존재하지 않는 이메일 입니다.");
		}	
		return null;
	}

	//비밀번호 찾기 임시 비밀번호 만드는 코드  
	private String init() {
        Random ran = new Random();
        StringBuffer sb = new StringBuffer();
        int num = 0;

        do {
            num = ran.nextInt(75) + 48;
            if ((num >= 48 && num <= 57) || (num >= 65 && num <= 90) || (num >= 97 && num <= 122)) {
                sb.append((char) num);
            } else {
                continue;
            }

        } while (sb.length() < size);
        if (lowerCheck) {
            return sb.toString().toLowerCase();
        }
        return sb.toString();
    }
	

    // 난수를 이용한 키 생성
    private boolean lowerCheck;
    private int size;

    public String getKey(boolean lowerCheck, int size) {
        this.lowerCheck = lowerCheck;
        this.size = size;
        return init();
    }
	
	@Override
	public void mailSendPwd(String id, String email, HttpServletRequest req) {
		
		String key = getKey(false, 6);
		
		 MimeMessage mail = mailSender.createMimeMessage();
	        String htmlStr = "<h2>안녕하세요 '"+ id +"' 님</h2><br><br>"
	                + "<p>임시 발급 비밀번호는 <h2 style='color : blue'>'" + key +"'</h2>이며 로그인 후 마이페이지에서 비밀번호를 변경하실 수 있습니다.</p><br>"
	                + "<h3><a href='http://localhost:8080/happyhour'>홈페이지 접속</a></h3><br><br>";
	        try {
	            mail.setSubject("[HappyHour] 임시 비밀번호가 발급되었습니다.", "utf-8");
	            mail.setText(htmlStr, "utf-8", "html");
	            mail.addRecipient(RecipientType.TO, new InternetAddress(email));
	            mailSender.send(mail);
	        } catch (MessagingException e) {
	            e.printStackTrace();
	        }

	        key = UserSha256.encrypt(key);

	        userMapper.searchPwd(id,email,key);
	    }
	
	@Override
	public UserDTO selectMy(Integer origin_num) {
		return userMapper.selectMy(origin_num);
	}

	@Override
	public UserDTO myOrigin_num(Integer origin_num) {
		return userMapper.myOrigin_num(origin_num);
	}
	
	@Override
	public int leaveMember(Integer myOrigin_num) {
		return userMapper.leaveMember(myOrigin_num);
	}

	@Override
    public String checkUser_dt(String id) {
        return userMapper.checkUser_dt(id);
    }
    
	@Override
	public int updateUser(UserDTO user) {
		return userMapper.updateUser(user);
	}
	
	@Override
	public boolean pwdCheck(Integer origin_num, String password) {
		UserDTO user = userMapper.selectMy(origin_num);
		if (user.getPassword().equals(password)) {
			return true;
		} else {
			return false;
		}
	}
	
	}
 




