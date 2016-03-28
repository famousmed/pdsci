import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.pinde.sci.biz.security.PasswordHelper;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.ExamBookMapper;
import com.pinde.sci.dao.base.SysUserMapper;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.SysUserExample;


public class PasswordInitUtil {

	public static void main(String[] args) {
		
			ApplicationContext contextsci = new ClassPathXmlApplicationContext("spring-context.xml");
			SysUserMapper mapper = contextsci.getBean(SysUserMapper.class);
			SysUserExample example = new SysUserExample();
			example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			List<SysUser> users = mapper.selectByExample(example);
			for(SysUser user : users){
				String passwd = PasswordHelper.encryptPassword(user.getUserFlow(),"123456");
				System.out.println(passwd);
				user.setUserPasswd(passwd);
				mapper.updateByPrimaryKeySelective(user);
				System.out.println("====done===");
			}
//				user.setUserPasswd(PasswordHelper.encryptPassword(user.getUserFlow(),"123456"));
//				mapper.updateByPrimaryKeySelective(user);
//				System.out.println("====end===="+user.getUserFlow());
//			}
		

	}

}
