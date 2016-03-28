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

</script>
</c:if>
<style type="text/css">
 .bs_tb tbody td input{text-align: left;margin-left: 10px;}
</style>
<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" style="position: relative;">
    <input type="hidden" id="pageName" name="pageName" value="step6" /> 
	<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
	<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
	<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
	<table width="100%" cellspacing="0" cellpadding="0" class="basic">
	    <tr>
		    <th colspan="11" style="text-align: left;padding-left: 20px;font-size: 14px;">六、项目研究预期成果及效益</th>
		</tr>
	    <tr>
		    <td>
			    <c:choose>
			        <c:when test="${param.view==GlobalConstant.FLAG_Y}">${resultMap.expectAchievement}</c:when>
			    	<c:otherwise><textarea placeholder="此处填写该项目的研究预期成果及效益" name="expectAchievement"  class="validate[required] xltxtarea" style="height: 300px;">${resultMap.expectAchievement}</textarea></c:otherwise>
			    </c:choose>
			</td>
		</tr>
	</table>
   	<c:if test="${param.view!=GlobalConstant.FLAG_Y}">
   	<div align="center" style="margin-top: 10px">
   	    <input id="prev" type="button" onclick="nextOpt('step5')" class="search" value="上一步"/>
   	    <input id="nxt" type="button" onclick="nextOpt('step7')" class="search" value="下一步"/>
   	</div>
   	</c:if>
</form>
