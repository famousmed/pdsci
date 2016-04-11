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

function add(itemGroupName){
	var url = "?pageName="+$('#pageName').val()+
	"&itemGroupName="+itemGroupName+
	"&recFlow="+$('#recFlow').val()+
	"&projFlow="+$('#projFlow').val();
	jboxOpen("<s:url value='/srm/proj/mine/showPageGroupStep'/>"+url, "添加信息", 500,350);
}

function edit(flow,itemGroupName){
	var url = "?pageName="+$('#pageName').val()+
	"&itemGroupName="+itemGroupName+
	"&recFlow="+$('#recFlow').val()+
	"&projFlow="+$('#projFlow').val()+
	"&itemGroupFlow="+flow;
	jboxOpen("<s:url value='/srm/proj/mine/showPageGroupStep'/>"+url, "编辑信息", 500,350);
}

function del(flow,itemGroupName){
	var datas = {
			"pageName":$('#pageName').val(),
			"itemGroupName":itemGroupName,
			"recFlow":$('#recFlow').val(),
			"projFlow":$('#projFlow').val(),
			"itemGroupFlow":flow,
	};
	var url = "<s:url value='/srm/proj/mine/delPageGroupStep'/>";
	jboxPost(url , datas , function(){
		window.parent.frames['mainIframe'].location.reload(true);
		doClose();
	} , null , true);
}

function addCost(tb){
	var html = '<tr>'+
			'<td><input class="inputText" name="ids" type="checkbox"></td>'+
			'<td><input class="inputText" name="cost_costReason" style="width: 80%"></td>'+
			'<td><input class="inputText" name="cost_costCount" style="width: 50%"></td>'+
		'</tr>';
	$('#'+tb).append(html);
	
}

function delTr(tb){
	var checkboxs = $("input[name='ids']:checked");
	if(checkboxs.length==0){
		jboxTip("请勾选要删除的！");
		return false;
	}
	jboxConfirm("确认删除?",function () {
		var trs = $('#'+tb).find(':checkbox:checked');
		$.each(trs , function(i , n){
			$(n).parent('td').parent("tr").remove();
			
		});
	});
}
</script>
</c:if>
<style type="text/css">
.title_sp{padding-left: 10px;font-size: 14px; margin-bottom:10px; margin-top:10px; font-weight: bold;color: #333;}
</style>
<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" style="position: relative;">
    <input type="hidden" id="pageName" name="pageName" value="step3"/>
	<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
	<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
	<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
	<div class="title_sp">三、经费情况</div>
    <table width="100%" cellspacing="0" cellpadding="0" class="bs_tb">
	    <tr>
		    <th colspan="7" class="theader">项目实际到位经费情况</th>
	    </tr>
    	<tr>
		    <td width="14%">项目总经费</td>
			<td width="14%">国家拨款</td>
			<td width="14%">省拨款</td>
			<td width="14%">市拨款</td>
			<td width="14%">地方/部门配套</td>
			<td width="14%">自筹(含贷款)</td>
			<td>其他</td>
	    </tr>
	    <tbody>
		    <tr>
			    <td><input type="text" name="allCostCount" value="${resultMap.allCostCount }" class="inputText validate[custom[number]]" style="width:80%"></td>
				<td><input type="text" name="countryCost" value="${resultMap.countryCost }" class="inputText validate[custom[number]]" style="width:80%"></td>
				<td><input type="text" name="provinceCost" value="${resultMap.provinceCost }" class="inputText validate[custom[number]]" style="width:80%"></td>
				<td><input type="text" name="cityCost" value="${resultMap.cityCost }" class="inputText validate[custom[number]]" style="width:80%"></td>
				<td><input type="text" name="orgBelongPost" value="${resultMap.orgBelongPost }" class="inputText validate[custom[number]]" style="width:80%"></td>
				<td><input type="text" name="orgDoPost" value="${resultMap.orgDoPost }" class="inputText validate[custom[number]]" style="width:80%"></td>
				<td><input type="text" name="otherPost" value="${resultMap.otherPost }" class="inputText validate[custom[number]]" style="width:80%"></td>
			</tr>
		</tbody>
	</table> 
    <table width="100%" cellspacing="0" cellpadding="0" class="bs_tb" style="margin-top: 10px;">
        <tr>
		    <th colspan="3"  class="theader">项目经费支出情况<c:if test="${param.view != GlobalConstant.FLAG_Y}"><span style="float: right;padding-right: 10px"><img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addCost('costTb');"></img>&nbsp;<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('costTb');"></img></span></c:if></th>
		</tr>
		<tr>
		    <td width="10%"></td>
			<td width="50%">栏目</td>
			<td width="40%">金额</td>
		</tr>
		<tbody id="costTb">
		    <c:forEach var="cost" items="${resultMap.cost}" varStatus="sta">
			    <tr>
				    <td><input name="ids" type="checkbox"></td>
					<td><input type="text" name="cost_costReason" value="${cost.objMap.cost_costReason}" class="inputText" style="width: 80%"/></td>
					<td><input type="text" name="cost_costCount" value="${cost.objMap.cost_costCount}" class="inputText validate[custom[number]]" style="width: 50%"/></td>
				</tr>
			</c:forEach>
		</tbody>
		<tbody>
		    <tr>
			    <td></td>
	      		<td style="text-align: center;">合&#12288;计：</td>
				<td>
				    <input name="costSum"  value="${resultMap.costSum}" class="inputText validate[custom[number]]" style="width: 50%"/>
				</td>
			</tr>
		</tbody>
	</table>
</form>
<div class="button" width="100%" style="
<c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none</c:if>">
   <input id="prev" type="button" onclick="nextOpt('step2')" class="search" value="上一步"/>
   <input id="nxt" type="button" onclick="nextOpt('finish')" class="search" value="完成"/>
</div>

<!-- 
<body>
第三步 流水号：${param.projFlow}
<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm">
	<input type="hidden" id="pageName" name="pageName" value="step3"/>
	<input type="hidden" id="projRecFlow" name="projRecFlow" value="${param.projRecFlow}"/>
	<input type="hidden" id="projFlow" name="projFlow" value="${param.projFlow}"/>
	<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
	
	<fieldset>
<legend>项目实际到位经费情况:</legend>
<table>
	<thead>
		<tr>
		    <td>项目总经费</td>
			<td>国家拨款</td>
			<td>省拨款</td>
			<td>市拨款</td>
			<td>地方/部门配套</td>
			<td>自筹(含贷款)</td>
			<td>其他</td>
		</tr>
	</thead>
	<tbody>
	     <tr>
	        <td><input type="text" name="allCostCount" value="${resultMap.allCostCount }"></td>
	        <td><input type="text" name="countryCost" value="${resultMap.countryCost }"></td>
	        <td><input type="text" name="provinceCost" value="${resultMap.provinceCost }"></td>
	        <td><input type="text" name="cityCost" value="${resultMap.cityCost }"></td>
	        <td><input type="text" name="orgBelongPost" value="${resultMap.orgBelongPost }"></td>
	        <td><input type="text" name="orgDoPost" value="${resultMap.orgDoPost }"></td>
	        <td><input type="text" name="otherPost" value="${resultMap.otherPost }"></td>
	     </tr>
	</tbody>
	</table>
	</fieldset>
</form>
<a href="javascript:void(0)" onclick="add('cost');">新增</a><br/>
	<fieldset>
	  <legend>项目经费支出情况</legend>
	<table>
	<thead>
	   <tr>
	     <td>栏目</td>
	     <td>金额</td>
	   </tr>
	</thead>
	<tbody>
		<c:forEach var="cost" items="${resultMap.cost}" >
			<tr>
				<td>${cost.objMap.costReason }</td>
				<td>${cost.objMap.costCount }</td>
				<td>
				[<a href="javascript:void(0);" onclick="edit('${cost.flow}','cost')">编辑</a>]
				[<a href="javascript:void(0);" onclick="del('${cost.flow}','cost')">删除</a>]</td>
			</tr>
		</c:forEach>
	</tbody>
	</table>
	</fieldset>

<a href="javascript:void(0)" target="_self" onclick="nextOpt('step2')" id="next">上一步</a>
<a href="javascript:void(0)" target="_self"  onclick="nextOpt('finish')">完成</a>
</body>
 -->
