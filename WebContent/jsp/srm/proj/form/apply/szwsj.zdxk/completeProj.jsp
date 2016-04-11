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
	'<td width="50px" class="completeSerial"></td>'+
	'<td><input type="text" class="inputText" name="complete_lessonNo" style="width:80%;"/></td>'+
	'<td><input type="text" class="inputText" name="complete_projName" style="width:80%;"/></td>'+
	'<td><select name="complete_projSource" class="inputText" style="width:80%;">'+
		'<option value="">请选择</option>'+
		'<option value="国家自然科学基金">国家自然科学基金</option>'+
		'<option value="卫生部">卫生部</option>'+
		'<option value="教育部">教育部</option>'+
		'<option value="科技厅">科技厅</option>'+
		'<option value="国际资助或国际合作">国际资助或国际合作</option>'+
		'<option value="科技局">科技局</option>'+
		'<option value="卫生局">卫生局</option>'+
	'</select></td>'+
	
	'<td><input type="text" class="inputText"  readonly="readonly" name="complete_projStartTime"    onclick="WdatePicker({dateFmt:'+"'yyyy-MM-dd'"+'})" style="width:40%; margin-right: 0px;"/>'+
	' ~ <input type="text" class="inputText"  readonly="readonly" name="complete_projEndTime"   onclick="WdatePicker({dateFmt:'+"'yyyy-MM-dd'"+'})" style="width:40%;"/>'+
	'</td>'+
	'<td><input type="text" class="inputText validate[custom[number]]" name="complete_projFund" style="width:80%;"/></td>'+
	'<td><input type="text" class="inputText" name="complete_firstCompletePerson" style="width:80%;"/></td>'+
	'</tr>'; 
	$('#'+tb+'Tb').append(html);
	//序号
	$("#"+tb+"Tb").children("tr").last().children("td").eq(1).text(length+1);
}

</script>
</c:if>


        	    	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" style="position: relative;">
						<input type="hidden" name="pageName" value="completeProj"/>
						<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
                        <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
						<input type="hidden" name="recTypeId" value="${param.recTypeId}"/>
   					<table class="bs_tb" style="width: 100%;margin-top: 10px;" id="complete">
	   					<tr>
		   					<th colspan="8" class="theader">五、近五年为第一负责人已完成的市级及以上科研项目共 <input type="text" name="completeNum" value="${resultMap.completeNum}" class="validate[custom[integer]] inputText"  style="width:30px;" />项。（限填10项代表作）
		   					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
		   					<span style="float: right;padding-right: 10px">
		   					<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addProj('complete',this);"></img>&nbsp;
		   					<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('complete');"></img>
		   					</span> 
		   					</c:if>
		   					</th>
	   					</tr>
       					<tr>
			           		<td style="text-align: center;" width="3%"></td>
			           		<td style="text-align: center;" width="4%">序号</td>
			                <td style="text-align: center;" >课题编号</td>
			                <td style="text-align: center;" >项目名称</td>
			                <td style="text-align: center;" >项目来源</td>
			                <td style="text-align: center;" >项目起迄时间</td>
			                <td style="text-align: center;" >项目经费(万元)</td>
			                <td style="text-align: center;" >第一完成人</td>
          				</tr>
          			<tbody id="completeTb" class="tb">
          			<c:if test="${empty resultMap.complete}">
          			   <tr>
				           <td width="3%"><input name="ids" type="checkbox"/></td>
				           <td width="3%" style="text-align: center;" class="completeSerial">1</td>
				           <td>
				           		<input type="text" class="inputText"  name="complete_lessonNo"  style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText"   name="complete_projName"  style="width:80%;"/>
				           </td>
				           <td>
				           		<select name="complete_projSource" class="inputText" style="width:80%;">
				           			<option value="">请选择</option>
				           			<option value="国家自然科学基金" >国家自然科学基金</option>
									<option value="卫生部" >卫生部</option>
									<option value="教育部" >教育部</option>
									<option value="科技厅" >科技厅</option>
									<option value="国际资助或国际合作" >国际资助或国际合作</option>
									<option value="科技局" >科技局</option>
									<option value="卫生局" >卫生局</option>
				           		</select>
				           </td>
				           <td>
				           		<input type="text" class="inputText"   name="complete_projStartTime"   onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:40%; margin-right: 0px;"/>
				           		~
				           		<input type="text" class="inputText"    name="complete_projEndTime"    onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:40%;"/>
				           </td>
				           <td>
				             	<input type="text" class="inputText validate[custom[number]]"   name="complete_projFund"  style="width:80%;"/>
				           </td>
				           <td>
				             	<input type="text" class="inputText"   name="complete_firstCompletePerson"  style="width:80%;"/>
				           </td>
				        </tr>
          			</c:if>
          			<c:if test="${! empty resultMap.complete}">
					<c:forEach var="complete" items="${resultMap.complete}" varStatus="status">
				        <tr>
				           <td width="3%"><input name="ids" type="checkbox"/></td>
				           <td width="3%" style="text-align: center;" class="completeSerial">${status.count}</td>
				           <td>
				           		<input type="text" class="inputText"  name="complete_lessonNo" value="${complete.objMap.complete_lessonNo}" style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText"   name="complete_projName" value="${complete.objMap.complete_projName}" style="width:80%;"/>
				           </td>
				           <td>
				           		<select name="complete_projSource" class="inputText" style="width:80%;">
				           			<option value="">请选择</option>
				           			<option value="国家自然科学基金" <c:if test="${complete.objMap.complete_projSource eq '国家自然科学基金'}">selected="selected"</c:if> >国家自然科学基金</option>
									<option value="卫生部" <c:if test="${complete.objMap.complete_projSource eq '卫生部'}">selected="selected"</c:if> >卫生部</option>
									<option value="教育部" <c:if test="${complete.objMap.complete_projSource eq '教育部'}">selected="selected"</c:if> >教育部</option>
									<option value="科技厅" <c:if test="${complete.objMap.complete_projSource eq '科技厅'}">selected="selected"</c:if> >科技厅</option>
									<option value="国际资助或国际合作" <c:if test="${complete.objMap.complete_projSource eq '国际资助或国际合作'}">selected="selected"</c:if> >国际资助或国际合作</option>
									<option value="科技局" <c:if test="${complete.objMap.complete_projSource eq '科技局'}">selected="selected"</c:if> >科技局</option>
									<option value="卫生局" <c:if test="${complete.objMap.complete_projSource eq '卫生局'}">selected="selected"</c:if> >卫生局</option>
				           		</select>
				           </td>
				           <td>
				           		<input type="text" class="inputText"   name="complete_projStartTime" value="${complete.objMap.complete_projStartTime}"   onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:40%; margin-right: 0px;"/>
				           		~
				           		<input type="text" class="inputText"    name="complete_projEndTime" value="${complete.objMap.complete_projEndTime}"    onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:40%;"/>
				           </td>
				           <td>
				             	<input type="text" class="inputText validate[custom[number]]"   name="complete_projFund" value="${complete.objMap.complete_projFund}" style="width:80%;"/>
				           </td>
				           <td>
				             	<input type="text" class="inputText"   name="complete_firstCompletePerson" value="${complete.objMap.complete_firstCompletePerson}" style="width:80%;"/>
				           </td>
				        </tr>
				    </c:forEach>
				    </c:if>
				    </tbody>
					</table>
					</form>
					
                	 <div class="button" style="width:100%;
                	 <c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none;</c:if>">
                	 	<input id="prev" type="button" onclick="nextOpt('personInfo')" class="search" value="上一步"/>
                	    <input id="nxt" type="button" onclick="nextOpt('researchProj')" class="search" value="下一步"/>
      			     </div>
