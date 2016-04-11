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
	jboxLoad("report","<s:url value='/jsp/res/intern/report.jsp'/>",true); 
}
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				<table class="basic" width="100%">
					<tr>
						<th colspan="6" style="text-align: left;">&#12288;医德医风</th>
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
						理解医生职业道德和医患沟通的意义，树立"以人为本，服务健康"的意识，具有奉献精神和服务意识。掌握医患沟通的基本技能，感受并实践医患沟通
						、维护好医患关系。熟悉并严格遵守医院各项规章制度。
						</td>
						
					</tr>
					<tr>
						<td  width="100px;" style="text-align: left;">&#12288;&#12288;<font style="font-weight: bold;">考核内容：</font></td>
						<td style="line-height: 25px;" colspan="3">
						<div style="float: left;">
						<p>1、科室实习表现(责任心、爱心、主动性、纪律性、合作性等)</p>
						<p>2、门诊导医或病房陪护（1天）出勤和表现</p>
						<p>3、调查报告或经验总结一篇（不低于1000字）</p>
						<p>4、遵章守纪表现</p>
						</div>
						
						
						<div style="margin-right: 10px;margin-top: 5px;margin-bottom: 5px;;cursor: pointer;height:200px;width:150px;float: right;background: url('<s:url value='/css/skin/${skinPath}/images/caseinfo_edit.jpg'/>' ) no-repeat;" onclick="show();">
							<p style="margin-top: 20px;text-align: center;"><b>经验总结</b></p>
							</div>
						</td>
						
					</tr>
					<tr>
						<th colspan="6" style="text-align: left;">&#12288;教学记录</th>
					</tr>
					<tr style="font-weight: bold;"><td>时间</td><td>教师</td><td>形式</td><td>教学主要内容</td></tr>
					<tr><td>2014-03-21</td><td>李凯</td><td>讲座</td><td>急性肺炎的处理常规处理</td></tr>
					<tr><td></td><td></td><td></td><td></td></tr>
					<tr><td></td><td></td><td></td><td></td></tr>
					<tr><td></td><td></td><td></td><td></td></tr>
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