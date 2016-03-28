<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	var ues = ['intro1' , 'intro2' , 'intro3'];
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
	initUEditer("intro1");
	initUEditer("intro2");
	initUEditer("intro3");
});

</script>
</c:if>

<div style="margin-top: 10px;">
<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" style="position: relative;">
	<input type="hidden" id="pageName" name="pageName" value="step2"/>
	<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
	<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
	<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
	 <div style="margin-bottom: 10px; font-weight:bold;">二、项目简介</div>
	 <table  width="100%"  class="basic">
            	  <tr>
		  	         <th style="text-align: left;padding-left: 20px;">技术指标<span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span></th>	
		          </tr>
                  <tr>
                     <td style="text-align:left;padding-right: 10px;padding-top: 10px;padding-bottom: 10px;">
                         <c:choose>
                             <c:when test="${param.view==GlobalConstant.FLAG_Y}">
                                 ${resultMap.intro1}
                             </c:when>
                             <c:otherwise>
                                 <script id="intro1" name="intro1" type="text/plain" style="width:100%;height:500px;margin-right: 10px;">${resultMap.intro1}</script>
                             </c:otherwise>
                         </c:choose>
                     </td>
                  </tr>
            	  <tr>
		  	         <th style="text-align: left;padding-left: 20px;">经济指标<span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span></th>	
		          </tr>
                  <tr>
                        <td style="text-align:left;padding-right: 10px;padding-top: 10px;padding-bottom: 10px;">
                        
                            <c:choose>
                            	<c:when test="${param.view==GlobalConstant.FLAG_Y}">
                            	    ${resultMap.intro2}
                            	</c:when>
                            	<c:otherwise>
                        		    <script id="intro2" name="intro2" type="text/plain" style="width:100%;height:300px;margin-right: 10px;">${resultMap.intro2}</script>
                            	</c:otherwise>
                            </c:choose>
                        </td>
                  </tr>
        	      <tr>
		  	         <th style="text-align: left;padding-left: 20px;">主要技术改进</th>	
		          </tr>
            	  <tr>
                        <td style="text-align:left;padding-right: 10px;padding-top: 10px;padding-bottom: 10px;">
                        	<c:choose>
                        	    <c:when test="${param.view==GlobalConstant.FLAG_Y}">
                        	        ${resultMap.intro3}
                        	    </c:when>
                        	    <c:otherwise>
                        		    <script id="intro3" name="intro3" type="text/plain" style="width:100%;height:500px;margin-right: 10px;">${resultMap.intro3}</script>    
                        	    </c:otherwise>
                        	</c:choose>
                        </td>
                  </tr>
             </table>
   
</form>
</div>
<div class="button" style="width: 100%; <c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none</c:if>">
    <input id="prev" type="button" onclick="nextOpt('step1')" class="search" value="上一步"/>
    <input id="nxt" type="button" onclick="nextOpt('step3')" class="search" value="下一步"/>
</div>

