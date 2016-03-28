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
$(function(){ 
    var tables=$(".tb");
    $.each(tables , function(i , n){
    	var count=$(n).children().length;
    	var id=$(n).parent().attr("id");
    	$("input[name="+id+"Num]").val(count);
    });
});
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
		//计算行数
		var length = $("#"+tb+"Tb").children().length;
		$("input[name="+tb+"Num]").val(length);
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
	if(length > 9){
		jboxTip("限填10项!");
		return false; 
	}
	$("input[name="+tb+"Num]").val(length+1);
	
	var html = '<tr>'+
	'<td width="50px"><input name="ids" type="checkbox"/></td>'+
	'<td width="50px" class="officeSerial"></td>'+
	'<td><input type="text" class="inputText validate[custom[number]]" name="office_year" style="width:80%;"/></td>'+
	'<td><input type="text" class="inputText" name="office_committeeName" style="width:80%;"/></td>'+
	'<td><input type="text" class="inputText" name="office_zw" style="width:80%;"/></td>'+
	'<td><input type="text" class="inputText" name="office_fzw" style="width:80%;"/></td>'+
	'<td><input type="text" class="inputText" name="office_headman" style="width:80%;"/></td>'+
	'<td><input type="text" class="inputText" name="office_cw" style="width:80%;"/></td>'+
	'<td><input type="text" class="inputText" name="office_member" style="width:80%;"/></td>'+
	'</tr>'; 
	$('#'+tb+'Tb').append(html);
	//序号
	$("#"+tb+"Tb").children("tr").last().children("td").eq(1).text(length+1);
}
</script>
</c:if>

        	    	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" style="position: relative;">
						<input type="hidden" name="pageName" value="academic"/>
						<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
                        <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
						<input type="hidden" name="recTypeId" value="${param.recTypeId}"/>
   					<table class="bs_tb" style="width: 100%;margin-top: 10px" id="office">
						<tr>
							<th colspan="9" class="theader">十一、近五年学会任职情况，共 <input type="text" name="officeNum" value="${resultMap.officeNum}" class="validate[custom[integer]] inputText" style="width:30px;"/>个职务。（限填10项最高职务）
							<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
							<span style="float: right;padding-right: 10px">
							<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addProj('office',this);"></img>&nbsp;
							<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('office');"></img>
							</span> 
							</c:if>
							</th>
						</tr>
       					<tr>
			           		<td style="font-weight:bold;" width="50px" rowspan="2"></thd>
			           		<td style="font-weight:bold;" width="50px" rowspan="2">序号</td>
			                <td style="font-weight:bold;" rowspan="2" width="150px">任期年限</td>
			                <td style="font-weight:bold;" rowspan="2" width="400px">学会（分会、学组）名称</td>
			                <td style="font-weight:bold;" colspan="5" >根据职务对应填写姓名</td>
			            </tr>
			            <tr>
			                <td style="font-weight:bold;" >主委</td>
			                <td style="font-weight:bold;" >副主委</td>
			                <td style="font-weight:bold;" >组长</td>
			                <td style="font-weight:bold;" >常委</td>
			                <td style="font-weight:bold;" >委员</td>
          				</tr>
          			<tbody id="officeTb" class="tb">
          			<c:if test="${empty resultMap.office}">
          			    <tr>
				           <td width="3%"><input name="ids" type="checkbox"/></td>
				           <td width="5%" style="text-align: center;" class="officeSerial">1</td>
				           <td>
				           		<input type="text" class="inputText validate[custom[number]]" name="office_year"  style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText" name="office_committeeName"  style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText" name="office_zw"  style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText" name="office_fzw"  style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText" name="office_headman"  style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText" name="office_cw"  style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText" name="office_member"  style="width:80%;"/>
				           </td>
				        </tr>
          			</c:if>
          			
          			<c:if test="${! empty resultMap.office}">
					<c:forEach var="office" items="${resultMap.office}" varStatus="status">
				        <tr>
				           <td width="3%"><input name="ids" type="checkbox"/></td>
				           <td width="5%" style="text-align: center;" class="officeSerial">${status.count}</td>
				           <td>
				           		<input type="text" class="inputText validate[custom[number]]" name="office_year" value="${office.objMap.office_year}" style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText" name="office_committeeName" value="${office.objMap.office_committeeName}" style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText" name="office_zw" value="${office.objMap.office_zw}" style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText" name="office_fzw" value="${office.objMap.office_fzw}" style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText" name="office_headman" value="${office.objMap.office_headman}" style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText" name="office_cw" value="${office.objMap.office_cw}" style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText" name="office_member" value="${office.objMap.office_member}" style="width:80%;"/>
				           </td>
				        </tr>
				    </c:forEach>
				    </c:if>
				    </tbody>
					</table>
					</form>
				
                	 <div class="button"  style="width:100%;<c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none;</c:if>" 	 >
                	    <input id="prev" type="button"  onclick="nextOpt('monograph')" class="search" value="上一步"/>
                	    <input id="nxt" type="button"  onclick="nextOpt('laboratoryEquipment')" class="search" value="下一步"/>
      			     </div>
