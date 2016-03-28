<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
</jsp:include>
<script type="text/javascript">

	function searchProj() {
		jboxStartLoading();
		$("#searchForm").submit();
	}
	function apply(){
		jboxStartLoading();
		window.location.href="<s:url value='/srm/proj/mine/addProjInfo'/>";
	}
	
	function auditList(projFlow){
		jboxStartLoading();
		jboxOpen("<s:url value='/srm/proj/mine/auditList?projFlow='/>"+projFlow,"审核信息", 800,600);
	}
	
	function delProj(projFlow){
		var url = "<s:url value='/srm/proj/mine/del?projFlow='/>"+projFlow;
		jboxConfirm("确认删除该项目？" , function(){
			jboxStartLoading();
			jboxGet(url , null , function(){
				searchProj();
			} , null , true);
		});
		
	}
	
	function toPage(page) {
		if(page!=undefined){
			$("#currentPage").val(page);			
		}
		searchProj();
	}
	
	function applyProj(){
		var applyLimit = "${sysCfgMap['researcher_apply_limit_ky']}";
		var projCategoryId = "${projCategroyEnumKy.id}";
		if(applyLimit != ""){
			var data = {
				userFlow : "${sessionScope.currUser.userFlow}",
				projCategoryId : projCategoryId,
				applyLimit : applyLimit
			};
			var url = "<s:url value='/srm/proj/mine/queryProjApplyLimit'/>";
			jboxPost(url, data, function(resp){
				if("${GlobalConstant.FLAG_Y}" == resp){
					apply();
				}else if("${GlobalConstant.FLAG_N}" == resp){
					jboxInfo("您本年度申请科研项目数已满，无法继续申请！");
				}else{
					return false;
				}
			}, null, false);
		}else{
			apply();
		}
	}
	
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<form id="searchForm" action="<s:url value="/srm/proj/mine/projList/${sessionScope.projCateScope}" />"
				method="post">
				<p>
					年&#12288;&#12288;度: 
					<input type="text" class="xltext ctime" name="projYear" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy'})" value="${param.projYear }"/>
					项目类别:
					<select name="projTypeId" class="xlselect" style="width:auto;">
							<option value="">--请选择--</option>
                       	<c:forEach var="dictEnuProjType" items="${dictTypeEnumProjTypeList}">
                       		<option value="${dictEnuProjType.dictId}" <c:if test='${param.projTypeId==dictEnuProjType.dictId}'>selected="selected"</c:if>>${dictEnuProjType.dictName}</option>
                       	</c:forEach>
					</select>
				</p>
				<p>
				   项目编号: <input type="text" name="projNo" value="${param.projNo}" class="xltext" />
				   项目名称:
					<input type="text" name="projName" value="${param.projName}" class="xltext" style="width: 176px" />
					<input id="currentPage" type="hidden" name="currentPage" value=""/>
					<input type="button" class="search" onclick="searchProj();" value="查&#12288;询"> 
					<input type="button" class="search" style="width: 100px" onclick="applyProj();" value="申报新项目"> 
				</p>
			</form>
		</div>
		<table class="xllist">
			<thead>
				<tr>
					<th width="5%" rowspan="2">年份</th>
					<th width="20%" rowspan="2">项目名称</th>
					<th width="12%" rowspan="2">项目类型</th>
					<th width="13%" rowspan="2">起止时间</th>
					<th width="6%" rowspan="2">当前阶段</th>
					<th width="20%" colspan="6">当前状态</th>
					<th width="5%" rowspan="2">审核意见</th>
					<th width="5%" rowspan="2">操作</th>
				</tr>
				<tr>
					<th>项目<br/>申报</th>
					<th>项目<br/>评审</th>
					<th>项目<br/>立项</th>
					<th>合同<br/>管理</th>
					<th>进展<br/>报告</th>
					<th>项目<br/>验收</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${projList}" var="proj">
					<tr>
						<td><span>${proj.projYear }</span></td>
						<td><a style="color:blue" href="<s:url value='/srm/proj/mine/projView?projFlow=${proj.projFlow}'/>" target="_blank">${proj.projName}</a></td>
						<td>${proj.projTypeName }</td>
						<td>&#12288;${proj.projStartTime}~<br/>${proj.projEndTime}</td>
						<td>${proj.projStageName }</td>
						<c:set var="icnMap" value="${pdfn:showIcn(projAndProcessListMap[proj.projFlow])}"></c:set>
						<td>
							<c:if test='${icnMap["1"] eq 1}'>
								<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>" />
							</c:if>
							<c:if test='${icnMap["1"] eq 2}'>
								<img src="<s:url value='/css/skin/${skinPath}/images/shu.gif'/>" />
							</c:if>
						</td>
						<td>
							<c:if test='${icnMap["2"] eq 1}'>
								<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>" />
							</c:if>
							<c:if test='${icnMap["2"] eq 2}'>
								<img src="<s:url value='/css/skin/${skinPath}/images/shu.gif'/>" />
							</c:if>
						</td>
						<td>
							<c:if test='${icnMap["3"] eq 1}'>
								<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>" />
							</c:if>
							<c:if test='${icnMap["3"] eq 2}'>
								<img src="<s:url value='/css/skin/${skinPath}/images/shu.gif'/>" />
							</c:if>
							<c:if test='${icnMap["3"] eq 4}'>
								<img src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" />
							</c:if>
						</td>
						<td>
							<c:if test='${icnMap["4"] eq 1}'>
								<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>" />
							</c:if>
							<c:if test='${icnMap["4"] eq 2}'>
								<img src="<s:url value='/css/skin/${skinPath}/images/shu.gif'/>" />
							</c:if>
							<c:if test='${icnMap["4"] eq 4}'>
								<img src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" />
							</c:if>
						</td>
						<td>	
							<c:if test='${icnMap["5"] eq 1}'>
								<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>" />
							</c:if>
							<c:if test='${icnMap["5"] eq 2}'>
								<img src="<s:url value='/css/skin/${skinPath}/images/shu.gif'/>" />
							</c:if>
							<c:if test='${icnMap["5"] eq 4}'>
								<img src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" />
							</c:if>
						</td>
						<td>
							<c:if test='${icnMap["6"] eq 1}'>
								<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>" />
							</c:if>
							<c:if test='${icnMap["6"] eq 2}'>
								<img src="<s:url value='/css/skin/${skinPath}/images/shu.gif'/>" />
							</c:if>
							<c:if test='${icnMap["6"] eq 4}'>
								<img src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" />
							</c:if>
						</td>
						<td><a href="javascript:void(0)" onclick="auditList('${proj.projFlow}');">查看</a></td>
						<td><a href="<s:url value='/srm/proj/mine/process?projFlow=${proj.projFlow}'/>">进入</a>
							<c:if test="${proj.projStageId==projStageEnumApply.id and proj.projStatusId==projApplyStatusEnumApply.id}">|&nbsp;<a href="javascript:void(0);" onclick="delProj('${proj.projFlow}');">删除</a>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<c:set var="pageView" value="${pdfn:getPageView(projList)}" scope="request"></c:set>
			<pd:pagination toPage="toPage"/>	
	</div>
</div>
</body>
</html>