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
	<jsp:param name="jquery_cxselect" value="true"/>
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
	[type='text']{width:150px;height: 22px;}
	select{width: 153px;height: 27px;}
	.i-trend-main-div-table th{background: #F0FAFF;color: #1079B6;}
	.ith{background-color: #f8f8f8;}
</style>
<script type="text/javascript">
$(document).ready(function(){
	$("[onclick]").click(function(e){
		e.stopPropagation();
	});
	
	loadEditor();
});

function loadEditor(){
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
	    elementPathEnabled : false,
	    autoFloatEnabled:false,
	    toolbars:[
	                [/* 'fullscreen' */, /*'source',*/ '|', 'undo', 'redo', '|','lineheight',
	                    'bold', 'italic', 'underline', 'fontborder', /* 'strikethrough', 'superscript', 'subscript', 'removeformat', 'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|', */ 'forecolor',/* 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', '|', 'rowspacingtop', 'rowspacingbottom', 'lineheight', '|',
	                    'customstyle', 'paragraph', */ 'fontfamily', 'fontsize', '|',
	                    /* 'directionalityltr', 'directionalityrtl', 'indent', '|',*/ 
	                    'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|', 'touppercase', 'tolowercase', '|',
	                    /* 'link', 'unlink', 'anchor', '|', 'imagenone', 'imageleft', 'imageright', 'imagecenter', '|', */
	                    'insertimage', /* 'emotion','scrawl', 'insertvideo', 'music',*/ 'attachment', /*'map', 'gmap', 'insertframe','insertcode', 'webapp', 'pagebreak',*/ /*'template', 'background'*/, '|',
	                    /* 'horizontal', 'date', 'time', 'spechars', 'snapscreen',  'wordimage', '|',*/
	                    /*'inserttable', 'deletetable', 'insertparagraphbeforetable', 'insertrow', 'deleterow', 'insertcol', 'deletecol', 'mergecells', 'mergeright', 'mergedown', 'splittocells', 'splittorows', 'splittocols', 'charts', '|'*/,
	                    /*'print'*/,  'preview', /*'searchreplace', 'help','drafts','wordimage'*/]
	            ]
	});
}

function editResRec(recFlow){
	var url = "<s:url value='/res/doc/getResRecByRecFlow'/>?recFlow="+recFlow;
	jboxGet(url , null , function(resp){
		if(resp){
			if($("#editForm").is(":hidden")){
				showHidden();
			}
			$("#recFlow").val(resp.recFlow);
			$("#teachTypeId").val(resp.teachTypeId);
			$("#teachAddress").val(resp.teachAddress);
			$("#teachDate").val(resp.teachDate);
			UE.getEditor('ueditor').setContent(resp.teachExplain);
			//$("[value='"+resp.columnId+"']").attr("selected","selected");
			$("#bodyDiv").animate({scrollTop:"0px"},500);
		}
	} , null , false);
}

function showExplain(recFlow){
	$("#div_"+recFlow).slideToggle("slow");
}

function delRec(recFlow){
	jboxConfirm("确认删除教学登记?",  function(){
		jboxStartLoading();
		var url = "<s:url value='/res/doc/delResRec'/>?recFlow="+recFlow;
		jboxPost(url , null , function(resp){
			if("${GlobalConstant.DELETE_SUCCESSED}" == resp){
				url = "<s:url value='/res/doc/teachRegistryList'/>?";
				window.location.href = url;
			}
		}, null, true);
	});
}


function showHidden(){
	$("#editForm,#operImg img").slideToggle("normal");
}

function save(){
	if(""==$("#teachTypeId").val()){
		jboxTip("活动类型不能为空！");
		return false;
	}
	if(""==$("#teachDate").val()){
		jboxTip("活动时间不能为空！");
		return false;
	}
	if(""==$("#teachAddress").val().trim()){
		jboxTip("活动地点不能为空！");
		return false;
	}
	var url = "<s:url value='/res/doc/saveResRecContent'/>";
	jboxSubmit($('#editForm'), url, 
		function(resp){
			if("${GlobalConstant.SAVE_SUCCESSED}" == resp){
				window.location.reload(true);
				jboxClose();
			}
		},
		function(resp){}, true);
}
</script>
</head>
<body>
<div id="bodyDiv" style="height: 100%;overflow: auto;">
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix" style="padding-bottom: 0;">
			<table width="100%" class="basic">
				<tr onclick="showHidden();" style="cursor: pointer;">
					<th style="text-align: left;padding-left:10px;">
						<span id="titleSpan">教学登记编辑</span>
						<span id="operImg" style="float: right;cursor: pointer;">
							<img title="收缩" src="<s:url value='/jsp/hbres/images/up.png'/>"/>
							<img title="展开" src="<s:url value='/jsp/hbres/images/down.png'/>" style="display: none;"/>
						</span>
					</th>
				</tr>
			</table>
			</div>
			
			<form id="editForm" style="position: relative; display:none;">
				<input type="hidden" id="recFlow" name="recFlow" value="${resRec.recFlow}"/>
				<div style="position: relative; overflow:auto;">
				<table style="width: 100%; border-top-style: none;">
					<colgroup>
						<col width="20%"/>
						<col width="20%"/>
						<col width="60%"/>
					</colgroup>
					<tbody>
						<tr style="height: 37px;">
							<td><font color="red" >*</font>活动类型：
								<select name="teachTypeId" id="teachTypeId" style="width: 120px;">
									<option value="">请选择</option>
									<c:forEach items="${dictTypeEnumTeachTypeList}" var="dict">
										<option value="${dict.dictId}" ${resRec.teachTypeId eq dict.dictId?'selected':''}>${dict.dictName}</option>
									</c:forEach>
								</select>
							</td>
							<td><font color="red" >*</font>活动时间：
								<input id="teachDate" name="teachDate" value="${resRec.teachDate}" type="text" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width: 120px;" readonly="readonly"/>
							</td>
							<td><font color="red" >*</font>活动地点：
								<input type="text" id="teachAddress" name="teachAddress" value="${resRec.teachAddress}" style="width:70%;"/>
								<input type="button" onclick="save();" class="search" value="保&#12288;存" style="float: right;"/>
							</td>
						</tr>
					</tbody>
				</table>
				</div>
				<script type="text/plain" id="ueditor" name="teachExplain" style="height:150px;">${resRec.teachExplain}</script>
			</form>

			
			<c:forEach items="${resRecFormList}" var="recForm">
			<div style="cursor: pointer; border: 1px solid #E2E2E2; margin-top:8px;" class="ith" onclick="showExplain('${recForm.recFlow}');">
				<table style="width: 100%;border: 0;line-height: 30px; border: none;">
					<colgroup>
						<col width="20%"/>
						<col width="20%"/>
						<col width="50%"/>
						<col width="10%"/>
					</colgroup>
					<tr>
						<td>
							活动类型：
							<c:forEach items="${dictTypeEnumTeachTypeList}" var="dict">
								<c:if test="${dict.dictId eq recForm.teachTypeId}">${dict.dictName}</c:if>
							</c:forEach>
						</td>
						<td>活动时间：${recForm.teachDate}</td>
						<td>活动地点：${recForm.teachAddress}</td>
						<td>
							[<a href="javascript:void(0);" onclick="editResRec('${recForm.recFlow}');" >编辑</a>] |
							[<a href="javascript:void(0);" onclick="delRec('${recForm.recFlow}');" >删除</a>]
						</td>
					</tr>
				</table>
			</div>
			
			<div id="div_${recForm.recFlow}" style="display: none;">
				<div style="max-height: 300px; overflow: auto; overflow-x:hidden; border-bottom: 1px solid #E2E2E2; ">
				<table class="i-trend-table " cellspacing="0" style="width: 100%; border-top: none; border-bottom: none;">
					<tbody>
						<tr>
				          <td colspan="5" style="padding-left: 20px;">活动说明：</td>
				        </tr>
				        <tr>
				          <td colspan="5" style="padding-left: 20px;">
				             <div id="content_${recForm.recFlow}">
				             	${recForm.teachExplain}
				             	<%-- <pre style="font-family: Microsoft Yahei;line-height:25px;">${recForm.teachExplain}</pre> --%>
				             </div>
				          </td>
				        </tr>
			      </tbody>
				</table>
				</div>
			</div>
			</c:forEach>
			
			<c:if test="${empty resRecFormList}">
			<div style="cursor: pointer; border: 1px solid #ccc; margin-top: 10px;" class="ith" onclick="showExplain('${recForm.recFlow}');">
				<table style="width: 100%;border: 0;line-height: 30px;">
					<tr>
						<td align="center">无记录</td>
					</tr>
				</table>
			</div>
			</c:if>
			<p>
			   	<%-- <c:set var="pageView" value="${pdfn:getPageView2(resRecFormList, 10)}" scope="request"/> 
				<pd:pagination toPage="toPage"/> --%>
			</p>
		</div>
	</div>
</div>
</body>
</html>