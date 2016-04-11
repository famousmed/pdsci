import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.SysUserMapper;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.SysUserExample;


public class RegionUtil {

	public static void main(String[] args) {
		
		try {

			ApplicationContext contextsci = new ClassPathXmlApplicationContext("spring-context.xml");
			File f = new File("D:\\provCityAreaJson.min.json");
			InputStreamReader read = new InputStreamReader(new FileInputStream(f),"UTF-8");
			BufferedReader br=new BufferedReader(read);
			String line="";
			StringBuffer  buffer = new StringBuffer();
			while((line=br.readLine())!=null){
			buffer.append(line);
			}
			String fileContent = buffer.toString();
			System.err.println(fileContent);
			
			Map<String,String> refMap = new HashMap<String, String>();
			
			JSONArray provArray = JSON.parseArray(fileContent);
			for(Object provObj : provArray.toArray()){
				JSONObject prov = (JSONObject)provObj;
				String v = prov.getString("v");
				String n = prov.getString("n");
//				System.err.println(v);
//				System.err.println(n);
				JSONArray cityArray = prov.getJSONArray("s");
				for(Object cityObj : cityArray.toArray()){
					JSONObject city = (JSONObject)cityObj;
					String vc = city.getString("v");
					String nc = city.getString("n");
//					System.err.println(vc);
//					System.err.println(nc);
					JSONArray areaArray = city.getJSONArray("s");
					for(Object areaObj : areaArray.toArray()){
						JSONObject area = (JSONObject)areaObj;
						String va = area.getString("v");
						String na = area.getString("n");
						System.err.println(va);
						System.err.println(na);
						refMap.put(va, na+"_"+vc+"_"+nc+"_"+v+"_"+n);
					}
				}
			}
			SysUserMapper mapper = contextsci.getBean(SysUserMapper.class);
			SysUserExample example = new SysUserExample();
			example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			List<SysUser> users = mapper.selectByExample(example);
			int updateCount = 0;
			for(SysUser user : users){
				String areaId = user.getNativePlaceAreaId();
				String refValue = refMap.get(areaId);
				if(StringUtil.isNotBlank(refValue)){
					String[] values = StringUtil.split(refValue, "_");
					if(values!=null && values.length==5){
						user.setNativePlaceAreaName(values[0]);
						//1,2,3,4
						mapper.updateByPrimaryKeySelective(user);
						updateCount++;
					}
				}
			}
			System.err.println("updateCount="+updateCount); 
			br.close();
			read.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		
	}
}
