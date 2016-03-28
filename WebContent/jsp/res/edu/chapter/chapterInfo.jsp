<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
	<jsp:param name="jquery_ui_sortable" value="false"/>
	<jsp:param name="jquery_cxselect" value="false"/>
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
<script type="text/javascript">
$(document).ready(function(){
	 loadTestList('${param.chapterFlow}');
	});
function loadTestList(chapterFlow){
	var selfFlag=$("#selfFlag").val();
	var url ="<s:url value='/resedu/manage/course/loadTestList?chapterFlow='/>"+chapterFlow+"&selfFlag="+selfFlag;
	    jboxLoad("content",url,false);
}
function searchSelfTest(obj){
    if($(obj).attr("checked")=="checked"){
 	   $(obj).val("Y");
    }else{
 	   $(obj).val("N");
    }
    loadTestList('${param.chapterFlow}');
 }
function bindTest(paperFlow,chapterFlow){
	var checkBox=$("#check_"+paperFlow);
	var type="";
	if(checkBox.is(":checked")){
		type="add";
	}else{
		type="del";
	}
	var url="<s:url value='/resedu/manage/course/changePaperBind'/>?paperFlow="+paperFlow+"&chapterFlow="+chapterFlow+"&type="+type;
	 jboxPost(url,null,function(resp){
		           if(resp=='${GlobalConstant.ONE_LINE}'){
		        	   jboxTip('${GlobalConstant.OPRE_SUCCESSED}');
		           }else if(resp=='${GlobalConstant.CAN_NOT_BIND_FLAG}'){
		        	   jboxTip('${GlobalConstant.CAN_NOT_BIND}');
		        	   checkBox.removeAttr("checked");
		           }else{
		        	  jboxTip('${GlobalConstant.OPRE_FAIL}');
		        	   checkBox.removeAttr("checked");
		           }
		           var testCount=$("#testCount").val();
		           var courseTestCount=$("#content").find('input:checkbox[name="courseTestCount"]:checked').length;
		           if(testCount>0 && courseTestCount>0 && testCount==courseTestCount){
		        	  $("#selfFlag").attr("checked","checked");
		        	   $("#selfFlag").attr("disabled","disabled");
		           }else{
		        	  $("#selfFlag").removeAttr("checked");
		        	   $("#selfFlag").removeAttr("disabled");
		           }
				},
				null,false);
}
function testResultInfo(paperFlow){
	var url="<s:url value='/resedu/manage/course/testResultInfo'/>?paperFlow="+paperFlow;
	var w = $('.mainright').width()*0.8;
		var h = $('.mainright').height()*0.8;
		jboxOpen(url, "查看考试结果",w, h);
}
function doClose(){
	var url = "<s:url value='/resedu/manage/course/loadChapterList'/>?courseFlow=${chapter.courseFlow}";
	window.parent.frames['mainIframe'].window.jboxLoad("content_${chapter.courseFlow}", url, false);
	jboxCloseMessager();
}
</script>
</head>
<body>
	<div class="mainright">
	<div class="content">
	<div class="title1 clearfix">
	  <table class="basic" width="100%"> 
	    <colgroup>
	      <col width="20%"/>
	      <col width="30%"/>
	      <col width="20%"/>
	      <col width="30%"/>
	    </colgroup>
							<tr>
								<th id="chapterType">名&#12288;&#12288;称：</th>
								<td style="text-align: left;">${chapter.chapterName }</td>
								<th >序&#12288;&#12288;号：</th>
								<td style="text-align: left;">${chapter.chapterNo }</td>
							</tr>
							<tr>
								<th>章节视频：</th>
								<td colspan="3" style="text-align: left;">
								<span id="uploadChapterVideoName">
				                  <c:if test="${not empty chapter.chapterFileName }">
				                   <a href="<s:url value='/resedu/manage/course/previewCourseVideo'/>?chapterFlow=${chapter.chapterFlow}" target="_blank" title="点击预览视频">
				                                                            预览${chapter.chapterFileName }
				                   </a>
				                  </c:if>
				                </span>
								</td>
							</tr>
							<tr>
								<th>章节图片：</th>
								<td colspan="3" style="text-align: left;">
									<span id="uploadChapterImgName">
				                      <c:if test="${not empty chapter.chapterImgName }">
				                        <a href="${sysCfgMap['upload_base_url']}${chapter.chapterFile}" target="_blank" title="点击查看大图">预览${chapter.chapterImgName }</a>
				                      </c:if>
				                    </span>
								</td>
							</tr>
							<tr>
							    <th>时&#12288;&#12288;长：</th>
								<td colspan="3" style="text-align: left;" id="chapterTimeTd">
                                     <span id="chapterTimeText">${chapter.chapterTime}</span>
								</td>
							</tr>
							<tr>
							    <th><span style="color: red">*</span>&nbsp;学&#12288;&#12288;分：</th>
								<td style="text-align: left;">${chapter.chapterCredit}</td>
								<th><span style="color: red">*</span>&nbsp;授课教师：</th>
								<td style="text-align: left;">${teacherName }</td>
							</tr>
							<tr>
								<th>介&#12288;&#12288;绍：</th>
								<td colspan="3">
									${chapter.chapterIntro}
								</td>
							</tr>
						</table>
		<table class="xllist" style="width: 100%;margin-top: 10px;">
             <colgroup>
             <col width="9%"/>
   		     <col width="13%"/>
   		     <col width="13%"/>
   		     <col width="13%"/>
   		     <col width="13%"/>
   		     <col width="13%"/>
   		     <col width="13%"/>
   		     <col width="13%"/>
   		  </colgroup>
             <thead>
                <tr>
                   <td colspan="8" style="text-align: left;padding-left: 10px;">
                                                                 试卷信息
                      &#12288;<input type="checkBox" id="selfFlag" value="${param.selfFlag }" class="只显示本课程试卷" onclick="searchSelfTest(this);"
                      <c:if test="${param.selfFlag eq 'Y'}">checked</c:if>/>
                      <label for="selfFlag">只显示本章节试卷</label>
                   </td>
                </tr>
                <tr>
                   <th>选择试卷</th>
                   <th>考卷名称</th>
                   <th>考试时间（分钟）</th>
                   <th>出题方式</th>
                   <th>出卷人</th>
                   <th>总分</th>
                   <th>及格分</th>
                   <th>操作</th>
                </tr>
             </thead>
             <tbody id="content">
              
             </tbody>
         </table>
			<p align="center" style="width:100%">
				<input class="search" type="button" value="关&#12288;闭"  onclick="doClose();"/>
			</p>
</div>
</div>
</div>
</body>
</html>