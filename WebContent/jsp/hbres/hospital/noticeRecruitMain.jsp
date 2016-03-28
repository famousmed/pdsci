<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>湖北省住院医师规范化培训招录系统</title>
<jsp:include page="/jsp/hbres/htmlhead-hbres.jsp">
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

function noticeRecruit(){
	var admitNotice = UE.getEditor('admitNotice').getContent();
	if(admitNotice==""){
		jboxTip("录取通知内容不能为空！");
		return;
	}
	
	if ("single" == "${param.operType}"){
		noticeRecruitSingle();
	}else if("batch" == "${param.operType}"){
		noticeRecruitBatch();
	}
}

function swapRecruit(){
	var speId = $("#speId").val();
	if(!speId){
		jboxTip("请选择调剂专业");
		return ;
	}
	var admitNotice = UE.getEditor('admitNotice').getContent();
	if(admitNotice==""){
		jboxTip("调剂通知内容不能为空！");
		return;
	}
	
	jboxConfirm("确认调剂通知吗？" , function(){
		var recruitFlow = "${param.recruitFlow}";
		$("#operBtn").hide();
		$("#closeBtn").hide();
		var data = {'recruitFlow':recruitFlow ,'speFlow':speId , 'swapNotice':UE.getEditor('admitNotice').getContent()};
		jboxPost("<s:url value='/hbres/singup/hospital/swaprecruit'/>", data,function(resp){
			if(resp == "${GlobalConstant.OPRE_SUCCESSED_FLAG}"){
				jboxTip("${GlobalConstant.OPERATE_SUCCESSED}");
				window.parent.searchDoctor();
				jboxClose();
			}
		} , null , false);
		
	});
}

function noticeRecruitSingle(){
	jboxConfirm("确认录取通知吗？" , function(){
		var recruitFlows = "${param.recruitFlow}";
		$("#operBtn").hide();
		$("#closeBtn").hide();
		var data = {'recruitFlows':recruitFlows,'admitNotice':UE.getEditor('admitNotice').getContent()};
		jboxPost("<s:url value='/hbres/singup/hospital/noticeRecruit'/>", data,function(resp){
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

function noticeRecruitBatch(){
	 var recruitFlows = "";
	 window.parent.$("input[name='recruitFlow_check']:checked").each(function(i,n){
		if(i==0){
			recruitFlows = $(this).val();
		}else{
			recruitFlows = recruitFlows +","+$(this).val();
		}
	});
	 jboxConfirm("确认发送批量录取通知？" , function(){
		 var data = {'recruitFlows':recruitFlows,'admitNotice':UE.getEditor('admitNotice').getContent()};
		 jboxPost("<s:url value='/hbres/singup/hospital/noticeRecruit'/>", data,function(resp){
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
	<div class="infoAudit" >
	<form id="noticeForm">
	    <c:if test="${spes!=null and spes.size()>0}">
	        <label>调剂专业：</label>
	        <select id="speId" style="border:1px solid #d6d7d9; height:34px; line-height:30px; outline:none;font-family: microsoft yahei;">
	            <option value=''>请选择</option>
	            <c:forEach items="${spes}" var="spe">
	                <option value='${spe.recordFlow}'>${spe.speName}</option>
	            </c:forEach>
	        </select>
	    </c:if>
		<table border="0" width="945" cellspacing="0" cellpadding="0">
				<caption>${title}</caption>
				<tr>
					<td colspan="4" style="padding-top:10px;padding-left:0;">
					<script id="admitNotice" name="admitNotice" style="width:100%;height:200px;position:relative;"></script>
					</td>
				</tr>
			</table>
		</form>
		<div align="center" style="margin-top: 20px; margin-bottom:20px;">
		    <c:if test="${noticeType eq 'swap'}">
		        <a class="btn_green" id="operBtn" href="javascript:swapRecruit();">确定</a>
		    </c:if>
		    <c:if test="${empty noticeType}">
		        <a class="btn_green" id="operBtn" href="javascript:noticeRecruit();">确定</a>
		    </c:if>
			<a class="btn_grey" id="closeBtn" href="javascript:jboxClose();">关闭</a>
		</div>
	</div>
</body>
</html>