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
function addProj(tb,obj){
	var length = $("#"+tb+"Tb").children().length;
	if(length > 9){
		jboxTip("限填10项!");
		return false; 
	}
	$("input[name="+tb+"Num]").val(length+1);
	var html = '<tr>'+
	'<td width="3%"><input name="ids" type="checkbox"/></td>'+
	'<td width="3%" class="certificateSerial"></td>'+
	'<td><input type="text" class="inputText" name="certificate_awardTime"   onclick="WdatePicker({dateFmt:'+"'yyyy-MM-dd'"+'})" style="width:80%;"/></td>'+
	'<td><input type="text" class="inputText" name="certificate_name" style="width:80%;"/></td>'+
	'<td><input type="text" class="inputText" name="certificate_publishPerson" style="width:80%;"/></td>'+
	'<td><input type="text" class="inputText" name="certificate_patentOrCertificate"  style="width:80%;"/></td>'+
	'<td><input type="text" class="inputText" name="certificate_grade" style="width:80%;"/></td>'+
	'</tr>'; 
	$('#'+tb+'Tb').append(html);
	//序号
	$("#"+tb+"Tb").children("tr").last().children("td").eq(1).text(length+1);
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

</script>
</c:if>


					 <form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" style="position: relative;">
						<input type="hidden" id="pageName" name="pageName" value="patentAndCertificate"/>
						<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
                        <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
						<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
						<input type="hidden" id="itemGroupName" value="certificate"/>
						<table class="bs_tb" style="width: 100%;margin-top: 10px;" id="certificate">
						<tr>
							<th colspan="7" class="theader">九、近五年为第一完成人的发明专利、新药证书共 <input type="text" name="certificateNum" value="${resultMap.certificateNum}" class="validate[custom[integer]] inputText" style="width:30px;"/> 张。（限填10项代表作）
							<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
							<span style="float: right;padding-right: 10px">
							<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addProj('certificate',this);"></img>&nbsp;
							<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('certificate');"></img>
							</span> 
							</c:if>
							</th>
						</tr>
       					<tr>
			           		<td style="font-weight:bold;" width="3%"></td>
			           		<td style="font-weight:bold;" width="5%">序号</td>
			                <td style="font-weight:bold;" >颁发时间</td>
			                <td style="font-weight:bold;" >名称</td>
			                <td style="font-weight:bold;" >完成人</td>
			                <td style="font-weight:bold;" >发明专利或新药证书</td>
			                <td style="font-weight:bold;" >等级</td>
          				</tr>
          				<tbody id="certificateTb" class="tb">
          				<c:if test="${empty resultMap.certificate}">
          				   <tr>
					           <td width="3%"><input name="ids" type="checkbox"/></td>
					           <td width="3%" style="text-align:center;" class="certificateSerial">1</td>
					           <td width="20%">
					           		<input type="text" class="inputText" name="certificate_awardTime"  style="width:80%;"/>
					           </td>
					           <td>
					          		 <input type="text" class="inputText" name="certificate_name"  style="width:80%;"/>
					           </td>
					           <td>
					           		<input type="text" class="inputText" name="certificate_publishPerson"  style="width:80%;"/>
					           </td>
					           <td>
					           		<input type="text" class="inputText" name="certificate_patentOrCertificate"  style="width:80%;"/>
					           </td>
					           <td>
					           		<input type="text" class="inputText" name="certificate_grade"  style="width:80%;"/>
					           </td>
					        </tr>
          				</c:if>
						<c:if test="${! empty resultMap.certificate}">
						<c:forEach var="certificate" items="${resultMap.certificate}" varStatus="status">
					        <tr>
					           <td width="3%"><input name="ids" type="checkbox"/></td>
					           <td width="3%" style="text-align:center;" class="certificateSerial">${status.count}</td>
					           <td width="20%">
					           		<input type="text" class="inputText" name="certificate_awardTime" value="${certificate.objMap.certificate_awardTime}" style="width:80%;"/>
					           </td>
					           <td>
					          		 <input type="text" class="inputText" name="certificate_name" value="${certificate.objMap.certificate_name}" style="width:80%;"/>
					           </td>
					           <td>
					           		<input type="text" class="inputText" name="certificate_publishPerson" value="${certificate.objMap.certificate_publishPerson}" style="width:80%;"/>
					           </td>
					           <td>
					           		<input type="text" class="inputText" name="certificate_patentOrCertificate" value="${certificate.objMap.certificate_patentOrCertificate}" style="width:80%;"/>
					           </td>
					           <td>
					           		<input type="text" class="inputText" name="certificate_grade" value="${certificate.objMap.certificate_grade}" style="width:80%;"/>
					           </td>
					        </tr>
					    </c:forEach>
					    </c:if>
					    </tbody>
						</table>
					</form>
					
                	 <div class="button" style="width:100%;
                	 <c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none;</c:if>">
                	 	<input id="prev" type="button" onclick="nextOpt('SCIAndThesis')" class="search" value="上一步"/>
                	    <input id="nxt" type="button" onclick="nextOpt('monograph')" class="search" value="下一步"/>
      			     </div>
