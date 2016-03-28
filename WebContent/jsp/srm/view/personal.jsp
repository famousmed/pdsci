<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<script type="text/javascript" defer="defer">
function showProj(stageId){
	jboxStartLoading();
	window.location.href="<s:url value="/srm/proj/mine/projList/ky" />?projStageId="+stageId;
}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<div style="width: 100%;">			
						<table  class="xllist nofix" style="width: 100%">
							<tr>
								<th  colspan="3" style="text-align: left;">&#12288;常用操作</th>
							</tr>
							<tbody>								
								<tr>
									<td class="bs_mod viewTd" align="left" >
										<div style="float: left;padding-top:10px;padding-bottom: 10px;">
											<div align="left" style="padding-left: 10px;float: left;cursor: pointer;">
												<img  src="<s:url value="/css/skin/${skinPath}/images/index_proj_city.png" />" onclick="window.location.href='<s:url value='/srm/proj/mine/projList/ky'/>'">
											</div>
											<div align="left" style=";margin-top: 5px;width: 220px">
												<b style="font-size: 16px;"><a href="<s:url value='/srm/proj/mine/projList/ky'/>">新项目申报</a></b><br/>
												年度新项目申报
											</div>
										</div>
										<div style="float: left;padding-top:10px;padding-bottom: 10px;">
											<div align="left" style="padding-left: 10px;float: left;cursor: pointer;">
												<img  src="<s:url value="/css/skin/${skinPath}/images/index_proj_province.png" />" onclick="window.location.href='<s:url value="/srm/aid/proj/list"/>?isCountry=${aidProjCategoryEnumProvince.id}'">
											</div>
											<div align="left" style=";margin-top: 5px;width: 220px">
												<b style="font-size: 16px;"><a href="<s:url value="/srm/aid/proj/list"/>?isCountry=${aidProjCategoryEnumProvince.id}">备案项目</a></b><br/>
												备案项目填写
											</div>
										</div>
										<!-- 
										<div style="float: left;padding-top:10px;padding-bottom: 10px;">
											<div align="left" style="padding-left: 10px;float: left;cursor: pointer;">
												<img  src="<s:url value="/css/skin/${skinPath}/images/index_proj_country.png" />" onclick="window.location.href='<s:url value="/srm/aid/proj/list"/>?isCountry=${aidProjCategoryEnumCountry.id}'">
											</div>
											<div align="left" style=";margin-top: 5px;width: 220px">
												<b style="font-size: 16px;"><a href="<s:url value="/srm/aid/proj/list"/>?isCountry=${aidProjCategoryEnumCountry.id}">国家级项目</a></b><br/>
												国家级项目填写
											</div>
										</div>
										 -->
										<div style="float: left;padding-top:10px;padding-bottom: 10px;">
											<div align="left" style="padding-left: 10px;float: left;cursor: pointer;">
												<img  src="<s:url value="/css/skin/${skinPath}/images/index_zdxk.png" />" onclick="window.location.href='<s:url value='/srm/proj/mine/projList/xk'/>'">
											</div>
											<div align="left" style=";margin-top: 5px;width: 220px">
												<b style="font-size: 16px;"><a href="<s:url value='/srm/proj/mine/projList/xk'/>">重点学科申请</a></b><br/>
												重点学科申请
											</div>
										</div>
										<div style="float: left;padding-top:10px;padding-bottom: 10px;">
											<div align="left" style="padding-left: 10px;float: left;cursor: pointer;">
												<img  src="<s:url value="/css/skin/${skinPath}/images/index_talent.png" />" onclick="window.location.href='<s:url value='/srm/aid/talents/list/personal'/>'">
											</div>
											<div align="left" style=";margin-top: 5px;width: 220px">
												<b style="font-size: 16px;"><a href="<s:url value='/srm/aid/talents/list/personal'/>">人才专项<br>资金申请</a></b><br/>
												人才专项资金申请
											</div>
										</div>
										<div style="float: left;padding-top:10px;padding-bottom: 10px;">
											<div align="left" style="padding-left: 10px;float: left;cursor: pointer;">
												<img  src="<s:url value="/css/skin/${skinPath}/images/index_user.png" />" onclick="window.location.href='<s:url value='/sys/user/view'/>'">
											</div>
											<div align="left" style=";margin-top: 5px;width: 220px">
												<b style="font-size: 16px;"><a href="<s:url value='/sys/user/view?editFlag=${GlobalConstant.FLAG_Y}'/>">个人信息</a></b><br/>
												基本信息、教育、工作经历
											</div>
										</div>
									</td>
								</tr>		
							</tbody>													
						</table>
					</div>
				<div style="width:100%; margin-top: 10px;">
					<table  class="xllist" width="100%">
						<tr>
								<th  colspan="3" style="text-align: left;">&#12288;最新公告</th>
							</tr>
							<tr><td style="text-align: left;padding-left: 20px;">暂无消息</td></tr>
					</table>
				</div>
				<div style=" margin-top: 10px;width: 100%;">
					<div style="width:59%;float: left;" align="left">
						<table  class="xllist" width="100%">
							<tr>
									<th  colspan="3" style="text-align: left;">&#12288;我的消息</th>
								</tr>
								<tr><td style="text-align: left;padding-left: 20px;">暂无消息</td></tr>
						</table>
					</div>
					<div style="width:39%; ;float: right;margin-left: 10px;">
						<table  class="xllist" width="100%">
							<tr>
									<th  colspan="3" style="text-align: left;">&#12288;我的申报</th>
								</tr>
								<tr>
									<td style="text-align: left;padding-left: 30px;">申报课题总数：<a href="javascript:showProj('');" style="color: red">${projCount}</a>
								          &#12288;&#12288; 研究中：<a href="javascript:showProj('${projStageEnumSchedule.id}');" style="color: red">${scheduleCount }</a> &#12288;
								    待验收：<a href="javascript:showProj('${projStageEnumComplete.id}');" style="color: red">${completeCount }</a> &#12288;
								          已结题：<a href="javascript:showProj('${projStageEnumArchive.id}');" style="color: red">${archiveCount}</a>
									</td>
								</tr>
								<c:forEach items="${projTypeCountMap}" var="entity">
									<tr><td style="text-align: left;padding-left: 30px;">${entity.key }：${entity.value }</td></tr>
								</c:forEach>
						</table>
					</div>
				</div>
		</div>
	</div>
</div>
</body>
</html>