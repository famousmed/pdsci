<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true" />
	<jsp:param name="jbox" value="true" />
	<jsp:param name="jquery_form" value="false" />
	<jsp:param name="jquery_ui_tooltip" value="true" />
	<jsp:param name="jquery_ui_combobox" value="false" />
	<jsp:param name="jquery_ui_sortable" value="false" />
	<jsp:param name="jquery_cxselect" value="true" />
	<jsp:param name="jquery_scrollTo" value="false" />
	<jsp:param name="jquery_jcallout" value="false" />
	<jsp:param name="jquery_validation" value="true" />
	<jsp:param name="jquery_datePicker" value="true" />
	<jsp:param name="jquery_fullcalendar" value="false" />
	<jsp:param name="jquery_fngantt" value="false" />
	<jsp:param name="jquery_fixedtableheader" value="true" />
	<jsp:param name="jquery_placeholder" value="true" />
	<jsp:param name="jquery_iealert" value="false" />
</jsp:include>
<script>
$(document).mouseup(function(f) {
	if ($(window).width() - f.pageX < 800) {
		return
	}
	if ($(f.target).closest("div.mfp-content").length) {
		return
	}
	if (f.target.nodeName == "SELECT") {
		if ($(event.target).closest($("#report")).length) {
			return
		}
	}
	$("#report").hide();
});
function show(){
	$("#report").show(); 
	jboxLoad("report","<s:url value='/jsp/res/intern/report2.jsp'/>",true); 
}
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				<table class="basic" width="100%">
					<tr>
						<th colspan="6" style="text-align: left;">&#12288;医学文案</th>
					</tr>
					<tr >
						<td  style="text-align: left;" colspan="4">&#12288;&#12288;<font style="font-weight: bold;">教学时间：</font>
						&#12288;<input type="text" class="inputText"  value="自定"
							style="text-align:center; width:100px; border-width: 0px; border-bottom-width: 1px;"/>
						&#12288;&#12288;<font style="font-weight: bold;">负责科室：</font><input type="text" class="inputText"  value="科教科"
							style="text-align:center; width:100px; border-width: 0px; border-bottom-width: 1px;"/>&#12288;&#12288;
							<font style="font-weight: bold;">总完成时间：</font><input type="text" class="inputText"  value="52周"
							style="text-align:center; width:100px; border-width: 0px; border-bottom-width: 1px;"/></td>
					</tr>

					<tr>
						<td  width="100px;" style="text-align: left;">&#12288;&#12288;<font style="font-weight: bold;">教学目标：</font></td>
						<td colspan="3">
						掌握内外妇儿科病历书写的规范要求，熟练并提高质量地完成病历书写。了解专题综述的协作方法和基本要求，能在老师的指导下独立完成综述
						</td>
						
					</tr>
					<tr>
						<td  width="100px;" style="text-align: left;">&#12288;&#12288;<font style="font-weight: bold;">考核内容：</font></td>
						<td style="line-height: 25px;" colspan="3">
						<div style="float: left;">
							<p>1、病历质量与数量要求</p>
							<p>&#12288;(1)完成实习大纲中规定各科书写病历数</p>
							<p>&#12288;(2)书写质量符合规范化病历标准</p>
							<p >2、在教师指导下完成一篇专题综述(字数不低于1500字)</p>
						</div>
						<div style="margin-right: 10px;margin-top: 5px;margin-bottom: 5px;;cursor: pointer;height:200px;width:150px;float: right;background: url('<s:url value='/css/skin/${skinPath}/images/caseinfo_edit.jpg'/>' ) no-repeat;" onclick="show();">
							<p style="margin-top: 20px;text-align: center;"><b>专题综述</b></p>
							</div>
						</td>
					</tr>
					<tr>
						<th colspan="6" style="text-align: left;">&#12288;教学记录</th>
					</tr>
					<tr style="font-weight: bold;"><td>时间</td><td>教师</td><td>形式</td><td>教学主要内容</td></tr>
					<tr><td>2014-03-21</td><td>李凯</td><td>讲座</td><td>内科病历书写规范</td></tr>
					<tr><td>2014-06-09</td><td>王军</td><td>讲课</td><td>外科病历书写规范</td></tr>
					<tr><td>2014-08-23</td><td>张洪</td><td>示教</td><td>妇科病历书写规范</td></tr>
					<tr><td>2014-11-15</td><td>李毅</td><td>讲座</td><td>儿科病历书写规范</td></tr>
				</table>
			</div>
		</div>
	</div>
	<div id="report" style="height: 100%; 
	background: url(<s:url value='/css/skin/${skinPath}/images/detail_shadow.jpg'/>) left repeat-y;
	width: 800px;
	padding-left:11px; 
	position: fixed;
	z-index: 1000;
	display: none;
	right: 0;
	top: 0">
	
	</div>
</body>
</html>