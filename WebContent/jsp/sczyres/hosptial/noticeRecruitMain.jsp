<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>湖北省住院医师规范化培训招录系统</title>
<jsp:include page="/jsp/sczyres/htmlhead-sczyres.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="font" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="ueditor" value="true"/>
</jsp:include>
<script type="text/javascript">

$(document).ready(function(){
	var uecfg = {
		    autoHeight: false,
		    imagePath: '${sysCfgMap['upload_base_url']}/',
		    imageManagerPath: '${sysCfgMap['upload_base_url']}/',
		    filePath: '${sysCfgMap['upload_base_url']}/',
		    videoPath: '${sysCfgMap['upload_base_url']}/',
		    wordImagePath: '${sysCfgMap['upload_base_url']}/',
		    snapscreenPath: '${sysCfgMap['upload_base_url']}/',
		    catcherPath: '${sysCfgMap['upload_base_url']}/',
		    scrawlPath: '${sysCfgMap['upload_base_url']}/',
		    maximumWords:500,
		    elementPathEnabled:false,
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
		};
	var ue1 = UE.getEditor('admitNotice', uecfg);//实例化编辑器
});

function recruit(){
	jboxConfirm("确认录取？" , function(){
		var data = $("#noticeForm").serialize();
		jboxPost("<s:url value='/sczyres/hosptial/recruit'/>" , data , function(resp){
			if(resp == "1"){
				jboxTip("操作成功");
				window.parent.searchDoctor();
				jboxClose();
			}else{
				jboxTip("操作失败");
			}
		} , null , false);
	});
}
</script>
</head>
<body style="width:100%; min-width: inherit; height:100%;background-image:none; background:#fff;">
	<div class="infoAudit">
	<div class="div_table">
	<span>学员姓名：${user.userName}</span>
	<span style='margin-left: 20px;'>录取专业：<c:if test="${recruit.catSpeId==speCatEnumZy.id }">${recruit.speName}(${recruit.catSpeName})</c:if><c:if test="${recruit.catSpeId==speCatEnumZyqk.id }">${recruit.speName}</c:if></span>
	</div>
	<div class="search_table">
	<form id="noticeForm">
	   <input type="hidden" name="recruitFlow" value='${param.recruitFlow}'/>
		<table border="0" width="945" cellspacing="0" cellpadding="0">
				<!-- 
				<caption>${title}</caption>
				 -->
				<tr>
					<td colspan="4" style="padding-top:10px;padding-left:0;">
					<script id="admitNotice" name="admitNotice" style="width:100%;height:200px;position:relative;">
					${recruit.admitNotice}
					</script>
					</td>
				</tr>
			</table>
		</form>
		</div>
		<div align="center" style="margin-top: 20px; margin-bottom:20px;">
		    <a class="btn_green" id="operBtn" href="javascript:recruit();">确定</a>
			<a class="btn_grey" id="closeBtn" href="javascript:jboxClose();">关闭</a>
		</div>
	</div>
</body>
</html>