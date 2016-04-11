<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ztree" value="true"/>
</jsp:include>

<c:if test="${param.view != GlobalConstant.FLAG_Y}">
<script type="text/javascript">
	function nextOpt(step){
		if(false==$("#projForm").validationEngine("validate")){
			return false;
		}
		var form = $('#projForm');
		var action = form.attr('action');
		action+="?nextPageName="+step;
		form.attr("action" , action);
		form.submit();
	}
</script>
</c:if>
<style>
	.xltxtarea{height: 200px;}
</style>
	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" style="position: relative;"
		id="projForm">
		<input type="hidden" id="pageName" name="pageName" value="step3" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
		 
		<font style="font-size: 14px; font-weight:bold;color: #333;">三、工作业绩</font>

		 <table width="100%" class="bs_tb" style="margin-top: 20px;">
		 	<tr>
				<th class="theader" style="text-align: left;padding-left: 20px;">八、参加国内外进修培训及学术交流情况</th>
			</tr>
			<tr>
		     	<td style="text-align:left;">
		     		<textarea placeholder="时间、地点、内容"  class="xltxtarea" name="trainAcademicCondition">${resultMap.trainAcademicCondition}</textarea>
		     	</td>
		    </tr>
		 </table>
		 
		 
		 <table width="100%" class="bs_tb" style="margin-top: 20px;">
		 	<tr>
				<th class="theader" style="text-align: left;padding-left: 20px;">九、目前主持的科研项目（项目名称、项目来源、起始时间、研究主要内容）</th>
			</tr>
			<tr>
		     	<td style="text-align:left;">
		     		<textarea placeholder=""  class="xltxtarea" name="hostProj">${resultMap.hostProj}</textarea>
		     	</td>
		    </tr>
		 </table>
		 
		 
		 <table width="100%" class="bs_tb" style="margin-top: 20px;">
		 	<tr>
				<th class="theader" style="text-align: left;padding-left: 20px;">十、近五年来工作业绩（业务技术水平、临床带教、对单位贡献、有无医疗事故及医疗损害案件等，300字）</th>
			</tr>
			<tr>
		     	<td style="text-align:left;">
		     		<textarea placeholder=""  class="xltxtarea" name="achievement">${resultMap.achievement}</textarea>
		     	</td>
		    </tr>
		 </table>
	</form>
	
	
    <c:if test="${param.view!=GlobalConstant.FLAG_Y}">
		<div align="center" style="margin-top: 10px">
		    <input id="prev" type="button" onclick="nextOpt('step2')" class="search" value="上一步"/>
     	    <input id="nxt" type="button" onclick="nextOpt('finish')" class="search" value="完&#12288;成"/>
       	</div>
    </c:if>
		