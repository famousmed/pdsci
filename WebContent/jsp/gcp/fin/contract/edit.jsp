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
<style type="text/css">
	.basic tbody th{text-align: left;padding-left: 10px;}
	.basic td.title_td{text-align: right;padding:0;}
</style>
<script type="text/javascript">
	function save(){
		var form = $("#saveForm");
		if(form.validationEngine("validate")){
			var url = "<s:url value='/gcp/fin/saveContract'/>";
			jboxSubmit(form,url,function(resp){
				if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
					//window.parent.frames['mainIframe'].window.reload();
					var url = "<s:url value='/gcp/fin/projList'/>?projFlow=${param.projFlow}";
					window.parent.frames['mainIframe'].window.location.href=url;
					jboxClose();
				}
			},function(){
				jboxTip('${GlobalConstant.SAVE_FAIL}');
			},true);
		}
	}
	function reupload(){
		$("#file_td").html('<input type="file" name="file">');
	}
	function delFile(){
		var url = "<s:url value='/gcp/fin/delContFile'/>?contractFlow=${cont.contractFlow }";
		jboxPost(url,null,function(resp){
			if(resp=='${GlobalConstant.DELETE_SUCCESSED}'){
				reupload();
			}
		},null,true);
	}
</script>
</head>
<body>
	<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<div class="title1 clearfix">
				<form id="saveForm" enctype="multipart/form-data" method="post"> 
				<input type="hidden" name="projFlow" value='${param.projFlow}'/>
				<input type="hidden" name="contractFlow" value='${cont.contractFlow}'/>
				<table width="100%" cellpadding="0" cellspacing="0" class="basic">
					<tr>
						<th colspan="4">合同信息</th>
					</tr>
					<tr>
						<td width="14%" class="title_td">合同名称：</td>
						<td colspan="3">
							<input type="text" class="validate[required] xltext" name="contractName" style="width: 547px;margin-right: 3px;" value="${cont.contractName}"/>
							<font class="red" >*</font>
						</td>
					</tr>
					<tr>
						<td class="title_td">合同编号：</td>
						<td>
							<input type="text" class="validate[required] xltext" name="contractNo" style="margin-right: 3px;" value="${cont.contractNo}"/><font class="red">*</font>
						</td>
						<td width="16%" class="title_td">合同类型：</td>
						<td>
							<select name="contractTypeId" class="validate[required] xlselect" style="margin-right: 3px;">
								<option value="">请选择</option>
								<c:forEach items="${gcpContractTypeEnumList}" var="type"> 
								<option value="${type.id }" <c:if test="${cont.contractTypeId eq type.id}">selected="selected"</c:if>>${type.name}</option>
								</c:forEach>
							</select>
							<font class="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="title_td">合同经费：</td>
						<td >
							<input type="text" class="validate[custom[number],min[0],maxSize[11]] xltext" name="contractFund" style="margin-right: 3px;" value="${cont.contractFund}"/>
						</td>
						<td  class="title_td">合同病例数：</td>
						<td >
							<input type="text" class="validate[custom[integer],min[0],maxSize[5]] xltext" name="caseNumber" style="margin-right: 3px;" value="${cont.caseNumber}"/>
						</td>
					</tr>
					<tr>
						<td class="title_td">合同份数：</td>
						<td>
							<input type="text" class="validate[custom[integer],min[1],maxSize[5]] xltext" name="contractCopies" style="margin-right: 3px;" value="${cont.contractCopies}"/>
						</td>
						<td  class="title_td">合同盖章日期：</td>
						<td>
							<input type="text" class="xltext ctime" name="stampDate" style="margin-right: 3px;" value="${cont.stampDate}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
						</td>
					</tr>
					<tr>
						<td class="title_td">合同附件：</td>
						<td colspan="3" id="file_td">
							<c:choose>
								<c:when test="${empty cont.contractFile }">
									<input type="file" name="file">
								</c:when>
								<c:otherwise>
									<a href="<s:url value='/pub/file/down'/>?fileFlow=${file.fileFlow}">${file.fileName}</a>
									<input type="hidden" name="contractFile" value="${cont.contractFile }"/>
									 &#12288;<a href="javascript:void(0);" onclick="reupload(this);" class="lock">[重新上传]</a>
									 &#12288;<a href="javascript:void(0);" onclick="delFile();" class="lock">[删除]</a>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div style="width: 100%;" align="center" >
			<input class="search" type="button" value="保&#12288;存" onclick="save()"  />
		</div>
</div></div></div>
</body>
</html>