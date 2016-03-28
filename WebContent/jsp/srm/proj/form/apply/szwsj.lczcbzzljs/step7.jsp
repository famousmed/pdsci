 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:if test="${param.view != GlobalConstant.FLAG_Y}">
<script type="text/javascript">
function nextOpt(step){
	if(false==$("#projForm").validationEngine("validate")){
			return false;
		}
	var form = $('#projForm');
	form.append("<input name='nextPageName' value='"+step+"' type='hidden'/>");
	$('#nxt').attr({"disabled":"disabled"});
	$('#prev').attr({"disabled":"disabled"});
	jboxStartLoading();
	form.submit();
}

	function addPlanSchedule(tb){
		$('#'+tb).append($('#'+tb+"_model").html());
	}
	function delTr(tb){
		var trs = $('#'+tb).find(':checkbox:checked');
		if(trs.length==0){
			jboxTip("请勾选要删除的！");
			return false;
		}
		jboxConfirm("确认删除？" , function(){
			$.each(trs , function(i , n){
				$(n).parent('td').parent("tr").remove();
				
			});
			
		});
	}
</script>
</c:if>
<style type="text/css">
 .bs_tb tbody td input{text-align: left;margin-left: 10px;}
</style>
<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" style="position: relative;">
    <input type="hidden" id="pageName" name="pageName" value="step7" /> 
	<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
	<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
	<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
	<div style="margin-bottom: 10px;">七、计划进度安排与考核指标<span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span></div>
	    <table width="100%" cellspacing="0" cellpadding="0" class="basic">
		    <tr>
		        <th width="50px" style="text-align: center">序号</th>
			    <th width="300px" style="text-align: center">工作进度</th>
			    <th style="text-align: center">主要工作内容 <c:if test="${param.view!=GlobalConstant.FLAG_Y}"><span style="float: right;padding-right: 10px"><a href="javascript:void(0)"><img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addPlanSchedule('planScheduleTb');"></img></a>&nbsp;<a href="javascript:void(0)"><img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('planScheduleTb')"></img></a></span></c:if></th>
			</tr>
			<tbody id="planScheduleTb" class="bs_tb">
		        <c:choose>
				    <c:when test="${param.view==GlobalConstant.FLAG_Y}">
					    <c:forEach var="plan" items="${resultMap.planSchedule}" varStatus="num">
						    <tr>
							    <td>${num.count }</td>
								<td>${plan.objMap.planSchedule_startDate}~${plan.objMap.planSchedule_endDate}</td>
								<td>${plan.objMap.planSchedule_content}</td>
							</tr>
			      		</c:forEach>
					</c:when>
					<c:otherwise>
					    <c:if test="${not empty resultMap.planSchedule}">
				      	    <c:forEach var="plan" items="${resultMap.planSchedule}" varStatus="num">
							    <tr>
								    <td><input type="checkbox"/></td>
									<td><input type="text"  name="planSchedule_startDate" value="${plan.objMap.planSchedule_startDate}" class="inputText validate[required]" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width: 100px;"/>~&#12288;
									    <input type="text"  name="planSchedule_endDate" value="${plan.objMap.planSchedule_endDate}" class="inputText validate[required]" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width: 100px;"/></td>
									<td><input type="text" style="width:90%" class="inputText validate[required]" name="planSchedule_content" value="${plan.objMap.planSchedule_content}" class="inputText"/></td>
								</tr>
				      		</c:forEach>
				      	</c:if>
				      	<c:if test="${empty resultMap.planSchedule}">
				      	    <tr>
							    <td><input type="checkbox"/></td>
								<td><input type="text"  name="planSchedule_startDate"  class="inputText validate[required]" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width: 100px;"/>~&#12288;
								    <input type="text"  name="planSchedule_endDate"  class="inputText validate[required]" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width: 100px;"/></td>
								<td><input type="text" style="width:90%" class="inputText validate[required]" name="planSchedule_content" /></td>
							</tr>
				      	</c:if>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
       	<table width="100%" cellspacing="0" cellpadding="0" class="basic" style="margin-top: 10px;">
       		<tr>
				<th colspan="11" style="text-align: left;">&#12288;项目完成后主要考核指标<span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span></th>
			</tr>
			<tr>
				<td>
				<c:choose>
    				<c:when test="${param.view==GlobalConstant.FLAG_Y}">${resultMap.target}</c:when>
    				<c:otherwise><textarea placeholder="此处填写该项目完成后主要考核指标" name="target"  class="validate[required] xltxtarea" style="height: 300px;">${resultMap.target}</textarea></c:otherwise>
    			</c:choose>
				</td>
			</tr>
       	</table>
       	<c:if test="${param.view!=GlobalConstant.FLAG_Y}">
       	<div align="center" style="margin-top: 10px">
       	    <input id="prev" type="button" onclick="nextOpt('step6')" class="search" value="上一步"/>
       	    <input id="nxt" type="button" onclick="nextOpt('step8')" class="search" value="下一步"/>
       	</div>
       	</c:if>
</form>
<div style="display: none;">
	<table>
		<tbody id="planScheduleTb_model">
			<tr>
				<td><input type="checkbox"/></td>
				<td><input type="text"  name="planSchedule_startDate"  class="inputText" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width: 100px;"/>~&#12288;
				    <input type="text"  name="planSchedule_endDate"  class="inputText" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width: 100px;"/></td>
				<td><input type="text"  class="inputText" style="width:90%" name="planSchedule_content" /></td>
			</tr>
		</tbody>
	</table>
</div>
