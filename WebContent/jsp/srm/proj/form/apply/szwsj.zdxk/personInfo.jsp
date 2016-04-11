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
			calculate();
		});
		//删除后序号
		var serial = 0;
		$("."+tb+"Serial").each(function(){
			serial += 1;
			$(this).text(serial);
		});
	});
	
	calculate();
}

function addPerson(tb,obj){
	
	var length = $("#"+tb+"Tb").children().length;
	if(length > 19){
		jboxTip("限20人以内!");
		return false; 
	}
	//$("input[name="+tb+"Num]").val(length+1);
	
	var html = '<tr>'+
	'<td width="50px"><input name="ids" type="checkbox"/></td>'+
	'<td width="50px" class="personSerial"></td>'+
	'<td><input type="text" class="validate[required] inputText" name="person_name" style="width:80%;"/></td>'+
	'<td><input type="text" class="inputText validate[required] validate[custom[integer]]" name="person_age"  onchange="calculate()" style="width:80%;"/></td>'+
	
	'<td><select name="person_education" class="validate[required] inputText" style="width: 85%;">'+
    '<option value="">请选择</option>'+
    '<c:forEach var="dict" items="${dictTypeEnumUserEducationList}">'+
    '<option value="${dict.dictId}">${dict.dictName}</option>'+
    '</c:forEach>'+
 	'</select></td>'+
	
	'<td><select name="person_technologyTitle" class="validate[required] inputText"  onchange="calculate()">'+
	'<option value="">请选择</option>'+
    '<option value="主任医师">主任医师</option>'+
    '<option value="副主任医师">副主任医师</option>'+
    '<option value="主治医师">主治医师</option>'+
	'</select></td>'+
	'<td><input type="text" class="validate[required] inputText" name="person_organization" style="width:80%;"/></td>'+
	'<td><input type="text" class="validate[required] inputText" name="person_offices" style="width:80%;"/></td>'+
	'<td><input type="text" class="validate[required] inputText" name="person_major" style="width:80%;"/></td>'+
	'</tr>'; 
	$('#'+tb+'Tb').append(html);
	//序号
	$("#"+tb+"Tb").children("tr").last().children("td").eq(1).text(length+1);
}


function calculate(){
	var directorPhysicianAmount = 0;
	var directorPhysicianLess35 = 0;
	var directorPhysicianBetween36And45 = 0;
	var directorPhysicianBetween46And55 = 0;
	var directorPhysicianBetween56And60 = 0;
	var directorPhysicianGreater61 = 0;
	
	var assistantPhysicianAmount = 0;
	var assistantPhysicianLess35 = 0;
	var assistantPhysicianBetween36And45 = 0;
	var assistantPhysicianBetween46And55 = 0;
	var assistantPhysicianBetween56And60 = 0;
	var assistantPhysicianGreater61 = 0;
	
	var staffPhysicianAmount = 0;
	var staffPhysicianLess35 = 0;
	var staffPhysicianBetween36And45 = 0;
	var staffPhysicianBetween46And55 = 0;
	var staffPhysicianBetween56And60 = 0;
	var staffPhysicianGreater61 = 0;
	//遍历年龄
	$("input[name='person_age']").each(function (index, domEle) {
		var age = domEle.value;
		var technologyTitle = $(this).parent().next().next().children().val();
		//alert(domEle.value+","+technologyTitle);
		if(technologyTitle =='主任医师'){
			directorPhysicianAmount += 1;
			if(age > 0 && age <= 35){
				directorPhysicianLess35 += 1;
			}else if(age >= 36 && age <= 45){
				directorPhysicianBetween36And45 += 1;
			}else if(age >= 46 && age <= 55){
				directorPhysicianBetween46And55 += 1;
			}else if(age >= 56 && age <= 60){
				directorPhysicianBetween56And60 += 1;
			}else if(age >= 61){
				directorPhysicianGreater61 += 1;
			}
		}
		if(technologyTitle =='副主任医师'){
			assistantPhysicianAmount += 1;
			if(age > 0 && age <= 35){
				assistantPhysicianLess35 += 1;
			}else if(age >= 36 && age <= 45){
				assistantPhysicianBetween36And45 += 1;
			}else if(age >= 46 && age <= 55){
				assistantPhysicianBetween46And55 += 1;
			}else if(age >= 56 && age <= 60){
				assistantPhysicianBetween56And60 += 1;
			}else if(age >= 61){
				assistantPhysicianGreater61 += 1;
			}
		}
		if(technologyTitle =='主治医师'){
			staffPhysicianAmount += 1;
			if(age > 0 && age <= 35){
				staffPhysicianLess35 += 1;
			}else if(age >= 36 && age <= 45){
				staffPhysicianBetween36And45 += 1;
			}else if(age >= 46 && age <= 55){
				staffPhysicianBetween46And55 += 1;
			}else if(age >= 56 && age <= 60){
				staffPhysicianBetween56And60 += 1;
			}else if(age >= 61){
				staffPhysicianGreater61 += 1;
			}
		}
	}); 
	
	$("input[name='directorPhysicianAmount']").val(directorPhysicianAmount);
	$("input[name='directorPhysicianLess35']").val(directorPhysicianLess35);
	$("input[name='directorPhysicianBetween36And45']").val(directorPhysicianBetween36And45);
	$("input[name='directorPhysicianBetween46And55']").val(directorPhysicianBetween46And55);
	$("input[name='directorPhysicianBetween56And60']").val(directorPhysicianBetween56And60);
	$("input[name='directorPhysicianGreater61']").val(directorPhysicianGreater61);
	
	$("input[name='assistantPhysicianAmount']").val(assistantPhysicianAmount);
	$("input[name='assistantPhysicianLess35']").val(assistantPhysicianLess35);
	$("input[name='assistantPhysicianBetween36And45']").val(assistantPhysicianBetween36And45);
	$("input[name='assistantPhysicianBetween46And55']").val(assistantPhysicianBetween46And55);
	$("input[name='assistantPhysicianBetween56And60']").val(assistantPhysicianBetween56And60);
	$("input[name='assistantPhysicianGreater61']").val(assistantPhysicianGreater61);
	
	$("input[name='staffPhysicianAmount']").val(staffPhysicianAmount);
	$("input[name='staffPhysicianLess35']").val(staffPhysicianLess35);
	$("input[name='staffPhysicianBetween36And45']").val(staffPhysicianBetween36And45);
	$("input[name='staffPhysicianBetween46And55']").val(staffPhysicianBetween46And55);
	$("input[name='staffPhysicianBetween56And60']").val(staffPhysicianBetween56And60);
	$("input[name='staffPhysicianGreater61']").val(staffPhysicianGreater61);
}

</script>
</c:if>

        	    	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" style="position: relative;">
						<input type="hidden" name="pageName" value="personInfo"/>
						<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
                        <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
						<input type="hidden" name="recTypeId" value="${param.recTypeId}"/>
   					<table class="bs_tb" style="width: 100%;margin-top: 10px;">
   						<tr>
	   						<th colspan="9" class="theader">四、重点学科人员信息（限20人以内）<span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
	   						<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
	   						<span style="float: right;padding-right: 10px">
	   						<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addPerson('person',this);"></img>&nbsp;
	   						<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('person');"></img>
	   						</span> 
	   						</c:if>
	   						</th>
   						</tr>
       					<tr>
			           		<td style="text-align: center;" width="50px"></td>
			           		<td style="text-align: center;" width="50px">序号</td>
			                <td style="text-align: center;" width="100px">姓名</td>
			                <td style="text-align: center;" width="80px">年龄</td>
			                <td style="text-align: center;" width="100px">学历</td>
			                <td style="text-align: center;" width="100px">技术职称</td>
			                <td style="text-align: center;" >所在单位</td>
			                <td style="text-align: center;" width="150px">科室</td>
			                <td style="text-align: center;" width="150px">专业</td>
          				</tr>
          			<tbody id="personTb">
          			<c:if test="${empty resultMap.person}">
          			    <tr>
				           <td width="50px"><input name="ids" type="checkbox"/></td>
				           <td width="50px" style="text-align: center;" class="personSerial">1</td>
				           <td >
				           		<input type="text" class="inputText" name="person_name"  style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText validate[required] validate[custom[integer]]" name="person_age"  onchange="calculate()"  style="width:80%;"/>
				           </td>
				           <td>
								<select name="person_education" class="inputText" style="width: 85%;">
				                   <option value="">请选择</option>
				                   <c:forEach var="dict" items="${dictTypeEnumUserEducationList}">
				                   <option value="${dict.dictId}">${dict.dictName}</option> 
				                   </c:forEach>
				                </select>
				           </td>
				           <td>
				           		<select name="person_technologyTitle" class="inputText"  onchange="calculate()">
				           		   <option value="">请选择</option>
							       <option value="主任医师" >主任医师</option>
							       <option value="副主任医师">副主任医师</option>
							       <option value="主治医师" >主治医师</option>
								</select>
				           </td>
				           <td>
				             	<input type="text" class="inputText" name="person_organization"  style="width:80%;"/>
				           </td>
				           <td>
				             	<input type="text" class="inputText" name="person_offices" style="width:80%;"/>
				           </td>
				           <td>
				             	<input type="text" class="inputText" name="person_major"  style="width:80%;"/>
				           </td>
				        </tr>
          			</c:if>
          			
          			
          			<c:if test="${! empty resultMap.person}">
					<c:forEach var="person" items="${resultMap.person}" varStatus="status">
				        <tr>
				           <td width="50px"><input name="ids" type="checkbox"/></td>
				           <td width="50px" style="text-align: center;" class="personSerial">${status.count}</td>
				           <td >
				           		<input type="text" class="inputText" name="person_name" value="${person.objMap.person_name}" style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText validate[required] validate[custom[integer]]" name="person_age"  onchange="calculate()" value="${person.objMap.person_age}" style="width:80%;"/>
				           </td>
				           <td>
								<select name="person_education" class="inputText" style="width: 85%;">
				                   <option value="">请选择</option>
				                   <c:forEach var="dict" items="${dictTypeEnumUserEducationList}">
				                   <option value="${dict.dictId}" <c:if test="${person.objMap.person_education eq dict.dictId}">selected="selected"</c:if>>${dict.dictName}</option> 
				                   </c:forEach>
				                </select>
				           </td>
				           <td>
				           		<select name="person_technologyTitle" class="inputText"  onchange="calculate()">
				           		   <option value="">请选择</option>
							       <option value="主任医师" <c:if test="${person.objMap.person_technologyTitle eq '主任医师'}">selected="selected"</c:if> >主任医师</option>
							       <option value="副主任医师" <c:if test="${person.objMap.person_technologyTitle eq '副主任医师'}">selected="selected"</c:if> >副主任医师</option>
							       <option value="主治医师" <c:if test="${person.objMap.person_technologyTitle eq '主治医师'}">selected="selected"</c:if> >主治医师</option>
								</select>
				           </td>
				           <td>
				             	<input type="text" class="inputText" name="person_organization" value="${person.objMap.person_organization}" style="width:80%;"/>
				           </td>
				           <td>
				             	<input type="text" class="inputText" name="person_offices" value="${person.objMap.person_offices}" style="width:80%;"/>
				           </td>
				           <td>
				             	<input type="text" class="inputText" name="person_major" value="${person.objMap.person_major}" style="width:80%;"/>
				           </td>
				        </tr>
				    </c:forEach>
				    </c:if>
				    </tbody>
					</table><br/>
					
					
					<table class="bs_tb" style="width: 100%;">
						<tr>
							<td rowspan="4" width="100px" style="text-align: center; font-weight:bold;">年龄结构</td>
							<td width="150px" style="text-align: center; font-weight:bold;">技术职称</td>
							<td style="text-align: center; font-weight:bold;">合  计</td>
							<td style="text-align: center; font-weight:bold;">35岁以下</td>
							<td style="text-align: center; font-weight:bold;">36-45岁</td>
							<td style="text-align: center; font-weight:bold;">46-55岁</td> 
							<td style="text-align: center; font-weight:bold;">56-60岁</td> 
							<td style="text-align: center; font-weight:bold;">61岁以上</td> 
						</tr>
						<tr>
							<td style="text-align: center; font-weight:bold;">主任医师</td>
							<td><input readonly="readonly" type="text" name="directorPhysicianAmount" value="${resultMap.directorPhysicianAmount}" class="inputText validate[custom[integer]]" style="width:80%;"/></td>
							<td><input readonly="readonly" type="text" name="directorPhysicianLess35" value="${resultMap.directorPhysicianLess35}" class="inputText validate[custom[integer]]" style="width:80%;"/></td>
							<td><input readonly="readonly" type="text" name="directorPhysicianBetween36And45" value="${resultMap.directorPhysicianBetween36And45}" class="inputText validate[custom[integer]]" style="width:80%;"/></td>
							<td><input readonly="readonly" type="text" name="directorPhysicianBetween46And55" value="${resultMap.directorPhysicianBetween46And55}" class="inputText validate[custom[integer]]" style="width:80%;"/></td>
							<td><input readonly="readonly" type="text" name="directorPhysicianBetween56And60" value="${resultMap.directorPhysicianBetween56And60}" class="inputText validate[custom[integer]]" style="width:80%;"/></td>
							<td><input readonly="readonly" type="text" name="directorPhysicianGreater61" value="${resultMap.directorPhysicianGreater61}" class="inputText validate[custom[integer]]" style="width:80%;"/></td>
						</tr>
						<tr>
							<td style="text-align: center; font-weight:bold;">副主任医师</td>
							<td><input readonly="readonly" type="text" name="assistantPhysicianAmount" value="${resultMap.assistantPhysicianAmount}" class="inputText validate[custom[integer]]" style="width:80%;"/></td>
							<td><input readonly="readonly" type="text" name="assistantPhysicianLess35" value="${resultMap.assistantPhysicianLess35}" class="inputText validate[custom[integer]]" style="width:80%;"/></td>
							<td><input readonly="readonly" type="text" name="assistantPhysicianBetween36And45" value="${resultMap.assistantPhysicianBetween36And45}" class="inputText validate[custom[integer]]" style="width:80%;"/></td>
							<td><input readonly="readonly" type="text" name="assistantPhysicianBetween46And55" value="${resultMap.assistantPhysicianBetween46And55}" class="inputText validate[custom[integer]]" style="width:80%;"/></td>
							<td><input readonly="readonly" type="text" name="assistantPhysicianBetween56And60" value="${resultMap.assistantPhysicianBetween56And60}" class="inputText validate[custom[integer]]" style="width:80%;"/></td>
							<td><input readonly="readonly" type="text" name="assistantPhysicianGreater61" value="${resultMap.assistantPhysicianGreater61}" class="inputText validate[custom[integer]]" style="width:80%;"/></td>
						</tr>
						<tr>
							<td style="text-align: center; font-weight:bold;">主治医师</td>
							<td><input readonly="readonly" type="text" name="staffPhysicianAmount" value="${resultMap.staffPhysicianAmount}" class="inputText validate[custom[integer]]" style="width:80%;"/></td>
							<td><input readonly="readonly" type="text" name="staffPhysicianLess35" value="${resultMap.staffPhysicianLess35}" class="inputText validate[custom[integer]]" style="width:80%;"/></td>
							<td><input readonly="readonly" type="text" name="staffPhysicianBetween36And45" value="${resultMap.staffPhysicianBetween36And45}" class="inputText validate[custom[integer]]" style="width:80%;"/></td>
							<td><input readonly="readonly" type="text" name="staffPhysicianBetween46And55" value="${resultMap.staffPhysicianBetween46And55}" class="inputText validate[custom[integer]]" style="width:80%;"/></td>
							<td><input readonly="readonly" type="text" name="staffPhysicianBetween56And60" value="${resultMap.staffPhysicianBetween56And60}"class="inputText validate[custom[integer]]" style="width:80%;"/></td>
							<td><input readonly="readonly" type="text" name="staffPhysicianGreater61" value="${resultMap.staffPhysicianGreater61}" class="inputText validate[custom[integer]]" style="width:80%;"/></td>
						</tr>
					</table>
					</form>
					
                	 <div class="button" style="width:100%;
                	 <c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none;</c:if>">
                	 	<input id="prev" type="button" onclick="nextOpt('achievement')" class="search" value="上一步"/>
                	    <input id="nxt" type="button" onclick="nextOpt('completeProj')" class="search" value="下一步"/>
      			     </div>
