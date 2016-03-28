<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
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

$(document).ready(function(){
	//initUEditer("targetAndContent2");
});
</script>
</c:if>
<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" style="position: relative;">
    <input type="hidden" id="pageName" name="pageName" value="step2"/>
	<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
	<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
    <input type="hidden" name="recTypeId" value="${param.recTypeId}"/>
	<div class="title_sp">二、项目的目标和主要研究内容</div>
	    <table width="100%" cellspacing="0" cellpadding="0" class="basic">
	        <tr>
			    <th colspan="11" style="text-align: left;padding-left: 15px;">项目的目标、任务<span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span></th>
			</tr>
			<tr>
			    <td>
				    <c:choose>
					    <c:when test="${param.view == GlobalConstant.FLAG_Y}">
						    ${resultMap.targetAndContent1}      
						</c:when>
					    <c:otherwise>
						    <textarea  placeholder="此处填写该项目的目标和任务" name="targetAndContent1" class="validate[required] xltxtarea" style="height: 300px;">${resultMap.targetAndContent1}</textarea>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
			    <th colspan="11" style="text-align: left;padding-left: 15px;">项目研发内容和创新点<span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span></th>
			</tr>
			<tr>
			    <td>
				    <c:choose>
					    <c:when test="${param.view == GlobalConstant.FLAG_Y}">
						    ${resultMap.targetAndContent2}
						</c:when>
					    <c:otherwise>
						    <textarea  placeholder="项目研发内容和创新点" id="targetAndContent2" name="targetAndContent2" class="validate[required] xltxtarea" style="height: 300px;">${resultMap.targetAndContent2}</textarea>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</table>
	    <c:if test="${param.view != GlobalConstant.FLAG_Y}">
	        <div align="center" style="margin-top: 10px">
			     <input id="prev" type="button" onclick="nextOpt('step1')" class="search" value="上一步"/>
        	    <input id="nxt" type="button" onclick="nextOpt('step3')" class="search" value="下一步"/>
			</div>
		</c:if>
</form>
