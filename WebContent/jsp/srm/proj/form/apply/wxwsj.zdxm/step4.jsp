<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:if test="${param.view!=GlobalConstant.FLAG_Y}">
<script type="text/javascript">
	$(document).ready(function(){
		if($("#yptTb tr").length<=0){
			add('ypt');
		}
	});
	
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
	
	function add(tb){
	 	$("#"+tb+"Tb").append($("#"+tb+"Template tr:eq(0)").clone());
	 	
	 	var length = $("#"+tb+"Tb").children().length;
	 	//序号
		$("#"+tb+"Tb").children("tr").last().children("td").eq(1).text(length);
	}
	
	function delTr(tb){
		//alert("input[name="+tb+"Ids]:checked");
		var checkboxs = $("input[name='"+tb+"Ids']:checked");
		if(checkboxs.length==0){
			jboxTip("请勾选要删除的！");
			return false;
		}
		jboxConfirm("确认删除?",function () {
			var trs = $('#'+tb+'Tb').find(':checkbox:checked');
			$.each(trs , function(i , n){
				$(n).parent('td').parent("tr").remove();
			});
			//删除后序号
			var serial = 0;
			$("."+tb+"Serial").each(function(){
				serial += 1;
				$(this).text(serial);
			});
		});
	}
</script>
</c:if>

	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" style="position: relative;"
		id="projForm">
		<input type="hidden" id="pageName" name="pageName" value="step4" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
		
		
		<font style="font-size: 14px; font-weight:bold;color: #333; ">四、年度计划及年度目标、工作条件和环境保障</font>
		<table class="bs_tb" style="width: 100%;margin-top: 10px; border-bottom-style: none;">
			<tr>
				<th colspan="10" class="theader">年度计划及年度目标
					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
					<span style="float: right;padding-right: 10px">
					<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('ypt')"></img>&#12288;
					<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('ypt');"></img></span>
					</c:if>
				</th>
			</tr>
			<tr>
				<td width="4%"></td>
				<td width="5%">序号</td>
				<td width="20%">年度</td>
				<td width="70%">年度计划及年度目标（按半年度划分工作节点，要求明确关键的、必须实现的节点目标）</td>
			</tr>
			<tbody id="yptTb">
			<c:if test="${not empty resultMap.yearPlanTarget}">
				<c:forEach var="rpt" items="${resultMap.yearPlanTarget}" varStatus="status">
				<tr>
		             <td width="4%" style="text-align: center;"><input name="yptIds" type="checkbox"/></td>
		             <td width="5%" style="text-align: center;" class="yptSerial">${status.count}</td>
		             <td>
		             	 <input class="inputText ctime" type="text" name="yearPlanTarget_startYear" value="${rpt.objMap.yearPlanTarget_startYear}" onclick="WdatePicker({dateFmt:'yyyy-MM'})" readonly="readonly" style="width: 70px; margin-right: 0px;text-align:left;"/>
		             	 ~<input class="inputText ctime" type="text" name="yearPlanTarget_endYear" value="${rpt.objMap.yearPlanTarget_endYear}" onclick="WdatePicker({dateFmt:'yyyy-MM'})" readonly="readonly" style="width: 70px;text-align:left;"/>
		             </td>
		             <td style="text-align:left;">
			     		 <textarea placeholder="" class="validate[maxSize[1000]] xltxtarea"  name="yearPlanTarget_planTarget">${rpt.objMap.yearPlanTarget_planTarget}</textarea>
			     	 </td>
				</tr>
			    </c:forEach>
	    	</c:if>
			</tbody>
			<tr>
				<td colspan="4" style="text-align: left;">
					&#12288;本项目应于<input class="inputText ctime" type="text" name="endSubjectDate" value="${resultMap.endSubjectDate}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width: 120px;margin: 0px;"/>前结题。
				</td>
			</tr>
		</table>
		
		 <table class="basic" style="width: 100%;margin-top: 10px;">
			<tr>
				<th style="text-align: left;padding-left: 20px;">工作条件和环境保障</th>
			</tr>          
			<tr>
				<td style="text-align:left;">
		     		<textarea placeholder="申请单位情况；已具备的实验条件；已做的工作基础；组织机制设计；保障和加快工作进展的设想等。" style="height: 300px;" class="xltxtarea"  name="workConditionEnvironment">${resultMap.workConditionEnvironment}</textarea>
		     	</td>
			</tr>
		 </table>
	</form>
	
	<!-------------------------------------------------------------------------------------------------------->
		
	<div style="display: none">
		<!-- 模板 -->
		<table class="basic" id="yptTemplate" style="width: 100%">
        <tr>
             <td width="4%" style="text-align: center;"><input name="yptIds" type="checkbox"/></td>
             <td width="5%" style="text-align: center;" class="yptSerial"></td>
             <td>
             	 <input class="inputText ctime" type="text" name="yearPlanTarget_startYear" onclick="WdatePicker({dateFmt:'yyyy-MM'})" readonly="readonly" style="width: 70px; margin-right: 0px;text-align:left;"/>
             	 ~<input class="inputText ctime" type="text" name="yearPlanTarget_endYear" onclick="WdatePicker({dateFmt:'yyyy-MM'})" readonly="readonly" style="width: 70px;text-align:left;"/>
             </td>
             <td style="text-align:left;">
	     		 <textarea placeholder="" class="validate[maxSize[1000]] xltxtarea"  name="yearPlanTarget_planTarget"></textarea>
	     	 </td>
		</tr>
		</table>
	</div>	
		
   	<c:if test="${param.view!=GlobalConstant.FLAG_Y}">
		<div align="center" style="margin-top: 10px">
		    <input id="prev" type="button" onclick="nextOpt('step3')" class="search" value="上一步"/>
		    <input id="nxt" type="button" onclick="nextOpt('step5')" class="search" value="下一步"/>
       	</div>
    </c:if>

		