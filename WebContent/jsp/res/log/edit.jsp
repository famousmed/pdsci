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
		});
	});
	
	function doClose(){
		jboxClose();
	}
	
	function doBack(logFlow){
		var url = "<s:url value='/res/log/getLog?logFlow='/>" + logFlow;//查看日志
		window.location.href = url;
	}
	
	function save(){
		if(false == $("#editForm").validationEngine("validate")){
			return false;
		}
		var url = "<s:url value='/res/log/saveLog'/>";
		jboxSubmit($('#logForm'), url, 
					function(resp){
						if("${GlobalConstant.SAVE_SUCCESSED}" == resp){
							<c:if test="${param.editFlag != GlobalConstant.FLAG_Y}">
								<c:if test="${param.logTypeId eq logTypeEnumDay.id}">
									window.parent.frames['mainIframe'].location.reload(true);
									jboxClose();
							    </c:if>
								<c:if test="${param.logTypeId != logTypeEnumDay.id}">
									url = "<s:url value='/res/log/list?logTypeId=${param.logTypeId}'/>";
									window.parent.frames['mainIframe'].location.href = url;
									jboxClose();
							    </c:if>
					    	</c:if>
					      	<c:if test="${param.editFlag == GlobalConstant.FLAG_Y}">
					      		doBack("${workLog.logFlow}");
					    	</c:if>
						}
					},
					function(resp){},true);
	}
	
	function getStartAndEnd(weekNum){//fillDate,endDate
		if($.trim(weekNum)!="" && !isNaN(weekNum) && weekNum.indexOf(".")<0){
			jboxGet("<s:url value='/res/doc/getStartAndEnd'/>?weekNum="+weekNum,null,function(resp){
				if(resp){
					$("[name='fillDate']").val(resp.start);
					$("[name='endDate']").val(resp.end);
				}else{
					$("[name='fillDate']").val("");
					$("[name='endDate']").val("");
				}
			},null,false);
		}
	}
	
</script>
</head>
<body>
<div style="height: 450px; position: relative; overflow:auto;">
	<div class="mainright" align="center">
	<div class="content">
		<form id="logForm" style="position: relative;">
		<input type="hidden" name="logFlow" value="${workLog.logFlow}"/>
		<table class="basic" style="width: 100%;margin-top: 20px;">
			<colgroup>
				<col width="100px;"/>
				<col />
			</colgroup>
			<tbody>
				<tr>
					<th>类型：</th>
					<td colspan="3">
					    <c:if test="${param.logTypeId eq logTypeEnumDay.id}">
					    	<input type="hidden" name="logTypeId" value="${logTypeEnumDay.id}"/>
					    	<input type="hidden" name="logTypeName" value="${logTypeEnumDay.name}"/>
					        <span>日志</span>
					    </c:if>
					    <c:if test="${param.logTypeId eq logTypeEnumWeek.id}">
					    	<input type="hidden" name="logTypeId" value="${logTypeEnumWeek.id}"/>
					    	<input type="hidden" name="logTypeName" value="${logTypeEnumWeek.name}"/>
					        <span>周记</span>
					    </c:if>
					    <c:if test="${param.logTypeId eq logTypeEnumMonth.id}">
					    	<input type="hidden" name="logTypeId" value="${logTypeEnumMonth.id}"/>
					    	<input type="hidden" name="logTypeName" value="${logTypeEnumMonth.name}"/>
					        <span>月记</span>
					    </c:if>
					</td>
				</tr>
				<c:if test="${param.logTypeId eq logTypeEnumDay.id}">
				<tr>
					<th>日期：</th>
					<td colspan="3">
					    <span><input type="text" name="fillDate" value="${empty workLog.fillDate?param.fillDate:workLog.fillDate}" class="xltext ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width: 100px;margin-right: 0px;" readonly="readonly"> </span>
					</td>
				</tr>
				</c:if>
				<c:if test="${param.logTypeId eq logTypeEnumWeek.id}">
				    <th>日期：</th>
					<td colspan="3">
					    <div class="cat" id="week" style="margin-top: 5px;"> 
					                      第&#12288;<input type="text" name="weekNum" class="validate[custom[integer,min[1]]] xltext" style="width: 50px;text-align: center;margin-right: 0px;" onchange="getStartAndEnd(this.value);"/>&#12288;周  &#12288;&#12288;
					                     日期：<input type="text" name="fillDate" class="xltext ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width: 100px;margin-right: 0px;" readonly="readonly"> 
					                     至 <input type="text" name="endDate" class="xltext ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width: 100px;margin-right: 0px;" readonly="readonly"> 
					    </div>
					</td>
				</c:if>
				<c:if test="${param.logTypeId eq logTypeEnumMonth.id}">
				<tr>
					<th>年月：</th>
					<td colspan="3">
					    <span> 
					   		<input type="text" name="fillDate" value="${workLog.fillDate}" onClick="WdatePicker({dateFmt:'yyyy-MM'})" class="xltext ctime" style="width: 100px;text-align: center;margin-right: 0px;" readonly="readonly"/>
					    </span>
					</td>
				</tr>
				</c:if>
				<tr>
					<th style="text-align: left;padding-left:10px;" colspan="4">内容</th>
				</tr>
				<tr>
					<td colspan="4">
						<script type="text/plain" id="ueditor" name="logContent" style="height:200px;">${workLog.logContent}</script>
					</td>
				</tr>
			</tbody>
		</table>
		</form>
	</div>
	</div>
	</div>
<div style="margin-top: 15px;">
	<p style="text-align: center;">
      	<input type="button" onclick="javascript:save();" class="search" value="保&#12288;存"/>
      	<c:if test="${param.editFlag != GlobalConstant.FLAG_Y}">
      		<input type="button" onclick="doClose();" class="search" value="关&#12288;闭"/>
    	</c:if>
      	<c:if test="${param.editFlag == GlobalConstant.FLAG_Y}">
      		<input type="button" onclick="doBack('${workLog.logFlow}');" class="search" value="返&#12288;回"/>
    	</c:if>
    </p>
</div>
</body>
</html>