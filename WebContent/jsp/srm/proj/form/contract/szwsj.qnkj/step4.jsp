<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<c:if test="${param.view != GlobalConstant.FLAG_Y}">
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="ueditor" value="true"/>
</jsp:include>
<script type="text/javascript">
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
function nextOpt(step){
	if(false==$("#projForm").validationEngine("validate")){
		return false;
	}
    var form = $('#projForm');
    form.append('<input type="hidden" name="nextPageName" value="'+step+'"/>');
    $('#nxt').attr({"disabled":"disabled"});
    $('#prev').attr({"disabled":"disabled"});
    jboxStartLoading();
    form.submit();
}
</script>
</c:if>

<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" style="position: relative;">
    <input type="hidden" id="pageName" name="pageName" value="step4"/>
	<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
	<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
	<input type="hidden" name="recTypeId" value="${param.recTypeId}"/>
	<table width="100%" cellspacing="0" cellpadding="0" class="bs_tb" id="table3">
	    <tr>
		    <th colspan="3" style="text-align: left;padding-left: 15px;font-size:14px;" class="theader">四、项目进度计划与考核指标<span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span><c:if test="${param.view != GlobalConstant.FLAG_Y}"><span style="float: right;padding-right: 10px"><img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addPlanSchedule('planScheduleTb');"></img>&nbsp;<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('planScheduleTb')"></img></span></c:if></th>
		</tr>
		<tr>
		    <td width="50px">序号</td>
			<td width="300px">阶段</td>
			<td>项目进度计划于考核指标</td>
		</tr>
		<tbody id="planScheduleTb">
		    
		       <c:if test="${not empty resultMap.planScheduleAndTarget}">
		         <c:choose>
                   <c:when test="${param.view == GlobalConstant.FLAG_Y}">
                      <c:forEach var="plan" items="${resultMap.planScheduleAndTarget}" varStatus="num">
				        <tr>
					    <td>${num.count }</td>
						<td>${plan.objMap.planScheduleAndTarget_schedule}</td>
						<td>${plan.objMap.planScheduleAndTarget_content}</td>
					    </tr>
	      		      </c:forEach>
                   </c:when>
                   <c:otherwise>
	      	        <c:forEach var="plan" items="${resultMap.planScheduleAndTarget}" varStatus="num">
				    <tr>
					    <td><input type="checkbox"/></td>
						<td><input type="text" class='inputText validate[required]'  name="planScheduleAndTarget_schedule" value="${plan.objMap.planScheduleAndTarget_schedule}" style="width: 200px;"/></td>
						<td><input type="text" class='inputText validate[required]' style="width:90%" name="planScheduleAndTarget_content" value="${plan.objMap.planScheduleAndTarget_content}"/></td>
					</tr>
	      		  </c:forEach>
	      		</c:otherwise>
	      	    </c:choose>
	      	   </c:if>
	      	
	      	<c:if test="${empty resultMap.planScheduleAndTarget and param.view != GlobalConstant.FLAG_Y}">
	      	    <tr>
				    <td><input type="checkbox"/></td>
					<td><input type="text" class='inputText validate[required]' name="planScheduleAndTarget_schedule" style="width: 200px;"/></td>
				    <td><input type="text" class='inputText validate[required]' style="width:90%" name="planScheduleAndTarget_content" /></td>
				</tr>
	      	</c:if>
		</tbody>
	</table>
	<c:if test="${param.view != GlobalConstant.FLAG_Y}">
	    <div align="center" style="margin-top: 10px">
	         <input id="prev" type="button" onclick="nextOpt('step3')" class="search" value="上一步"/>
        	 <input id="nxt" type="button" onclick="nextOpt('step5')" class="search" value="下一步"/>
		</div>
	</c:if>
</form>
<c:if test="${param.view != GlobalConstant.FLAG_Y}">
    <div style="display: none;">
        <table>
		    <tbody id="planScheduleTb_model">
			    <tr>
			        <td><input type="checkbox"/></td>
					<td><input type="text" name="planScheduleAndTarget_schedule" class='inputText validate[required]' style="width: 200px;"/></td>
					<td><input type="text" class='inputText validate[required]' style="width:90%" name="planScheduleAndTarget_content" /></td>
				</tr>
			</tbody>
		</table>
	</div>
</c:if>
