<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
</jsp:include>
<script type="text/javascript">
$().ready(function(){
	if('${allConfirm}'=='true'){
		$("#recNotice").attr("class","step_on");
	}
});
	function confirm(irbFlow,fileIds){
		jboxConfirm("确认审查通过该文件？",function(){
			var url = "<s:url value='/irb/secretary/fileConfirm'/>"
				var requestData= "fileIds="+fileIds+"&irbFlow="+irbFlow;
				jboxPost(url,requestData,function(resp){
					if(resp=='${GlobalConstant.OPRE_SUCCESSED}'){
						var fileIdsInputs = $("input[name='fileIds']:enabled");
						if (fileIdsInputs.length==1) {	//已全部确认
							window.location.reload();
						} else {
							reloadContent("<s:url value='/irb/secretary/showFormcheck'/>");
						}
					}
				},null,true);
		},null);
	}
	function confirmAll(){
		var fileIdsInputs = $("input[name='fileIds']:enabled");
		if(fileIdsInputs.length==0){
			jboxTip("无可操作记录！");
			return false;
		}
		jboxConfirm("确认全部审查通过？",function(){
			var fileIds = "";
			fileIdsInputs.each(function(){
				fileIds +="fileIds="+this.value+"&"
			});
			var irbFlow = '${param.irbFlow}'
			var url = "<s:url value='/irb/secretary/fileConfirm'/>"
			var requestData= fileIds+"irbFlow="+irbFlow;
			jboxPost(url,requestData,function(resp){
				if(resp=='${GlobalConstant.OPRE_SUCCESSED}'){
				//	reloadContent("<s:url value='/irb/secretary/showFormcheck'/>");
					window.location.reload();
				}
			},null,true);
		},null);
	}
	function createNotice(){
		if(false==$("#fileForm").validationEngine("validate")){
			return false;
		}
		
		var fileIdsInputs = $("input[name='fileIds']:checked");
		var fileIdsInput = $("input[name='fileId']:checked");
		var fileIdsAllInput = $("input[name='fileIds']:enabled");
		var fileIdAllInput = $("input[name='fileId']:enabled");
		if((fileIdsInputs.length==0&&fileIdsInput.length==0)&&(fileIdsAllInput.length>0||fileIdAllInput.length>0)){
			jboxTip("请勾选要操作的记录！");
			return false;
		}else if(fileIdsAllInput.length==0&&fileIdAllInput.length==0){
			jboxTip("无可操作记录！");
			return false;
		}
		jboxConfirm("确认生成补充修改通知？",function(){
			var applyFileIds = [];
			fileIdsInput.each(function(){
				var applyFileId = {"id":this.value,"name":$("#fileName_"+this.value).val()};
				applyFileIds.push(applyFileId);
			});
			var datas = [];
			fileIdsInputs.each(function(){
			 var data={
					 "fileTempId":this.value,
					 "fileName":$("#fileName_"+this.value).val(),
					 "fileFlow":$("#fileFlow_"+this.value).val(),
					 "suggest":$("#sug_"+this.value).val()
			 };
			 datas.push(data);
		 });
			var requestData =JSON.stringify({"applyFiles":applyFileIds,"modifyFiles":datas,"irbFlow":'${param.irbFlow}'});
			//alert(requestData);
			var url="<s:url value='/irb/secretary/createNotice'/>"
			jboxPostJson(url,requestData,function(resp){
				if(resp=='${GlobalConstant.OPRE_SUCCESSED}'){
					window.location.href="<s:url value='/irb/secretary/list'/>?irbStageId=${irbStageEnumHandle.id}";
				}
			},null,true);
		});
	}
	function reApply(){
		jboxConfirm("确认撤回申请状态?",function(){
			var url = "<s:url value='/irb/secretary/reApply'/>?irbFlow=${param.irbFlow}"
			jboxGet(url,null,function(resp){
				if(resp=='${GlobalConstant.OPRE_SUCCESSED}'){
					window.location.href="<s:url value='/irb/secretary/list'/>?irbStageId=${irbStageEnumHandle.id}";
				}
			},null,true);
		});
	}
	
	function editSug(fileTempId){
		$("#"+fileTempId).attr("checked",true);
		$("#sugSpan_"+fileTempId).css("display","");
		$("#sug_"+fileTempId).addClass("validate[required]");
	}
	
	function doChecked(fileId) {
		var file = $("#"+fileId);
		if (file.attr("checked")) {
			file.attr("checked",false);
		} else {
			file.attr("checked",true);
		}
	}
	
	function checkFile(fileId) {
		if ($("#"+fileId).attr("checked")) {
			$("#sugSpan_"+fileId).css("display","");
			$("#sug_"+fileId).addClass("validate[required]");
		} else {
			$("#sug_"+fileId).removeClass("validate[required]");
			$("#sugSpan_"+fileId).css("display","none");
		}
	}
	
	
</script>
<style type="text/css">
.confirmTd{background-image:url('<s:url value='/css/skin/${skinPath}/images/gou.gif' />');background-repeat: no-repeat;background-position: center;}
</style>
<div class="mainright">
		<div class="content">
		<form id="fileForm">
			<div style="margin-top: 5px">
				<table class="xllist">
					<tr><th style="text-align: left;" colspan="4">&#12288;送审文件清单</th></tr>
					<tr>
					<td style="text-align: left;font-weight: bold;" colspan="4">
						&#12288;&#12288;一、已提交送审文件<c:if test="${empty uploadFiles }">（无）</c:if>
					</td>
					</tr>
					<c:forEach items="${uploadFiles}" var="file" varStatus="statu">
						<tr>
							<td width="60px;">
								<input type="checkbox" id="${file.fileTempId }" name="fileIds"  onclick="checkFile('${file.fileTempId }')" value="${file.fileTempId }" <c:if test="${file.confirm}"> disabled="disabled"</c:if>  />
								<input type="hidden" id="fileName_${file.fileTempId}" value="${file.fileName }">
								<input type="hidden" id="fileFlow_${file.fileTempId}" value="${file.fileFlow }">
							</td>
							<td width="50px;" <c:if test="${file.confirm}"> class="confirmTd" title="已确认"</c:if>></td>
							<td width="400px;" style="text-align: left;border-right: 0;padding-left: 10px">
								${statu.count}、<a <c:choose><c:when test="${!empty file.fileFlow }">href="${ctxPath}/pub/file/down?fileFlow=${file.fileFlow}"</c:when><c:otherwise>href="javascript:jboxOpen('${file.url}','${file.fileName}',900,600)"</c:otherwise></c:choose>  >${file.fileName }</a>
								&#12288;<c:set var="versionKey" value="${file.fileTempId }_version"></c:set><c:set var="versionDateKey" value="${file.fileTempId }_versionDate"></c:set>
								<c:choose>
									<c:when test="${GlobalConstant.FLAG_Y eq versionMap[versionKey] && GlobalConstant.FLAG_Y eq versionMap[versionDateKey]}">
										（版本号：${file.version}&#12288;版本日期：${file.versionDate}）
									</c:when>
									<c:when test="${GlobalConstant.FLAG_Y eq versionMap[versionKey]}">
										（版本号：${file.version}）
									</c:when>
									<c:when test="${GlobalConstant.FLAG_Y eq versionMap[versionDateKey]}">
										（版本日期：${file.versionDate}）
									</c:when>
								</c:choose>
							</td>
							<td style="text-align: left;border-left: 0;">&#12288;
								<c:if test="${!file.confirm}">
									<a href="javascript:void(0)" onclick="confirm('${param.irbFlow}','${file.fileTempId }')">[确认]</a>&#12288;
									<a href="javascript:void(0)" onclick="editSug('${file.fileTempId }')">[意见]</a>&#12288;
									<span id="sugSpan_${file.fileTempId }" style="display: <c:if test="${!file.confirm}">none</c:if>">
										<input type="text" id="sug_${file.fileTempId }" class="xltext" placeholder="请填写修改意见" style="width: 400px;">
									</span>
								</c:if>
							</td>
						</tr>
					</c:forEach>
					<tr>
						<td style="text-align: left;font-weight: bold;" colspan="4">
						&#12288;&#12288;二、未提交送审文件<c:if test="${empty notUploadFiles }">（无）</c:if>
						</td>
					</tr>
					<c:forEach items="${notUploadFiles}" var="file" varStatus="statu">
						<tr onclick="doChecked('${file.id}');">
							<td width="60px;"><input type="checkbox" name="fileId" id="${file.id }" onclick="doChecked('${file.id}');" value="${file.id }"/><input type="hidden" id="fileName_${file.id}" value="${file.name }"></td>
							<td colspan="3" style="text-align: left;padding-left: 10px;">${statu.count}、${file.name }</td>
						</tr>
					</c:forEach>
				</table>
				<div style="margin-top: 10px;text-align: center;">
					<c:if test="${empty findApply.irbNo }">
						<span><input type="button" class="search" value="生成补充修改通知" onclick="createNotice()" /></span>
						<span><input type="button" class="search" value="全部确认" onclick="confirmAll()"/></span>
					</c:if>
					<c:if test="${findApply.irbStageId == irbStageEnumHandle.id }">
						<span><input type="button" class="search" value="撤&#12288;回" onclick="reApply()" /></span>
					</c:if>
				</div>
			</div>
			</form>
		</div>
</div>
