<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:if test="${param.view != GlobalConstant.FLAG_Y}">
<script type="text/javascript">
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
						<input type="hidden" name="pageName" value="cooperationOrg"/>
						<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
                        <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
						<input type="hidden" name="recTypeId" value="${param.recTypeId}"/>
					 <table class="basic" style="width: 100%;margin-top: 10px;">
					 	<tr><th style="text-align: left;padding-left: 15px;font-size: 14px">十三、协作单位（科室）相关材料 </th></tr>
				        <tr>
					     	<td style="text-align:left;padding-left: 10px;padding-top: 10px;padding-bottom: 10px;">
					     	 <c:choose>
                               <c:when test="${param.view==GlobalConstant.FLAG_Y}">
                                 ${resultMap.assumeTask}
                             </c:when>
                               <c:otherwise>
					     		<textarea placeholder="概述协作单位（科室）承担的任务，限1000字。" style="width:98%; height:250px;" name="assumeTask" class="validate[maxSize[1000]]">${resultMap.assumeTask}</textarea>
					     	 </c:otherwise>
					     	 </c:choose>
					     	</td>
					    </tr>
					 </table>
					 </form>
					 				 
                	 <div class="button" style="width:100%;
                	 <c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none;</c:if>">
                	 	<input id="prev" type="button" onclick="nextOpt('laboratoryEquipment')" class="search" value="上一步"/>
                	    <input id="nxt" type="button" onclick="nextOpt('fundsBudget')" class="search" value="下一步"/>
      			     </div>
