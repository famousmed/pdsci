<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="false"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
	<jsp:param name="jquery_ui_sortable" value="false"/>
	<jsp:param name="jquery_cxselect" value="false"/>
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="false"/>
	<jsp:param name="jquery_placeholder" value="false"/>
	<jsp:param name="jquery_iealert" value="true"/>
	<jsp:param name="jquery_fixedtable" value="false"/>
</jsp:include>
<style type="text/css">
	.basic tbody th{text-align: left;padding-left: 10px;}
	.basic td.title_td{text-align: right;padding:0;}
</style>
<script type="text/javascript">
	function save(){
		if(false==$("#projForm").validationEngine("validate")){
			return false;
		}
		if(${empty sysCfgMap['researcher_role_flow']}){
			jboxTip("请联系管理员维护主要研究者角色!");
			return;
		}
		if("${param.roleScope}" == "${GlobalConstant.ROLE_SCOPE_DECLARER}" && "${defalutOrgFlow}"==""){
			jboxTip("请联系管理员维护默认的机构!");
			return;
		}
		var url = "<s:url value='/gcp/proj/saveProj'/>";
		var requestData = $("#projForm").serialize();
		jboxPost(url,requestData,function(resp){
			if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
				var projFlow = $("#projFlow").val();
				if(projFlow==""){
					window.parent.frames['mainIframe'].window.location.reload();
				}else{
					window.parent.frames['mainIframe'].window.loadBaseInfo();
				}
				jboxClose();
			}
		},null,true);
	}
	
	function clearName(){
		$("input[name='applyUserName']").val("");
	}
	
	function chooseUser(){
		var applyDeptFlow = $("select[name='applyDeptFlow']").val();
		var w = window.parent.frames["mainIframe"].document.body.clientWidth;
		var h = window.parent.frames["mainIframe"].document.body.clientHeight;
		var url ="<s:url value='/gcp/proj/chooseUser?deptFlow='/>" + applyDeptFlow + "&projFlow=${param.projFlow}";
		var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='"+w+"px' height='"+h+"px' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
		jboxMessager(iframe,'选择主要研究者',w,h);
	}
	
	function declarerMain(){
		var url = "<s:url value='/gcp/proj/declarerMain'/>";
		var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='800px' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
		jboxMessager(iframe,'选择项目来源',800,600);	
	}
	function doAgree(){
		$("#projInfoDiv").show();
		$("#noticeDiv").hide();
	}
</script>
</head>
<body>
	<div class="mainright">
	<div class="content">
		<div class="title1 clearfix" id="projInfoDiv" style="display: ${param.roleScope==GlobalConstant.ROLE_SCOPE_DECLARER&& empty projInfoForm.proj.projFlow && applicationScope.sysCfgMap['gcp_sponsor_notice_flag'] ==  GlobalConstant.FLAG_Y  ?'none':''}">
			<div class="title1 clearfix">
				<form id="projForm"> 
				<input type="hidden" name="projInfo" value='${projInfoForm.proj.projInfo}'/>
				<input type="hidden" name="roleScope" value='${param.roleScope}'/>
				<table width="100%" cellpadding="0" cellspacing="0" class="basic">
					<tr>
						<th colspan="6">项目信息</th>
					</tr>
					<tr>
						<td width="16%" class="title_td">项目名称：</td>
						<td colspan="5">
							<input type="hidden" id="projFlow" name="projFlow" value="${projInfoForm.proj.projFlow}"/>
							<input type="hidden"  name="isDeclare" value="${param.isDeclare}"/>
							<input type="text" class="validate[required] xltext" name="projName" style="width: 460px;margin-right: 3px;" value="${projInfoForm.proj.projName}"/>
							<font class="red" >*</font>
						</td>
					</tr>
					<tr>
						<td class="title_td">项目简称：</td>
						<td width="24%">
							<input type="text" class="validate[required] xltext" name="projShortName" style="margin-right: 3px;" value="${projInfoForm.proj.projShortName}"/><font class="red">*</font>
						</td>
						<td width="16%" class="title_td">期类别：</td>
						<td width="24%">
							<select id="projSubTypeId" name="projSubTypeId" class="validate[required] xlselect" style="margin-right: 3px;">
								<option value="">请选择</option>
								<c:forEach items="${gcpProjSubTypeEnumList}" var="projSubType"> 
								<option value="${projSubType.id }" <c:if test="${projInfoForm.proj.projSubTypeId eq projSubType.id}">selected="selected"</c:if>>${projSubType.name}</option>
								</c:forEach>
							</select>
							<font class="red">*</font>
						</td>
						<td width="18%" class="title_td">项目编号：</td>
						<td width="19%"><input type="text"  class="xltext" name="projNo" value="${projInfoForm.proj.projNo}"/></td>
					</tr>
					<tr>
						<td class="title_td">项目类别：</td>
						<td>
							<select class="xlselect" name="projTypeId">
		          		  		<option value="">请选择</option>
		                       	<c:forEach var="dictEnuProjType" items="${dictTypeEnumGcpProjTypeList}" >
		                       		<option value="${dictEnuProjType.dictId}" <c:if test='${projInfoForm.proj.projTypeId eq dictEnuProjType.dictId}'>selected="selected"</c:if>>${dictEnuProjType.dictName}
		                       		</option>
		                       	</c:forEach>
	          		  		</select> 
						</td>
						<td class="title_td">注册分类：</td>
						<td>
							<input type="text" class="xltext" name="registCategory" value="${projInfoForm.registCategory}"/>
						</td>
						<td style="text-align: right;padding:0px;">CFDA批件号：</td>
						<td><input type="text" class="xltext" name="cfdaNo" value="${projInfoForm.proj.cfdaNo}"/></td>
					</tr>
					<tr>
						<td class="title_td">组长/参加：</td>
						<td>
		         		  	<input type="radio" name="isLeader" id="isLeader_yes" value="${projOrgTypeEnumLeader.id}" <c:if test="${projInfoForm.isLeader eq projOrgTypeEnumLeader.id}">checked="checked"</c:if>><label for="isLeader_yes">${projOrgTypeEnumLeader.name }</label>&nbsp;
	          		  		<input type="radio" name="isLeader" id="isLeader_no" value="${projOrgTypeEnumParti.id}"  <c:if test="${projInfoForm.isLeader eq projOrgTypeEnumParti.id}">checked="checked"</c:if>><label for="isLeader_no">${projOrgTypeEnumParti.name }</label>
						</td>
						<td class="title_td">国际多中心：</td>
						<td colspan="3">
	          		  		<input type="radio" name="interMulCenter" id="interMulCenter_yes" value="1" <c:if test="${projInfoForm.interMulCenter == 1}">checked="checked"</c:if>><label for="interMulCenter_yes">是</label>&nbsp;
	          		  		<input type="radio" name="interMulCenter" id="interMulCenter_no" value="2"  <c:if test="${projInfoForm.interMulCenter == 2}">checked="checked"</c:if>><label for="interMulCenter_no">否</label>
						</td>
					</tr>
					<c:if test="${param.roleScope!=GlobalConstant.ROLE_SCOPE_DECLARER }">
					<tr>
						<!-- 承担科室：研究者：默认当前登录者；项目管理：可选择-->
						<td width="13%" style="text-align: right;">承担科室：</td> 
						<td width="20%">
							<c:choose>
								<c:when test="${param.roleScope eq GlobalConstant.ROLE_SCOPE_GO}">
									<select id="applyDeptFlow" name="applyDeptFlow" class="xlselect" onchange="clearName()">
										<option value="">请选择</option>
										<c:forEach items="${sysDeptList}" var="dept">
										<option value="${dept.deptFlow}" <c:if test="${projInfoForm.proj.applyDeptFlow eq dept.deptFlow}">selected</c:if>>${dept.deptName}</option>
										</c:forEach>
									</select>
								</c:when>
								<c:otherwise>
									${sessionScope.currUser.deptName}
								</c:otherwise>
							</c:choose>
							<input type="hidden" id="applyDeptName" name="applyDeptName" value="${projInfoForm.proj.applyDeptName}"/>
						</td>
						
						<!-- 主要研究者：研究者：默认当前登录者；项目管理：可选择 -->
						<td width="13%" style="text-align: right;">主要研究者：</td>
						<td width="20%" colspan="3">
							<c:choose>
								<c:when test="${param.editFlag eq GlobalConstant.FLAG_Y}"> 
									<input type="hidden" id="applyUserFlow" name="applyUserFlow" value="${projInfoForm.proj.applyUserFlow}"/>
									<input type="text" class="validate[required] xltext" id="applyUserName" name="applyUserName" value="${projInfoForm.proj.applyUserName}" style="width: 100px;"/>
									<img title="选择主要研究者" src="<s:url value="/css/skin/${skinPath}/images/add_user.png" />" style="cursor: pointer;" onclick="chooseUser();" />
								</c:when> 
								<c:otherwise>${sessionScope.currUser.userName}</c:otherwise>
							</c:choose>
						</td>
					</tr>
					</c:if>
					<tr>
						<td width="20%" class="title_td">项目来源全称：</td>
						<td colspan="5">
							<input type="text" class="validate[required] xltext" id="projDeclarer" name="projDeclarer" style="width: 460px;margin-right: 3px;" 
								value="${(empty projInfoForm.proj.projDeclarer && param.roleScope eq GlobalConstant.ROLE_SCOPE_DECLARER)?sessionScope.currUser.orgName:projInfoForm.proj.projDeclarer}"/>
							<font class="red">*</font>
							<c:choose>
								<c:when test="${param.roleScope eq GlobalConstant.ROLE_SCOPE_GO || param.roleScope eq GlobalConstant.ROLE_SCOPE_RESEARCHER}">
									&#12288;<img title="选择项目来源" src="<s:url value="/css/skin/${skinPath}/images/search.gif" />" style="cursor: pointer;" onclick="declarerMain();" />
									<input type="hidden" id="projDeclarerFlow" name="projDeclarerFlow" value="${projInfoForm.proj.projDeclarerFlow}">
								</c:when>
								<c:otherwise>
									<input type="hidden" id="projDeclarerFlow" name="projDeclarerFlow" value="${empty projInfoForm.proj.projDeclarerFlow?sessionScope.currUser.orgFlow:projInfoForm.proj.projDeclarerFlow}">
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<td class="title_td">项目来源简称：</td>
						<td width="22%">
							<input type="text"  class="validate[required] xltext" style="margin-right: 3px;" id="projShortDeclarer" name="projShortDeclarer" 
								value="${(empty projInfoForm.proj.projShortDeclarer && param.roleScope eq GlobalConstant.ROLE_SCOPE_DECLARER)?sessionScope.currUser.orgName:projInfoForm.proj.projShortDeclarer}"/>
							<font color="red">*</font>
						</td>
						<td class="title_td">起止时间：</td>
						<td colspan="3" >
							<input type="text" class="xltext ctime" name="projStartTime" value="${projInfoForm.proj.projStartTime}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
							~ &#12288;<input type="text" class="xltext ctime" name="projEndTime" value="${projInfoForm.proj.projEndTime}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div style="width: 100%;margin-top: 10px;" align="center" >
			<input class="search" type="button" value="保&#12288;存" onclick="save()"  />
			<input class="search" type="button" value="关&#12288;闭" onclick="jboxClose();" />
		</div>
</div>
<c:if test="${applicationScope.sysCfgMap['gcp_sponsor_notice_flag'] ==  GlobalConstant.FLAG_Y}">
<div style="" class="mainright"  id="noticeDiv">
		<embed
			src="<s:url value='/jsp/gcp/declarer/notice.swf'/>"
			quality="best" width="100%" height="500" align="Middle"
			name="Print2FlashDoc" play="true" loop="false"
			allowscriptaccess="sameDomain" type="application/x-shockwave-flash"
			pluginspage="http://www.macromedia.com/go/getflashplayer">
		<div style="width: 100%;margin-top: 10px;" align="center" >
			<input class="search" type="button" value="同&#12288;意" onclick="doAgree();" />
	</div>
	</div>
	
</c:if>
</div></div>
</body>
</html>