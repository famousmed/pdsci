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
	<jsp:param name="ueditor" value="true"/>
</jsp:include>
<script type="text/javascript">
<c:if test="${GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag}">
	$(document).ready(function(){
		var ue = UE.getEditor('rotationStandard_ueditor', {
		    autoHeight: false,
		    imagePath: '${sysCfgMap['upload_base_url']}/',
		    imageManagerPath: '${sysCfgMap['upload_base_url']}/',
		    filePath: '${sysCfgMap['upload_base_url']}/',
		    videoPath: '${sysCfgMap['upload_base_url']}/',
		    wordImagePath: '${sysCfgMap['upload_base_url']}/',
		    snapscreenPath: '${sysCfgMap['upload_base_url']}/',
		    catcherPath: '${sysCfgMap['upload_base_url']}/',
		    scrawlPath: '${sysCfgMap['upload_base_url']}/',
		    toolbars:[
		                [/* 'fullscreen' */, /*'source',*/ /* '|' */, 'undo', 'redo', '|','lineheight',
		                    'bold', 'italic', 'underline', 'fontborder', /* 'strikethrough', */ /*'superscript', 'subscript', 'removeformat', 'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', '|',*/
		                    /* 'rowspacingtop', 'rowspacingbottom', 'lineheight', '|',
		                    'customstyle', 'paragraph', */ 'fontfamily', 'fontsize', '|',
		                    /* 'directionalityltr', 'directionalityrtl', 'indent', '|',*/ 
		                    'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|', 'touppercase', 'tolowercase', '|',
		                    /* 'link', 'unlink', 'anchor', '|', 'imagenone', 'imageleft', 'imageright', 'imagecenter', '|', */
		                    'insertimage', /* 'emotion','scrawl', 'insertvideo', 'music', 'attachment'*/, /*'map', 'gmap', 'insertframe','insertcode', 'webapp', 'pagebreak',*/ /*'template', 'background'*/, '|',
		                    /* 'horizontal', 'date', 'time', 'spechars', 'snapscreen',  'wordimage', '|',*/
		                    /*'inserttable', 'deletetable', 'insertparagraphbeforetable', 'insertrow', 'deleterow', 'insertcol', 'deletecol', 'mergecells', 'mergeright', 'mergedown', 'splittocells', 'splittorows', 'splittocols', 'charts', '|'*/,
		                    /*'print'*/,  'preview', /*'searchreplace', 'help' */, /*'drafts'*//* 'wordimage' */]
		            ]
		    ,initialStyle:'body{font-family: SimSun; font-size:14px}'
		});//实例化编辑器
	});
	
	function saveRotationStandard(){
		jboxSubmit($("#rotationStandard"),"<s:url value='/sch/template/saveStandard'/>",function(resp){
			if(resp=="${GlobalConstant.SAVE_SUCCESSED}"){
				jboxClose();
			}
		},function(){},true);
	}
</c:if>
</script>
</head>
<body>
<div class="mainright" align="center">
	<div class="content">
	<div class="title1 clearfix" align="left">
		<div>轮转科室：${rotationDept.standardDeptName}</div>
	</div>
		<div align="left">
			<form id="rotationStandard" method="post">
				<input type="hidden" name="recordFlow" value="${rotationDept.recordFlow}"/>
				<c:if test="${GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag}">
				<script id="rotationStandard_ueditor" name="schStandard" type="text/plain" style="width:99%;height:300px;position:relative;">${rotationDept.schStandard}</script>
				</c:if>
				<c:if test="${!(GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag)}">
				<div>${rotationDept.schStandard}</div>
				</c:if>
				<c:if test="${GlobalConstant.USER_LIST_GLOBAL eq param.roleFlag}">
				<div align="center" style="margin-top: 10px;">
					<input type="button" value="保&#12288;存" class="search" onclick="saveRotationStandard();"/>
					<input type="button" value="关&#12288;闭" class="search" onclick="jboxClose();"/>
				</div>
				</c:if>
			</form>
		</div>
	</div>
</div>
</body>
</html>