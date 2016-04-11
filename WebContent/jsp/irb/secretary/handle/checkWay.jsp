<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
function save() {
	var saveForm = $("#saveForm");
	if(saveForm.validationEngine("validate")){
		jboxConfirm("确定保存审查方式？",function(){
			var url="<s:url value='/irb/secretary/saveCheckWay'/>";
			var requestData=saveForm.serialize();
			jboxPost(url,requestData,function(resp){
				if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
					$("#i_checkWay").text($("input[name='reviewWayId']:checked + span").text());
					$("#chooseMember").attr("class","stepend_on");
					//toCheckWay();
					window.location.reload();
				}
			},null,true);
		},null);
	}
}
</script>
<div class="title1 clearfix">
<form id="saveForm">
	<div class="content">
		<table class="xllist">
					 	<tr>
					<th  colspan="2" align="left">确定审查方式</th>
				</tr>
					 		<tr>
					<td width="20%" >审查方式</td>
					<td style="text-align: left" >&#12288;
					<c:if test="${empty curIrbApply.reviewWayName }">
					 	<c:forEach items="${irbReviewTypeEnumList}" var="item" varStatus="status">
					 		<input type="radio" id="${item.id }" name="reviewWayId" value="${item.id }" <c:if test="${status.first}">checked="checked"</c:if> />
					 		<label for="${item.id }"> <span style="margin: 0 10px 0 5px;">${item.name}</span></label>
					 	</c:forEach>
					</c:if>
					<c:if test="${!empty curIrbApply.reviewWayName }">
						${curIrbApply.reviewWayName }
					</c:if>
				</tr>
				<tr>
					<td width="20%" >伦理委员会</td>
					<td style="text-align: left" >&#12288;
					<c:if test="${empty curIrbApply.irbInfoFlow }">
					   	<c:forEach items="${infoList}" var="info" varStatus="status">
							<input type="radio" id="${info.recordFlow }" name="irbInfoFlow" value="${info.recordFlow }" <c:if test="${status.first}">checked="checked"</c:if>  />
							<label for="${info.recordFlow }"> <span style="margin: 0 10px 0 5px;">${info.irbName}</span></label>
						</c:forEach>
					</c:if>
					<c:if test="${!empty curIrbApply.irbInfoFlow }">
						${irbInfo.irbName}
					</c:if>
				</tr>
					 	</table>
		<div class="button" style="width:100%">
			<input type="hidden" name="irbFlow" value="${param.irbFlow}"/>
			<c:if test="${empty curIrbApply.reviewWayId }">
				<input type="button" class="search" value="确&#12288;认" onclick="save();" />
			</c:if>
		</div>
	</div>
	</form>
	</div>