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
	<input type="hidden" name="pageName" value="step5"/>
	<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
    <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
	<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
    <table width="100%" cellspacing="0" cellpadding="0" class="basic" style="margin-top: 10px;">
        <tbody>
            <tr>
		        <th style="text-align:left; padding-left: 15px;font-size: 14px;">五、执行情况</th>
		    </tr>
       	    <tr>
                <td>
         	        <c:choose>
                        <c:when test="${param.view==GlobalConstant.FLAG_Y}">
                            ${resultMap.report}
                        </c:when>
                        <c:otherwise>
            	            <textarea name="report" placeholder="(项目已开展研发工作，已取得的产出及效益，计划或已进行的科技成果转化情况，下一步计划，以及资金使用、项目进展过程中存在的问题、解决措施及有关建议，500字以内)" 
             				class="validate[requireds,maxSize[500]] xltxtarea " style="height: 200px;width: 98%;">${resultMap.report}</textarea>
             	        </c:otherwise>
         	        </c:choose>
         	    </td>
            </tr>
        </tbody>
    </table>
</form>
<div class="button" style="width: 100%;
 <c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none</c:if>">
     <input onclick="nextOpt('step4')" id="prev" class="search" type="button" value="上一步"/>
     <input onclick="nextOpt('file')" id="nxt" class="search" type="button" value="下一步"/>
</div>
