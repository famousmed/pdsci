<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="ueditor" value="true"/>
</jsp:include>
<script type="text/javascript">
	function doClose(){
		jboxClose();
	}
	
	function rotaitonInfo(type){
		var url = {
				info:"<s:url value='/sch/template/editRotation'/>?roleFlag=${param.roleFlag}&viewFlag=${param.viewFlag}&rotationFlow=${param.rotationFlow}",
				detail:"<s:url value='/sch/template/ruleView'/>?rotationFlow=${param.rotationFlow}",
		};
		if("info"==type){
			location.href = url[type];
		}else{
			jboxLoad("container",url[type],true);
		}
	}
	
	$(function(){
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
		            ],
		     readonly:true
		});
	});
</script>
</head>
<body>
<div style="margin-bottom: 10px;">
	<a style="color: blue;cursor: pointer;" onclick="rotaitonInfo('info');">轮转说明</a>
	|
	<a style="color: blue;cursor: pointer;" onclick="rotaitonInfo('detail');">轮转详情</a>
</div>
<!-- <div style="height: 430px; position: relative; overflow:auto;border: 1px solid #AAAAAA"> -->
	<div class="mainright" align="center">
	<div class="content">
	<div class="title1 clearfix">
		<div id="container">
		<script type="text/plain" id="ueditor" style="height:150px;width: 95%;">${rotation.rotationNote}</script>
		</div>
	</div>
	</div>
	</div>
<!-- </div> -->
<div style="margin-top: 15px;">
	<p style="text-align: center;">
	 <input type="button" onclick="javascript:doClose();" class="search" value="关&#12288;闭"/>
	</p>
</div>
</body>
</html>