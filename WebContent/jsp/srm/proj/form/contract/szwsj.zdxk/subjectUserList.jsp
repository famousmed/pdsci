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

function addApplyUser(tb,obj){
	var tr = $("#"+tb+"Tb").children("tr").last();
	if(tb=='director' && tr.index() > -1){
		jboxTip("限1人!");
		return false; 
	}
	if(tb=='deputy' && tr.index() > 0){
		jboxTip("限2人!");
		return false; 
	}
	if(tb=='other' && tr.index() > 15){
		jboxTip("限17人!");
		return false; 
	}
	
	var html = '<tr>'+
	'<td width="3%"><input name="ids" type="checkbox"/></td>'+
	'<td><input style="width:80%;" name="'+tb+'_name" type="text" class="validate[required] inputText"/></td>'+
	'<td style="width: 10%">'+
	 '<select name="'+tb+'_sex" class="validate[required] inputText" style="width:80%;">'+
	    <c:forEach items="${userSexEnumList}" var="sex">
	    	'<c:if test="${sex.id != userSexEnumUnknown.id}">'+
            '<option value="${sex.id}">${sex.name }</option>'+  
            '</c:if>'+
        </c:forEach>
	 '</select></td>'+
	'<td><input  class="validate[required] inputText" style="width:80%;" name="'+tb+'_birthday" type="text" class="ctime" onClick="WdatePicker({dateFmt:'+"'yyyy-MM-dd'"+'})" readonly="readonly"/></td>'+
	'<td style="width: 10%">'+
		'<select name="'+tb+'_title"  class="validate[required] inputText" style="width:80%;">'+
			<c:forEach items="${dictTypeEnumUserTitleList}" var="title">
				'<option value="${title.dictId}">${title.dictName}</option>'+
			</c:forEach>
		'</select></td>'+
	'<td><input type="text" name="'+tb+'_major" class="validate[required] inputText" style="width:80%;"/></td>'+
	'<td><input type="text" name="'+tb+'_mainTask" class="validate[required] inputText" style="width:80%;"/></td>'+
	'<td><input type="text" name="'+tb+'_workOrg" class="validate[required] inputText" style="width:80%;"/></td>'+
	'</tr>'; 
	$('#'+tb+'Tb').append(html);
}


function delTr(tb){
	var checkboxs = $("input[name='ids']:checked");
	if(checkboxs.length==0){
		jboxTip("请勾选要删除的人员！");
		return false;
	}
	jboxConfirm("确认删除?",function () {
		var trs = $('#'+tb+'Tb').find(':checkbox:checked');
		$.each(trs , function(i , n){
			$(n).parent('td').parent("tr").remove();
			
		});
	});
}
</script>
</c:if>
<style type="text/css">
.title_sp{padding-left: 10px;font-size: 14px;padding-bottom: 10px;font-weight: bold;color: #333;margin-top: 10px;}
</style>
		
            		<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" style="position: relative;">
	            		<input type="hidden" id="pageName" name="pageName" value="subjectUserList"/>
						<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
                        <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
						<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
					<div class="title_sp">五、学科人员名单（限20人，必须和申报书人员名单一致）</div>
   					<table class="bs_tb" style="width: 100%">
   					   <tr><th colspan="8" class="theader">学科主任（限1人）<span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span><c:if test="${param.view!=GlobalConstant.FLAG_Y }"><span style="float: right;padding-right: 10px"><img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addApplyUser('director',this);"></img>&#12288;<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('director');"></img></span> </c:if></th></tr>
       					<tr>
			           		<td style="font-weight:bold;" width="3%"></td>
			                <td style="font-weight:bold;" width="12.6%">姓	名</td>
			                <td style="font-weight:bold;" width="10%">性	别</td>
			                <td style="font-weight:bold;" width="14.4%">出生年月</td>
			                <td style="font-weight:bold;" width="10%">职	称</td>
			                <td style="font-weight:bold;" width="12.5%">专	业</td>
			                <td style="font-weight:bold;" width="12.8%">主要任务</td>
			                <td style="font-weight:bold;" width="12.5%">所在单位</td>
          				</tr>
          			<tbody id="directorTb">
          			<c:if test="${! empty resultMap.director}">
					<c:forEach var="director" items="${resultMap.director}" >
				        <tr>
				           <td width="3%"><input name="ids" type="checkbox"/></td>
				           <td>
				           		<input type="text" name="director_name" value="${director.objMap.director_name}" class="validate[required] inputText" style="width:80%;" />
				           </td>
				           <td style="width: 10%">
				              	<select name="director_sex" class="validate[required] inputText" style="width: 80%" >
							     <c:forEach items="${userSexEnumList}" var="sex">
							       <c:if test="${sex.id != userSexEnumUnknown.id}">
							       	<option value="${sex.id}" <c:if test="${director.objMap.director_sex eq sex.id}">selected="selected"</c:if> >${sex.name}</option>
							       </c:if>
							     </c:forEach>
								</select>		
				           </td>
				           <td>
				           		<input type="text" name="director_birthday" value="${director.objMap.director_birthday}" class="validate[required] inputText" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:80%;"/>
				           </td>
				           <td style="width: 10%">
				                <select name="director_title" class="validate[required] inputText" style="width:80%;">
									<c:forEach items="${dictTypeEnumUserTitleList}" var="title">
      										<option value="${title.dictId}" <c:if test="${director.objMap.director_title eq title.dictId}">selected="selected"</c:if>>${title.dictName}</option>
      									</c:forEach>
							    </select>
				           </td>
				           <td>
				             	<input type="text" name="director_major" value="${director.objMap.director_major}" class="validate[required] inputText" style="width:80%;"/>
				           </td>
				           <td>
				             	<input type="text" name="director_mainTask" value="${director.objMap.director_mainTask}" class="validate[required] inputText" style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" name="director_workOrg" value="${director.objMap.director_workOrg}" class="validate[required] inputText" style="width:80%;"/>
				           </td>
				        </tr>
				    </c:forEach>
				    </c:if>
				    </tbody>
					</table>
              		<table class="bs_tb"  style="width: 100%;margin-top: 10px;">
              		<tr><th colspan="8" class="theader">学科副主任（限2人）<span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span><c:if test="${param.view!=GlobalConstant.FLAG_Y }"><span style="float: right;padding-right: 10px"><img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addApplyUser('deputy',this);"></img>&#12288;<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('deputy');"></img></span> </c:if></th></tr>
       					<tr>
			           		<td style="font-weight:bold;" width="3%"></td>
			                <td style="font-weight:bold;" width="12.6%">姓	名</td>
			                <td style="font-weight:bold;" width="10%">性	别</td>
			                <td style="font-weight:bold;" width="14.4%">出生年月</td>
			                <td style="font-weight:bold;" width="10%">职	称</td>
			                <td style="font-weight:bold;" width="12.5%">专	业</td>
			                <td style="font-weight:bold;" width="12.8%">主要任务</td>
			                <td style="font-weight:bold;" width="12.5%">所在单位</td>
          				</tr>
          			<tbody id="deputyTb">
          			<c:if test="${! empty resultMap.deputy}">
					<c:forEach var="deputy" items="${resultMap.deputy}" varStatus="num">
				        <tr>
				           <td width="3%"><input name="ids" type="checkbox"/></td>
				           <td>
				           		<input type="text" name="deputy_name" value="${deputy.objMap.deputy_name}" class="inputText" style="width:80%;" />
				           </td>
				           <td style="width: 10%">
				              	<select name="deputy_sex" class="inputText" style="width: 80%">
							     <c:forEach items="${userSexEnumList}" var="sex">
							       <c:if test="${sex.id != userSexEnumUnknown.id}">
							        <option value="${sex.id}" <c:if test="${deputy.objMap.deputy_sex eq sex.id}">selected="selected"</c:if> >${sex.name}</option>
							      </c:if>
							     </c:forEach>
								</select>		
				           </td>
				           <td>
				           		<input type="text" name="deputy_birthday" value="${deputy.objMap.deputy_birthday}" class="inputText" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputText" style="width:80%;"/>
				           </td>
				           <td style="width: 10%">
				                <select name="deputy_title" class="inputText" style="width:80%;">
									<c:forEach items="${dictTypeEnumUserTitleList}" var="title">
      										<option value="${title.dictId}" <c:if test="${deputy.objMap.deputy_title eq title.dictId}">selected="selected"</c:if>>${title.dictName}</option>
      									</c:forEach>
							    </select>
				           </td>
				           <td>
				             	<input type="text" name="deputy_major" value="${deputy.objMap.deputy_major}" class="inputText" style="width:80%;"/>
				           </td>
				           <td>
				             	<input type="text" name="deputy_mainTask" value="${deputy.objMap.deputy_mainTask}" class="inputText" style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" name="deputy_workOrg" value="${deputy.objMap.deputy_workOrg}" class="inputText" style="width:80%;"/>
				           </td>
				        </tr>
				    </c:forEach>
				    </c:if>
				    </tbody>
					</table>
					<!-- 其他人员（限17人） -->
					<table class="bs_tb" style="width: 100%;margin-top: 10px;">
					<tr><th colspan="8" class="theader">其他人员（限17人）<c:if test="${param.view!=GlobalConstant.FLAG_Y }"><span style="float: right;padding-right: 10px"><img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addApplyUser('other',this);"></img>&#12288;<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('other');"></img></span> </c:if></th></tr>
       					<tr>
			           		<td style="font-weight:bold;" width="3%"></td>
			                <td style="font-weight:bold;" width="12.6%">姓	名</td>
			                <td style="font-weight:bold;" width="10%">性	别</td>
			                <td style="font-weight:bold;" width="14.4%">出生年月</td>
			                <td style="font-weight:bold;" width="10%">职	称</td>
			                <td style="font-weight:bold;" width="12.5%">专	业</td>
			                <td style="font-weight:bold;" width="12.8%">主要任务</td>
			                <td style="font-weight:bold;" width="12.5%">所在单位</td>
          				</tr>
          			<tbody id="otherTb">
          			<c:if test="${! empty resultMap.other}">
					<c:forEach var="other" items="${resultMap.other}" varStatus="num">
				        <tr>
				           <td width="3%"><input name="ids" type="checkbox"/></td>
				           <td>
				           		<input type="text" name="other_name" value="${other.objMap.other_name}"  class="inputText" style="width:80%;" />
				           </td>
				           <td style="width: 10%">
				              	<select name="other_sex"  class="inputText" style="width: 80%">
							     <c:forEach items="${userSexEnumList}" var="sex">
							       <c:if test="${sex.id != userSexEnumUnknown.id}">
							         <option value="${sex.id}" <c:if test="${other.objMap.other_sex eq sex.id}">selected="selected"</c:if> >${sex.name}</option>
							       </c:if>
							     </c:forEach>
								</select>		
				           </td>
				           <td>
				           		<input type="text" name="other_birthday" value="${other.objMap.other_birthday}" class="inputText" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:80%;"/>
				           </td>
				           <td style="width: 10%">
				                <select name="other_title" class="inputText" style="width:80%;" >
									<c:forEach items="${dictTypeEnumUserTitleList}" var="title">
      										<option value="${title.dictId}" <c:if test="${other.objMap.other_title eq title.dictId}">selected="selected"</c:if>>${title.dictName}</option>
      									</c:forEach>
							    </select>
				           </td>
				           <td>
				             	<input type="text" name="other_major" value="${other.objMap.other_major}" class="inputText" style="width:80%;"/>
				           </td>
				           <td>
				             	<input type="text" name="other_mainTask" value="${other.objMap.other_mainTask}" class="inputText" style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" name="other_workOrg" value="${other.objMap.other_workOrg}" class="inputText" style="width:80%;"/>
				           </td>
				        </tr>
				    </c:forEach>
				    </c:if>
				    </tbody>
					</table> 
	
            		</form>
            		
               		<div class="button" style="width:1000px; <c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none</c:if>">
               			<input id="prev" type="button" onclick="nextOpt('step2')" class="search" value="上一步"/>
						<input id="nxt" type="button" onclick="nextOpt('fundsBudget')" class="search" value="下一步"/>
   					</div>
</body>
</html>