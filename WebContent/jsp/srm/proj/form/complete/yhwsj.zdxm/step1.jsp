<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ztree" value="true"/>
</jsp:include>
<style>
	.borderNone{border-bottom-style: none;}
</style>
<c:if test="${param.view != GlobalConstant.FLAG_Y}">
<script type="text/javascript">
	function nextOpt(step){
		if(false==$("#projForm").validationEngine("validate")){
			return false;
		}
		var form = $('#projForm');
		var action = form.attr('action');
		action+="?nextPageName="+step;
		form.attr("action" , action);
		form.submit();
	}
	
	function checkTeltphone(obj){
		var r, reg; 
		var s = obj.value;
		reg =/^[1][34578]\w*$/; //正则表达式模式。
		r = reg.test(s); 
		if(r){
			$(obj).addClass("validate[custom[mobile]]");
			$(obj).removeClass("validate[custom[phone2]]");
		}else{
			$(obj).addClass("validate[custom[phone2]]");
			$(obj).removeClass("validate[custom[mobile]]");
		}       
	}
</script>
</c:if>

	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" style="position: relative;"
		id="projForm">
		<input type="hidden" id="pageName" name="pageName" value="step1" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
		<font style="font-size: 14px; font-weight:bold;color: #333;">一、基本信息</font>
		<table class="basic" style="width: 100%; margin-top: 10px;" >
			<tr>
				<td style="text-align: right;">计划编号：</td>
				<td><input type="text" name="planNo" value="${resultMap.planNo}" class="inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td style="text-align: right;">项目名称：</td>
				<td><input type="text" name="projName" value="${empty resultMap.projName?proj.projName:resultMap.projName}" class="inputText borderNone" style="width: 80%" readonly="readonly"/></td>
			</tr>
			<tr>
           		<td style="text-align: right;">计划类别：</td>
				<td><input type="text" name="planCategory" value="${resultMap.planCategory}" class="inputText" style="width: 80%"/></td>
			</tr>
			<tr>
           		<td style="text-align: right;">起止年月：</td>
				<td>
					<input class="inputText borderNone" type="text" name="projStartTime" value="${empty resultMap.projStartTime?proj.projStartTime:resultMap.projStartTime}" readonly="readonly" style="width: 120px; margin-right: 0px;"/>
					~ <input class="inputText borderNone" type="text" name="projEndTime" value="${empty resultMap.projEndTime?proj.projEndTime:resultMap.projEndTime}" readonly="readonly" style="width: 120px;"/>
				</td>
			</tr>
			<tr>
           		<td style="text-align: right;">申请单位：</td>
				<td><input type="text" name="applyOrgName" value="${empty resultMap.applyOrgName?proj.applyOrgName:resultMap.applyOrgName}" class="inputText" style="width: 80%"/></td>
			</tr>
			<tr>
           		<td style="text-align: right;">申请验收形式：</td>
				<td><input type="text" name="applyCompleteShape" value="${resultMap.applyCompleteShape}" class="inputText" style="width: 80%"/></td>
			</tr>
			<tr>
           		<td style="text-align: right;">申请验收时间：</td>
				<td><input type="text" name="applyCompleteTime" value="${empty resultMap.applyCompleteTime?pdfn:getCurrDate():resultMap.applyCompleteTime}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputText ctime" style="width: 120px;" readonly="readonly"/></td>
			</tr>
			<tr>
           		<td style="text-align: right;">申请验收地点：</td>
				<td><input type="text" name="applyCompleteAddress" value="${resultMap.applyCompleteAddress}" class="inputText" style="width: 80%;"/></td>
			</tr>
			<tr>
           		<td style="text-align: right;">联系人及电话：</td>
				<td><input type="text" name="userNamePhone" value="${resultMap.userNamePhone}" class="inputText" style="width: 80%;"/></td>
			</tr>
		</table>
	</form>
	
	
    <c:if test="${param.view!=GlobalConstant.FLAG_Y}">
		<div align="center" style="margin-top: 10px">
		   <input id="nxt" type="button" onclick="nextOpt('step2')" class="search" value="下一步"/>
       	</div>
    </c:if>

		