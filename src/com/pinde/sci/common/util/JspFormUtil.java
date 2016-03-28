package com.pinde.sci.common.util;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.Node;

import com.oreilly.servlet.multipart.FilePart;
import com.oreilly.servlet.multipart.MultipartParser;
import com.oreilly.servlet.multipart.ParamPart;
import com.oreilly.servlet.multipart.Part;
import com.pinde.core.jspform.Item;
import com.pinde.core.jspform.ItemGroup;
import com.pinde.core.jspform.ItemGroupData;
import com.pinde.core.jspform.Page;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.SpringUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.pub.IFileBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.model.mo.PubFile;

public class JspFormUtil {
	
	/**
	 * 判断该请求是否是文件上传的请求
	 * @param request
	 * @return
	 */
	public static boolean isMultipart(HttpServletRequest request) {
		String type = null;
		String type1 = request.getHeader("Content-Type");
		String type2 = request.getContentType();
		// If one value is null, choose the other value
		if (type1 == null && type2 != null) {
		  type = type2;
		}
		else if (type2 == null && type1 != null) {
		  type = type1;
		}
		// If neither value is null, choose the longer value
		else if (type1 != null && type2 != null) {
		  type = (type1.length() > type2.length() ? type1 : type2);
		}
		
		if (type == null || 
		    !type.toLowerCase().startsWith("multipart/form-data")) {
			return false;
		}
		return true;
	 }

	
	/**
	 * 解析request对象
	 * 如果该对象中有描述文件的就上传 ， 返回的文件流水号重新添加到map中
	 * @param request
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public static Map<String , String[]> getParameterMap(HttpServletRequest request){
		
		boolean isMultipart = isMultipart(request);
		if(isMultipart){
			Map<String , String[]> dataMap = new HashMap<String, String[]>();
			//用来限制用户上传文件大小的   
			int maxPostSize = 2 * 100 * 1024 * 1024;   
			//第一个参数为传过来的请求HttpServletRequest，   
			//第二个参数为上传文件要存储在服务器端的目录名称   
			//第三个参数是用来限制用户上传文件大小   
			//第四个参数可以设定用何种编码方式来上传文件名称，可以解决中文问题   
			
			MultipartParser mp;
			try {
				mp = new MultipartParser(request, maxPostSize, false, false, "UTF-8");
			    Part part;
			      while ((part = mp.readNextPart()) != null) {        
			    	  String paramName = part.getName();
			        if (part.isParam()) { 
			        	
			        	ParamPart paramPart = (ParamPart) part;
			        	String value = paramPart.getStringValue();

			        	if(!dataMap.containsKey(paramName)){
							dataMap.put(paramName, new String[]{value});							
						}else{
							String [] values = dataMap.get(paramName);
							List<String> valueList = new ArrayList<String>();	
							for(String temp : values){
								valueList.add(temp);
							}
							valueList.add(value);
							String [] newValues = new String [valueList.size()];
							dataMap.put(paramName,valueList.toArray(newValues));
						}
			        } else if (part.isFile()) {           
			        	FilePart filePart = (FilePart) part;
			        	String fileName = filePart.getFileName();
			        	String fileFlow ="";
			        	if (fileName != null) {            
			        		fileFlow = PkUtil.getUUID();
							PubFile pubFile = new PubFile();
							pubFile.setFileFlow(fileFlow);
							pubFile.setFileName(fileName);
							pubFile.setFileRemark(paramName);
							pubFile.setFileSuffix("");
							ByteArrayOutputStream out = null;
							try {
								  out = new ByteArrayOutputStream();
								  filePart.writeTo(out);
								  pubFile.setFileContent(out.toByteArray());
							} catch (IOException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}finally{
								if(out!=null)
									out.close();
							}
							pubFile.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
							GeneralMethod.setRecordInfo(pubFile, true);
							IFileBiz fileBiz = SpringUtil.getBean(IFileBiz.class);
							fileBiz.addFile(pubFile);
			            
			        	} else {            
			        	  fileFlow="";
			        	}
			          
			        	if(!dataMap.containsKey(paramName)){
							dataMap.put(paramName, new String[]{fileFlow});							
						}else{
							String [] values = dataMap.get(paramName);
							List<String> valueList = new ArrayList<String>();	
							for(String temp : values){
								valueList.add(temp);
							}
							valueList.add(fileFlow);
							String [] newValues = new String [valueList.size()];
							dataMap.put(paramName,valueList.toArray(newValues));
						}
			          
			        }
			      }
			} catch (IOException e) {
				e.printStackTrace();
				throw new RuntimeException(e);
			}
			return dataMap;		 
		}else{
			Map<String , String[]> dataMap = request.getParameterMap();
			return dataMap;
		}
	}
	
	private static String createXmlStr(Page page , Map<String , String[]> dataMap){
		Document document = DocumentHelper.createDocument();
		//建立根节点
		Element rootElement = document.addElement("projInfo");
		//建立步骤节点
		Element stepElement = rootElement.addElement(page.getName());
		List<Item> itemList = page.getItemList();
		for(Item item:itemList){
			Element itemElement = stepElement.addElement("item");
			itemElement.addAttribute("name", item.getName());
			itemElement.addAttribute("remark", item.getRemark());
			itemElement.addAttribute("multiple", item.getMultiple());
			String isFile = item.getIsFile();
			if(StringUtil.isNotBlank(isFile)){
				itemElement.addAttribute("isFile", item.getIsFile());
			}
			String[] values = dataMap.get(item.getName());
			if(values==null){
				values = new String[]{""};	
			}
			for(String value:values){
				itemElement.addElement("value").setText(value);
			}
		}
		List<ItemGroup> itemGroupList = page.getItemGroupList();
		if(itemGroupList!=null && itemGroupList.size()>0){
			for(ItemGroup ig:itemGroupList){
				String igName = ig.getName();
				if("add".equals(ig.getModelStyle())){
					//平滑增加
					 int count = getMatchDataIndex(igName , dataMap);
					 for(int i = 0 ; i<count ; i++){
						 Element itemGroupEle = stepElement.addElement("itemGroup");
							String igFlow = ig.getFlow();
							if(StringUtil.isNotBlank(igFlow)){
								itemGroupEle.addAttribute("flow", igFlow);
							}
							String igJsp = ig.getJsp();
							if(StringUtil.isNotBlank(igJsp)){
								itemGroupEle.addAttribute("jsp", igJsp);
							}
							String remark = ig.getRemark();
							if(StringUtil.isNotBlank(remark)){
								itemGroupEle.addAttribute("remark", remark);
							}
							itemGroupEle.addAttribute("name", igName);
							
							if(StringUtil.isNotBlank(remark)){
								itemGroupEle.addAttribute("remark", remark);
							}
							List<Item> igItemList = ig.getItemList();
							iteratorItem(igItemList , itemGroupEle , dataMap , i);
					 }	
				}
				
			}
		}
		return document.asXML();
	}
	
	/**
	 * 解析request对象
	 * 如果该对象中有描述文件的就上传 ， 返回的文件流水号重新添加到map中
	 * @param request
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public static Map<String , String[]> getParamMap(HttpServletRequest request){
		
		boolean isMultipart = isMultipart(request);
		if(isMultipart){
			Map<String , String[]> dataMap = new HashMap<String, String[]>();
			//用来限制用户上传文件大小的   
			int maxPostSize = 2 * 100 * 1024 * 1024;   
			//第一个参数为传过来的请求HttpServletRequest，   
			//第二个参数为上传文件要存储在服务器端的目录名称   
			//第三个参数是用来限制用户上传文件大小   
			//第四个参数可以设定用何种编码方式来上传文件名称，可以解决中文问题   
			
			MultipartParser mp;
			try {
				mp = new MultipartParser(request, maxPostSize, false, false, "UTF-8");
			    Part part;
			      while ((part = mp.readNextPart()) != null) {        
			    	  String paramName = part.getName();
			        if (part.isParam()) { 
			        	
			        	ParamPart paramPart = (ParamPart) part;
			        	String value = paramPart.getStringValue();

			        	if(!dataMap.containsKey(paramName)){
							dataMap.put(paramName, new String[]{value});							
						}else{
							String [] values = dataMap.get(paramName);
							List<String> valueList = new ArrayList<String>();	
							for(String temp : values){
								valueList.add(temp);
							}
							valueList.add(value);
							String [] newValues = new String [valueList.size()];
							dataMap.put(paramName,valueList.toArray(newValues));
						}
			        } else if (part.isFile()) {           
			        	FilePart filePart = (FilePart) part;
			        	String fileName = filePart.getFileName();
			        	String fileFlow ="";
			        	if (fileName != null) {            
			        		fileFlow = PkUtil.getUUID();
			        		String[] fileParamName= paramName.split("file_");
			        		String fileTempId = fileParamName[1];
			        		//已确认文件不再更新
							String confirm = dataMap.get("confirm_"+fileTempId) == null?"":dataMap.get("confirm_"+fileTempId)[0];
							if ("Y".equals(confirm)) {
								continue;
							}
							PubFile pubFile = new PubFile();
							pubFile.setFileFlow(fileFlow);
							pubFile.setFileName(fileName);
							String[] nameArray= fileName.split("\\.");
							pubFile.setFileType(nameArray[nameArray.length-1]);
							pubFile.setFileSuffix(nameArray[nameArray.length-1]);
							ByteArrayOutputStream out = null;
							try {
								  out = new ByteArrayOutputStream();
								  filePart.writeTo(out);
								  pubFile.setFileContent(out.toByteArray());
							} catch (IOException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}finally{
								if(out!=null)
									out.close();
							}
							pubFile.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
							GeneralMethod.setRecordInfo(pubFile, true);
							IFileBiz fileBiz = SpringUtil.getBean(IFileBiz.class);
							fileBiz.addFile(pubFile);
			        	} else {            
			        	  fileFlow="";
			        	}
			          
			        	if(!dataMap.containsKey(paramName)){
							dataMap.put(paramName, new String[]{fileFlow});							
						}else{
							String [] values = dataMap.get(paramName);
							List<String> valueList = new ArrayList<String>();	
							for(String temp : values){
								valueList.add(temp);
							}
							valueList.add(fileFlow);
							String [] newValues = new String [valueList.size()];
							dataMap.put(paramName,valueList.toArray(newValues));
						}
			          
			        }
			      }
			} catch (IOException e) {
				e.printStackTrace();
				throw new RuntimeException(e);
			}
			return dataMap;		 
		}else{
			Map<String , String[]> dataMap = request.getParameterMap();
			return dataMap;
		}
	}
	
	/**
	 * 创建 或  修改
	 * @param page
	 * @param datasMap
	 * @return
	 */
//	public static String createXml(Page page , Map<String , String[]> datasMap){
//		Document document = null;
//		try{
//			document = DocumentHelper.createDocument();
//			//建立根节点
//			Element rootEle = document.addElement("projInfo");
//			//建立步骤节点
//			Element stepEle = rootEle.addElement(page.getName());
//			//获取当前page下的所有定义的item
//			List<Item> itemList = page.getItemList();
//			iteratorItem(itemList , stepEle ,datasMap);
//			//获取当前page下的所有定义的itemGroup
//			List<ItemGroup> itemGroupList = page.getItemGroupList();
//			if(itemGroupList!=null && itemGroupList.size()>0){
//				for(ItemGroup ig:itemGroupList){
//					String igName = ig.getName();
//					 int count = getMatchDataIndex(igName , datasMap);
//					 for(int i = 0 ; i<count ; i++){
//						 Element itemGroupEle = stepEle.addElement("itemGroup");
//							String igFlow = ig.getFlow();
//							if(StringUtil.isNotBlank(igFlow)){
//								itemGroupEle.addAttribute("flow", igFlow);
//							}
//							String igJsp = ig.getJsp();
//							if(StringUtil.isNotBlank(igJsp)){
//								itemGroupEle.addAttribute("jsp", igJsp);
//							}
//							String remark = ig.getRemark();
//							if(StringUtil.isNotBlank(remark)){
//								itemGroupEle.addAttribute("remark", remark);
//							}
//							itemGroupEle.addAttribute("name", igName);
//							
//							if(StringUtil.isNotBlank(remark)){
//								itemGroupEle.addAttribute("remark", remark);
//							}
//							List<Item> igItemList = ig.getItemList();
//							iteratorItem(igItemList , itemGroupEle , datasMap , i);
//					 }	
//					
//						
//				}
//			}
//		}catch(Exception e){
//			e.printStackTrace();
//			throw new RuntimeException("projInfo生成异常");
//		}
//		
//		return document.asXML();
//	}
	
	public static String updateXmlStr(String text,Page page , Map<String , String[]> dataMap){
		
		if(StringUtil.isBlank(text)){			
			return createXmlStr(page ,dataMap);
		}
		 
		Document document = null;
		try {
			document = DocumentHelper.parseText(text);
		} catch (DocumentException e) {
			e.printStackTrace();
			return text;
		}
		Element rootEle = document.getRootElement();
		Node pageDataNode = rootEle.selectSingleNode("./"+page.getName());
		if(pageDataNode!=null){
			List<Node> itemNodes = pageDataNode.selectNodes("item");
			for(Node n:itemNodes){
				n.detach();
			}
		}else{
			pageDataNode = rootEle.addElement(page.getName());
		}
		List<ItemGroup> itemGroupList = page.getItemGroupList();
		if(itemGroupList!=null && itemGroupList.size()>0){
			for(ItemGroup ig:itemGroupList){
				String igName = ig.getName();
				String modelStyle = ig.getModelStyle();
				if("add".equals(modelStyle)){
					int count = getMatchDataIndex(igName , dataMap);		
					//平滑式
					List<Node> itemGroupNodes = pageDataNode.selectNodes("itemGroup[@name='"+igName+"']");
					for(Node n:itemGroupNodes){
						n.detach();
					}
					 for(int i = 0 ; i<count ; i++){
						 Element itemGroupEle = ((Element)pageDataNode).addElement("itemGroup");
							String igFlow = ig.getFlow();
							if(StringUtil.isNotBlank(igFlow)){
								itemGroupEle.addAttribute("flow", igFlow);
							}
							String igJsp = ig.getJsp();
							if(StringUtil.isNotBlank(igJsp)){
								itemGroupEle.addAttribute("jsp", igJsp);
							}
							String remark = ig.getRemark();
							if(StringUtil.isNotBlank(remark)){
								itemGroupEle.addAttribute("remark", remark);
							}
							itemGroupEle.addAttribute("name", igName);
							
							if(StringUtil.isNotBlank(remark)){
								itemGroupEle.addAttribute("remark", remark);
							}
							List<Item> igItemList = ig.getItemList();
							iteratorItem(igItemList , itemGroupEle , dataMap , i);
					 }	
				}else{
					//弹出式
					List<Node> itemNodes = pageDataNode.selectNodes("item");
					for(Node n:itemNodes){
						n.detach();
					}
				}
				 	 
			}
		}
		
		//重新创建
		List<Item> itemList = page.getItemList();
		for(Item item:itemList){
			Element itemElement = ((Element)pageDataNode).addElement("item");
			itemElement.addAttribute("name", item.getName());
			itemElement.addAttribute("remark", item.getRemark());
			itemElement.addAttribute("multiple", item.getMultiple());
			String isFile = item.getIsFile();
			if(StringUtil.isNotBlank(isFile)){
				itemElement.addAttribute("isFile", isFile);
			}
			String[] values = dataMap.get(item.getName());
			if(values==null){
				values = new String[]{""};	
			}
			for(String value:values){
				itemElement.addElement("value").setText(value);
			}
		}
		return document.asXML();
	}
	
	public static String updateXmlItemGroupStr(String text,Page page , String itemGroupName  , String itemGroupFlow , Map<String , String[]> dataMap){
		Document document = null;
		try {
			document = DocumentHelper.parseText(text);
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return text;
		}
		Element rootElement = document.getRootElement();
		Node stepNode = rootElement.selectSingleNode("./"+page.getName());
		if(stepNode==null){
			stepNode = rootElement.addElement(page.getName());
		}
		Node itemGroupNode = stepNode.selectSingleNode("./itemGroup[@flow=\'"+itemGroupFlow+"\']");
		if(itemGroupNode!=null){
			itemGroupNode.detach();
		}
		//建立itemGroup节点
		Element itemGroupElement = ((Element)stepNode).addElement("itemGroup");
		List<ItemGroup> itemGroupList = page.getItemGroupList();
		ItemGroup itemGroup = null;
		for(ItemGroup ig : itemGroupList){
			if(ig.getName().equals(itemGroupName)){
				itemGroup = ig;
				break;
			}
		}
		if(itemGroup!=null){
			itemGroupElement.addAttribute("name", itemGroup.getName());
			itemGroupElement.addAttribute("remark", itemGroup.getRemark());
			itemGroupElement.addAttribute("flow",itemGroupFlow);
			List<Item> items = itemGroup.getItemList();
			for(Item item:items){
				Element itemElement = itemGroupElement.addElement("item");
				itemElement.addAttribute("name", item.getName());
				itemElement.addAttribute("remark", item.getRemark());
				itemElement.addAttribute("multiple", item.getMultiple());
				if(GlobalConstant.FLAG_Y.equals(item.getIsFile())){
					itemElement.addAttribute("isFile", item.getIsFile());
				}
				String[] values = dataMap.get(item.getName());
				if(values==null){
					values = new String[]{""};	
				}
				for(String value:values){
					itemElement.addElement("value").setText(value);
				}
				
			}
		}
		return document.asXML();
	}
	
	public static String delXmlItemGroupStr(String text,Page page , String itemGroupName  , String flow){
		Document document = null;
		try {
			document = DocumentHelper.parseText(text);
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return text;
		}
		Element rootElement = document.getRootElement();
		Node stepNode = rootElement.selectSingleNode("./"+page.getName());
		if(stepNode==null){
			stepNode = rootElement.addElement(page.getName());
		}
		Node itemGroupNode = stepNode.selectSingleNode("./itemGroup[@flow=\'"+flow+"\']");
		if(itemGroupNode!=null){
			itemGroupNode.detach();
		}
		return document.asXML();
	}
	
	
	public static Map<String , Object> parseXmlStr(String xml){
		Map<String , Object> map = new HashMap<String , Object>();
		if(StringUtil.isBlank(xml)){
			return map;
		}
		Document doc = null;
		try{
			doc = DocumentHelper.parseText(xml);
			//获取根节点
			Element rootEle = doc.getRootElement();
			//获取根节点下的所有步骤节点
			Iterator stepIterator = rootEle.elementIterator();
			while(stepIterator.hasNext()){
				Element stepEle = (Element)stepIterator.next();
				if(stepEle==null){
					return map;
				}
				map.putAll(IteratorItemNode(stepEle));
				Iterator<Element> itemGroupIterator = stepEle.elementIterator("itemGroup");
				while(itemGroupIterator.hasNext()){
					Element itemGroupElement = itemGroupIterator.next();
					String key = itemGroupElement.attributeValue("name");
					String flow = itemGroupElement.attributeValue("flow");
					Map<String , Object> itemGroupDataMap =IteratorItemNode(itemGroupElement);
					ItemGroupData itemGroupData = new ItemGroupData();
					itemGroupData.setFlow(flow);
					itemGroupData.setObjMap(itemGroupDataMap);
					
					if(map.containsKey(key)){
						Object obj = map.get(key);
						List<ItemGroupData> itemGroupDataList = (List<ItemGroupData>)obj;
						itemGroupDataList.add(itemGroupData);
						map.put(key, itemGroupDataList);
					}else{
						List<ItemGroupData> itemGroupDataList = new ArrayList<ItemGroupData>();
						itemGroupDataList.add(itemGroupData);
						map.put(key, itemGroupDataList);
					}
				}
				
			}
		}catch(Exception e){
			e.printStackTrace();
			throw new RuntimeException("xml解析异常");
		}
		return map;
	}
	
	@SuppressWarnings("rawtypes")
	public static Map<String , Object> parseXmlStr(String xml , Page page){
		Map<String , Object> map = new HashMap<String , Object>();
		if(StringUtil.isBlank(xml)){
			return map;
		}
		Document doc = null;
		try{
			doc = DocumentHelper.parseText(xml);
			String stepName = page.getName();
			Element root = doc.getRootElement();
			String path = "//"+stepName;
			Element stepElement = (Element)root.selectSingleNode(path);
			if(stepElement==null){
				return map;
			}
			map.putAll(IteratorItemNode(stepElement));
			Iterator<Element> itemGroupIterator = stepElement.elementIterator("itemGroup");
			while(itemGroupIterator.hasNext()){
				Element itemGroupElement = itemGroupIterator.next();
				String key = itemGroupElement.attributeValue("name");
				String flow = itemGroupElement.attributeValue("flow");
				Map<String , Object> itemGroupDataMap =IteratorItemNode(itemGroupElement);
				ItemGroupData itemGroupData = new ItemGroupData();
				itemGroupData.setFlow(flow);
				itemGroupData.setObjMap(itemGroupDataMap);
				
				if(map.containsKey(key)){
					Object obj = map.get(key);
					List<ItemGroupData> itemGroupDataList = (List<ItemGroupData>)obj;
					itemGroupDataList.add(itemGroupData);
					map.put(key, itemGroupDataList);
				}else{
					List<ItemGroupData> itemGroupDataList = new ArrayList<ItemGroupData>();
					itemGroupDataList.add(itemGroupData);
					map.put(key, itemGroupDataList);
				}
			}
				
		}catch(Exception e){
			e.printStackTrace();
			throw new RuntimeException("xml解析异常");
		}
		return map;
	}
	
	
	@SuppressWarnings("rawtypes")
	public static Map<String , Object> parseXmlItemGroupStr(String xml , Page page , String flow){
		Map<String , Object> map = new HashMap<String , Object>();
		Document doc = null;
		try{
			doc = DocumentHelper.parseText(xml);
			String stepName = page.getName();
			Element root = doc.getRootElement();
			String path = "//"+stepName+"/itemGroup[@flow=\'"+flow+"\']";
			Element itemGroupElement = (Element)root.selectSingleNode(path);
			//String key = itemGroupElement.attributeValue("name");
			Map<String , Object> itemGroupDataMap =IteratorItemNode(itemGroupElement);
			//ItemGroupData itemGroupData = new ItemGroupData();
			//itemGroupData.setFlow(flow);
			//itemGroupData.setObjMap(itemGroupDataMap);
			//List<ItemGroupData> itemGroupDataList = new ArrayList<ItemGroupData>();
			//itemGroupDataList.add(itemGroupData);
			map.putAll(itemGroupDataMap);
		}catch(Exception e){
			e.printStackTrace();
		}
		return map;
	}
	
	/**
	 * 删除xml中的指定文件流水号
	 * @param xml
	 * @param page
	 * @param fileFlows
	 * @return
	 */
//	public static String delFileFlow(String xml , String pageName , List<String> fileFlows){
//		Document doc = null;
//		
//		try{
//			doc = DocumentHelper.parseText(xml);
//			Element rootEle = doc.getRootElement();
//			Element stepEle = (Element)rootEle.selectSingleNode("./"+pageName);
//			if(stepEle!=null){
//				Element itemEle = stepEle.element("item");
//				if(itemEle!=null){
//					Iterator<Element> valIterator = itemEle.elementIterator("value");
//					while(valIterator.hasNext()){
//						Element valEle = valIterator.next();
//						String val = valEle.getText();
//						if(fileFlows.contains(val)){
//							valEle.detach();
//						}
//					}
//				}
//				
//			}
//			
//		}catch(Exception e){
//			e.printStackTrace();
//		}
//		return doc.asXML(); 
//	}
	
	
	/**
	 * 迭代父元素下的Item节点 并组成Map返回
	 * @param parentElement
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public static Map<String , Object> IteratorItemNode(Element parentElement){
		Map<String , Object> map = new HashMap<String, Object>();
		Iterator<Element> itemEleIterator =  parentElement.elementIterator("item");
		while(itemEleIterator.hasNext()){
			Element itemElement = itemEleIterator.next();
			String key = itemElement.attributeValue("name");
			String mutiple = itemElement.attributeValue("multiple");
			String isFile = itemElement.attributeValue("isFile");
			if(GlobalConstant.FLAG_Y.equals(isFile)){
				setMapData(map , key , isFile , mutiple , itemElement ,  GlobalConstant.IS_FILE);
			}else{
				setMapData(map , key , isFile , mutiple , itemElement , null);
			}
			
			
		}
		return map;
	}
	
	/**
	 * 设置Map的key val
	 * @param map
	 * @param key
	 * @param isFile
	 * @param mutiple
	 * @param itemElement
	 */
	private  static void setMapData(Map<String , Object> map , String key , String isFile , String mutiple , Element itemElement , String fileFlag ){
		if(GlobalConstant.FLAG_N.equals(mutiple)){
			String val = itemElement.element("value").getText();
			map.put(key, val);
			if(GlobalConstant.IS_FILE.equals(fileFlag)){
				map.put(fileFlag, val);
			}
		}else if(GlobalConstant.FLAG_Y.equals(mutiple)){
			Iterator itemIterator = itemElement.elementIterator();
			List<String> values = new ArrayList<String>();
			while(itemIterator.hasNext()){
				Element valueElement = (Element)itemIterator.next();
				values.add(valueElement.getText());
			}
			if(map.containsKey(key)){
				List<String> oldVals = (List<String>)map.get(key);
				oldVals.addAll(values);
			}
			if(GlobalConstant.IS_FILE.equals(fileFlag)){
				if(map.containsKey(fileFlag)){
					List<String> oldVals = (List<String>)map.get(fileFlag);
					oldVals.addAll(values);
				}
				map.put(fileFlag, values);
			}
			map.put(key, values);
			
		}
	}
	
	/*-------------------------------------以下是项目基本信息的xml操作----------------------------------------------------*/
	
	
	
//	public static String setFileItem(String xml , Page page , List<String> fileFlows){
//		Document doc = null;
//		try{
//			doc = DocumentHelper.parseText(xml);
//			Element rootEle = doc.getRootElement();
//			Element stepEle = (Element)rootEle.selectSingleNode("./"+page.getName());
//			Element fileItem = (Element)stepEle.selectSingleNode("./item[@name=\'file\']");
//			for(String fileFlow:fileFlows){
//				Element val = fileItem.addElement("value");
//				val.setText(fileFlow);
//			}
//		}catch(Exception e){
//			return xml;
//		}
//		return doc.asXML();
//	}
	
	
	/**
	 * 创建item节点和值
	 * @param itemList
	 * @param ele
	 * @param datasMap
	 */
//	private static void iteratorItem(List<Item> itemList , Element ele , Map<String , String[]> datasMap){
//		if(itemList!=null && itemList.size()>0){
//			for(Item item:itemList){
//				
//				Element itemEle = ele.addElement("item");
//				String name = item.getName();
//				itemEle.addAttribute("name", name);
//				String remark = item.getRemark();
//				itemEle.addAttribute("remark", remark);
//				String[] values = datasMap.get(name);
//				String multiple = item.getMultiple();
//				itemEle.addAttribute("multiple", multiple);
//				if(values!=null && values.length>0){
//					for(String val:values){
//						Element valEle = itemEle.addElement("value");
//						valEle.setText(val);
//					}
//				}
//				
//			}
//		}
//	}
	
	/**
	 * 创建item节点 , 并根据索引设置值
	 * @param itemList
	 * @param ele
	 * @param datasMap
	 * @param index
	 */
	private static void iteratorItem(List<Item> itemList , Element ele , Map<String , String[]> datasMap , int index){
		if(itemList!=null && itemList.size()>0){
			for(Item item:itemList){
				Element itemEle = ele.addElement("item");
				String name = item.getName();
				itemEle.addAttribute("name", name);
				String remark = item.getRemark();
				itemEle.addAttribute("remark", remark);
				String isFile = item.getIsFile();
				if(StringUtil.isNotBlank(isFile)){
					itemEle.addAttribute("isFile", isFile);
				}
				String[] values = datasMap.get(name);
				String multiple = item.getMultiple();
				itemEle.addAttribute("multiple", multiple);
				Element valEle = itemEle.addElement("value");
				if(values!=null){
					valEle.setText(values[index]);
				}
				
				
			}
		}
	}
	
	
	/**
	 * 获取匹配的itemGroup name的item索引
	 * @param pattern
	 * @param datasMap
	 * @return
	 */
	private static int getMatchDataIndex(String pattern , Map<String , String[]> datasMap){
		int count = 0;
		Set<String> keys = datasMap.keySet();
		for(String key:keys){
			if(key.startsWith(pattern+"_")){
				String[] values = datasMap.get(key);
				count = values.length;
				break;
			}
		}
		return count;
	}
	
	
	
	
	public static void main(String[] args){
		String xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"+
				"<projInfo>" +
					"<step4>" +
					"<itemGroup name=\"wcr\" remark=\"主要完成人情况表\" flow=\"bdfeafe7d54b47309874870079bfea76\">"+
						"<Item name=\"userName\" remark=\"姓名\" multiple=\"N\">"+
							"<value>dd</value>"+
						"</Item>"+
						"<Item name=\"sex\" remark=\"性别\" multiple=\"N\">"+
							"<value>2</value>"+
						"</Item>" +
					"</itemGroup>"+
					"<itemGroup name=\"wcr\" remark=\"主要完成人情况表\" flow=\"bdfeafe7d54b47309874870079bfea77\">"+
						"<Item name=\"userName\" remark=\"姓名\" multiple=\"N\">"+
							"<value>123</value>"+
						"</Item>"+
						"<Item name=\"sex\" remark=\"性别\" multiple=\"N\">"+
							"<value>1</value>" +
						"</Item>" +
					"</itemGroup>" +
					"</step4>" +
				"</projInfo>";
		Page page = new Page();
		page.setName("step4");
		Map<String , Object> map = parseXmlStr(xml ,page);
		Set<Entry<String , Object>> entrys = map.entrySet();
		Iterator<Entry<String , Object>> iterator = entrys.iterator();
		while(iterator.hasNext()){
			Entry<String , Object> entry = iterator.next();
			System.out.println("--------------------------------------");
			String key = entry.getKey();
			System.out.println(key);
			Object obj = entry.getValue();
			if(obj instanceof List){
				List<ItemGroupData> list = (List<ItemGroupData>)obj;
				for(ItemGroupData igd:list){
					System.out.println(igd.getFlow());
					System.out.println(igd.getObjMap()+"-----");
					Map<String , Object> objMap = igd.getObjMap();
					Set<String> keys = objMap.keySet();
					for(String s:keys){
						Object ob = objMap.get(s);
						if(ob instanceof List){
							List<String> lis = (List<String>)ob;
							for(String si:lis){
								System.out.println(si);
							}
						}else{
							System.out.println(ob.toString());
						}
					}
				}
			}
			System.out.println("--------------------------------------");
		}
		
	}


	@SuppressWarnings("unchecked")
	public static String delXmlFileItemGroupStr(String recContent, Page page,
			String itemGroupName, String flow) {
		Document document = null;
		try {
			document = DocumentHelper.parseText(recContent);
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return recContent;
		}
		Element rootElement = document.getRootElement();
		Node stepNode = rootElement.selectSingleNode("./"+page.getName());
		if(stepNode==null){
			stepNode = rootElement.addElement(page.getName());
		}
		String fileXpath = "//itemGroup/item/value";
		List<Node> fileItemGroupNodeList = stepNode.selectNodes(fileXpath);
		if(fileItemGroupNodeList != null && !fileItemGroupNodeList.isEmpty()){
			for(Node n : fileItemGroupNodeList){
				if(n.getText().equals(flow)){
					Node itemGroupNode = n.getParent().getParent();
					if(itemGroupNode!=null){
						itemGroupNode.detach();
						return document.asXML();
					}
				}
			}
		}
		return null;
	}
}
