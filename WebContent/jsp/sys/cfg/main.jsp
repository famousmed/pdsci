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
	<jsp:param name="ueditor" value="true"/>
</jsp:include>
</head>
<body>
<script type="text/javascript">
function save() {
	if(false==$("#saveCfgForm").validationEngine("validate")){
		return ;
	}
	var url = "<s:url value='/sys/cfg/save'/>";
	var data = $('#saveCfgForm').serialize();
	jboxPost(url, data, function() {
		window.location.href="<s:url value='/sys/cfg/main'/>?tagId=${param.tagId}";
	});
}

$(document).ready(function(){
	if ("${param.tagId}" != "") {
		$("#${param.tagId}").click();
	} else {
		$("li a:first").click();
	}
});

function selectTag(selfObj,url) {
	var selLi = $(selfObj).parent();
	selLi.siblings("li").removeClass("selectTag");
	selLi.addClass("selectTag");
	jboxLoad("tagContent",url,true);
}

function initUE(id){
	var uecfg = {
		    autoHeight: false,
		    imagePath: '${sysCfgMap['upload_base_url']}/',
		    imageManagerPath: '${sysCfgMap['upload_base_url']}/',
		    filePath: '${sysCfgMap['upload_base_url']}/',
		    videoPath: '${sysCfgMap['upload_base_url']}/',
		    wordImagePath: '${sysCfgMap['upload_base_url']}/',
		    snapscreenPath: '${sysCfgMap['upload_base_url']}/',
		    catcherPath: '${sysCfgMap['upload_base_url']}/',
		    scrawlPath: '${sysCfgMap['upload_base_url']}/'
		};
	 UE.getEditor(id, uecfg);//实例化编辑器
}
</script>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<ul id="tags">
				<li>
					<a id="systemCfg" onclick="selectTag(this,'<s:url value='/sys/cfg/edit'/>?tagId=systemCfg')" href="javascript:void(0)">系统设置</a>
				</li>
				<li>
					<a id="emailWeixin" onclick="selectTag(this,'<s:url value='/sys/cfg/edit'/>?tagId=emailWeixin')" href="javascript:void(0)">邮件/微信</a>
				</li>
				<li>
					<a id="editorCfg" onclick="selectTag(this,'<s:url value='/sys/cfg/edit'/>?tagId=editorCfg')" href="javascript:void(0)">编辑器</a>
				</li>
				<li>
					<a id="loginCfg" onclick="selectTag(this,'<s:url value='/sys/cfg/edit'/>?tagId=loginCfg')" href="javascript:void(0)">人员/机构</a>
				</li>
				<li>
					<a id="forgerPsswd" onclick="selectTag(this,'<s:url value='/sys/cfg/edit'/>?tagId=forgerPsswd')" href="javascript:void(0)">忘记密码</a>
				</li>
				<li>
					<a id="securityCenter" onclick="selectTag(this,'<s:url value='/sys/cfg/edit'/>?tagId=securityCenter')" href="javascript:void(0)">安全中心</a>
				</li>
				<c:if test="${sessionScope.currWsId==GlobalConstant.EDC_WS_ID }"> 
					<li>
						<a id="randomCfg" onclick="selectTag(this,'<s:url value='/sys/cfg/edit'/>?tagId=randomCfg')" href="javascript:void(0)">随机设置</a>
					</li>
					<li>
						<a id="appCfg" onclick="selectTag(this,'<s:url value='/sys/cfg/edit'/>?tagId=appCfg')" href="javascript:void(0)">app设置</a>
					</li>
				</c:if>
				<c:if test="${sessionScope.currWsId==GlobalConstant.GCP_WS_ID }"> 
					<li>
						<a id="roleCfg" onclick="selectTag(this,'<s:url value='/sys/cfg/edit'/>?tagId=roleCfg')" href="javascript:void(0)">角色设置</a>
					</li>
					<li>
						<a id="qcCfg" onclick="selectTag(this,'<s:url value='/sys/cfg/edit'/>?tagId=qcCfg')" href="javascript:void(0)">质控设置</a>
					</li>
				</c:if>
				<c:if test="${sessionScope.currWsId==GlobalConstant.IRB_WS_ID }"> 
					<li>
						<a id="irbRoleCfg" onclick="selectTag(this,'<s:url value='/sys/cfg/edit'/>?tagId=irbRoleCfg')" href="javascript:void(0)">角色设置</a>
					</li>
					<li>
						<a id="irbFormCfg" onclick="selectTag(this,'<s:url value='/sys/cfg/edit'/>?tagId=irbFormCfg')" href="javascript:void(0)">表单设置</a>
					</li>
				</c:if>
				<c:if test="${sessionScope.currWsId==GlobalConstant.SRM_WS_ID }"> 
					<c:if test="${sessionScope.currUser.userCode==GlobalConstant.ROOT_USER_CODE }">
					<li>
						<a id="srmVersionCfg" onclick="selectTag(this,'<s:url value='/sys/cfg/edit'/>?tagId=srmVersionCfg')" href="javascript:void(0)">版本设置</a>
					</li>
					</c:if>
					<li>
						<a id="srmRoleCfg" onclick="selectTag(this,'<s:url value='/sys/cfg/edit'/>?tagId=srmRoleCfg')" href="javascript:void(0)">角色设置</a>
					</li>
					<li>
						<a id="srmFormCfg" onclick="selectTag(this,'<s:url value='/sys/cfg/edit'/>?tagId=srmFormCfg')" href="javascript:void(0)">表单设置</a>
					</li>
					<li>
						<a id="srmProcessCfg" onclick="selectTag(this,'<s:url value='/sys/cfg/edit'/>?tagId=srmProcessCfg')" href="javascript:void(0)">流程设置</a>
					</li>
				</c:if>
				<c:if test="${sessionScope.currWsId==GlobalConstant.RES_WS_ID }"> 
					<li>
						<a id="resRoleCfg" onclick="selectTag(this,'<s:url value='/sys/cfg/edit'/>?tagId=resRoleCfg')" href="javascript:void(0)">角色设置</a>
					</li>
					<li>
						<a id="resFormCfg" onclick="selectTag(this,'<s:url value='/sys/cfg/edit'/>?tagId=resFormCfg')" href="javascript:void(0)">表单设置</a>
					</li>
					<c:if test="${sessionScope.currUser.userCode==GlobalConstant.ROOT_USER_CODE }">
					<li>
						<a id="hbResCfg" onclick="selectTag(this,'<s:url value='/sys/cfg/edit'/>?tagId=hbResCfg')" href="javascript:void(0)">湖北报名招录</a>
					</li>
					</c:if>
					<c:if test="${sessionScope.currUser.userCode==GlobalConstant.ROOT_USER_CODE }">
					<li>
						<a id="sczyResCfg" onclick="selectTag(this,'<s:url value='/sys/cfg/edit'/>?tagId=sczyResCfg')" href="javascript:void(0)">四川中医报名招录</a>
					</li>
					</c:if>
					<c:if test="${sessionScope.currUser.userCode==GlobalConstant.ROOT_USER_CODE }">
					<li>
						<a id="jsResCfg" onclick="selectTag(this,'<s:url value='/sys/cfg/edit'/>?tagId=jsResCfg')" href="javascript:void(0)">江苏招录</a>
					</li>
					</c:if>
				</c:if>
				<c:if test="${sessionScope.currWsId==GlobalConstant.EDU_WS_ID }"> 
					<li>
						<a id="eduRoleCfg" onclick="selectTag(this,'<s:url value='/sys/cfg/edit'/>?tagId=eduRoleCfg')" href="javascript:void(0)">角色设置</a>
					</li>
				</c:if>
				<c:if test="${sessionScope.currWsId==GlobalConstant.NJMUEDU_WS_ID }"> 
					<li>
						<a id="njmueduRoleCfg" onclick="selectTag(this,'<s:url value='/sys/cfg/edit'/>?tagId=njmueduRoleCfg')" href="javascript:void(0)">角色设置</a>
					</li>
				</c:if>
				<li>
					<a id="systemFuncs" onclick="selectTag(this,'<s:url value='/sys/cfg/edit'/>?tagId=systemFuncs')" href="javascript:void(0)">功能设置</a>
				</li>
			</ul>
			<div id="tagContent">
			</div>
		</div>
	</div> 
</div>
</body>
</html>