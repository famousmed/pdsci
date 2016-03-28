<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
function save() {
	jboxConfirm("确认受理该伦理审查？",function(){
		var saveForm = $("#saveForm");
		if(saveForm.validationEngine("validate")){
			var url="<s:url value='/irb/secretary/saveRecNotice'/>";
			var requestData=saveForm.serialize();
			jboxPost(url,requestData,function(resp){
				if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
					$("#i_operTime").text($("input[name='operTime']").val());
					$("#i_irbNo").text($("input[name='irbNo']").val());
					$("#checkWay").attr("class","step_on");
					window.location.reload();
				}
			},null,true);
		}
	},null);
}

function print(fileType){
	var url ="<s:url value='/irb/printOther'/>?watermarkFlag=${GlobalConstant.FLAG_N}&irbFlow=${curApply.irbFlow}&recTypeId="+fileType;
	window.location.href= url;
}
</script>
<div class="title1 clearfix">
<form id="saveForm">
	<div class="content">
		<table class="xllist" >
			<thead>
				<tr>
					<th  colspan="2" >伦理审查受理通知</th>
				</tr>
				<tr>
					<td width="10%" >申请人</td>
					<td style="text-align: left;">&#12288;${proj.applyUserName }</td>
				</tr>
				<tr>
					<td width="10%" >项目名称</td>
					<td style="text-align: left;">&#12288;${proj.projName }</td>
				</tr>
				<tr>
					<td width="10%" >项目来源</td>
					<td style="text-align: left;">&#12288;${proj.projDeclarer }</td>
				</tr>
				<tr>
					<td width="10%" >受理号</td>
					<td style="text-align: left;">&#12288;<c:if test="${empty curApply.irbNo}"><input name="irbNo" type="text" class="validate[required] text-input " /></c:if><c:if test="${!empty curApply.irbNo}">${curApply.irbNo}</c:if></td>
				</tr>
				<tr>
					<td width="10%" >申请/报告类别</td>
					<td style="text-align: left;">&#12288;${curApply.irbTypeName}</td>
				</tr>
				<tr>
					<td width="10%" >送审材料</td>
					<td style="text-align: left;" >
					<c:forEach items="${irbFileList}" var="file">
						<c:if test="${GlobalConstant.FLAG_Y == file.showNotice}">
							&#12288;${file.fileName}<c:if test="${!empty file.version}">&#12288;&#12288;&#12288;版本号：${file.version}</c:if><c:if test="${!empty file.versionDate }">&#12288;&#12288;&#12288;版本日期：${file.versionDate }</c:if><br/>
						</c:if>
					</c:forEach>
				</td>
				</tr>
				<tr>
					<td width="20%" >受理人签字</td>
					<td  style="text-align: left;">&#12288;<c:if test="${empty process.operUserName }">${sessionScope.currUser.userName }</c:if>
					<c:if test="${!empty process.operUserName }">${process.operUserName }</c:if>
					</td>
				</tr>
				<tr>
					<td width="20%" >受理日期</td>
					<td style="text-align: left;">&#12288;<c:if test="${empty curApply.irbAcceptedDate}"><input type="text" name="operTime" class="validate[required] text-input  ctime" value="${pdfn:getCurrDate()}"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"></c:if>
					<c:if test="${!empty curApply.irbAcceptedDate}">${curApply.irbAcceptedDate}</c:if>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="button">
			<input type="hidden" name="irbFlow" value="${param.irbFlow}"/>
			<c:if test="${empty curApply.irbNo }"><input type="button" class="search" value="确认受理" onclick="save();" /></c:if>
			<input class="search" type="button" showFlag="${GlobalConstant.FLAG_Y }" value="打&#12288;印" onclick="print('receiptNotice');" />
		</div>
	</div>
	</form>
	</div>