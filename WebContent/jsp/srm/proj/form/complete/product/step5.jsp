<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
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
	jboxOpen("<s:url value='/srm/proj/mine/showPageGroupStep'/>"+url, "添加信息", 700,500);
}

function edit(flow,itemGroupName){
	var url = "?pageName="+$('#pageName').val()+
	"&itemGroupName="+itemGroupName+
	"&recFlow="+$('#recFlow').val()+
	"&projFlow="+$('#projFlow').val()+
	"&itemGroupFlow="+flow;
	jboxOpen("<s:url value='/srm/proj/mine/showPageGroupStep'/>"+url, "编辑信息", 700,500);
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
			'<td><input type="checkbox"></td>'+
			'<td><input name="cost_costReason" class="inputText" style="width:70%"></td>'+
			'<td><input name="cost_costCount" class="inputText"></td>'+
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
<style type="text/css">
.title_sp{padding-left: 10px;font-size: 14px;padding-bottom: 10px;font-weight: bold;color: #333;}
</style>

<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" style="position: relative;">
    <input type="hidden" id="pageName" name="pageName" value="step5"/>
	<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
    <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
	<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
	<div class="title_sp">四、项目经费</div>
    <table width="100%" cellspacing="0" cellpadding="0" class="bs_tb">
	    <tbody>
		    <tr>
			    <th colspan="7" class="theader" >项目实际到位经费情况</th>
		    </tr>
            <tr>
		        <td>项目总经费</td>
			    <td>国家拨款</td>
			    <td>省拨款</td>
			    <td>市拨款</td>
			    <td>地方/部门配套</td>
			    <td>自筹(含贷款)</td>
			    <td>其他</td>
		    </tr>
	        <tr>
	            <td><input class="inputText" style="width: 80%;" name="allCostCount" value="${resultMap.allCostCount }"/></td>
	            <td><input class="inputText" style="width: 80%;" type="text" name="countryCost" value="${resultMap.countryCost }"/></td>
	            <td><input class="inputText" style="width: 80%;" type="text" name="provinceCost" value="${resultMap.provinceCost }"/></td>
	            <td><input class="inputText" style="width: 80%;" type="text" name="cityCost" value="${resultMap.cityCost }"/></td>
	            <td><input class="inputText" style="width: 80%;" type="text" name="orgBelongPost" value="${resultMap.orgBelongPost }"/></td>
	            <td><input class="inputText" style="width: 80%;" type="text" name="orgDoPost" value="${resultMap.orgDoPost }"/></td>
	            <td><input class="inputText" style="width: 80%;" type="text" name="otherPost" value="${resultMap.otherPost }"/></td>
	        </tr>
	    </tbody>
	</table>
	<table width="100%" cellspacing="0" cellpadding="0" class="bs_tb">
	    <tr>
	        <th colspan="11" class="theader">项目经费支出情况<c:if test="${param.view!=GlobalConstant.FLAG_Y }"><span style="float: right;padding-right: 10px"><a href="javascript:void(0)"><img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addCost('costTb');"></img></a>&nbsp;<a href="javascript:void(0)"><img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('costTb');"></img></a></span> </c:if></th>
	    </tr>
        <tr>
		    <td width="15%">序号</td>
		    <td width="40%">栏目</td>
		    <td width="40%">金额</td>
        </tr>
		<tbody id="costTb">
		    <c:forEach var="cost" items="${resultMap.cost}">
			    <tr>
				    <td><input type="checkbox"></td>
					<td><input type="text" name="cost_costReason" value="${cost.objMap.cost_costReason}" class="inputText" style="width:70%" /></td>
					<td><input type="text" name="cost_costCount" class="inputText" value="${cost.objMap.cost_costCount}"/></td>
				</tr>
			</c:forEach>
         </tbody>
	 </table>
</form>
<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
    <div class="button" style="width: 100%;">
        <input onclick="nextOpt('step3')" id="prev" class="search" type="button" value="上一步"/>
        <input onclick="nextOpt('step6')" id="nxt" class="search" type="button" value="下一步"/>
    </div>
</c:if>
