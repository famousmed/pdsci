<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<c:if test="${!param.noHead}">
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
</c:if>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function saveForm(){
	if($("#resRecForm").validationEngine("validate")){
		jboxSubmit($("#resRecForm"),"<s:url value='/res/rec/saveRegistryForm'/>",function(resp){
			if(resp=="${GlobalConstant.SAVE_SUCCESSED}"){
				window.parent.frames['mainIframe'].$("#tags .selectTag a").click();
				jboxClose();
			}				
		},function(resp){
			jboxTip("${GlobalConstant.SAVE_FAIL}");
		},true);
	}
}

function audit(id,name){
	jboxConfirm("确认审核？审核后将无法修改！",function(){
		$("[name='adminAuditStatusId']").val(id);
		$("[name='adminAuditStatusName']").val(name);
		if($("#resRecForm").validationEngine("validate")){
			jboxSubmit($("#resRecForm"),"<s:url value='/res/teacher/tdUpdate'/>",function(resp){
				if(resp=="${GlobalConstant.OPRE_SUCCESSED}"){
					window.parent.frames['mainIframe'].$("#tags .selectTag a").click();
					jboxClose();
				}				
			},function(resp){
				jboxTip("${GlobalConstant.OPRE_FAIL}");
			},true);
		}
	});
}

$(function(){
	<c:if test="${rec.auditStatusId eq recStatusEnumTeacherAuditY.id || !(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR) || param.isRead}">
		$("#resRecForm").find(":text,textarea").each(function(){
			$(this).replaceWith($('<label>'+$(this).val()+'</label>'));
		});
		$("#resRecForm select").each(function(){
			var text = $(this).find(":selected").text();
			$(this).replaceWith($('<label>'+text+'</label>'));
		});
		$("#resRecForm").find(":checkbox,:radio").attr("disabled",true);
		$(":file").remove();
	</c:if>
	uediotInit();
});

function uediotInit(){
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
	                    'bold', 'italic', 'underline', 'fontborder', /* 'strikethrough', */ /*'superscript', 'subscript', 'removeformat', 'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', '|',*/
	                    /* 'rowspacingtop', 'rowspacingbottom', 'lineheight', '|',
	                    'customstyle', 'paragraph', */ 'fontfamily', 'fontsize', '|',
	                    /* 'directionalityltr', 'directionalityrtl', 'indent', '|',*/ 
	                    'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|', 'touppercase', 'tolowercase', '|',
	                    /* 'link', 'unlink', 'anchor', '|', 'imagenone', 'imageleft', 'imageright', 'imagecenter', '|', */
	                    'insertimage', /* 'emotion','scrawl', 'insertvideo', 'music', 'attachment'*/, /*'map', 'gmap', 'insertframe','insertcode', 'webapp', 'pagebreak',*/ /*'template', 'background'*/, '|',
	                    /* 'horizontal', 'date', 'time', 'spechars', 'snapscreen',  'wordimage', '|',*/
	                    /*'inserttable', 'deletetable', 'insertparagraphbeforetable', 'insertrow', 'deleterow', 'insertcol', 'deletecol', 'mergecells', 'mergeright', 'mergedown', 'splittocells', 'splittorows', 'splittocols', 'charts', '|'*/,
	                    /*'print'*/,  'preview', /*'searchreplace', 'help' */, /*'drafts'*/'wordimage']
	            ],
	     <c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">
	    	readonly:true,
	    </c:if>
	});
}
</script> 
</head>
<body>
<div class="mainright">
      <div class="content">
        <div class="title1 clearfix">
        <form id="resRecForm" method="post">
          <input type="hidden" name="formFileName" value="${formFileName}"/>
		  <input type="hidden" name="schDeptFlow" value="${param.schDeptFlow}"/>
	      <input type="hidden" name="recFlow" value="${rec.recFlow}"/>
	      <input type="hidden" name="processFlow" value="${currRegProcess.processFlow}"/>
	      <c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_ADMIN}">
	      	<input type="hidden" name="adminAuditStatusId" value="${rec.adminAuditStatusId}"/>
	      	<input type="hidden" name="adminAuditStatusName" value="${rec.adminAuditStatusName}"/>
	      </c:if>
   		<table class="basic" width="100%">
   			<tr>
                <th colspan="4" style="text-align: left;">&#12288;年度活动</th>
            </tr>
             <tr>
				<td style="width: 100px; text-align: right;"><span style="color: red;">*</span>活动类型：</td>
                <td>
                   <select class="validate[required]" name="activityType" style="width: 153px;">
                   		<option value="">请选择</option>
                   		<option value="校级市级活动报名" <c:if test="${formDataMap['activityType'] eq '校级市级活动报名'}">selected="selected"</c:if>>校级市级活动报名</option>
                   		<option value="科研项目" <c:if test="${formDataMap['activityType'] eq '科研项目'}">selected="selected"</c:if>>科研项目</option>
                   		<option value="发表文章" <c:if test="${formDataMap['activityType'] eq '发表文章'}">selected="selected"</c:if>>发表文章</option>
                   		<option value="各类获奖记录" <c:if test="${formDataMap['activityType'] eq '各类获奖记录'}">selected="selected"</c:if>>各类获奖记录</option>
                   </select>
				</td>
				<td style="width: 100px;text-align: right;"><span style="color: red;">*</span>时&#12288;&#12288;间：</td>
                <td >
                	<input class="validate[required]" style="width: 150px;" name="activityTime" type="text" value="${empty formDataMap['activityTime']?pdfn:getCurrDate():formDataMap['activityTime']}" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/>
				</td>
			</tr>
			<tr>
             	<td style="text-align: right;"><span style="color: red;">*</span>题&#12288;&#12288;目：</td>
                <td colspan="3">
                	<input class="validate[required]" name="activityTopic" type="text" value="${formDataMap['activityTopic']}" style="width: 97.5%;"/>
				</td>
			</tr>
			<tr>
				<td style="text-align: right;"><span style="color: red;">*</span>内&#12288;&#12288;容：</td>
				<td colspan="3" style="padding-top: 5px;padding-bottom: 5px;">
					<script id="ueditor" name="activityContent" type="text/plain" style="height:150px; width: 85%;">${formDataMap['activityContent']}</script>
				</td>
			</tr>
          </table>
			<p align="center">
				<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_ADMIN && empty rec.adminAuditStatusId}">
					<input class="search" type="button" value="审核通过"  onclick="audit('${recStatusEnumAdminAuditY.id}','${recStatusEnumAdminAuditY.name}');"/>
					<input class="search" type="button" value="审核不通过"  onclick="audit('${recStatusEnumAdminAuditN.id}','${recStatusEnumAdminAuditN.name}');"/>
				</c:if>
				<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_DOCTOR }">
					<input class="search" type="button" value="保&#12288;存"  onclick="saveForm();"/>
				</c:if>
				<input class="search" type="button" value="关&#12288;闭"  onclick="jboxClose();"/>
			</p>
			 </form>
         </div>
     </div> 	
   </div>
</body>
</html>