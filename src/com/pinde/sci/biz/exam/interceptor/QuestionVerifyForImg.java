package com.pinde.sci.biz.exam.interceptor;

import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.model.exam.QuestionFileVerifyInfo;

/**
 * 验证题目包含的图片
 * @author Administrator
 *
 */
public class QuestionVerifyForImg extends QuestionVerifyInterceptorAdapter{
	
	public static final String INCLUDE_IMGURL_REG = "<img"; 
	public static final String IMGURL_REG = "<img[^<>]*?\\ssrc=['\"]?(.*?)['\"].*?>";
	private static final String ROOT_PATH = "D:"+File.separator+"tomcat-7.0.55"+File.separator+"webapps"+File.separator;
	
	@Override
	public QuestionFileVerifyInfo handle(Object questionInfo,
			Integer questionNo, String questionTypeId , Object handler) {
		QuestionFileVerifyInfo verifyInfo = new QuestionFileVerifyInfo();
		@SuppressWarnings("unchecked")
		Map<Integer , String> questionData = (Map<Integer , String>)questionInfo;
		verifyInfo.setQuestionTypeId(questionTypeId);
		verifyInfo.setQuestionNo(questionNo);
		Set<Entry<Integer , String>> questionEntrySet = questionData.entrySet();
		Iterator<Entry<Integer , String>> iterator = questionEntrySet.iterator();
		while(iterator.hasNext()){
			Entry<Integer , String> iteratorEntry = iterator.next();
			Integer lineNum = iteratorEntry.getKey();
			String content = iteratorEntry.getValue();
			int imgCount = getImgCount(content);
			if(imgCount>0){
				List<String> imageUrls = getImageUrl(content);
				if(imageUrls.size()==imgCount){
					//检验图片
					String imgPath = exitImg(imageUrls);
					if(StringUtil.isNotBlank(imgPath)){
						verifyInfo.setLineNum(lineNum);
						verifyInfo.setMsg(verifyInfo.getMsg()+","+imgPath+"图片不存在");
						return verifyInfo;
					}
				}else{
					verifyInfo.setLineNum(lineNum);
					verifyInfo.setMsg(verifyInfo.getMsg()+",img标签有问题,请检查");
					return verifyInfo;
				}
			}
		}
		return null;
	}
	
	private int getImgCount(String html){
		int i = 0;
		Pattern includePattern = Pattern.compile(INCLUDE_IMGURL_REG);
		Matcher m = includePattern.matcher(html);
		while (m.find()) {
			i++;
		}
		return i;
	}
	
	private List<String> getImageUrl(String HTML) {
		Matcher matcher = Pattern.compile(IMGURL_REG).matcher(HTML);
		List<String> listImgUrl = new ArrayList<String>();
		while (matcher.find()) {
			listImgUrl.add(matcher.group());
		}
		return listImgUrl;
	}
	
	private String getImageSrc(String image) {
		String imgSrc = "";
		imgSrc = image.replaceAll("<img src=[\"|\']", "");
		imgSrc = imgSrc.replaceAll("[\"|\']/?>", "");
		return imgSrc;
	}
	
	private String exitImg(List<String> listImageUrl){
		for(String img:listImageUrl){
			String imgSrc = getImageSrc(img);
			String imgPath = ROOT_PATH+imgSrc;
			File imgFile = new File(imgPath);
			if(!imgFile.exists()){
				return imgPath;
			}
		}
		return "";
		
	}

}
