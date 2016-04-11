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
	<input type="hidden" name="pageName" value="step3"/>
	<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
    <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
	<input type="hidden" name="recTypeId" value="${param.recTypeId}"/>
	<table width="100%" cellspacing="0" cellpadding="0" class="basic" style="margin-top: 10px;">
	    <tbody>
	        <tr>
			    <th style="text-align:left; padding-left: 15px;font-size: 14px;">三、项目进展情况</th>
			</tr>
	        <tr>
	            <td style="text-align:left; padding-left: 20px;">
	                <input type="radio" id="projDevelop1" class="inputText" name="projDevelop" value="1" 
			        <c:forEach var="op" items="${resultMap.projDevelop }">
			            <c:if test="${op eq 1}">checked="checked"</c:if>
			        </c:forEach>/>
			        <label for="projDevelop1">按计划进行</label>&#12288;
	             	<input type="radio" class="inputText" name="projDevelop" id="projDevelop2" value="2"  
			        <c:forEach var="op" items="${resultMap.projDevelop }">
			            <c:if test="${op eq 2}">checked="checked"</c:if>
			        </c:forEach>/>
			        <label for="projDevelop2">进度超前</label>&#12288;
	             	<input type="radio" class="inputText" name="projDevelop" id="projDevelop3" value="3"
	             	<c:forEach var="op" items="${resultMap.projDevelop }">
	             	    <c:if test="${op eq 3}">checked="checked"</c:if>
	             	</c:forEach>/>
	             	<label for="projDevelop3">进度滞后</label>&#12288;
	             </td>
	          </tr>
	          <tr>
	          	<td style="text-align: left;padding-top: 5px;padding-left: 10px;">
	          	    &nbsp;进度滞后原因说明：
	          		<c:choose>
                        <c:when test="${param.view==GlobalConstant.FLAG_Y}">
                            ${resultMap.planReason}
                        </c:when>
                        <c:otherwise>
	          		        <textarea placeholder="此处填写进度滞后原因" name="planReason" class="xltxtarea">${resultMap.planReason}</textarea>
	          	        </c:otherwise>
	          	    </c:choose>
	          	</td>
	          </tr>
	      </tbody>
	  </table>
</form>
<div class="button" style="width: 100%;
<c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none</c:if>">
    <input onclick="nextOpt('step2')" id="prev" class="search" type="button" value="上一步"/>
    <input onclick="nextOpt('step4')" id="nxt" class="search" type="button" value="下一步"/>
</div>


