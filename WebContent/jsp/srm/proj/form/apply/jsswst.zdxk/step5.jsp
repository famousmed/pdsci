<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	
	function calculate(tb, col, obj){
		var num1 = parseFloat(obj.value);
		var num2 = 0;
		if(col == 'num'){
			num2 = $(obj).parent().next().children().val();
		}else if(col == 'price'){
			num2 = $(obj).parent().prev().children().val();
		}
		var totalPrice = num1 * num2;//总价
		if(!isNaN(totalPrice)){
			$(obj).parent().parent().find("input[name="+tb+"_totalPrice]").val(parseFloat(totalPrice.toFixed(3)));
		}
		
		var count = 0;
		var above100000Count = 0;
		$("#"+tb+"Tb"+" input[name="+tb+"_num]").each(function(){
			var num = parseFloat(this.value);
			var price = parseFloat($(this).parent().next().children().val());
			if(!isNaN(num)){
				count += num;
				if(price > 10){//10万以上台数
					above100000Count += num;
				}
			}
		});		
		$("input[name="+tb+"Count]").val(count);
		$("input[name="+tb+"Above100000Count]").val(above100000Count);
		
		var totalInvestment = 0;
		$("#"+tb+"Tb"+" input[name="+tb+"_totalPrice]").each(function(){
			var num = parseFloat(this.value);
			if(!isNaN(num)){
				totalInvestment += num;
			}
		});
		$("input[name="+tb+"TotalInvestment]").val(totalInvestment);
	}

</script>
</c:if>

<style type="text/css">
 .bs_tb tbody td input{text-align: left;margin-left: 10px;}
</style>

	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" style="position: relative;"
		id="projForm">
		<input type="hidden" id="pageName" name="pageName" value="step5" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
		   
		<div>
			<font style="font-size: 18px; font-weight:bold; ">五、设备和规模</font>
		</div>
		<table class="bs_tb" style="width: 100%;margin-top: 10px; position: relative;">
			<tr>
				<th colspan="11" class="theader">1.中心专用设备
					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
					<span style="float: right;padding-right: 10px">
					<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('equipment')"></img>&#12288;
					<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('equipment');"></img></span>
					</c:if>
				</th>
			</tr>
			<tr>
				<td width="50px"></td>
				<td width="50px">序号</td>
				<td width="30%">设备名称</td>
				<td width="20%">数量</td>
				<td width="20%">单价（万元）</td>
				<td width="20%">总价（万元）</td>
			</tr>
			<tbody id="equipmentTb">
			<c:if test="${not empty resultMap.equipment}">
				<c:forEach var="equipment" items="${resultMap.equipment}" varStatus="status">
				<tr>
		             <td width="50px" style="text-align: center;"><input name="equipmentIds" type="checkbox"/></td>
		             <td width="50px" style="text-align: center;" class="equipmentSerial">${status.count}</td>
		             <td><input type="text" name="equipment_name" value="${equipment.objMap.equipment_name}" class="inputText" style="width: 90%"/></td>
		             <td><input type="text" name="equipment_num" value="${equipment.objMap.equipment_num}"  class="inputText validate[custom[integer]]" style="width: 90%" onchange="calculate('equipment','num',this)"/></td>
		             <td><input type="text" name="equipment_price" value="${equipment.objMap.equipment_price}"  class="inputText validate[custom[number]]" style="width: 90%" onchange="calculate('equipment','price',this)"/></td>
		             <td><input type="text" name="equipment_totalPrice" value="${equipment.objMap.equipment_totalPrice}"  class="inputText validate[custom[number]]" style="width: 90%"/></td>
				</tr>
			    </c:forEach>
	    	</c:if>
			</tbody>
		</table>
		
		
		<font style="font-size: 14px; font-weight:bold; ">&#12288;设备统计</font>
		<table class="basic" style="width: 100%; position: relative;">
			<tr>
				<td style="text-align: right;">台数：</td>
				<td><input type="text" name="equipmentCount" value="${resultMap.equipmentCount}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td style="text-align: right;">10万以上台数：</td>
				<td><input type="text" name="equipmentAbove100000Count" value="${resultMap.equipmentAbove100000Count}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td style="text-align: right;">总投资（万元）：</td>
				<td><input type="text" name="equipmentTotalInvestment" value="${resultMap.equipmentTotalInvestment}" class="validate[custom[number]] inputText" style="width: 90%"/></td>
			</tr>
		</table>
		
		
		
		<!-- 2.中心专用实验室设备 -->
		<table class="bs_tb" style="width: 100%;margin-top: 40px; position: relative;">
			<tr>
				<th colspan="11" class="theader">2.中心专用实验室设备
					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
					<span style="float: right;padding-right: 10px">
					<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('laboratory')"></img>&#12288;
					<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('laboratory');"></img></span>
					</c:if>
				</th>
			</tr>
			<tr>
				<td width="50px"></td>
				<td width="50px">序号</td>
				<td width="30%">设备名称</td>
				<td width="20%">数量</td>
				<td width="20%">单价（万元）</td>
				<td width="20%">总价（万元）</td>
			</tr>
			<tbody id="laboratoryTb">
			<c:if test="${not empty resultMap.laboratory}">
				<c:forEach var="laboratory" items="${resultMap.laboratory}" varStatus="status">
				<tr>
		             <td width="50px" style="text-align: center;"><input name="laboratoryIds" type="checkbox"/></td>
		             <td width="50px" style="text-align: center;" class="laboratorySerial">${status.count}</td>
		             <td><input type="text" name="laboratory_name" value="${laboratory.objMap.laboratory_name}" class="inputText" style="width: 90%"/></td>
		             <td><input type="text" name="laboratory_num" value="${laboratory.objMap.laboratory_num}"  class="inputText validate[custom[integer]]" style="width: 90%" onchange="calculate('laboratory','num',this)"/></td>
		             <td><input type="text" name="laboratory_price" value="${laboratory.objMap.laboratory_price}"  class="inputText validate[custom[number]]" style="width: 90%" onchange="calculate('laboratory','price',this)"/></td>
		             <td><input type="text" name="laboratory_totalPrice" value="${laboratory.objMap.laboratory_totalPrice}"  class="inputText validate[custom[number]]" style="width: 90%"/></td>
				</tr>
			    </c:forEach>
	    	</c:if>
			</tbody>
		</table>
		
		
		<font style="font-size: 14px; font-weight:bold; ">&#12288;设备统计</font>
		<table class="basic" style="width: 100%; position: relative;">
			<tr>
				<td style="text-align: right;">台数：</td>
				<td><input type="text" name="laboratoryCount" value="${resultMap.laboratoryCount}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td style="text-align: right;">10万以上台数：</td>
				<td><input type="text" name="laboratoryAbove100000Count" value="${resultMap.laboratoryAbove100000Count}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td style="text-align: right;">总投资（万元）：</td>
				<td><input type="text" name="laboratoryTotalInvestment" value="${resultMap.laboratoryTotalInvestment}" class="validate[custom[number]] inputText" style="width: 90%"/></td>
			</tr>
		</table>
		
		</form>
		
	<!-- -----------------------------------模板------------------------------------------------------------ -->	
	<div style="display: none">
		<!-- 设备模板 -->
		<table class="bs_tb" id="equipmentTemplate" style="width: 100%">
        <tr>
             <td width="50px" style="text-align: center;"><input name="equipmentIds" type="checkbox"/></td>
             <td width="50px" style="text-align: center;" class="equipmentSerial"></td>
             <td><input type="text" name="equipment_name" class="inputText" style="width: 90%"/></td>
             <td><input type="text" name="equipment_num" class="inputText validate[custom[integer]]" style="width: 90%" onchange="calculate('equipment','num',this)"/></td>
             <td><input type="text" name="equipment_price" class="inputText validate[custom[number]]" style="width: 90%" onchange="calculate('equipment','price',this)"/></td>
             <td><input type="text" name="equipment_totalPrice" class="inputText validate[custom[number]]" style="width: 90%"/></td>
		</tr>
		</table>

		<!-- 中心专用实验室设备模板 -->
		<table class="bs_tb" id="laboratoryTemplate" style="width: 100%">
        <tr>
             <td width="50px" style="text-align: center;"><input name="laboratoryIds" type="checkbox"/></td>
             <td width="50px" style="text-align: center;" class="laboratorySerial"></td>
             <td><input type="text" name="laboratory_name" class="inputText" style="width: 90%"/></td>
             <td><input type="text" name="laboratory_num" class="inputText validate[custom[integer]]" style="width: 90%" onchange="calculate('laboratory','num',this)"/></td>
             <td><input type="text" name="laboratory_price" class="inputText validate[custom[number]]" style="width: 90%" onchange="calculate('laboratory','price',this)"/></td>
             <td><input type="text" name="laboratory_totalPrice" class="inputText validate[custom[number]]" style="width: 90%"/></td>
		</tr>
		</table>
	</div>
	
    <div class="button" style="width: 100%; <c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none</c:if>">
	    <a href="javascript:void(0)" target="_self" class="search" onclick="nextOpt('step4')">上一步</a>
	   <a href="javascript:void(0)" target="_self" class="search" onclick="nextOpt('step6')">下一步</a>
    </div>

		