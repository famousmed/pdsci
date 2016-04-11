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
	'<td width="50px" class="monographSerial"></td>'+
	'<td><input type="text" class="inputText"  name="monograph_publishTime"  onclick="WdatePicker({dateFmt:'+"'yyyy-MM-dd'"+'})" style="width:80%;"/></td>'+
	'<td><input type="text" class="inputText" name="monograph_monographName" style="width:80%;"/></td>'+
	'<td><input type="text" class="inputText" name="monograph_publishPress" style="width:80%;"/></td>'+
	'<td><input type="text" class="inputText validate[custom[integer]]" name="monograph_characterNum" style="width:80%;"/></td>'+
	'<td><input type="text" class="inputText" name="monograph_chiefEditor" style="width:80%;"/></td>'+
	'<td><input type="text" class="inputText" name="monograph_deputyEditor" style="width:80%;"/></td>'+
	'</tr>'; 
	$('#'+tb+'Tb').append(html);
	//序号
	$("#"+tb+"Tb").children("tr").last().children("td").eq(1).text(length+1);
}
</script>
</c:if>


        	    	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" style="position: relative;">
						<input type="hidden" name="pageName" value="monograph"/>
						<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
                        <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
						<input type="hidden" name="recTypeId" value="${param.recTypeId}"/>
   					<table class="bs_tb" style="width: 100%;margin-top: 10px;" id="monograph">
   						<tr>
	   						<th colspan="8" class="theader">十、近五年为主编/副主编出版的学术专著共 <input type="text" name="monographNum" value="${resultMap.monographNum}" class="validate[custom[integer]] inputText" style="width:30px;"/>本。（限填10项代表作）
	   						<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
	   						<span style="float: right;padding-right: 10px">
	   						<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addProj('monograph',this);"></img>&nbsp;
	   						<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('monograph');"></img>
	   						</span> 
	   						</c:if>
	   						</th>
   						</tr>
       					<tr>
			           		<td style="font-weight:bold;" width="3%"></td>
			           		<td style="font-weight:bold;" width="5%">序号</td>
			                <td style="font-weight:bold;" >出版时间</td>
			                <td style="font-weight:bold;" >专著名称</td>
			                <td style="font-weight:bold;" >出版社</td>
			                <td style="font-weight:bold;" >编写字数</td>
			                <td style="font-weight:bold;" >主编</td>
			                <td style="font-weight:bold;" >副主编</td>
          				</tr>
          			<tbody id="monographTb" class="tb">
          			<c:if test="${empty resultMap.monograph}">
          			   <tr>
				           <td width="3%"><input name="ids" type="checkbox"/></td>
				           <td width="3%" style="text-align: center;" class="monographSerial">1</td>
				           <td>
				           		<input type="text" class="inputText"   name="monograph_publishTime"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText" name="monograph_monographName"  style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText" name="monograph_publishPress" style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText validate[custom[integer]]" name="monograph_characterNum"  style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText" name="monograph_chiefEditor"  style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText" name="monograph_deputyEditor"  style="width:80%;"/>
				           </td>
				        </tr>
          			</c:if>
          			<c:if test="${! empty resultMap.monograph}">
					<c:forEach var="monograph" items="${resultMap.monograph}" varStatus="status">
				        <tr>
				           <td width="3%"><input name="ids" type="checkbox"/></td>
				           <td width="3%" style="text-align: center;" class="monographSerial">${status.count}</td>
				           <td>
				           		<input type="text" class="inputText"   name="monograph_publishTime" value="${monograph.objMap.monograph_publishTime}"     onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText" name="monograph_monographName" value="${monograph.objMap.monograph_monographName}" style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText" name="monograph_publishPress" value="${monograph.objMap.monograph_publishPress}" style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText validate[custom[integer]]" name="monograph_characterNum" value="${monograph.objMap.monograph_characterNum}" style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText" name="monograph_chiefEditor" value="${monograph.objMap.monograph_chiefEditor}" style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText" name="monograph_deputyEditor" value="${monograph.objMap.monograph_deputyEditor}" style="width:80%;"/>
				           </td>
				        </tr>
				    </c:forEach>
				    </c:if>
				    </tbody>
					</table>
					</form>
					
                	 <div class="button" style="width:100%;
                	 <c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none;</c:if>">
                	 	<input id="prev" type="button" onclick="nextOpt('patentAndCertificate')" class="search" value="上一步"/>
                	    <input id="nxt" type="button" onclick="nextOpt('academic')" class="search" value="下一步"/>
      			     </div>
 