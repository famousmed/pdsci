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
		jboxClose();
	} , null , true);
	
}

function addCost(tb){
	var html = '<tr>'+
			'<td><input class="inputText" type="checkbox"></td>'+
			'<td><input class="inputText" name="cost_costReason"></td>'+
			'<td><input class="inputText" name="cost_costCount"></td>'+
		'</tr>';
	$('#'+tb).append(html);
	
}

function delTr(tb){
	var trs = $('#'+tb).find(':checkbox:checked');
	$.each(trs , function(i , n){
		$(n).parent('td').parent("tr").remove();
		
	});
	
}
</script>
</c:if>
<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" style="position: relative;">
    <input type="hidden" id="pageName" name="pageName" value="step3"/>
	<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
    <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
	<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
    <div>
        <font style="font-size: 14px; font-weight:bold; margin-top: 10px; padding-left: 10px;color: #333; ">三、项目经费</font>
    </div>			
    <table width="100%" cellspacing="0" cellpadding="0"  style="margin-top: 10px;" class="bs_tb">
        <tr>
            <th colspan="5" class="theader">市财政拨款情况</th>
        </tr>
        <tr>
            <td colspan="1" style="text-align: right;">市财政计划下达经费：</td>
           	<td colspan="2"><input type="text" class="inputText validate[required]" name="cityCostPlan" value="${resultMap.cityCostPlan }"></td>
           	<td colspan="1" style="text-align: right;">市财政已下达经费：</td>
           	<td colspan="2"><input type="text" class="inputText validate[required]" name="cityCost" value="${resultMap.cityCost }"></td>
        </tr>
    </table>
    <table width="100%" class="bs_tb" style="margin-top: 20px;">
        <tr>
            <th colspan="7" class="theader">项目实际到位经费情况</th>
        </tr>
		<tr>
		    <td style="font-weight:bold;">项目总经费</td>
			<td style="font-weight:bold;">国家拨款</td>
			<td style="font-weight:bold;">省拨款</td>
			<td style="font-weight:bold;">市拨款</td>
			<td style="font-weight:bold;">地方/部门配套</td>
			<td style="font-weight:bold;">自筹(含贷款)</td>
			<td style="font-weight:bold;">其他</td>
        </tr>
		<tbody>
		    <tr>
			    <td><input type="text" class="inputText validate[required]" name="allCostCount" value="${resultMap.allCostCount }" style="width:100px;"></td>
				<td><input type="text" class="inputText validate[required]" name="countryCost" value="${resultMap.countryCost }" style="width:100px;"></td>
				<td><input type="text" class="inputText validate[required]" name="provinceCost" value="${resultMap.provinceCost }" style="width:100px;"></td>
				<td><input type="text" class="inputText validate[required]" name="cityCost" value="${resultMap.cityCost }" style="width:100px;"></td>
				<td><input type="text" class="inputText validate[required]" name="orgBelongPost" value="${resultMap.orgBelongPost }" style="width:100px;"></td>
				<td><input type="text" class="inputText validate[required]" name="orgDoPost" value="${resultMap.orgDoPost }" style="width:100px;"></td>
				<td><input type="text"  class="inputText validate[required]" name="otherPost" value="${resultMap.otherPost }" style="width:100px;"></td>
            </tr>
		</tbody>
    </table> 
    <table width="100%" cellspacing="0" cellpadding="0" class="bs_tb" style="margin-top: 10px;">
	    <tr>
	        <th colspan="3" class="theader">项目经费支出情况
	        <c:if test="${param.view!=GlobalConstant.FLAG_Y }"><span style="float: right;padding-right: 10px"><img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addCost('costTb');"></img>&#12288;<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('costTb');"></img></span> </c:if>
	    </tr>
		<tr>
		    <td width="20%" style="font-weight:bold;">序号</td>
			<td width="40%" style="font-weight:bold;">栏目</td>
			<td width="40%" style="font-weight:bold;">金额</td>
		</tr>
		<tbody id="costTb">
		    <c:forEach var="cost" items="${resultMap.cost}" varStatus="sta">
			    <tr>
				    <td width="20%"><input type="checkbox"></td>
					<td width="40%"><input type="text" class="inputText validate[required]" name="cost_costReason" value="${cost.objMap.cost_costReason}"/></td>
					<td width="40%"><input type="text" class="inputText validate[required]" name="cost_costCount" value="${cost.objMap.cost_costCount}"/></td>
				</tr>
			</c:forEach>
		</tbody>
		<tbody>
		    <tr>
		        <td></td>
          		<td>合计</td>
          		<td><input name="costSum" class="inputText validate[required]"  value="${resultMap.costSum}"/></td>
          	</tr>
		</tbody>
	</table>
    <table width="100%" style="margin-top: 10px;" cellspacing="0" cellpadding="0" class="basic">
        <tr>
		    <th width="100%" style="padding-left:15px;text-align:left;">结余经费处理意见：</th>
		</tr>
		<tr>
		    <td>
			    <c:choose>
                    <c:when test="${param.view==GlobalConstant.FLAG_Y}">
                        ${resultMap.otherMoney}
                    </c:when>
                    <c:otherwise>
				        <textarea placeholder="此处填写该项目的结余经费处理意见" name="otherMoney" class="xltxtarea">${resultMap.otherMoney}</textarea>
				    </c:otherwise>
				</c:choose>
			</td>
		</tr>
	</table>
</form>
<div class="button" style="width:100%; <c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none</c:if>">
    <input onclick="nextOpt('step2')" id="prev" class="search" type="button" value="上一步"/>
    <input onclick="nextOpt('finish')" id="nxt" class="search" type="button" value="完成"/>
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
