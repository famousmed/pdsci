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
	<input type="hidden" id="pageName" name="pageName" value="step3"/>
	<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
	<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
	<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
	 
	<table  width="100%" cellspacing="0" cellpadding="0" class="basic">
        <tr>
		    <th style="text-align: left;padding-left: 15px;font-size: 14px">三、引进项目推广情况</th>	
		</tr>
        <tr>
            <td>
                     <c:choose>
                             <c:when test="${param.view==GlobalConstant.FLAG_Y}">
                                 ${resultMap.intro4}
                             </c:when>
                             <c:otherwise>
                              <textarea placeholder="引进项目推广情况" class="xltxtarea" name="intro4" style="height: 300px;">${resultMap.intro4}</textarea>
                             </c:otherwise>
                         </c:choose>
            </td>
        </tr>   
    </table>
</form>
<div class="button" style="width: 100%; <c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none</c:if>">
    <input id="prev" type="button" onclick="nextOpt('step2')" class="search" value="上一步"/>
    <input id="nxt" type="button" onclick="nextOpt('step4')" class="search" value="下一步"/>
</div>
