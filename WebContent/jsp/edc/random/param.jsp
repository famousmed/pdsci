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
	function saveProj() {
		var url = "<s:url value='/edc/proj/saveInfo'/>";
		var data = $('#projForm').serialize();
		jboxPost(url, data, function() {
			window.parent.frames['mainIframe'].location.reload(true);
			jboxClose();
		});
	}
	function modProjParam(){
		var datas = {
				blindTypeId	:$("input:checked[name='blindTypeId']").val(),
				randomTypeId:$("#randomTypeId").val(),
				randomLock:$("input:checked[name='randomLock']").val()
		}
		jboxGet("<s:url value='/edc/random/modProjParam'/>",datas,null,null,true);
	}
	function addFactor(){
		jboxOpen("<s:url value='/edc/random/editFactor'/>","新增预后因素",500,400);
	}
	
	function delFactor(index,code){
		jboxConfirm("确定删除?",function(){
			var datas = {
					index	:index,
					code:code
			};
			jboxGet("<s:url value='/edc/random/delFactor'/>",datas,function(){
				window.parent.frames['mainIframe'].location.reload(true);
			},null,true);
		});
	}
	function saveFile(){
		if ($("#projOrgNum").val()==0) {
			jboxTip("请先维护项目机构信息！");
			return ;
		}
		
		if(false==$("#randomFileForm").validationEngine("validate")){
			return ;
		}
		$("#randomFileForm").submit();
	}
	function lockOrgRandom(orgFlow,checked){
		var checkedFlag = checked==true?'${GlobalConstant.LOCK_STATUS_Y}':'${GlobalConstant.LOCK_STATUS_N}';
		jboxGet("<s:url value='/edc/random/lockOrgRandom'/>?orgFlow="+orgFlow+"&checkedFlag="+checkedFlag,null,null,null,true);
	}
</script>
</head>
<body>
<div class="mainright">
<div class="content">
	<div class="title1 clearfix">
	<table width="800" cellpadding="0" cellspacing="0" class="basic">
		<thead>
                  <tr>
                      <th colspan="4" class="bs_name">参数信息</th>
                  </tr>
               </thead>
		
		<tr>
			<th width="20%">盲法类型：</th>
			<td width="80%" colspan="3">
				<c:choose>
					<c:when test="${ empty projParam.blindTypeId  }">
						<input type="radio" name="blindTypeId" id="blind" value="${edcBlindTypeEnumBlind.id }" onclick="modProjParam();" <c:if test="${projParam.blindTypeId == edcBlindTypeEnumBlind.id}">checked="checked"</c:if>/> <label for="blind">盲法  </label>&#12288;
						<input type="radio" name="blindTypeId" id="notBlind" value="${edcBlindTypeEnumNotBlind.id }" onclick="modProjParam();" <c:if test="${projParam.blindTypeId == edcBlindTypeEnumNotBlind.id}">checked="checked"</c:if>/> <label for="notBlind">非盲法 </label> 
					</c:when>
					<c:otherwise>
						${ projParam.blindTypeName}
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
		
		<tr>
			<th width="20%">随机类型：</th>
			<td width="30%" > 
				<c:choose>
					<c:when test="${ empty projParam.randomTypeId  }">
						<select style="width: 200px" id="randomTypeId" onchange="modProjParam();">
							<c:forEach items="${edcRandomTypeEnumList }" var="randomType">
							<option value="${randomType.id }" <c:if test="${projParam.randomTypeId == randomType.id}">selected</c:if>>${randomType.name }</option>					
							</c:forEach>
						</select>
					</c:when>
					<c:otherwise>
						${ projParam.randomTypeName}
					</c:otherwise>
				</c:choose>
			</td>
			<th width="20%">随机状态：</th>
			<td width="30%" ><input type="checkbox" id="randomLock" onclick="modProjParam();" <c:if test="${projParam.randomLock == GlobalConstant.FLAG_Y}">checked="checked"</c:if> name="randomLock" value="${GlobalConstant.FLAG_Y }"/><label for="randomLock">锁定</label>
			</td>
		</tr>
		</table>
		<table width="800" cellpadding="0" cellspacing="0" class="bs_tb">	
			<thead>
			  <tr>
                      <th colspan="5" class="bs_name">预后因素
                      <c:if test="${assignCount<=0 && projParam.randomLock != GlobalConstant.FLAG_Y}"> 
                      <img src="<s:url value="/css/skin/${skinPath}/images/add.png"/>" style="cursor: pointer;" onclick="addFactor();"></img>
                      </c:if>
                      </th>
               </tr>
               </thead>
              <tr><th width="100">分层</th><th width="200px">权重</th><th >代码</th><th width="200px">名称</th><th width="80px">操作</th></tr>
			<c:forEach items="${factors}" var="factor">
				<c:forEach items="${factor.itemMap }" var="item">
					<tr>
						<td >${ factor.index }</td>
						<td >${ factor.weight }</td>
						<td >${ item.key}</td>
						<td >${ item.value}</td>
						<td >
						<c:if test="${assignCount<=0 }"> 
						[<a href="javascript:delFactor('${factor.index }','${item.key }');">删除</a>]
						</c:if>
						</td>
					</tr>
					</c:forEach>
			</c:forEach>
			<c:if test="${factors == null || factors.size()==0 }"> 
				<tr> 
					<td align="center" style="text-align: center;" colspan="5">无记录</td>
				</tr>
			</c:if>	
	</table>
	<input type="hidden" id="projOrgNum" value="${pdfn:filterProjOrg(pubProjOrgList).size() }">
	<table width="800" cellpadding="0" cellspacing="0" class="bs_tb">	
			<thead>
			  <tr>
                      <th colspan="5" class="bs_name">机构信息</th>
               </tr>
               </thead>
               <tr><th width="100">中心号</th><th width="412px">中心名称</th><th >承担病例数</th><th width="100px">随机状态</th><th  width="80px">锁定</th></tr>
               <c:forEach items="${pdfn:filterProjOrg(pubProjOrgList) }" var="projOrg">
               	<tr>
               		<td>${projOrg.centerNo }</td>
               		<td>${applicationScope.sysOrgMap[projOrg.orgFlow].orgName}</td>
               		<td>${projOrg.patientCount }</td>
               		<td></td>
               		<td><input type="checkbox" onchange="lockOrgRandom('${projOrg.orgFlow }',this.checked)"
               		<c:if test="${edcProjOrgMap[projOrg.orgFlow].randomLock == GlobalConstant.LOCK_STATUS_Y }">checked</c:if>
               		/></td>
               	</tr>
               </c:forEach>
               <c:if test="${pdfn:filterProjOrg(pubProjOrgList) == null || pdfn:filterProjOrg(pubProjOrgList).size()==0 }"> 
					<tr> 
						<td align="center" style="text-align: center;" colspan="5">无记录</td>
					</tr>
				</c:if>
	</table>
				<form id="randomFileForm" action="<s:url value='/edc/random/randomFile'/>"  method="post" enctype="multipart/form-data"> 
			<table width="800" cellpadding="0" cellspacing="0" class="bs_tb">	
					<thead>
					  <tr>
		                      <th colspan="5" class="bs_name">盲底文件</th>
		               </tr>
		               </thead>
		               <tr><th width="20%">盲底文件</th>
		               <td colspan="3">
		               		
		               		<c:if test="${empty randomFile }">
		               		<input type="file" name="file" class="validate[required]"/><input type="button" onclick="saveFile();" value="上&#12288;传" class="search"/>
		               		</c:if>
		               		<c:if test="${!empty randomFile }">
		               		<a href="<s:url value='/pub/file/down'/>?fileFlow=${randomFile.fileFlow}">${randomFile.fileName}</a>
		               		</c:if>
		               </td>
		               </tr>
			</table>
		         </form>
	</div>
</div>
</div>
</body>
</html>