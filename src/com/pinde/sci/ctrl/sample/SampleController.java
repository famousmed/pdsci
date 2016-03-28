package com.pinde.sci.ctrl.sample;

import java.util.ArrayList;
import java.util.List;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.Node;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.jspform.Item;
import com.pinde.sci.biz.sample.ISampleBiz;
import com.pinde.sci.common.GeneralController;

@Controller  
@RequestMapping("/sample")
public class SampleController extends GeneralController{

	private static final Logger log = LoggerFactory.getLogger(SampleController.class); 
	
	@Autowired
	private ISampleBiz jobBiz; 
	
	@RequestMapping("/list.do")
	public String list(Model model) {
		log.info("get the jsp file at {}", System.currentTimeMillis());
//		model.addAttribute("list", jobBiz.get());
		int a=1;

		log.info("a {}", a);
		return "sample/list";
	}
	
	@RequestMapping("/json.do")
	public @ResponseBody String  json() {
		log.info("json the jsp file at {}", System.currentTimeMillis());
		return "123";
	}
	
	@RequestMapping("/jsons.do")
	public @ResponseBody List<String>  jsons() {
		log.info("jsons the jsp file at {}", System.currentTimeMillis());
		List<String> jsons = new ArrayList<String>();
		jsons.add("1");
		jsons.add("2");
		jsons.add("3");
		return  jsons;
	}
	public static void main(String[] args) throws DocumentException {
		String content = "<irb><applyorreport><templet><title id='1' name='二、研究进展情况'><item1 id='1_015832' ><text>研究阶段：</text>" +
				"<code id='1_015832_015857' text='研究尚未启动'>123</code>" +
				"<code id='1_015832_015933' text='正在招募受试者（尚未入组）' inputtype='单选' /><code id='1_015832_020003' text='正在实施研究'/>" +
				"<code id='1_015832_020029' text='受试者的试验干预已经完成' />" +
				"<code id='1_015832_020045' text='后期数据处理阶段'/></item1></title></templet></applyorreport><applyorreport><templet><title id='1' name='二、研究进展情况'><item1 id='1_015832' ><text>研究阶段：</text>" +
				"<code id='1_015832_015857' text='研究尚未启动'>456</code>" +
				"<code id='1_015832_015933' text='正在招募受试者（尚未入组）' inputtype='单选' /><code id='1_015832_020003' text='正在实施研究'/>" +
				"<code id='1_015832_020029' text='受试者的试验干预已经完成' />" +
				"<code id='1_015832_020045' text='后期数据处理阶段'/></item1></title></templet></applyorreport></irb>";
		
		
		Document document = DocumentHelper.parseText(content);
		List<Element> workSheet = document.selectNodes("/irb/applyorreport"); 
		System.out.println(workSheet.get(1).selectSingleNode("templet/title/item1[@id='1_015832']/code[text()!='']").getText());
//		Element node1Element = rootElement.addElement("node1");
//		node1Element.setText("value1");
//		node1Element.addAttribute("attr1","attr1");
//		
//		Element node2Element = rootElement.addElement("node2");
//		node2Element.addAttribute("attr2","attr2");
//		node2Element.setText("value2");
//		Element node2ChildElement = node2Element.addElement("node2Child1");
//		node2ChildElement.setText("node2Child1value");
//		node2ChildElement.addAttribute("node2Child1Attr","node2Child1Attr");
//		System.out.println(document.asXML());
////		//值查找
//		Node singleNode = document.selectSingleNode("orgInfo/node2");
//		System.out.println(singleNode.getText()); 
////		//查询
//		singleNode = rootElement.selectSingleNode("./node2/node2Child1");
//		System.out.println(singleNode.getText()); 
////		//属性查
//		singleNode = rootElement.selectSingleNode("./node2[@attr2='attr2']");
//		System.out.println(singleNode.getText()); 
	}
}
