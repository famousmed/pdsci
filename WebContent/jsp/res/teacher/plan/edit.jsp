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
	<jsp:param name="ueditor" value="true"/>
</jsp:include>
<style type="text/css">
	#ueditor{
		width:98%;
		margin: 10px 10px 10px 0px;
	}
	[type='text']{width:150px;height: 22px;}
	select{width: 153px;height: 27px;}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		var ue = UE.getEditor('ueditor', {
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
		                [/* 'fullscreen' */, /*'source',*/ '|', 'undo', 'redo', '|','lineheight',
		                    'bold', 'italic', 'underline', 'fontborder', /* 'strikethrough', 'superscript', 'subscript', 'removeformat', 'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|', */ 'forecolor',/* 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', '|', 'rowspacingtop', 'rowspacingbottom', 'lineheight', '|',
		                    'customstyle', 'paragraph', */ 'fontfamily', 'fontsize', '|',
		                    /* 'directionalityltr', 'directionalityrtl', 'indent', '|',*/ 
		                    'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|', 'touppercase', 'tolowercase', '|',
		                    /* 'link', 'unlink', 'anchor', '|', 'imagenone', 'imageleft', 'imageright', 'imagecenter', '|', */
		                    'insertimage', /* 'emotion','scrawl', 'insertvideo', 'music', 'attachment'*/, /*'map', 'gmap', 'insertframe','insertcode', 'webapp', 'pagebreak',*/ /*'template', 'background'*/, '|',
		                    /* 'horizontal', 'date', 'time', 'spechars', 'snapscreen',  'wordimage', '|',*/
		                    /*'inserttable', 'deletetable', 'insertparagraphbeforetable', 'insertrow', 'deleterow', 'insertcol', 'deletecol', 'mergecells', 'mergeright', 'mergedown', 'splittocells', 'splittorows', 'splittocols', 'charts', '|'*/,
		                    /*'print'*/,  'preview', /*'searchreplace', 'help','drafts','wordimage'*/]
		            ]
		});
	});

		
	function saveTeachPlan() {
		if(!$("#teachPlan").validationEngine("validate")){
			return ;
		}
		var url = "<s:url value='/res/teacher/saveTeachPlan'/>";
		var getdata = $('#teachPlan').serialize();
		jboxPost(url, getdata, function(data) {
			if('${GlobalConstant.OPRE_SUCCESSED_FLAG}'==data){
				top.jboxTip("${GlobalConstant.OPRE_SUCCESSED}");
				var frameWindow = window.parent.frames['mainIframe'];
				frameWindow.$(".selectTag").click(); 
				jboxClose();		
			}
		},null,false);
	}
	
	function doClose(){
		jboxClose();
	}
</script>
</head>
<body>
<div style="height: 450px; position: relative; overflow:auto;">
	<div class="mainright" align="center">
	<div class="content">
	<div class="title1 clearfix" >
		<form id="teachPlan" style="position: relative;">
		<input type="hidden" name="recordFlow" value="${dataMap.recordFlow}"/>
		<input type="hidden" name="recFlow" value="${rec.recFlow}"/>
		
		<table class="basic" style="width: 100%;">
			<colgroup>
				<col width="100px;"/>
				<col />
			</colgroup>
			<tbody>
				<tr>
					<th>科室(病区)：</th>
					<td>
						${schDept.schDeptName}
						<input type="hidden" name="schDeptFlow" value="${schDept.schDeptFlow}"/>
						<input type="hidden" name="schDeptName" value="${schDept.schDeptName}"/>
					</td>
					<th>教师：</th>
					<td>
						${user.userName}
						<input type="hidden" name="teacherFlow" value="${user.userFlow}"/>
						<input type="hidden" name="teacherName" value="${user.userName}"/>
					</td>
				</tr>
				<tr>
					<th>教学形式：</th>
					<td colspan="3">
						<select name="teachTypeName">
							<option>
							<c:forEach items="${dictTypeEnumTeachTypeList}" var="dict">
								<option value="${dict.dictName}" <c:if test="${dataMap.teachTypeName eq dict.dictName}">selected</c:if>>${dict.dictName}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th style="text-align: left;padding-left:10px;" colspan="4">教学内容</th>
				</tr>
				<tr>
					<td colspan="4">
						<script type="text/plain" id="ueditor" name="teachContent" style="height:180px;">${dataMap.teachContent}</script>
					</td>
				</tr>
			</tbody>
		</table>
		</form>
	</div>
	</div>
	</div>
</div>
<div style="margin-top: 15px;">
	<p style="text-align: center;">
      	<input type="button" onclick="saveTeachPlan();" class="search" value="保&#12288;存"/>
      	<input type="button" onclick="doClose();" class="search" value="关&#12288;闭"/>
    </p>
</div>
</body>
</html>