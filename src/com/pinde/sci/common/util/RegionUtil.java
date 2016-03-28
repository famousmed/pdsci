package com.pinde.sci.common.util;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Map;


public class RegionUtil {
	public static Map<String,String>  getRefMap() {
		Map<String,String> refMap = new HashMap<String, String>();
		try {
			ApplicationContext contextsci = new ClassPathXmlApplicationContext("spring-context.xml");
			//File f = new File("D:\\provCityAreaJson.min.json");
			
			InputStreamReader read =  new InputStreamReader(RegionUtil.class.getResourceAsStream("/provCityAreaJson.min.json"),"UTF-8");
					//new InputStreamReader(new FileInputStream(f),"UTF-8");
			BufferedReader br=new BufferedReader(read);
			String line="";
			StringBuffer  buffer = new StringBuffer();
			while((line=br.readLine())!=null){
			buffer.append(line);
			}
			String fileContent = buffer.toString();
			System.err.println(fileContent);
			
		
			
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
//						System.err.println(va);
//						System.err.println(na);
						refMap.put(va, na+"_"+vc+"_"+nc+"_"+v+"_"+n);
					}
				}
			}
			if(br!=null){
				br.close();
			}
			if(read!=null){
				read.close();
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return refMap;
	}
}
