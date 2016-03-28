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
	var ues = ['workingConditions2'];
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
	initUEditer("workingConditions2");
});

</script>
</c:if>
<style type="text/css">
 .bs_tb tbody td input{text-align: left;margin-left: 10px;}
</style>
<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" style="position: relative;">
    <input type="hidden" id="pageName" name="pageName" value="step5" /> 
	<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
	<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
	<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
	<div style="margin-bottom: 10px;">五、工作基础和条件</div>
	    <table width="100%" cellspacing="0" cellpadding="0" class="basic">
            <tr>
			    <th colspan="11" style="text-align: left;">&#12288;1、承担单位概况，拥有知识产权状况</th>
			</tr>
			<tr>
			    <td>
				    <c:choose>
			    	    <c:when test="${param.view==GlobalConstant.FLAG_Y}">${resultMap.workingConditions1}</c:when>
			    		<c:otherwise><textarea placeholder="此处填写该项目的承担单位概况，拥有知识产权状况" name="workingConditions1" class="validate[required] xltxtarea" style="height: 300px;">${resultMap.workingConditions1}</textarea></c:otherwise>
			    	</c:choose>
				</td>
			</tr>
			<tr>
			    <th colspan="11" style="text-align: left;">&#12288;2、本项目现有的研究工作基础</th>
			</tr>
			<tr>
			    <td style="text-align:left;padding-right: 10px;padding-top: 10px;padding-bottom: 10px;">
				    <c:choose>
			    	    <c:when test="${param.view==GlobalConstant.FLAG_Y}">${resultMap.workingConditions2}</c:when>
			    		<c:otherwise>
			    		    <script id="workingConditions2" name="workingConditions2" type="text/plain" style="width:100%;height:500px;margin-right: 10px;">${resultMap.workingConditions2}</script>
			    		</c:otherwise>
			    	</c:choose>
				</td>
			</tr>
			<tr>
			    <th colspan="11" style="text-align: left;">&#12288;3、项目负责人以往承担国家、省级、市级等各类科技计划项目完成情况</th>
			</tr>
			<tr>
			    <td>
				    <c:choose>
			    	    <c:when test="${param.view==GlobalConstant.FLAG_Y}">${resultMap.workingConditions3}</c:when>
			    		<c:otherwise><textarea placeholder="此处填写该项目的项目负责人以往承担国家、省级、市级等各类科技计划项目完成情况" name="workingConditions3" class="xltxtarea" style="height: 300px;">${resultMap.workingConditions3}</textarea></c:otherwise>
			    	</c:choose>
				</td>
			</tr>
			<tr>
			    <th colspan="11" style="text-align: left;">&#12288;4、项目实施具备的人才队伍、经费配套投入能力及科技服务管理能力</th>
			</tr>
			<tr>
			    <td>
				    <c:choose>
			    	    <c:when test="${param.view==GlobalConstant.FLAG_Y}">${resultMap.workingConditions4}</c:when>
			    		<c:otherwise><textarea placeholder="此处填写该项目实施具备的人才队伍、经费配套投入能力及科技服务管理能力" name="workingConditions4" class="xltxtarea" style="height: 300px;">${resultMap.workingConditions4}</textarea></c:otherwise>
			    	</c:choose>
				</td>
			</tr>
			<tr>
			    <th colspan="11" style="text-align: left;">&#12288;5、本项目实施可能存在的医疗安全风险及预防控制方案</th>
			</tr>
			<tr>
			    <td>
				    <c:choose>
			    	    <c:when test="${param.view==GlobalConstant.FLAG_Y}">${resultMap.workingConditions5}</c:when>
			    		<c:otherwise><textarea placeholder="此处填写该项目实施可能存在的医疗安全风险及预防控制方案" name="workingConditions5" class="xltxtarea" style="height: 300px;">${resultMap.workingConditions5}</textarea></c:otherwise>
			    	</c:choose>
				</td>
			</tr>
        </table>
       	<c:if test="${param.view!=GlobalConstant.FLAG_Y}">
       	<div align="center" style="margin-top: 10px">
       	    <input id="prev" type="button" onclick="nextOpt('step4')" class="search" value="上一步"/>
       	    <input id="nxt" type="button" onclick="nextOpt('step6')" class="search" value="下一步"/>
       	</div>
       	</c:if>
</form>
