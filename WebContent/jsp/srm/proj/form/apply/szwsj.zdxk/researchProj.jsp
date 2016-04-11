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
			calculate();
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
	'<td width="50px" class="researchSerial"></td>'+
	'<td><input type="text" class="inputText" name="research_lessonNo" style="width:80%;"/></td>'+
	'<td><input type="text" class="inputText" name="research_projName" style="width:80%;"/></td>'+
	
	'<td><select name="research_projSource" class="validate[required] inputText" style="width:80%;" onchange="calculate()">'+
		'<option value="">请选择</option>'+
		'<option value="国家自然科学基金">国家自然科学基金</option>'+
		'<option value="卫生部">卫生部</option>'+
		'<option value="教育部">教育部</option>'+
		'<option value="科技厅">科技厅</option>'+
		'<option value="国际资助或国际合作">国际资助或国际合作</option>'+
		'<option value="科技局">科技局</option>'+
		'<option value="卫生局">卫生局</option>'+
	'</select></td>'+
	
	'<td><input type="text" class="inputText" name="research_projStartTime" onclick="WdatePicker({dateFmt:'+"'yyyy-MM-dd'"+'})" style="width:40%;margin-right: 0px;"/>'+
	' ~ <input type="text" class="inputText" name="research_projEndTime" onclick="WdatePicker({dateFmt:'+"'yyyy-MM-dd'"+'})" style="width:40%;"/>'+
	'</td>'+
	'<td><input type="text" class="inputText validate[custom[number]]" name="research_projFund" onchange="calculate()" style="width:80%;"/></td>'+
	'<td><input type="text" class="inputText" name="research_firstResponsiblePerson" style="width:80%;"/></td>'+
	'</tr>'; 
	$('#'+tb+'Tb').append(html);
	//序号
	$("#"+tb+"Tb").children("tr").last().children("td").eq(1).text(length+1);
}



function defaultIfEmpty(obj){
	if(isNaN(obj)){
		return 0;
	}else{
		return obj;
	}
}

//计算项目、经费
function calculate(){
	var countryProjNum = 0; 
	var hygieneMinistryProjNum = 0;
	var educationProjNum = 0;
	var scienceOfficeProjNum = 0;
	var internationalProjNum = 0;
	var scienceBureauProjNum = 0;
	var hygieneBureauProjNum = 0;
	var amountNum = 0;
	
	var countryProjFund = 0; 
	var hygieneMinistryProjFund = 0;
	var educationProjFund = 0;
	var scienceOfficeProjFund = 0;
	var internationalProjFund = 0;
	var scienceBureauProjFund = 0;
	var hygieneBureauProjFund = 0;
	var amountFunds = 0;

	//遍历经费
	$("input[name='research_projFund']").each(function (index, domEle) {
		var projFund  = domEle.value;
		//alert(projFund);
		if(projFund ==''){
			projFund = 0;
		}else{
			projFund  = parseFloat(projFund);
		}
		//项目来源
		var projSource = $(this).parent().prev().prev().children().val();
		if(projSource == '国家自然科学基金'){
			countryProjNum += 1;
			countryProjFund += projFund;
		}
		if(projSource == '卫生部'){
			hygieneMinistryProjNum += 1;
			hygieneMinistryProjFund += projFund;
		}
		if(projSource == '教育部'){
			educationProjNum += 1;
			educationProjFund += projFund;
		}
		if(projSource == '科技厅'){
			scienceOfficeProjNum += 1;
			scienceOfficeProjFund += projFund;
		}
		if(projSource == '国际资助或国际合作'){
			internationalProjNum += 1;
			internationalProjFund += projFund;
		}
		if(projSource == '科技局'){
			scienceBureauProjNum += 1;
			scienceBureauProjFund += projFund;
		}
		if(projSource == '卫生局'){
			hygieneBureauProjNum += 1;
			hygieneBureauProjFund += projFund;
		}
	});
	
	amountNum = countryProjNum + hygieneMinistryProjNum + educationProjNum + scienceOfficeProjNum + internationalProjNum + scienceBureauProjNum + hygieneBureauProjNum;
	
	$("input[name='countryProjNum']").val(countryProjNum);
	$("input[name='hygieneMinistryProjNum']").val(hygieneMinistryProjNum);
	$("input[name='educationProjNum']").val(educationProjNum);
	$("input[name='scienceOfficeProjNum']").val(scienceOfficeProjNum);
	$("input[name='internationalProjNum']").val(internationalProjNum);
	$("input[name='scienceBureauProjNum']").val(scienceBureauProjNum);
	$("input[name='hygieneBureauProjNum']").val(hygieneBureauProjNum);
	$("input[name='amountNum']").val(amountNum);
	
	amountFunds =  defaultIfEmpty(countryProjFund) + defaultIfEmpty(hygieneMinistryProjFund) + defaultIfEmpty(educationProjFund) + defaultIfEmpty(scienceOfficeProjFund) + defaultIfEmpty(internationalProjFund) + defaultIfEmpty(scienceBureauProjFund)  + defaultIfEmpty(hygieneBureauProjFund) ;
	
	// alert(amountFund +"  =  "+ countryProjFund  +" + "+  hygieneMinistryProjFund  +" + "+  educationProjFund  +" + "+  scienceOfficeProjFund  +" + "+  internationalProjFund  +" + "+  scienceBureauProjFund   +" + "+  hygieneBureauProjFund);
	
	$("input[name='countryProjFund']").val(countryProjFund);
	$("input[name='hygieneMinistryProjFund']").val(hygieneMinistryProjFund);
	$("input[name='educationProjFund']").val(educationProjFund);
	$("input[name='scienceOfficeProjFund']").val(scienceOfficeProjFund);
	$("input[name='internationalProjFund']").val(internationalProjFund);
	$("input[name='scienceBureauProjFund']").val(scienceBureauProjFund);
	$("input[name='hygieneBureauProjFund']").val(hygieneBureauProjFund);
	$("input[name='amountFunds']").val(parseFloat(amountFunds.toFixed(3)));
	
}
</script>
</c:if>


        	    	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" style="position: relative;">
						<input type="hidden" name="pageName" value="researchProj"/>
						<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
                        <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
						<input type="hidden" name="recTypeId" value="${param.recTypeId}"/>
   					<table class="bs_tb" style="width: 100%;margin-top: 10px;" id="research">
	   					<tr>
		   					<th colspan="8" class="theader">六、近五年为第一负责人在研的市级及以上科技项目共 <input type="text" name="researchNum" value="${resultMap.researchNum}" class="validate[custom[integer]] inputText" style="width:30px;"/> 项。（限填10项代表作）
		   					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
		   					<span style="float: right;padding-right: 10px">
		   					<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addProj('research',this);"></img>&nbsp;
		   					<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('research');"></img>
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
			                <td style="text-align: center;" >第一负责人</td>
          				</tr>
          			<tbody id="researchTb" class="tb">
          			<c:if test="${empty resultMap.research}">
          			    <tr>
				           <td width="50px"><input name="ids" type="checkbox"/></td>
				           <td width="50px" style="text-align: center;" class="researchSerial">1</td>
				           <td>
				           		<input type="text"  class="inputText" name="research_lessonNo"  style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText" name="research_projName"  style="width:80%;"/>
				           </td>
				           <td>
				           		<select name="research_projSource" class="validate[required] inputText" style="width:80%;" onchange="calculate()">
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
				           		<input type="text" class="inputText" name="research_projStartTime"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:40%;margin-right: 0px;"/>
				           	   	~
				           	   	<input type="text" class="inputText" name="research_projEndTime"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:40%;"/>
				           </td>
				           <td>
				             	<input type="text" class="inputText validate[custom[number]]" name="research_projFund"  onchange="calculate()" style="width:80%;"/>
				           </td>
				           <td>
				             	<input type="text" class="inputText" name="research_firstResponsiblePerson"  style="width:80%;"/>
				           </td>
				        </tr>
          			
          			</c:if>
          			<c:if test="${! empty resultMap.research}">
					<c:forEach var="research" items="${resultMap.research}" varStatus="status">
				        <tr>
				           <td width="50px"><input name="ids" type="checkbox"/></td>
				           <td width="50px" style="text-align: center;" class="researchSerial">${status.count}</td>
				           <td>
				           		<input type="text"  class="inputText" name="research_lessonNo" value="${research.objMap.research_lessonNo}" style="width:80%;"/>
				           </td>
				           <td>
				           		<input type="text" class="inputText" name="research_projName" value="${research.objMap.research_projName}" style="width:80%;"/>
				           </td>
				           <td>
				           		<select name="research_projSource" class="validate[required] inputText" style="width:80%;" onchange="calculate()">
				           			<option value="">请选择</option>
				           			<option value="国家自然科学基金" <c:if test="${research.objMap.research_projSource eq '国家自然科学基金'}">selected="selected"</c:if> >国家自然科学基金</option>
									<option value="卫生部" <c:if test="${research.objMap.research_projSource eq '卫生部'}">selected="selected"</c:if> >卫生部</option>
									<option value="教育部" <c:if test="${research.objMap.research_projSource eq '教育部'}">selected="selected"</c:if> >教育部</option>
									<option value="科技厅" <c:if test="${research.objMap.research_projSource eq '科技厅'}">selected="selected"</c:if> >科技厅</option>
									<option value="国际资助或国际合作" <c:if test="${research.objMap.research_projSource eq '国际资助或国际合作'}">selected="selected"</c:if> >国际资助或国际合作</option>
									<option value="科技局" <c:if test="${research.objMap.research_projSource eq '科技局'}">selected="selected"</c:if> >科技局</option>
									<option value="卫生局" <c:if test="${research.objMap.research_projSource eq '卫生局'}">selected="selected"</c:if> >卫生局</option>
				           		</select>
				           </td>
				           <td>
				           		<input type="text" class="inputText" name="research_projStartTime" value="${research.objMap.research_projStartTime}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:40%;margin-right: 0px;"/>
				           	   	~
				           	   	<input type="text" class="inputText" name="research_projEndTime" value="${research.objMap.research_projEndTime}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:40%;"/>
				           </td>
				           <td>
				             	<input type="text" class="inputText validate[custom[number]]" name="research_projFund" value="${research.objMap.research_projFund}" onchange="calculate()" style="width:80%;"/>
				           </td>
				           <td>
				             	<input type="text" class="inputText" name="research_firstResponsiblePerson" value="${research.objMap.research_firstResponsiblePerson}" style="width:80%;"/>
				           </td>
				        </tr>
				    </c:forEach>
				    </c:if>
				    </tbody>
					</table><br/>
					
					
					<table id="amount" class="bs_tb" style="width: 100%;">
						<tr>
							<td style="text-align: center;" width="14%">按项目、课题来源统计</td>
							<td style="text-align: center;" width="13%">国家自然科学基金</td>
							<td style="text-align: center;">卫生部</td>
							<td style="text-align: center;">教育部</td>
							<td style="text-align: center;">科技厅</td>
							<td style="text-align: center;" width="14%">国际资助或国际合作</td>
							<td style="text-align: center;">科技局</td>
							<td style="text-align: center;">卫生局</td>
							<td style="text-align: center;">合计</td>
						</tr>
						<tr>
							<td style="text-align: center;">项目(个)</td>
							<td><input readonly="readonly" type="text" name="countryProjNum" value="${resultMap.countryProjNum}" class="inputText validate[custom[integer]]" style="width:60%;"/></td>
							<td><input readonly="readonly" type="text" name="hygieneMinistryProjNum" value="${resultMap.hygieneMinistryProjNum}" class="inputText validate[custom[integer]]" style="width:60%;"/></td>
							<td><input readonly="readonly" type="text" name="educationProjNum" value="${resultMap.educationProjNum}" class="inputText validate[custom[integer]]" style="width:60%;"/></td>
							<td><input readonly="readonly" type="text" name="scienceOfficeProjNum" value="${resultMap.scienceOfficeProjNum}" class="inputText validate[custom[integer]]" style="width:60%;"/></td>
							<td><input readonly="readonly" type="text" name="internationalProjNum" value="${resultMap.internationalProjNum}" class="inputText validate[custom[integer]]" style="width:60%;"/></td>
							<td><input readonly="readonly" type="text" name="scienceBureauProjNum" value="${resultMap.scienceBureauProjNum}" class="inputText validate[custom[integer]]" style="width:60%;"/></td>
							<td><input readonly="readonly" type="text" name="hygieneBureauProjNum" value="${resultMap.hygieneBureauProjNum}" class="inputText validate[custom[integer]]" style="width:60%;"/></td>
							<td><input readonly="readonly" type="text" name="amountNum" value="${resultMap.amountNum}" class="inputText validate[custom[integer]]" style="width:60%;"/></td>
						</tr>
						<tr>
							<td style="text-align: center;">经费(万元)</td>
							<td><input readonly="readonly" type="text" name="countryProjFund" value="${resultMap.countryProjFund}" class="inputText validate[custom[number]]" style="width:60%;"/></td>
							<td><input readonly="readonly" type="text" name="hygieneMinistryProjFund" value="${resultMap.hygieneMinistryProjFund}" class="inputText validate[custom[number]]" style="width:60%;"/></td>
							<td><input readonly="readonly" type="text" name="educationProjFund" value="${resultMap.educationProjFund}" class="inputText validate[custom[number]]" style="width:60%;"/></td>
							<td><input readonly="readonly" type="text" name="scienceOfficeProjFund" value="${resultMap.scienceOfficeProjFund}" class="inputText validate[custom[number]]" style="width:60%;"/></td>
							<td><input readonly="readonly" type="text" name="internationalProjFund" value="${resultMap.internationalProjFund}" class="inputText validate[custom[number]]" style="width:60%;"/></td>
							<td><input readonly="readonly" type="text" name="scienceBureauProjFund" value="${resultMap.scienceBureauProjFund}" class="inputText validate[custom[number]]" style="width:60%;"/></td>
							<td><input readonly="readonly" type="text" name="hygieneBureauProjFund" value="${resultMap.hygieneBureauProjFund}" class="inputText validate[custom[number]]" style="width:60%;"/></td>
							<td><input readonly="readonly" type="text" name="amountFunds" value="${resultMap.amountFunds}" class="inputText validate[custom[number]]" style="width:60%;"/></td>
						</tr>
					</table>
					</form>
					 
                	 <div class="button" style="width:100%;
                	 <c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none;</c:if>">
                	 	<input id="prev" type="button" onclick="nextOpt('completeProj')" class="search" value="上一步"/>
                	    <input id="nxt" type="button" onclick="nextOpt('progressPraise')" class="search" value="下一步"/>
      			     </div>
