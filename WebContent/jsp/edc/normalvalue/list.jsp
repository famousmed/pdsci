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
</head>
<style>
.none {
	border-collapse: collapse;
	table-layout: fixed;
}

.none td {
	border: 0 none;
	border-collapse: collapse;
	padding-bottom: 3px;
	padding-top: 3px;
}
.edit{background:none;text-align: center;border:none;}
.edit3{background:none;text-align: center;border:none;}
.DivSelect
{
     position: relative;
     background-color: transparent;
     width:   120px;
     height: 17px;
     overflow: hidden; /*隐藏了小三角，因为宽度为110px,而select宽度为130px*/
     border-width:0px;
     border-top-style: none; 
     border-right-style: none; 
     border-left-style: none; 
     border-bottom-style: none;
}
/*设置Select样式*/
.SelectList
{
     position: relative;
     background-color: transparent;
     TOP:    -2px;
     left:-2px;
     border-width: 0px;
     border-top-style: none; 
     border-right-style: none; 
     border-left-style: none; 
     border-bottom-style: none;
     width:150px;
     display:block;
     height: 18px;
     overflow:hidden;
}
</style>
<script type="text/javascript">
function changeStyle(obj,stylename){
	$(obj).removeClass(stylename);
}
function showNormalValue(orgFlow){
	window.location.href="<s:url value='/edc/normalvalue/list/${actionScope}'/>?orgFlow="+orgFlow;
}
function doSubmit(){
	if(false==$("#dataForm").validationEngine("validate")){
		return ;
	}
}
function modNormalValue(recordFlow,obj){
	$(obj).addClass("edit3");
	if($(obj).val()==$(obj).attr("oldvalue")){
		return;
	}
	
	<c:if test="${ projParam.projLock ==  GlobalConstant.FLAG_Y}">
	jboxTip("当前项目已锁定!");
	if($(obj).attr("type")=="text"){
		$(obj).val($(obj).attr("oldvalue"));
	}
	return;
	</c:if>
	
	if($("#lockStatus").val() == "${GlobalConstant.LOCK_STATUS_Y}"){
		jboxTip("本机构已提交,无法修改!");
		if(${applicationScope.sysCfgMap['sys_jbox']=='art'}){
			setTimeout(function(){
				showNormalValue($("#orgFlow").val());
			},800);
		}else{
			showNormalValue($("#orgFlow").val());
		}
		return;
	}
	var data = {
			orgFlow:$("#orgFlow").val(),
			recordFlow : recordFlow,
			lowerValue:$("#lowerValue_"+recordFlow).val(),
			upperValue:$("#upperValue_"+recordFlow).val(),
			sexId:$("#sexId_"+recordFlow).val()
	};
	jboxPost("<s:url value='/edc/normalvalue/modNormalValue'/>",data,null,null,false);
	$(obj).attr("oldvalue",$(obj).val());
}
function copyRecord(recordFlow){
	jboxConfirm("确定要复制该条记录?",function(){
		jboxGet("<s:url value='/edc/normalvalue/copyRecord'/>?recordFlow="+recordFlow,null,function(){
			showNormalValue($("#orgFlow").val());
		},null,false);
	});
}
function delRecord(recordFlow){
	jboxConfirm("确定要删除该条记录?",function(){
		jboxGet("<s:url value='/edc/normalvalue/delRecord'/>?recordFlow="+recordFlow,null,function(){
			showNormalValue($("#orgFlow").val());
		},null,false);
	});
}

function doSubmit(fileFlow){
	$("input[name='file']").removeAttr("class");
	if(false==$("#dataForm").validationEngine("validate")){
		return ;
	}
	$("input[name='file']").addClass("validate[required]");
	if(fileFlow==""){
		jboxTip("请先上传正常值范围盖章文件!");
		return;
	}
	jboxConfirm("确定提交,提交后无法修改数据?",function(){
		jboxGet("<s:url value='/edc/normalvalue/doSubmit'/>?orgFlow="+$("#orgFlow").val(),null,function(){
			showNormalValue($("#orgFlow").val());
		},null,false);
		});
}
function saveFile(){
	if(false==$("#dataForm").validationEngine("validate")){
		return ;
	}
	$("#dataForm").submit();
}
function updateFile(){
	if(false==$("#dataForm").validationEngine("validate")){
		return ;
	}
	$("#operateType").val("update");
	$("#dataForm").submit();
}
function unLockNormalValue(){
	jboxConfirm("确定解锁?",function(){
		jboxGet("<s:url value='/edc/normalvalue/unLockNormalValue'/>?orgFlow="+$("#orgFlow").val(),null,function(){
			showNormalValue($("#orgFlow").val());
		},null,false);
		});
}
function impNormalValue(){
	jboxConfirm("确定导入?",function(){
		jboxGet("<s:url value='/edc/normalvalue/impNormalValue'/>?orgFlow="+$("#orgFlow").val(),null,function(){
			showNormalValue($("#orgFlow").val());
		},null,true);
		});
}
</script>
<body>
<div class="mainright">
		<div class="content">
	<form id="dataForm" action="<s:url value='/edc/normalvalue/normalValueFile/${actionScope}'/>"  method="post" enctype="multipart/form-data">
		<input type="hidden" id="operateType" name="operateType" value=""></input>
		<div style="margin-top: 5px">
		<c:if test="${ actionScope == GlobalConstant.DEPT_LIST_GLOBAL}">
				机构：<select style="width: 200px" id="orgFlow" name="orgFlow" onchange="showNormalValue(this.value);">
						<option></option>
						<c:forEach items="${pdfn:filterProjOrg(pubProjOrgList)}" var="projOrg">
						<option value="${projOrg.orgFlow }" <c:if test="${param.orgFlow eq projOrg.orgFlow }">selected</c:if>>${projOrg.centerNo }&#12288;${projOrg.orgName }</option>	
						</c:forEach>
				</select>
				<c:if test="${edcProjOrg.normalValueLock == GlobalConstant.LOCK_STATUS_Y }">
				<c:if test="${projParam.projLock !=  GlobalConstant.FLAG_Y }">
					<input type="button" value="解&#12288;锁" class="search" onclick="unLockNormalValue();"  />
				</c:if>
				</c:if>
		</c:if>
		<c:if test="${ actionScope == GlobalConstant.DEPT_LIST_LOCAL}">
			当前机构： ${sessionScope.currUser.orgName}&#12288;&#12288;&#12288;&#12288;
			<input type="hidden" name="orgFlow" id="orgFlow" value="${orgFlow }"/>
		</c:if>
				
				<c:if test="${!empty orgFlow  }">
					<c:if test="${edcProjOrg.normalValueLock != GlobalConstant.LOCK_STATUS_Y}">
						<c:if test="${projParam.projLock !=  GlobalConstant.FLAG_Y }">
						<input type="button" value="导&#12288;入" class="search" onclick="impNormalValue();"/>
						</c:if>
						<input type="button" value="提&#12288;交" class="search" onclick="doSubmit('${edcProjOrg.normalValueFileFlow}');"  />
					</c:if>
					<div  style="float: right;">
					正常值盖章文件：
					<input type="hidden" id="lockStatus" value='${edcProjOrg.normalValueLock }'/>
					<c:choose>
						<c:when test="${empty edcProjOrg.normalValueFileFlow }">
							<input type="file" name="file" style="width: 200px;" class="validate[required]"/><input type="button" onclick="saveFile();" class="search" value="上&#12288;传"/>&#12288;
						</c:when>
						<c:otherwise>
							<a title="${edcProjOrg.normalValueFileName} " href="<s:url value='/pub/file/down'/>?fileFlow=${edcProjOrg.normalValueFileFlow}">${pdfn:cutString(edcProjOrg.normalValueFileName,8,true,3 )}</a>&#12288;
							<c:if test="${edcProjOrg.normalValueLock != GlobalConstant.LOCK_STATUS_Y}">
								<c:if test="${projParam.projLock !=  GlobalConstant.FLAG_Y }">
								<input type="file" name="file"  style="width: 200px;" class="validate[required]"/><input type="button" onclick="updateFile();" class="search" value="重新上传"/>&#12288;
								</c:if>
							</c:if>
						</c:otherwise>
					</c:choose>
					</div>
				</c:if>
			<hr/>
		</div>
	</form>
	<div class="title1 clearfix">
			<table class="basic">
				<tr>
					<th width="200px" style="text-align: center;">元素名称</th>
					<th  width="200px" style="text-align: center;">单位</th>
					<th width="150px" style="text-align: center;">适用性别</th>
					<!-- 
					<th width="100px" style="text-align: center;">年龄下限</th>
					<th width="100px" style="text-align: center;">年龄上限</th>
					 -->
					<th width="200px" style="text-align: center;">值下限</th>
					<th  width="200px" style="text-align: center;">值上限</th>
					<th width="150px" style="text-align: center;">操作</th>
				</tr>
				<c:forEach items="${moduleList}" var="module">
					<tr>
						<th	colspan="7" style="text-align: left">&#12288;${module.moduleName}</th>
					</tr>
					<c:forEach items="${moduleValueMap[module.moduleCode] }" var="elementCode"> 
						<c:forEach items="${eleValueMap[elementCode] }" var="normalValue">
						<tr>
							<td  style="text-align: center;">${elementMap[elementCode].elementName}
							</td>
							<td style="text-align: center;">
							${normalValue.unit}
							</td>
							<td style="text-align: center;">
								   <div class="DivSelect">
										<select id="sexId_${normalValue.recordFlow }" class="SelectList"   onchange="modNormalValue('${normalValue.recordFlow}',this);">
											<option value="${userSexEnumMan.id }" <c:if test="${normalValue.sexId ==  userSexEnumMan.id}">selected</c:if> >${userSexEnumMan.name }</option>
											<option value="${userSexEnumWoman.id }" <c:if test="${normalValue.sexId ==  userSexEnumWoman.id}">selected</c:if>>${userSexEnumWoman.name }</option>
											<option value="${userSexEnumUnknown.id }" <c:if test="${normalValue.sexId ==  userSexEnumUnknown.id}">selected</c:if>>${userSexEnumUnknown.name }</option>
										</select>
									</div>
							</td>
							<td style="text-align: center;">
								<input type="text" id="lowerValue_${normalValue.recordFlow }" style="text-align: center;width: 90%"  onfocus="changeStyle(this,'edit3');"   oldvalue="${normalValue.lowerValue}"  class="edit3" value="${normalValue.lowerValue }" onblur="modNormalValue('${normalValue.recordFlow}',this);" />
							</td>
							<td style="text-align: center;">
								<input type="text" id="upperValue_${normalValue.recordFlow }" style="text-align: center;width: 90%" onfocus="changeStyle(this,'edit3');"  oldvalue="${normalValue.upperValue}"   class="edit3" value="${normalValue.upperValue }" onblur="modNormalValue('${normalValue.recordFlow}',this);" />
							</td>
							<td style="text-align: center;">
									<c:if test="${edcProjOrg.normalValueLock != GlobalConstant.LOCK_STATUS_Y && projParam.projLock !=  GlobalConstant.FLAG_Y }">
									[<a href="javascript:copyRecord('${normalValue.recordFlow }');">复制</a>] |
									[<a href="javascript:delRecord('${normalValue.recordFlow }');">删除</a>]
									</c:if>
							</td>
						</tr>
						</c:forEach>
					</c:forEach>
					</c:forEach>
					<c:if test="${empty moduleList }"> 
						<tr> 
							<td align="center" style="text-align: center;" colspan="6">无记录</td>
						</tr>
					</c:if>
			</table>
		</div>
	</div>
	</div>
</body>
</html>