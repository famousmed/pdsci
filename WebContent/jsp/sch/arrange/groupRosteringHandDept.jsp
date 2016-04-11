<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<style type="text/css">
table.basic th,table.basic td{text-align: center;padding: 0;}
</style>
<script type="text/javascript">
// 	String.prototype.htmlFormart = function(){
// 		var html = this;
// 		for(var index in arguments){
// 			var reg = new RegExp('\\{'+index+'\\}','g');
// 			html = html.replace(reg,arguments[index]);
// 		}
// 		return html;
// 	};

	//初始化操作
	$(function(){
	    $("#sortResult").sortable({
	    	helper: function(e, ui) {
		   	    ui.children().each(function() {
			        $(this).width($(this).width());
		     	});
			    return ui;
			},  
	    	create: function(e,ui){
	    	},
	    	start:function(e,ui){
	    	    ui.helper.css({"backgroundColor":"rgba(225, 238, 245,0.95)"});
	    	    return ui;
	    	}, 
	    	stop: function(event,ui) {
	    		ui.item.css({"backgroundColor":"#fff"});
	    	}
	    });
	});
	
	//绑定数据到假排班
	function bindDataToResult(tr,rotationDeptFlow,schMonth,schYear){
		$(tr).data("rotationDeptData",{
			resultFlow:rotationDeptFlow,
			schMonth:schMonth,
			schYear:schYear
		});
	}
	
	//开始绑定
	$(function(){
		$(".simulateResult").change();
	});
	
	//重新选科
	function reSelDept(){
		jboxConfirm("重新选科后,现在的排班将被重置！",function(){
			$("#selArea").show();
			$("#rosteringHome").empty();
			$("#rosteringOper").hide();
		},null);
	}
	
	//保存排班
	function saveGroupResult(){
		if(!checkResult()){
			return jboxTip("请先完成排班！");
		}
		var requestData = [];
		$(".simulateResult").each(function(){
			var deptData = $(this).data("rotationDeptData");
			deptData.schStartDate = $(".start",this).val() || "";
			deptData.schEndDate = $(".end",this).val() || "";
			requestData.push(deptData);
		});
		jboxPostJson("<s:url value='/sch/template/saveGroupResult'/>?groupId="+$("#groupId").val(),JSON.stringify(requestData),function(resp){
			if(resp=="${GlobalConstant.OPRE_SUCCESSED_FLAG}"){
				$(".selDoc").click();
				jboxTip("${GlobalConstant.OPRE_SUCCESSED}");
			}
		},null,false);
	}
	
	//检查是否完成排班
	function checkResult(){
		var isFinish = true;
		$(".start,.end").each(function(){
			if(!this.value){
				return isFinish = false;
			}
		});
		return isFinish;
	}
</script>
</head>
<c:set value="schUnitEnum${sysCfgMap['res_rotation_unit']}" var="unitKey"/>
<body>
	<table class="basic" style="width: 100%;margin-top: 10px;margin-left: 10px;">
		<tr>
			<th width="20%">标准科室</th>
			<th width="20%">轮转科室</th>
			<th width="20%">轮转时长</th>
			<th width="40%">轮转时间</th>
		</tr>
		
		<tbody id="sortResult">
			<c:forEach items="${rotationDeptList}" var="rotationDept">
				<c:if test="${rotationDept.schMonth > 0}">
					<tr class="simulateResult" onchange="bindDataToResult(this,'${rotationDept.recordFlow}','${rotationDept.schMonth}','1');">
						<td>${rotationDept.standardDeptName}</td>
						<td>${rotationDept.schDeptName}</td>
						<td>${rotationDept.schMonth}</td>
						<td>
							<input class="start" type="text" style="width: 100px;cursor: pointer;" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/>
							~
							<input class="end" type="text" style="width: 100px;cursor: pointer;" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/>
						</td>
					</tr>
				</c:if>
			</c:forEach>
		</tbody>
		
		<c:if test="${empty rotationDeptList}">
			<tr>
				<td colspan="4">无记录</td>
			</tr>
		</c:if>
	</table>
	<div align="center" style="margin-top: 10px;margin-bottom: 20px;">
		<input type="button" value="重新选科" class="search" onclick="reSelDept();"/>
		<input type="button" value="完成排班" class="search" onclick="saveGroupResult();"/>
	</div>
</body>
</html>