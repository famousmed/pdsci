<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:if test="${param.view != GlobalConstant.FLAG_Y}">
<script type="text/javascript">
function nextOpt(step){
	if(false==$("#projForm").validationEngine("validate")){
		return false;
	}
var form = $('#projForm');
form.append('<input type="hidden" name="nextPageName" value="'+step+'"/>');
$('#nxt').attr({"disabled":"disabled"});
$('#prev').attr({"disabled":"disabled"});
jboxStartLoading();
form.submit();
}

function delTr(tb){
	var checkboxs = $("input[name='ids']:checked");
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

function addProj(tb,obj){
	var length = $("#"+tb+"Tb").children().length;
	if(length > 99999){
		jboxTip("限填10万以上的设备!");
		return false; 
	}
	
	var html = '<tr>'+
	'<td width="50px"><input name="ids" type="checkbox"/></td>'+
	'<td width="50px" class="equipmentSerial"></td>'+
	'<td><input type="text" class="inputText" name="equipment_equipmentName" style="width:80%;"/></td>'+
	'<td><input type="text" class="inputText" name="equipment_modelNumber" style="width:80%;"/></td>'+
	'<td><input type="text" class="inputText"  name="equipment_buyTime" onclick="WdatePicker({dateFmt:'+"'yyyy-MM-dd'"+'})" style="width:80%;"/></td>'+
	'<td><input type="text" class="inputText validate[custom[number]]" name="equipment_equipmentPrice" style="width:80%;"/></td>'+
	'<td><input type="text" class="inputText" name="equipment_equipmentRemark" style="width:80%;"/></td>'+
	'</tr>'; 
	$('#'+tb+'Tb').append(html);
	//序号
	$("#"+tb+"Tb").children("tr").last().children("td").eq(1).text(length+1);
}


</script>
</c:if>


        	    	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" style="position: relative;">
						<input type="hidden" name="pageName" value="laboratoryEquipment"/>
						<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
                        <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
						<input type="hidden" name="recTypeId" value="${param.recTypeId}"/>
   					<table class="bs_tb" style="width: 100%;margin-top: 10px;">
   						<tr>
	   						<th colspan="7" class="theader">十二、专用实验室设备（限填10万以上的设备）
	   						<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
	   						<span style="float: right;padding-right: 10px">
	   						<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addProj('equipment',this);"></img>&nbsp;
	   						<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('equipment');"></img>
	   						</span> 
	   						</c:if>
	   						</th>
   						</tr>
       					<tr>
			           		<td style="font-weight:bold;" width="3%"></td>
			           		<td style="font-weight:bold;" width="5%">序号</td>
			                <td style="font-weight:bold;" >设备名称</td>
			                <td style="font-weight:bold;" >规格型号</td>	
			                <td style="font-weight:bold;" >购置时间</td>
			                <td style="font-weight:bold;" >价  格</td>
			                <td style="font-weight:bold;" >备注</td>
          				</tr>
          			<tbody id="equipmentTb">
          			<c:if test="${empty resultMap.equipment}">
          			     <tr>
				           <td width="50px"><input name="ids" type="checkbox"/></td>
				           <td width="50px" class="equipmentSerial">1</td>
				           <td>
				           		<input type="text" class="inputText" name="equipment_equipmentName"  style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText" name="equipment_modelNumber"  style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText"  name="equipment_buyTime"   onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText validate[custom[number]]" name="equipment_equipmentPrice"  style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText" name="equipment_equipmentRemark"  style="width:80%;"/>
				           </td>
				        </tr>
          			</c:if>
          			<c:if test="${! empty resultMap.equipment}">
					<c:forEach var="equipment" items="${resultMap.equipment}" varStatus="status">
				        <tr>
				           <td width="50px"><input name="ids" type="checkbox"/></td>
				           <td width="50px" class="equipmentSerial">${status.count}</td>
				           <td>
				           		<input type="text" class="inputText" name="equipment_equipmentName" value="${equipment.objMap.equipment_equipmentName}" style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText" name="equipment_modelNumber" value="${equipment.objMap.equipment_modelNumber}" style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText"  name="equipment_buyTime" value="${equipment.objMap.equipment_buyTime}"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText validate[custom[number]]" name="equipment_equipmentPrice" value="${equipment.objMap.equipment_equipmentPrice}" style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText" name="equipment_equipmentRemark" value="${equipment.objMap.equipment_equipmentRemark}" style="width:80%;"/>
				           </td>
				        </tr>
				    </c:forEach>
				    </c:if>
				    </tbody>
					</table>
					</form>
					
                	 <div class="button" style="width:100%;
                	 <c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none;</c:if>">
                	 	<input id="prev" type="button" onclick="nextOpt('academic')" class="search" value="上一步"/>
                	    <input id="nxt" type="button" onclick="nextOpt('cooperationOrg')" class="search" value="下一步"/>
      			     </div>
 