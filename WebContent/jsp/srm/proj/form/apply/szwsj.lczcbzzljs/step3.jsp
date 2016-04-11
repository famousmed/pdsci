<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:if test="${param.view!=GlobalConstant.FLAG_Y}">
	<jsp:include page="/jsp/common/htmlhead.jsp">
		<jsp:param name="ueditor" value="true"/>
	</jsp:include>
	
<script type="text/javascript">
function nextOpt(step){
	if(false==$("#projForm").validationEngine("validate")){
			return false;
		}
	var flag = 1;
	var ues = ['researchContent1','researchContent2','researchContent3'];
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
		initUEditer("researchContent1");
		initUEditer("researchContent2");
		initUEditer("researchContent3");
	});
	
</script>
</c:if>
<style type="text/css">
 .bs_tb tbody td input{text-align: left;margin-left: 10px;}
</style>
<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" style="position: relative;">
    <input type="hidden" id="pageName" name="pageName" value="step3" /> 
    <input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
	<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
	<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
	<div style="margin-bottom: 10px;">三、研究内容</div>
        <table width="100%" cellspacing="0" cellpadding="0" class="basic">
	        <tr>
			    <th colspan="11" style="text-align: left;">&#12288;1、具体研究开发内容和要重点解决的关键技术问题</th>
			</tr>
			<tr>
			    <td style="text-align:left;padding-right: 10px;padding-top: 10px;padding-bottom: 10px;">
				    <c:choose>
			    	    <c:when test="${param.view==GlobalConstant.FLAG_Y}">${resultMap.researchContent1}</c:when>
			    	    <c:otherwise>
			    		    <script id="researchContent1" name="researchContent1" type="text/plain" style="width:100%;height:500px;margin-right: 10px;">${resultMap.researchContent1}</script>
			    		</c:otherwise>
			    	</c:choose>
				</td>
			</tr>
			<tr>
			    <th colspan="11" style="text-align: left;">&#12288;2、项目的特色和创新之处</th>
			</tr>
			<tr>
			    <td style="text-align:left;padding-right: 10px;padding-top: 10px;padding-bottom: 10px;">
				    <c:choose>
			    	    <c:when test="${param.view==GlobalConstant.FLAG_Y}">${resultMap.researchContent2}</c:when>
			    		<c:otherwise>
			    		    <script id="researchContent2" name="researchContent2" type="text/plain" style="width:100%;height:500px;margin-right: 10px;">${resultMap.researchContent2}</script>
			    		</c:otherwise>
			    	</c:choose>
				</td>
			</tr>
			<tr>
			    <th colspan="11" style="text-align: left;">&#12288;3、要达到的主要技术、经济指标及社会、经济效益</th>
			</tr>
			<tr>
			    <td style="text-align:left;padding-right: 10px;padding-top: 10px;padding-bottom: 10px;">
				    <c:choose>
			    	    <c:when test="${param.view==GlobalConstant.FLAG_Y}">${resultMap.researchContent3}</c:when>
			    		<c:otherwise>
			    		    <script id="researchContent3" name="researchContent3" type="text/plain" style="width:100%;height:500px;margin-right: 10px;">${resultMap.researchContent3}</script>
			    		</c:otherwise>
			    	</c:choose>
				</td>
			</tr>
        </table>
       	<c:if test="${param.view!=GlobalConstant.FLAG_Y}">
       	<div align="center" style="margin-top: 10px">
       	    <input id="prev" type="button" onclick="nextOpt('step2')" class="search" value="上一步"/>
       	    <input id="nxt" type="button" onclick="nextOpt('step4')" class="search" value="下一步"/>
       	</div>
       	</c:if>
		
</form>
