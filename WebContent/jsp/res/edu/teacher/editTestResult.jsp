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
</jsp:include>
<script type="text/javascript">
function saveOrg() {
	if(!$("#editTestForm").validationEngine("validate")){
		return;
	}
	var url="<s:url value='/resedu/edu/saveTestResult'/>";
	var testResults = [];
	$("tr.each:not(#temp)").each(function(){
		var obj = {
			"userCode":"${user.userCode}",
			"userFlow":"${user.userFlow}",
			"userName":"${user.userName}",
			"paperFlow":$(".paperFlow",this).val() || "000",
			"testTypeId":$(".testTypeId",this).val() || "",
			"ticketNumber":$(".ticketNumber",this).val() || "",
			"remark":$(".remark",this).val() || "",
 			"resultFlow":$(".resultFlow",this).val() || "",
			"testTime":$(".testTime",this).val() || "",
			"paperName":$(".paperName",this).val() || "",
			"totleScore":$(".totleScore",this).val() || "",
			"passFlag":$(".passFlag",this).val() || "",
		};
		testResults.push(obj);
	});
jboxPostJson(url,JSON.stringify(testResults),function(obj){
	if(obj=='${GlobalConstant.SAVE_SUCCESSED}'){
		jboxClose();
	}
},null,true);
}
function add(){
	 $("#temp").clone().show().attr("id","").appendTo("#tempTable"); 
}
function del(flow){
	jboxConfirm("确认删除？", function() {
		url="<s:url value='/resedu/edu/delTestResult'/>?resultFlow="+flow+"&recordStatus=${GlobalConstant.RECORD_STATUS_N}";
		jboxPost(url , null , function(obj){
			if(obj=="${GlobalConstant.DELETE_SUCCESSED}"){
				$("#"+flow).remove();
			}
	});
	});
} 
function delCurr(currTr){
	jboxConfirm("确认删除？", function() {
		$(currTr).closest('.each').remove();
	});
}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
	<form id="editTestForm" style="height: 100px;">
		<div class="title1 clearfix">
		<input type="hidden" name="userFlow" value="${user.userFlow }"/>
		<input type="hidden" name="userName" value="${user.userName }"/>
		<input type="hidden" name="userCode" value="${user.userCode }"/>
			<table  class="xllist" id="tempTable" style="width: 100%;">
				<tr>
					<th style="width: 14%;">考试类型</th>
					<th style="width: 14%;">准考证号</th>
					<th style="width: 14%;">考试时间</th>
					<th style="width: 17%;">考卷名称</th>
					<th style="width: 8%;">总分</th>
					<th style="width: 8%;">是否通过</th>
					<th style="width: 15%;">备注</th>
					<th style="width: 9%;">操作</th>
				</tr>
				<c:forEach items="${result }" var="result">
					<tr id="${result.resultFlow}" class="each">
								<input type="hidden" class="resultFlow" value="${result.resultFlow}"/>
								<input type="hidden" class="paperFlow" value="${result.paperFlow}"/> 
							<td>
								<select class="testTypeId validate[custom[number]]" style="width: 90px;">
									<option value=""></option>
									<c:forEach items="${dictTypeEnumTestTypeList}" var="dict">
										<option value="${dict.dictId}" <c:if test="${result.testTypeId eq dict.dictId}">selected</c:if>>${dict.dictName}</option>
									</c:forEach>
								</select>
							</td>
							<td><input class="ticketNumber validate[custom[number]]" style="width: 85px;" type="text" style="width: 50px;text-align: center;" value="${result.ticketNumber }"></td>
							<td><input class="testTime" readonly="readonly"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" type="text" style="width: 90px;text-align: center;" value="${result.testTime }"></td>
							<td><input class="paperName validate[required]" type="text" style="width: 125px;text-align: center;" value="${result.paperName }"></td>
							<td><input class="totleScore validate[custom[number]]" type="text" style="width: 50px;text-align: center;" value="${result.totleScore }"></td>
							<td><select class="passFlag" style="width: 50px;">
									<option></option>
									<option <c:if test="${result.passFlag == GlobalConstant.FLAG_Y}">selected</c:if> value="${GlobalConstant.FLAG_Y }">是</option>
									<option <c:if test="${result.passFlag == GlobalConstant.FLAG_N}">selected</c:if> value="${GlobalConstant.FLAG_N }">否</option>
								</select>
							</td>
							<td><input class="remark validate[custom[number]]" type="text" style="width: 110px; text-align: center;" value="${result.remark}"></td>
 							<td><a onclick="del('${result.resultFlow}');" style="cursor: pointer; color: blue;">删除</a></td>	 
					</tr>	
				</c:forEach>
					<tr class="each" style="display: none;" id="temp">
						
							<td><!-- <input class="testTypeName validate[custom[number]]" type="text" style="width: 50px;text-align: center;"> -->
								<select class="testTypeId validate[custom[number]]" style="width: 90px;">
									<option value=""></option>
									<c:forEach items="${dictTypeEnumTestTypeList}" var="dict">
										<option value="${dict.dictId}">${dict.dictName}</option>
									</c:forEach>
								</select>
							</td>
							<td><input class="ticketNumber validate[custom[number]]" type="text" style="width: 85px;px;text-align: center;"></td>
							<td><input class="testTime " readonly="readonly"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" type="text" style="width: 90px;text-align: center;"></td>
							<td><input class="paperName validate[required]" type="text" style="width: 125px;text-align: center;"></td>
							<td><input class="totleScore validate[custom[number]]" type="text" style="width: 50px;text-align: center;"></td>
							<td><select class="passFlag" style="width: 50px;">
									<option ></option>
									<option value="${GlobalConstant.FLAG_Y }">是</option>
									<option value="${GlobalConstant.FLAG_N }">否</option>
								</select>
							</td>
							<td><input class="remark validate[custom[number]]" type="text" style="width: 110px; text-align: center;"></td>
						<td><a onclick="delCurr(this);" style="cursor: pointer; color: blue;">删除</a></td>	
					</tr>
			</table>
				<div class="button">
					<input class="search" type="button" id="box" value="新&#12288;增" onclick="add();"/>
					<input class="search" type="button" value="保&#12288;存" onclick="saveOrg();"/>
					<input class="search" type="button" value="关&#12288;闭" onclick="jboxClose();"/>
				</div>
		</div>
	</form>
	</div>
	</div>
</body>
</html>