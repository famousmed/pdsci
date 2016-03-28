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
	if(!UE.getEditor('according').hasContents()){
		$('#eromsg').html("不能为空");
		location.href = "#eromsg"; 
		return false;
	}
	var flag = 1;
	var ues = ['according' , 'researchContent'];
	flag = checkImg(ues);
	if(flag){
		var form = $('#projForm');
		form.append("<input name='nextPageName' value='"+step+"' type='hidden'/>");
		$('#nxt').attr({"disabled":"disabled"});
		$('#prev').attr({"disabled":"disabled"});
		jboxStartLoading();
		form.submit();
	}
	
}

$(document).ready(function(){
	var ue1 = initUEditer("according");
	var ue2 = initUEditer("researchContent");

   
    
});

</script>
</c:if>

<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" style="position: relative;">
    <input type="hidden" id="pageName" name="pageName" value="step2"/>
	<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
    <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
    <input type="hidden" name="recTypeId" value="${param.recTypeId}"/>
    <table class="basic" style="width: 100%;margin-top: 10px;">
	    <tr>
	        <th style="text-align: left;padding-left: 20px;font-weight:bold;">一、立项依据&nbsp;&nbsp;<a name="eromsg" id="eromsg" style="color: red;font-size: 10"></a></th>
	    </tr>
	    <tr>
		    <td style="text-align:left;padding-right: 10px;padding-top: 10px;padding-bottom: 10px;">
		     <c:choose>
			    		    <c:when test="${param.view==GlobalConstant.FLAG_Y}">${resultMap.according}</c:when>
			    			<c:otherwise>
			    			<script id="according" type="text/plain" name="according" style="width:100%;height:500px;padding-right: 10px;">${resultMap.according}</script>
			    			</c:otherwise>
			    		</c:choose>
		        
		     	</td>
		    </tr>
	 	</table>
	 	
       	<table class="basic" style="width: 100%;margin-top: 10px;">
	        <tr>
		        <th style="text-align: left;padding-left: 20px;font-weight:bold;">二、研究内容
		        </th>
	        </tr>
	        <tr>
		        <td style="text-align:left;padding-right: 10px;padding-top: 10px;padding-bottom: 10px;">
		     	    <c:choose>
			    		    <c:when test="${param.view==GlobalConstant.FLAG_Y}">${resultMap.researchContent}</c:when>
			    			<c:otherwise>
			    			    <script id="researchContent" type="text/plain" name="researchContent" style="width:100%;height:500px;margin-right: 10px;">${resultMap.researchContent}</script>
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
