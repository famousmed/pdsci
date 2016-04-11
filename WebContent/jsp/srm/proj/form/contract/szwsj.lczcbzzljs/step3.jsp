<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<c:if test="${param.view != GlobalConstant.FLAG_Y}">
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="ueditor" value="true"/>
</jsp:include>
<script type="text/javascript">
function nextOpt(step){
	if(false==$("#projForm").validationEngine("validate")){
		return false;
	}
	var form = $("#projForm");
	form.append('<input type="hidden" name="nextPageName" value="'+step+'"/>');
	$('#nxt').attr({"disabled":"disabled"});
	$('#prev').attr({"disabled":"disabled"});
	jboxStartLoading();
	form.submit();
}
</script>
</c:if>
<style type="text/css">
.title_sp{padding-left: 10px;font-size: 14px; margin-bottom:10px; font-weight: bold;color: #333;}
</style>
<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" style="position: relative;">
    <input type="hidden" id="pageName" name="pageName" value="step3"/>
	<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
	<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
	<input type="hidden" name="recTypeId" value="${param.recTypeId}"/>
	<table width="100%" cellspacing="0" cellpadding="0" class="basic">
	    <tr>
		    <th colspan="11" style="text-align: left;padding-left: 15px;font-size: 14px; font-weight:bold;">三、计划进度（项目总期限，进度及分年度计划）<span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span></th>
		</tr>
		<tr>
		    <td>
		    <c:choose>
               <c:when test="${param.view==GlobalConstant.FLAG_Y}">
                ${resultMap.planSchedule}
               </c:when>
             <c:otherwise>
		    <textarea placeholder="此处填写该项目的计划进度（包括项目总期限，进度及分年度计划）" name="planSchedule" class="validate[required] xltxtarea" style="height: 300px;">${resultMap.planSchedule}</textarea>
		    </c:otherwise>
		    </c:choose>
		    </td>
		</tr>
	</table>
	<c:if test="${param.view != GlobalConstant.FLAG_Y}">
	    <div align="center" style="margin-top: 10px; width: 100%">
	        <input id="prev" type="button" onclick="nextOpt('step2')" class="search" value="上一步"/>
        	 <input id="nxt" type="button" onclick="nextOpt('step4')" class="search" value="下一步"/>
	    </div>
	</c:if>
</form>
