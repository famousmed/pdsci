<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<style type="text/css">
table#splist td{text-align: left;padding-left: 20px; width:100px;font-size: 13px;}
</style>
<script type="text/javascript">
function saveDes(){
	var saveForm = $("#saveForm");
	if(saveForm.validationEngine("validate")){
		var url="<s:url value='/irb/secretary/saveDecDetail'/>";
		var requestData = saveForm.serialize();
		requestData = requestData+"&contact="+$.trim($("#contact").text())+"&chairman="+$.trim($("#chairman").text())+"&irbInfo="+$.trim($("#irbInfo").text());
		jboxPost(url,requestData,function(resp){
			if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
				//$("#decisionDate").text($("#operTime").val());
				//load("<s:url value='/irb/secretary/decisionDetail'/>?irbFlow=${param.irbFlow }");
				window.location.href = "<s:url value='/irb/secretary/decision'/>?irbFlow=${param.irbFlow}&tagId=decisionDetail";
			}
		},null,true);
	}
}
	function changeStage(){
		jboxConfirm("确认传达决定,操作后将无法修改？",function(){
			var url = "<s:url value='/irb/secretary/changeApplyStage' />?irbFlow=${param.irbFlow}&date=${irbForm.irb.irbDecisionDate}";
			jboxPost(url,null,function(resp){
				jboxTip(resp);
				if(resp=='${GlobalConstant.OPRE_SUCCESSED}'){
					window.location.href="<s:url value='/irb/secretary/list'/>?irbStageId=${irbStageEnumDecision.id}";
				}
			},null,false);
		},null);
	}
	
	function selectSingle(obj) {
		var id = $(obj).attr("id");
		var name = $(obj).attr("name");
		$("input[name="+name+"][id!="+id+"]:checked").attr("checked",false);
	}
	
	function showTrackDate(){
		var trackObj = $("input[name=trackFrequency]:checked");
		if ($(trackObj).val() == null) {
			return;
		} else {
			jboxGet("<s:url value='/irb/secretary/showTrackDate?irbDecisionDate='/>" + $("#irbDecisionDate").val()+"&trackFrequency="+$(trackObj).val(), 
					null, function(resp) {
				$("#trackDate").val(resp);
			}, null, false);
		}
	}
	
	function showTrackDateSpan(flag) {
		if ("Y" == flag) {
			$("#trackDateSpan").show();
		} else {
			$("#trackDate").val("");
			$("input[name='trackFrequency']:checked").attr("checked",false);
			$("#trackDateSpan").hide();
		}
	}
	
	function print(fileType){
		var url ="<s:url value='/irb/printOther'/>?watermarkFlag=${GlobalConstant.FLAG_N}&irbFlow=${irbForm.irb.irbFlow}&recTypeId="+fileType;
		window.location.href= url;
	}
	
	function selReviewFile() {
		jboxOpen("<s:url value='/irb/secretary/selReviewFile'/>?irbFlow=${irbForm.irb.irbFlow}&fileType=${fileType}","编辑审查文件",650,500);
	}
	
</script>
<div class="mainright">
	<div class="content">
	<form id="saveForm">
	<div class="title1 clearfix">
			<table id="splist" class="xllist nofix" width="700px">
				<tr><th colspan="4"><c:if test="${irbRecTypeEnumOpinionFile.id==fileType}">${irbRecTypeEnumOpinionFile.name}</c:if><c:if test="${irbRecTypeEnumApproveFile.id==fileType}">${irbRecTypeEnumApproveFile.name}</c:if></th></tr>
				<tr><td style="width:100px;"><c:if test="${irbRecTypeEnumOpinionFile.id==fileType}">意见号：</c:if><c:if test="${irbRecTypeEnumApproveFile.id==fileType}">批件号：</c:if></td><td colspan="3">${irbForm.irb.irbNo} </td></tr>
				<tr><td style="width:100px;">项目名称：</td><td  colspan="3">${irbForm.proj.projName } </td></tr>
				<tr><td>项目来源：</td><td  colspan="3">${irbForm.proj.projDeclarer }</td></tr>
				<tr><td>研究单位：</td><td  colspan="3">${irbForm.proj.applyOrgName }</td></tr>
				<tr><td>主要研究者：</td><td  colspan="3">${irbForm.proj.applyUserName }</td></tr>
				<tr><td>审查类别：</td><td >${irbForm.irb.irbTypeName }</td>
					<td width="100px" style="text-align: right;padding-right: 10px;">审查方式：</td><td>${irbForm.irb.reviewWayName}</td>
				</tr>
				<tr><td>审查日期：</td><td >${irbForm.irb.irbReviewDate}</td>
					<td style="text-align: right;padding-right: 10px;">审查地点：</td>
					<td >
					<c:choose>
						<c:when test="${irbReviewTypeEnumFast.id eq irbForm.irb.reviewWayId}">${pdfn:getSysCfg('irb_review_address')}</c:when>
						<c:otherwise>${meeting.meetingAddress}</c:otherwise>
					</c:choose>
					</td>
				</tr>
				<tr><td>审查委员：</td><td  colspan="3"><c:forEach items="${filterUserList }" var="user" varStatus="statu">${user.userName}<c:if test="${fn:length(filterUserList)>1&&!statu.last}">、</c:if></c:forEach></td>
				</tr>
				<tr><td>审查文件：</td>
				<td colspan="3">
					<c:forEach items="${empty form.applyFileForms?fileList:form.applyFileForms}" var="file">
						<a style="color: blue;" <c:choose><c:when test="${!empty file.fileFlow }">href="${ctxPath}/pub/file/down?fileFlow=${file.fileFlow}"</c:when><c:otherwise>href="javascript:jboxOpen('${file.url}','${file.fileName}',900,600)"</c:otherwise></c:choose>  >${file.fileName}</a><c:if test="${!empty file.version }"><span style="margin-left: 30px;">版本号：${file.version}</span></c:if><c:if test="${!empty file.versionDate }"><span style="margin-left: 30px;">版本日期：${file.versionDate}</span></c:if><br/>
					</c:forEach>
				</td>
				</tr>
				<tr><td>审查决定：</td><td  colspan="3">${irbForm.irb.irbDecisionName } </td></tr>
				<tr>
					<td>审查意见：</td><td colspan="3" style="padding-left: 20;">
						<textarea  cols="130"  name="opinion" class="validate[required] xltxtarea" style="height: 200px;"><c:choose>
								<c:when test="${!empty form.opinion }">${form.opinion }</c:when>
								<c:when test="${irbRecTypeEnumOpinionFile.id==fileType}"><c:set var="suggestKey" value="irb_suggest_content_${irbForm.irb.irbTypeId}"></c:set>${pdfn:getSysCfg(suggestKey)}</c:when>
								<c:when test="${irbRecTypeEnumApproveFile.id==fileType}">${pdfn:getSysCfg('irb_approvals_content')}</c:when>
								</c:choose>
						</textarea>
					</td>
				</tr>
				<c:if test="${irbRecTypeEnumApproveFile.id==fileType}">
				<tr>
					<td>有效期：</td>
					<td colspan="3">
						<c:choose>
							<c:when test="${param.type eq 'view' }">
								${irbForm.irb.approveValidity }个月
							</c:when>
							<c:otherwise>
								<input type="text"  name="approveValidity" class="validate[required,custom[integer],min[0]] text-input xltext" style="width: 50px;margin-right: 8px;text-align: center;" value="${irbForm.irb.approveValidity }">个月
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				</c:if>
				<c:if test="${(irbTypeEnumInit.id == irbForm.irb.irbTypeId || irbTypeEnumRetrial.id == irbForm.irb.irbTypeId || irbTypeEnumRevise.id == irbForm.irb.irbTypeId) && 
					(irbRecTypeEnumApproveFile.id==fileType || haveApprove)}">
				<tr>
					<td>跟踪审查日期：</td>
					<td colspan="3">
						<c:choose>
							<c:when test="${irbForm.irb.irbStageId==irbStageEnumDecision.id }">
								<c:if test="${irbRecTypeEnumApproveFile.id !=fileType}">
									<span>
										<input type="checkbox" id="newTrackDateY" name="newTrackDate" ${!empty irbForm.irb.trackDate?"checked":"" } onclick="selectSingle(this);showTrackDateSpan('Y');"><label for="newTrackDateY">改变</label>
										<input type="checkbox" id="newTrackDateN" name="newTrackDate" ${empty irbForm.irb.trackDate?"checked":"" } onclick="selectSingle(this);showTrackDateSpan('N');"><label for="newTrackDateN">不变</label>&#12288;
									</span>
								</c:if>
								<span id="trackDateSpan" style="display: ${(!empty irbForm.irb.trackDate || irbRecTypeEnumApproveFile.id == fileType)?'':'none' };">
									<input type="text" id="trackDate" name="trackDate" class="text-input xltext ctime" value="${irbForm.irb.trackDate }"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"> 
									<c:forEach items="${dictTypeEnumTrackFrequencyList}" var="dict" >
										<input type="checkbox" id="trackFrequency${dict.dictId}" name="trackFrequency" onclick="selectSingle(this);showTrackDate();" value="${dict.dictId}" <c:if test="${dict.dictId == irbForm.irb.trackFrequency}">checked</c:if>><label for="trackFrequency${dict.dictId}">${dict.dictName}&#12288;</label>
									</c:forEach>
								</span>
							</c:when>
							<c:otherwise>
								${irbForm.irb.trackDate }
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				</c:if>
				<tr><td>联系方式：</td><td colspan="3" id="contact">
					<c:choose>
						<c:when test="${!empty form.contact }">
							${form.contact }
						</c:when>
						<c:otherwise>
							${irbInfo.contactUser}&#12288;${irbInfo.contactPhone}&#12288;${irbInfo.contactMobile}
						</c:otherwise>
					</c:choose>
				</td>
				</tr>
				<tr><td>主席签字：</td><td  colspan="3" id="chairman">
					<c:choose>
						<c:when test="${!empty form.chairman }">
							${form.chairman }
						</c:when>
						<c:otherwise>
							<c:forEach items="${infoUserList }" var="user" varStatus="statu">${user.userName}<c:if test="${fn:length(infoUserList)>1&&!statu.last}">、</c:if></c:forEach>
						</c:otherwise>
					</c:choose>
				</td>
				</tr>
				<tr><td>伦理委员会：</td><td  colspan="3" id="irbInfo">
					<c:choose>
						<c:when test="${!empty form.irbInfo }">
							${form.irbInfo }
						</c:when>
						<c:otherwise>
							${irbInfo.irbName }
						</c:otherwise>
					</c:choose>
				</td>
				</tr>
				<tr>
				<td>日期：</td>
				<td  colspan="3">
					<c:choose>
						<c:when test="${param.type eq 'view' }">
							${irbForm.irb.irbDecisionDate}
						</c:when>
						<c:otherwise>
							<input type="text" name="irbDecisionDate" id="irbDecisionDate" class="validate[required] text-input xltext ctime" value="${empty irbForm.irb.irbDecisionDate?pdfn:getCurrDate():irbForm.irb.irbDecisionDate}"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"> 
						</c:otherwise>
					</c:choose>
				</td>
				</tr>
			</table>
			<div class="button">
				<input type="hidden" name="irbFlow" value="${param.irbFlow }"/>
				<input type="hidden" name="irbRecTypeId" value="${fileType }"/>
				<input type="hidden" name="recFlow" value="${form.recFlow }"/>
				<c:if test="${irbForm.irb.irbStageId==irbStageEnumDecision.id }">
					<input type="button" class="search" value="编辑审查文件" onclick="selReviewFile();" />
					<input type="button" class="search" value="保&#12288;存" onclick="saveDes();" />
					<c:if test="${!empty irbForm.irb.irbDecisionDate }">
						<input type="button" class="search" value="传达决定" onclick="changeStage();" />
					</c:if>
				</c:if>
				<input class="search" type="button" showFlag="${GlobalConstant.FLAG_Y }" value="打&#12288;印" onclick="print('${fileType}');" />
			</div>
		</div>
		</form>
	</div>
	</div>