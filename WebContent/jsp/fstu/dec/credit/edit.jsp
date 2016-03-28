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
		if(!$("#sysOrgForm").validationEngine("validate")){
			return;
		}
		var url="<s:url value='/fstu/dec/saveCredit'/>";
		var credits = [];
			$("tr.each:not(#temp)").each(function(){
				var obj = {
					"userFlow":"${user.userFlow}",
					"userName":"${user.userName}",
					"recordFlow":$(".recordFlow",this).val() || "",
					"year":$(".year",this).val() || "",
					"periodOneCountryCredit":$(".periodOneCountryCredit",this).val() || "",
					"periodOneProvinceCredit":$(".periodOneProvinceCredit",this).val() || "",
					"periodTwoCredit":$(".periodTwoCredit",this).val() || "",
					"professionalEthicsFlag":$(".professionalEthicsFlag",this).val() || "",
					"finishCreditFlag":$(".finishCreditFlag",this).val() || "",
				};
				credits.push(obj);
			});
		jboxPostJson(url,JSON.stringify(credits),function(obj){
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
			url="<s:url value='/fstu/dec/delCredit'/>?recordFlow="+flow+"&recordStatus=${GlobalConstant.RECORD_STATUS_N}";
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
<form id="sysOrgForm" style="height: 100px;" >
	<div class="title1 clearfix">
		<input type="hidden" name="userFlow" value="${user.userFlow }"/>
		<input type="hidden" name="userName" value="${user.userName }"/>
				<table  class="xllist" id="tempTable">
					<tr>
						<th rowspan="2" width="10%">
						<span class="red">*</span>年份</th>
						<th colspan="2" width="25%" >一类学分</th>
						<th rowspan="2" width="25%">二类学分</th>
						<th rowspan="2" width="15%">职业道德（是否完成）</th>
						<th rowspan="2" width="15%">学分是否完成</th>
						<th rowspan="2" width="10%">操作</th>
					</tr>
					<tr>
						<th>国家级</th><th>省级</th>
					</tr>
					<c:forEach items="${credit }" var="credit">		
								
						<tr id="${credit.recordFlow}" class="each">
							<input type="hidden" class="recordFlow" value="${credit.recordFlow}"/>
							<td><input class="validate[required] year" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy'})" type="text" style="width: 70px;text-align: center;" value="${credit.year }"></td>
							<td><input class="periodOneCountryCredit" type="text" style="width: 50px;text-align: center;" value="${credit.periodOneCountryCredit }"></td>
							<td><input class="periodOneProvinceCredit" type="text" style="width: 50px;text-align: center;" value="${credit.periodOneProvinceCredit }"></td>
							<td><input class="periodTwoCredit" type="text" style="width: 50px;text-align: center;" value="${credit.periodTwoCredit }"></td>
							<td><select class="professionalEthicsFlag" style="width: 100px;">
									<option></option>
									<option <c:if test="${credit.professionalEthicsFlag == GlobalConstant.FLAG_Y}">selected</c:if> value="${GlobalConstant.FLAG_Y }">是</option>
									<option <c:if test="${credit.professionalEthicsFlag == GlobalConstant.FLAG_N}">selected</c:if> value="${GlobalConstant.FLAG_N }">否</option>
								</select>
							</td>
							<td><select class="finishCreditFlag" style="width: 100px;">
									<option></option>
									<option <c:if test="${credit.finishCreditFlag == GlobalConstant.FLAG_Y}">selected</c:if> value="${GlobalConstant.FLAG_Y }">是</option>
									<option <c:if test="${credit.finishCreditFlag == GlobalConstant.FLAG_N}">selected</c:if> value="${GlobalConstant.FLAG_N }">否</option>
								</select>
							</td>
							<td><a onclick="del('${credit.recordFlow}');" style="cursor: pointer; color: blue;">删除</a></td>						
						</tr>
					</c:forEach>
						<tr class="each" style="display: none;" id="temp">
							<td><input class="validate[required] year" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy'})" type="text" style="width: 70px;text-align: center;" ></td>
							<td><input class="periodOneCountryCredit" type="text" style="width: 50px;text-align: center;" ></td>
							<td><input class="periodOneProvinceCredit"  type="text" style="width: 50px;text-align: center;" ></td>
							<td><input class="periodTwoCredit" type="text" style="width: 50px;text-align: center;" ></td>
							<td><select class="professionalEthicsFlag" style="width: 100px;">
									<option></option>
									<option value="${GlobalConstant.FLAG_Y }">是</option>
									<option value="${GlobalConstant.FLAG_N }">否</option>
								</select>
							</td>
							<td><select  class="finishCreditFlag" style="width: 100px;">
									<option></option>
									<option value="${GlobalConstant.FLAG_Y }">是</option>
									<option value="${GlobalConstant.FLAG_N }">否</option>
								</select>
							</td>
							<td><a onclick="delCurr(this);" style="cursor: pointer; color: blue;">删除</a></td>	
						</tr>
				</table>
				<div class="button">
					<input class="search" type="button" id="box" value="新&#12288;增" onclick="add();"/>
					<input class="search" type="button" value="保&#12288;存" onclick="saveOrg();"/>
				</div>
			</div>
</form>
</body>
</html>