<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="true"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
	<jsp:param name="jquery_ui_sortable" value="false"/>
	<jsp:param name="jquery_cxselect" value="true"/>
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
	function reupload(){
		$("#fileName,#reupload").hide();
		$("#file").show().attr("disabled",false);
		$("#declarationFormFlow").attr("disabled",true);
		$("#cancel").show();
	}
	
	function saveOrg() {
		if(!$("#addForm").validationEngine("validate")){
			return;
		}
		var form=$("#addForm");
		var url = "<s:url value='/fstu/dec/save'/>";
		jboxSubmit(form,url, function(obj) {
			if(obj=="${GlobalConstant.SAVE_SUCCESSED}"){
				window.parent.document.mainIframe.search();
				jboxClose();
			}
		});
	}
	
	function cancel(){
		$("#fileName,#reupload").show();
		$("#file").hide().attr("disabled",true);
		$("#declarationFormFlow").attr("disabled",false);
		$("#cancel").hide();
	}
</script>
</head>
<body>

<form id="addForm" style="height: 100px;" >
<input name="projFlow" value="${proj.projFlow}" type="hidden"/>
<input name="orgName" type="hidden" value="<c:out value="${proj.orgName}" default="${sessionScope.currUser.orgName}"/>"/>
<input name="orgFlow" type="hidden" value="<c:out value="${proj.orgFlow}" default="${sessionScope.currUser.orgFlow}"/>"/>
<div class="content">
	<div class="title1 clearfix">
				<table width="800" cellpadding="0" cellspacing="0" class="basic">
					<tr>
						<th width="20%"><span class="red">*</span>年份：</th>
						<td width="30%"><input type="text"  class="validate[required] xltext ctime" name="projYear" value="${proj.projYear}" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy'})" /></td>
						<th width="20%">项目级别：</th>
						<td width="30%">
						<select name="projLevelId" class="xlselect">
							<option/>
							<c:forEach items="${dictTypeEnumFstuTypeList}" var="dict">
								<option value="${dict.dictId}" <c:if test="${proj.projLevelId==dict.dictId}">selected</c:if> >${dict.dictName}</option>
							</c:forEach>
						</select>
<%-- 							<input class=" xltext" name="projLevelName" type="text" value="${proj.projLevelName}"/> --%>
						</td>
					</tr>
					<tr style="display:${showJglx}">
						<th><span class="red">*</span>项目名称：</th>
						<td >
							<input class="validate[required] xltext" name="projName" type="text" value="${proj.projName}" />
						</td>
						<th>所属学科：</th>
						<td colspan="3">
							<input class="xltext" name="projSubject" type="text" value="${proj.projSubject}"/>
						</td>
					</tr>
					<tr style="display:${showJglx}">
						<th>主办单位：</th>
						<td>
							<input class="xltext" name="applyOrgName" type="text" value="${proj.applyOrgName}"/>
						</td>
						<th><span class="red">*</span>项目负责人：</th>
						<td width="30%"><input  class="validate[required] xltext" type="text" name="applyUserName" value="${proj.applyUserName}"/></td>
					</tr>
					<tr>
						<th>电话：</th>
						<td colspan="3">
							 <input type="text" name="projPhone" value="${proj.projPhone}" class="xltext"/>
						</td>
					</tr>
					<tr>
						<th><span class="red">*</span>开始时间：</th>
							<td >
								<input type="text" class="validate[required] xltext ctime" name="projStartTime" value="${proj.projStartTime}"  readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
							</td>
						<th><span class="red">*</span>结束时间：</th>
							<td>
								<input type="text"  class="validate[required] xltext ctime" name="projEndTime"  value="${proj.projEndTime}" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
							</td>
						</tr>
					<tr>
						<th><span class="red">*</span>举办地点：</th>
						<td>
						    <input type="text" name="projHoldAddress" value="${proj.projHoldAddress}" class="validate[required] xltext"/>
						</td>
						<th>申请学分：</th>
						<td>
						    <input type="text" name="applyScore" value="${proj.applyScore}" class="xltext"/>
						</td>
					</tr>	
					<tr>
						<th>教学对象：</th>
						<td>
						    <input type="text" name="teachingObject" value="${proj.teachingObject}" class="xltext"/>
						</td>
						<th>拟招生人数：</th>
						<td>
						    <input type="text" name="recruitNum" value="${proj.recruitNum}" class="validate[custom[integer]] xltext"/>
						</td>
					</tr>	
					<tr>
						<th>申报表：</th>
						<td colspan="3">
						   <c:choose>
						   		<c:when test="${empty proj.declarationFormFlow}">
						   			<input type="file" name="file" />
						   		</c:when>
						   		<c:otherwise>
						   			<font id="fileName">${file.fileName}</font>
									<input id="file" type="file" name="file" style="display: none;" disabled="disabled"/>
						   			<input type="hidden" id="declarationFormFlow"  name="declarationFormFlow" value="${proj.declarationFormFlow}"/>
						   			<a id="reupload" href="javascript:void(0);" onclick="reupload();">[重新上传]</a>
						   			<a id="cancel" onclick="cancel();" style="display: none;">[取消]</a>
						   		</c:otherwise>
						   </c:choose> 
						</td>
						</tr>
						<tr>
						<th>申报结果：</th>
						<td>
						    <select class="xlselect" name="declarationResultId">
						    	<option></option>
						    	<option value="${declarationResultEnumPass.id}" <c:if test="${proj.declarationResultName == declarationResultEnumPass.name}">selected</c:if>>${declarationResultEnumPass.name}</option>
						    	<option value="${declarationResultEnumNotPass.id}" <c:if test="${proj.declarationResultName == declarationResultEnumNotPass.name}">selected</c:if>>${declarationResultEnumNotPass.name}</option>
						    </select>
						</td>
						<th><span class="red">*</span>项目编号：</th>
						<td>
						    <input type="text" name="projNo" value="${proj.projNo}" class="validate[required] xltext" />
						</td>
					</tr>	
						<tr>
					<th>备注：</th>
						<td colspan="3">
							<textarea  name="remark"  class="xltxtarea" style="margin-left: 0px;" >${proj.remark}</textarea>
<%-- 						    <input type="text" name="remark" value="${proj.remark}" class="xltext"/> --%>
						</td>	
					</tr>
				</table>
				<div class="button" style="width: 800px;">
					<input class="search" type="button" value="保&#12288;存" onclick="saveOrg();"/>
					<input class="search" type="button" value="关&#12288;闭" onclick="jboxClose();" />
				</div>
			</div>
</div>
</form>
</body>
</html>