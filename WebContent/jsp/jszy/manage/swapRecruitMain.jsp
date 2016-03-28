<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>湖北省住院医师规范化培训招录系统</title>
<jsp:include page="/jsp/jszy/htmlhead-jszy.jsp">
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

function getCatSpe(){
	var orgFlow = $("#orgFlow").val();
	if(orgFlow){
		var url = "<s:url value='/jszy/doctor/findcatspe'/>?orgFlow="+orgFlow;
		jboxGet(url , null , function(resp){
			$("#catSpeId").empty();
			$("#catSpeId").append("<option value=''>请选择</option>");
			$.each(resp , function(i , n){
				$("#catSpeId").append("<option value='"+n.speId+"'>"+n.speName+"</option>");
			});
		} , null , false);
	}
	$("#speId").empty();
	$("#speId").append("<option value=''>请选择</option>");
}

function getSpe(){
	var catSpeId = $("#catSpeId").val();
	if(catSpeId){
		var url = "<s:url value='/jszy/doctor/findspe'/>?catSpeId="+catSpeId;
		jboxGet(url , null , function(resp){
			$("#speId").empty();
			$("#speId").append("<option value=''>请选择</option>");
			$.each(resp , function(i , n){
				$("#speId").append("<option value='"+n.dictId+"'>"+n.dictName+"</option>");
			});
		} , null , false);
	}
	
}

function swapRecruit(){
	if(!$("#swapForm").validationEngine("validate")){
		return false;
	}
	jboxConfirm("确认调剂？" , function(){
		$("#catSpeName").val($("#catSpeId :selected").text());
		$("#speName").val($("#speId :selected").text());
		var data = $("#swapForm").serialize();
		jboxPost("<s:url value='/jszy/manage/swapRecruit'/>" , data , function(resp){
			if(resp == "1"){
				jboxTip("操作成功");
				window.parent.swap();
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
	<span style='margin-left: 20px;'>填报基地：${recruit.orgName}&nbsp;&nbsp;&nbsp;&nbsp;填报专业：<c:if test="${recruit.catSpeId==speCatEnumZy.id }">${recruit.speName}(${recruit.catSpeName})</c:if><c:if test="${recruit.catSpeId==speCatEnumZyqk.id }">${recruit.speName}</c:if></span>
	</div>
	<div class="search_table">
	<form id="swapForm">
	    <input type="hidden" name="doctorFlow" value="${param.doctorFlow}"/>
	    <table class="base_info">
            <tr>
                <th><font color="red">*</font>培训基地：</th>
                <td>   
                    <select class="select validate[required]" id="orgFlow" name="orgFlow" onchange="getCatSpe();">
		                <option value="">请选择</option>
		                <c:forEach items="${hospitals}" var="hosptial">
		                    <option value='${hosptial.orgFlow}'>${hosptial.orgName}</option>
		                </c:forEach>      
          		    </select>
                </td>
            </tr>
            <tr>
                <th><font color="red">*</font>培训专业：</th>
                <td>   
                    <select class="select validate[required]" id="catSpeId" name="catSpeId" onchange="getSpe();">
		                <option value="">请选择</option>
		                <c:forEach items="${catspes}" var="catspe">
		                    <option value="${catspe.speId}">${catspe.speName}</option>
		                </c:forEach>
		            </select>
         		    <input type="hidden" id='catSpeName' name="catSpeName" value=''/>
                </td>
            </tr>
            <tr>
                <th><font color="red">*</font>第二阶段意向专业：</th>
                <td>   
                    <select class="select validate[required]" id="speId" name="speId">
			            <option value="">请选择</option>
			            <c:forEach items="${spes}" var="spe">
			               <option value="${spe.dictId}">${spe.dictName}</option>
			            </c:forEach>
			        </select>
			        <input type="hidden" id="speName" name="speName" value=''/>
                </td>
            </tr>
        </table>
		<table border="0" width="945" cellspacing="0" cellpadding="0">
				<tr>
					<td colspan="4" style="padding-top:10px;padding-left:0;">
					<script id="admitNotice" name="admitNotice" style="width:100%;height:200px;position:relative;">
					</script>
					</td>
				</tr>
			</table>
		</form>
		</div>
		<div align="center" style="margin-top: 20px; margin-bottom:20px;">
		    <a class="btn_green" id="operBtn" href="javascript:swapRecruit();">确定</a>
			<a class="btn_grey" id="closeBtn" href="javascript:jboxClose();">关闭</a>
		</div>
	</div>
</body>
</html>