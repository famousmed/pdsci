<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:if test="${param.view!=GlobalConstant.FLAG_Y}">
<script type="text/javascript">
	$(document).ready(function(){
		if($("#schTb tr").length<=0){
			add('sch');
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
		<input type="hidden" id="pageName" name="pageName" value="step2" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>

		<font style="font-size: 14px; font-weight:bold;color: #333; ">三、项目进度及考核指标</font>
		<table class="bs_tb" style="width: 100%;margin-top: 10px; border-bottom-style: none;">
			<tr>
				<th colspan="10" class="theader">项目进度及考核指标
					<%-- <c:if test="${param.view!=GlobalConstant.FLAG_Y }">
					<span style="float: right;padding-right: 10px">
					<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('sch')"></img>&#12288;
					<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('sch');"></img></span>
					</c:if> --%>
				</th>
			</tr>
			<tr>
				<!-- <td width="4%"></td> -->
				<td width="5%">序号</td>
				<td width="23%">时间</td>
				<td width="67%">考核指标</td>
			</tr>
			<tbody id="schTb">
	    	<c:if test="${not empty resultMap.scheduleExamineNorm}">
				<c:forEach var="sch" items="${resultMap.scheduleExamineNorm}" varStatus="status">
				<tr>
		             <td width="5%" style="text-align: center;" class="schSerial">${status.count}</td>
		             <td>
		             	 <input class="inputText ctime" type="text" name="scheduleExamineNorm_startDate" value="${sch.objMap.scheduleExamineNorm_startDate}" readonly="readonly" style="width: 37%; margin-right: 0px;"/>
		             	 ~<input class="inputText ctime" type="text" name="scheduleExamineNorm_endDate" value="${sch.objMap.scheduleExamineNorm_endDate}" readonly="readonly" style="width: 37%;"/>
		             </td>
		             <td style="text-align:left;">
			     		 <textarea placeholder="" class="validate[maxSize[1000]] xltxtarea"  name="scheduleExamineNorm_examineNorm" readonly="readonly">${sch.objMap.scheduleExamineNorm_examineNorm}</textarea>
			     	 </td>
				</tr>
			    </c:forEach>
	    	</c:if>
	    	<c:if test="${empty resultMap.scheduleExamineNorm}">
				<c:forEach var="ypt" items="${applyMap.yearPlanTarget}" varStatus="status">
				<tr>
		             <td width="5%" style="text-align: center;" class="yptSerial">${status.count}</td>
		             <td>
		             	 <input class="inputText ctime" type="text" name="scheduleExamineNorm_startDate" value="${ypt.objMap.yearPlanTarget_startYear}" readonly="readonly" style="width: 70px; margin-right: 0px;text-align:left;"/>
		             	 ~<input class="inputText ctime" type="text" name="scheduleExamineNorm_endDate" value="${ypt.objMap.yearPlanTarget_endYear}" readonly="readonly" style="width: 70px;text-align:left;"/>
		             </td>
		             <td style="text-align:left;">
			     		 <textarea placeholder="" class="validate[maxSize[1000]] xltxtarea"  name="scheduleExamineNorm_examineNorm" readonly="readonly">${ypt.objMap.yearPlanTarget_planTarget}</textarea>
			     	 </td>
				</tr>
			    </c:forEach>
	    	</c:if>
			</tbody>
		</table>
	</form>
	
	<!-------------------------------------------------------------------------------------------------------->
		
	<div style="display: none">
		<!-- 模板 -->
		<table class="basic" id="schTemplate" style="width: 100%">
        <tr>
             <td width="4%" style="text-align: center;"><input name="schIds" type="checkbox"/></td>
             <td width="5%" style="text-align: center;" class="schSerial"></td>
             <td>
             	 <input class="inputText ctime" type="text" name="scheduleExamineNorm_startDate" onclick="WdatePicker({dateFmt:'yyyy-MM'})" readonly="readonly" style="width: 37%;margin-right: 0px;"/>
             	 ~<input class="inputText ctime" type="text" name="scheduleExamineNorm_endDate" onclick="WdatePicker({dateFmt:'yyyy-MM'})" readonly="readonly" style="width: 37%;"/>
             </td>
             <td>
	     		 <input type="text" name="scheduleExamineNorm_examineNorm" class="inputText" style="width: 80%"/>
	     	 </td>
		</tr>
		</table>
	</div>	
   	<c:if test="${param.view!=GlobalConstant.FLAG_Y}">
		<div align="center" style="margin-top: 10px">
		    <input id="prev" type="button" onclick="nextOpt('step1')" class="search" value="上一步"/>
		    <input id="nxt" type="button" onclick="nextOpt('step3')" class="search" value="下一步"/>
       	</div>
    </c:if>

		