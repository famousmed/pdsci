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
	$().ready(function(){
		var url = '<s:url value="/irb/committee/fileList"/>?irbFlow=${param.irbFlow }';
		jboxLoad("tagContent",url,true);
	});
	function selectTag(selfObj,url) {
		var selLi = $(selfObj).parent();
		selLi.siblings("li").removeClass("selectTag");
		selLi.addClass("selectTag");
		jboxLoad("tagContent",url,true);
	}
	 
	function doBack(){
		window.location.href="<s:url value='/irb/committee/list/${role}'/>";
	}
</script>
<style>
.edit{background-color:;border:none;}
</style>
</head>
<body>
	<div id="main">
		<div class="mainright">
			<div class="content">
				<div style="margin-top: 5px">
					项目名称：<b>${irbForm.proj.projShortName} </b>
					<span style="margin-left: 40px;">项目类别：</span><b>${irbForm.proj.projSubTypeName}</b>
					<span style="margin-left: 40px;">伦理审查类别：</span><b>${irbForm.irb.irbTypeName}</b>
					<span style="margin-left: 40px;">审查方式：</span><b>${irbForm.irb.reviewWayName}</b>
					<span style="margin-left: 40px;">受理号：</span><b>${irbForm.irb.irbNo}</b>
					&#12288;<input type="button"  class="search" value="返&#12288;回" onclick="doBack();"/> 
				</div>
				<div class="title1 clearfix">
					<ul id="tags">
						<li class="selectTag"><a onclick="selectTag(this,'<s:url value="/irb/committee/fileList"/>?irbFlow=${param.irbFlow }')" href="javascript:void(0)">送审文件清单</a></li>
						<c:forEach items="${irbUserList }" var="irbUser" varStatus="statu">
							<li><a onclick="selectTag(this,'<s:url value="/irb/committee/irbWorksheet"/>?irbFlow=${param.irbFlow }&irbAuthTypeId=${irbUser.authId}&irbUserFlow=${irbUser.recordFlow}')" href="javascript:void(0)">
								<c:if test="${irbUser.authId==irbAuthTypeEnumCommitteePRO.id }">审查工作表_方案（${irbUser.userName }）</c:if>
								<c:if test="${irbUser.authId==irbAuthTypeEnumCommitteeICF.id }">审查工作表_知情同意书（${irbUser.userName }）</c:if>
								<c:if test="${irbUser.authId==irbAuthTypeEnumCommittee.id }">审查工作表（${irbUser.userName }）</c:if>
								<c:if test="${irbUser.authId==irbAuthTypeEnumConsultant.id }">独立顾问咨询表（${irbUser.userName }）</c:if>
								</a>
							</li>
						</c:forEach>
						<c:if test="${role==GlobalConstant.IRB_COMMITTEE_SECRETARY && irbForm.irb.reviewWayId==irbReviewTypeEnumFast.id }" >
							<li><a onclick="selectTag(this,'<s:url value="/irb/secretary/quickOpinion"/>?irbFlow=${param.irbFlow }')" href="javascript:void(0)">快审主审综合意见</a></li>
						</c:if>
					</ul>
					<div id="tagContent">
					</div>
				</div>
			</div>
		</div>
		</div>
</body>
</html>