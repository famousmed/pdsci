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
	var flag = 1;
	var ues = ['technologicalProcess'];
	flag = checkImg(ues);
	if(flag){
		var form = $('#projForm');
		form.append('<input type="hidden" name="nextPageName" value="'+step+'"/>');
		$('#nxt').attr({"disabled":"disabled"});
		$('#prev').attr({"disabled":"disabled"});
		jboxStartLoading();
		form.submit();
	}
}
$(document).ready(function(){
	initUEditer("technologicalProcess");
});
</script>
</c:if>

 	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post"
		id="projForm" style="position: relative;">
		<input type="hidden" id="pageName" name="pageName" value="step3"/>
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
        <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" name="recTypeId" value="${param.recTypeId}"/>
                             
       	<table class="basic" style="width: 100%;margin-top: 10px;">
	        <tr>
	        	<th style="text-align: left;padding-left: 20px;font-weight:bold;">三、研究试验方法、技术路线以及工艺流程</th>
	        </tr>
	        <tr>
		     	<td style="text-align:left;padding-right: 10px;padding-top: 10px;padding-bottom: 10px;">
		     		<c:choose>
			    	    <c:when test="${param.view==GlobalConstant.FLAG_Y}">${resultMap.technologicalProcess}</c:when>
			    		<c:otherwise>
			    		    <script id="technologicalProcess" name="technologicalProcess" type="text/plain" style="width:100%;height:500px;margin-right: 10px;">${resultMap.technologicalProcess}</script>
			    		</c:otherwise>
			    	</c:choose>
		     	</td>
		    </tr>
	 	</table>
		 
       	<c:if test="${param.view != GlobalConstant.FLAG_Y}">
       	<div align="center" style="margin-top: 10px">
       	    <input id="prev" type="button" onclick="nextOpt('step2')" class="search" value="上一步"/>
       	    <input id="nxt" type="button" onclick="nextOpt('step4')" class="search" value="下一步"/>
       	</div>
       	</c:if>	          
	</form>

