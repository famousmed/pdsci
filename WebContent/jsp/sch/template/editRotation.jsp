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
		
		$("#isStageTd :checked").change();
	});

		
	function saveRotation() {
		if(!$("#schRotation").validationEngine("validate")){
			return ;
		}
		var url = "<s:url value='/sch/template/saveRotation'/>";
		var isStage = $("[name='isStage']:checked").val() != "${GlobalConstant.FLAG_Y}";
		if(isStage){
			$("[name='isCrisscrossFlag'][value='${GlobalConstant.FLAG_Y}']").attr("checked",true);
		}
		var getdata = $('#schRotation').serialize();
		jboxPost(url, getdata, function(data) {
			if('${GlobalConstant.SAVE_SUCCESSED}'==data){
				var frameWindow = window.parent.frames['mainIframe'];
// 				var sessionNumber = frameWindow.$("#sessionNumber").val();
// 				var speId = frameWindow.$("#speId").val();
				frameWindow.search(); 
				jboxClose();		
			}
		});
	}
	
	function doClose(){
		jboxClose();
	}
	
	function crisscrossView(val){
		var isStage = val=="${GlobalConstant.FLAG_Y}";
		$(".cc").toggle(isStage);
		$("#isStageTd").attr("colspan",isStage?1:3);
// 		if(!isStage){
// 			$("[name='isCrisscrossFlag'][value='${GlobalConstant.FLAG_Y}']").attr("checked",true);
// 		}else{
// 			$("[name='isCrisscrossFlag']:checked").attr("checked",false);
// 		}
	}
</script>
</head>
<body>
<div style="height: 450px; position: relative; overflow:auto;">
	<div class="mainright" align="center">
	<div class="content">
	<div class="title1 clearfix" >
		<form id="schRotation" style="position: relative;">
			<input type="hidden" name="rotationFlow" value="${rotation.rotationFlow}"/>
			<input type="hidden" name="publishFlag" value="${empty rotation?GlobalConstant.FLAG_N:rotation.publishFlag}"/>
		<table class="basic" style="width: 100%;">
			<colgroup>
				<col width="16%"/>
				<col width="34%"/>
				<col width="16%"/>
				<col width="34%"/>
			</colgroup>
			<tbody>
				<tr>
					<th><font color="red" >*</font>培训方案名称：</th>
					<td>
						<input type="text" class="validate[required]"  name="rotationName" value="${rotation.rotationName}" style="margin-right: 0px"/>
					</td>
					<th><font color="red" >*</font>人员类型：</th>
					<td>
						<c:if test="${empty rotation || GlobalConstant.FLAG_N eq rotation.publishFlag}">
						<select name="doctorCategoryId" class="validate[required]">
							<option />
							<c:forEach items="${recDocCategoryEnumList}" var="category">
								<c:set var="res_doctor_category_key" value="res_doctor_category_${category.id }"/>
								<c:if test="${sysCfgMap[res_doctor_category_key]==GlobalConstant.FLAG_Y }">
								<option value="${category.id}" ${rotation.doctorCategoryId eq category.id?'selected':''}>${category.name}</option>
								</c:if>
							</c:forEach>
						</select>
						</c:if>
						<c:if test="${GlobalConstant.FLAG_Y eq rotation.publishFlag}">
							<font style="font-weight: bold;">&#12288;${rotation.doctorCategoryName}</font>
						</c:if>
					</td>
				</tr>
				<tr>
					<th><font color="red" >*</font>专业：</th>
					<td>
						<c:if test="${empty rotation || GlobalConstant.FLAG_N eq rotation.publishFlag}">
						<select name="speId" class="validate[required]" style="margin-right: 0px">
							<option></option>
							<c:forEach items="${dictTypeEnumDoctorTrainingSpeList}" var="dict">
								<option value="${dict.dictId}" ${rotation.speId eq dict.dictId?'selected':''}>${dict.dictName}</option>
							</c:forEach>
						</select>
						</c:if>
						<c:if test="${GlobalConstant.FLAG_Y eq rotation.publishFlag}">
							<input type="hidden" name="speId" value="${rotation.speId}"/>
							<font style="font-weight: bold;">&#12288;${rotation.speName}</font>
						</c:if>
					</td>
					<th><font color="red" >*</font>培养年限：</th>
					<td>
						<c:if test="${!(GlobalConstant.FLAG_Y eq rotation.publishFlag)}">
							<select name="rotationYear" class="validate[required]" style="margin-right: 0px">
								<option></option>
								<option value="1" ${rotation.rotationYear eq '1'?'selected':''}>1</option>
								<option value="2" ${rotation.rotationYear eq '2'?'selected':''}>2</option>
								<option value="3" ${rotation.rotationYear eq '3'?'selected':''}>3</option>
							</select>
							
						</c:if>
						<c:if test="${GlobalConstant.FLAG_Y eq rotation.publishFlag}">
							<font style="font-weight: bold;">&#12288;${rotation.rotationYear}</font>
						</c:if>
					</td>
				</tr>
				<tr>
					<th><font color="red" >*</font>方案类型：</th>
					<td>
						<select name="rotationTypeId" class="validate[required]" style="margin-right: 0px">
							<option></option>
							<c:forEach items="${schRotationMedicineTypeList}" var="medicineType">
								<option value="${medicineType.id}" ${rotation.rotationTypeId eq medicineType.id?'selected':''}>${medicineType.name}</option>
							</c:forEach>
						</select>
					</td>
					<th>方案版本：</th>
					<td>
						<input type="text" name="rotationVersion" value="${rotation.rotationVersion}" style="margin-right: 0px"/>
					</td>
				</tr>
				<tr>
					<th><font color="red" >*</font>是否区分阶段：</th>
					<td id="isStageTd">
						<label>
							<input type="radio" name="isStage" value="${GlobalConstant.FLAG_Y}" <c:if test="${rotation.isStage eq GlobalConstant.FLAG_Y}">checked</c:if>  class="validate[required]" onchange="crisscrossView(this.value);"/>
							是
						</label>
						&#12288;
						<label>
							<input type="radio" name="isStage" value="${GlobalConstant.FLAG_N}" <c:if test="${rotation.isStage eq GlobalConstant.FLAG_N}">checked</c:if>  class="validate[required]" onchange="crisscrossView(this.value);"/>
							否
						</label>
					</td>
					<th class="cc"><font color="red" >*</font>允许交错排班：</th>
					<td class="cc">
						<label>
							<input type="radio" name="isCrisscrossFlag" value="${GlobalConstant.FLAG_Y}" <c:if test="${rotation.isCrisscrossFlag eq GlobalConstant.FLAG_Y}">checked</c:if>  class="validate[required]"/>
							是
						</label>
						&#12288;
						<label>
							<input type="radio" name="isCrisscrossFlag" value="${GlobalConstant.FLAG_N}" <c:if test="${rotation.isCrisscrossFlag eq GlobalConstant.FLAG_N}">checked</c:if>  class="validate[required]"/>
							否
						</label>
					</td>
				</tr>
				<tr>
					<th style="text-align: left;padding-left:10px;" colspan="4">轮转方案说明</th>
				</tr>
				<tr>
					<td colspan="4">
						<script type="text/plain" id="ueditor" name="rotationNote" style="height:150px;">${rotation.rotationNote}</script>
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
      	<input type="button" onclick="javascript:saveRotation();" class="search" value="保&#12288;存"/>
      	<input type="button" onclick="javascript:doClose();" class="search" value="关&#12288;闭"/>
    </p>
</div>
</body>
</html>