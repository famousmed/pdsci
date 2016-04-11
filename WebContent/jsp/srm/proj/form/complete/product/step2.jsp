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
			"&itemGroupName=":itemGroupName,
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

function delTr(tb){
	var trs = $('#'+tb).find(':checkbox:checked');
	jboxConfirm("确认删除？" , function(){
		$.each(trs , function(i , n){
			$(n).parent('td').parent("tr").remove();
			
		});
		
	});
}

function addTarget(tb){
	var htm = '<tr>'+
        '<td><input type="checkbox"/></td>'+
        "<td><input name='target_name' class='inputText'/></td>"+
        "<td><input name='target_org' class='inputText'/></td>"+
        "<td><input name='target_contract' class='inputText'/></td>"+
        "<td><input name='target_complete' class='inputText'/></td>"+
      '</tr>';
	$('#'+tb).append(htm);
}

</script>
</c:if>
<style type="text/css">
.inputText{width: 80%;}
</style>
<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" style="position: relative;">
    <input type="hidden" id="pageName" name="pageName" value="step2"/>
	<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
    <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
	<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
	<table width="100%" cellspacing="0" cellpadding="0" class="bs_tb">
	    <tr>
		    <th colspan="5" class="theader">二、指标完成情况<c:if test="${param.view!=GlobalConstant.FLAG_Y }"><span style="float: right;margin-right: 5px;"><a href="javascript:void(0)"><img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addTarget('targetTb');"></img></a>&nbsp;<a href="javascript:void(0)"><img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('targetTb')"></img></a></span> </c:if></th>
		</tr>
		<tr>
		    <td style="width: 5%;">序号</td>
            <td style="width: 20%;">技术指标名称</td>
            <td style="width: 20%;">单位</td>
            <td style="width: 25%;">合同技术指标</td>
            <td >指标实际完成情况</td>
        </tr>
	    <tbody id='targetTb'>
	        <c:forEach var="target" items="${resultMap.target}">
	            <tr>
	                <td><input type="checkbox"/></td>
	                <td><input name='target_name' value='${target.objMap.target_name}' class="inputText" /></td>
	                <td><input name='target_org' value='${target.objMap.target_org}' class="inputText"/></td>
	                <td><input name='target_contract' value='${target.objMap.target_contract}' class="inputText"/></td>
	                <td><input name='target_complete' value='${target.objMap.target_complete}' class="inputText"/></td>
	            </tr>
	        </c:forEach>
	    </tbody>
	</table>
	<table width="100%" cellspacing="0" cellpadding="0" class="basic" style="margin-top: 10px;">
		<tr>
			<th colspan="5" style="font-weight:bold; text-align: left;padding-left: 15px;font-size: 13px;">其他情况说明</th>
		</tr>
		<tr>
			<td colspan="5">
			 <c:choose>
                   <c:when test="${param.view==GlobalConstant.FLAG_Y}">
                    ${resultMap.otherThing}
                   </c:when>
                 <c:otherwise> 
			<textarea name="otherThing" rows="6" cols="20" class="xltxtarea">${resultMap.otherThing }</textarea>
			  </c:otherwise>
			  </c:choose>
			</td>
		</tr>
	</table>
</form>
<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
    <div class="button" style="width: 100%;">
       <input id="prev" type="button" onclick="nextOpt('step1')" class="search" value="上一步"/>
       <input id="nxt" type="button" onclick="nextOpt('step3')" class="search" value="下一步"/>
    </div>
</c:if>
