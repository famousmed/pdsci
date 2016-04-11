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
		var ues = ['approveGist1','approveGist2','approveGist4'];
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
		initUEditer("approveGist1");
		initUEditer("approveGist2");
		initUEditer("approveGist4");
	});
</script>
</c:if>
<style type="text/css">
 .bs_tb tbody td input{text-align: left;margin-left: 10px;}
</style>
	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post"
		id="projForm" style="position: relative;">
		<input type="hidden" id="pageName" name="pageName" value="step2" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
		
		<div style="margin-bottom: 10px;">二、立项依据</div>
	        <table width="100%" cellspacing="0" cellpadding="0" class="basic">
			    <tr>
				    <th colspan="11" style="text-align: left;">&#12288;1、本项目国内外科技创新发展概况和最新发展趋势</th>
				</tr>
				<tr>
				    <td style="text-align:left;padding-right: 10px;padding-top: 10px;padding-bottom: 10px;">
					    <c:choose>
				    	    <c:when test="${param.view==GlobalConstant.FLAG_Y}">${resultMap.approveGist1}</c:when>
				    	    <c:otherwise>
				    		    <script id="approveGist1" type="text/plain" name="approveGist1"  style="width:100%;height:500px;margin-right: 10px;">${resultMap.approveGist1}</script>
				    		</c:otherwise> 
			    		</c:choose>
			        </td>
				</tr>
				<tr>
				    <th colspan="11"  style="text-align: left;">&#12288;2、本项目研究的目的、意义</th>
				</tr>
				<tr>
				    <td style="text-align:left;padding-right: 10px;padding-top: 10px;padding-bottom: 10px;">
					    <c:choose>
			    		    <c:when test="${param.view==GlobalConstant.FLAG_Y}">${resultMap.approveGist2}</c:when>
			    			<c:otherwise>
			    			    <script id="approveGist2" type="text/plain" name="approveGist2" style="width:100%;height:400px;margin-right: 10px;">${resultMap.approveGist2}</script>
			    			</c:otherwise>
			    		</c:choose>
					</td>
				</tr>
				<tr>
					<th colspan="11" style="text-align: left;">&#12288;3、本项目研究现有起点科技水平及已存在的知识产权情况</th>
				</tr>
				<tr>
				    <td>
					    <c:choose>
    				        <c:when test="${param.view==GlobalConstant.FLAG_Y}">${resultMap.approveGist3}</c:when>
    				        <c:otherwise><textarea placeholder="此处填写该项目的研究现有起点科技水平及已存在的知识产权情况" name="approveGist3" class="validate[required] xltxtarea" style="height: 200px;">${resultMap.approveGist3}</textarea></c:otherwise>
    			        </c:choose>
					</td>
				</tr>
				<tr>
					<th colspan="11" style="text-align: left;">&#12288;4、本项目研究国内外竞争情况及行业发展前景</th>
				</tr>
				<tr>
					<td style="text-align:left;padding-right: 10px;padding-top: 10px;padding-bottom: 10px;">
					    <c:choose>
    				        <c:when test="${param.view==GlobalConstant.FLAG_Y}">${resultMap.approveGist4}</c:when>
    				        <c:otherwise>
    				            <script id="approveGist4" type="text/plain" name="approveGist4" style="width:100%;height:400px;margin-right: 10px;">${resultMap.approveGist4}</script>
    				        </c:otherwise>
    			        </c:choose>
					</td>
				</tr>
			</table>
        	<c:if test="${param.view!=GlobalConstant.FLAG_Y}">
        	<div align="center" style="margin-top: 10px">
        	    <input id="prev" type="button" onclick="nextOpt('step1')" class="search" value="上一步"/>
        	    <input id="nxt" type="button" onclick="nextOpt('step3')" class="search" value="下一步"/>
        	</div>
        	</c:if>
	</form>
