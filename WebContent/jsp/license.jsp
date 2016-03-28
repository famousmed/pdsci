<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="true"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="true"/>
	<jsp:param name="jquery_ui_sortable" value="true"/>
	<jsp:param name="jquery_cxselect" value="true"/>
	<jsp:param name="jquery_scrollTo" value="true"/>
	<jsp:param name="jquery_jcallout" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="true"/>
	<jsp:param name="jquery_fngantt" value="true"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="true"/>
</jsp:include>
<script type="text/javascript">
function upload() {
	if(false == $("#licenseForm").validationEngine("validate")){
		return false;
	}
	var url ="<s:url value='/license/upload'/>";
	jboxSubmit(
			$("#licenseForm"),
			url,
			function(resp){
				if("${GlobalConstant.SAVE_SUCCESSED}" != resp){
					jboxTip(resp, 'loading');
				}else{
					jboxTip("${GlobalConstant.SAVE_SUCCESSED}", 'loading');
					window.location.href="<s:url value='/license'/>";
					jboxCloseMessager();
				}
			},null,true);
}
</script>
</head>
<body>
<div class="content">
	<div class="title1 clearfix">
		<div id="tagContent">
			<div class="tagContent selectTag" id="tagContent0">
				<table width="800" cellpadding="0" cellspacing="0" class="basic">
					<c:choose>
						<c:when test="${licenseed==false or expired==true}">
							<tr>
								<th style="text-align: center;">
									授权文件无效!!!
									<c:if test="${expired == true}">
										<font color="red">授权文件过期,授权到期日:${validDate }</font>
									</c:if>
								</th>
							</tr>
							<tr>
								<td>
									<div id="errors" style="display: ; color: ; width:800;"> 
										第一步：请复制服务器唯一硬件号:<input type="text" value="${machineId}" style="width: 300px;">,
										并与管理员联系，获取license.key文件。
								    </div> 
								</td>
							</tr>
							<tr>
								<td>
									<div id="errors" style="display: ; color: ; width:800;"> 
										<form id="licenseForm" style="position: relative;" enctype="multipart/form-data" method="post">
										第二步:上传license.key文件,<input type="file" name="licenseFile" style="width: 300px;" class="validate[required]">
										<input id="uploadButton" type="button" value="上传" onclick="upload();">
										</form>
								    </div> 
								</td>
							</tr>
						</c:when>
						<c:otherwise>
							<tr>
								<th style="text-align: center;">合法授权!!!</th>
							</tr>
							<tr>
								<td>
									<div id="errors" style="display: ; color: ; width:800;">  
										授权发行日:${issueDate }，授权到期日:${validDate }
										<br>
										<form id="licenseForm" style="position: relative;" enctype="multipart/form-data" method="post">
										更新license.key文件,<input type="file" name="licenseFile" style="width: 300px;" class="validate[required]">
										<input id="uploadButton" type="button" value="上传" onclick="upload();">
										</form>
										<br>
										授权工作站:<br>
										<c:forEach items="${licenseedWorkStation}" var="wsId">
											${workStationMap[wsId].workStationName }<br>
										</c:forEach>
								    </div> 
								</td>
							</tr>	
						</c:otherwise>
					</c:choose>
				</table>
			</div>
		</div>
	</div>
</div>
<div>
</div>
</body>
</html>