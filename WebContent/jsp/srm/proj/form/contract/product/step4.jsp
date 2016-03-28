<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
</jsp:include>
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
	jboxOpen("<s:url value='/srm/proj/mine/showPageGroupStep'/>"+url, "添加信息", 700,500);
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

function addBudget(tb){
	var html=' <tr>'+
		'<td><input type="checkbox"/></td>'+
        '<td><input  name="projBudget_name" class="inputText"/></td>'+
        '<td><input style="width:80%;" name="projBudget_sum" class="inputText"/></td>'+
        '<td><input style="width:80%;" name="projBudget_govPostPlan" class="inputText"/></td>'+
        '<td><input name="projBudget_remark" class="inputText"/></td>'+
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
table tr.th_bold td {font-weight: bold;}
</style>

<div id="main">
	<div class="mainright">
		<div class="content">
        	    	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm">
						<input type="hidden" id="pageName" name="pageName" value="step4"/>
						<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
                        <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
						<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
                		<table width="100%" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
              				<tr>
                				<td>
                					<table width="100%" cellspacing="0" cellpadding="0" class="basic">
           								<tr>
               								<th colspan="11" style=" font-weight:bold; text-align: left;padding-left: 15px;font-size: 14px;">四、经费来源(单位：万元)</th>
           								</tr>
           								<tr>
           									<td width="20%" style="text-align: right;">项目总投入：</td>
                							<td width="30%"><input type="text" name="projFundSum" value="<c:if test='${! empty resultMap.projFundSum}'>${resultMap.projFundSum}</c:if><c:if test='${empty resultMap.projFundSum}'>${projInfoMap.projFund[0].objMap.projFundSum}</c:if>" class="inputText"/></td>
                							<td width="20%" style="text-align: right;">前期投入：</td>
                							<td width="30%"><input type="text" name="projFundEarly" value="<c:if test='${! empty resultMap.projFundEarly}'>${resultMap.projFundEarly}</c:if><c:if test='${empty resultMap.projFundEarly}'>${projInfoMap.projFund[0].objMap.projFundEarly}</c:if>" class="inputText"/></td>
           								</tr>
      								</table>
      							</td>
              				</tr>
              				<tr>
                				<td>
                					<table width="100%" cellspacing="0" cellpadding="0" class="bs_tb">
           								<tr class="th_bold">
           									<td width="20%">栏目</td>
                							<td width="15%">合计</td>
                							<td width="15%">第一年</td>
                							<td width="15%">第二年</td>
                							<td width="15%">第三年</td>
                							<td>备注</td>
           								</tr>
							           	<tr>
							                <td style="font-weight:bold;">新增收入</td>
							                <td><input type="text" id="allCount"  style="width:80%;" name="allCount" value="${resultMap.allCount}" class="inputText" /></td>
		   									<td><input type="text" id="newFirstYear" style="width:80%;" name="newFirstYear" value="${resultMap.newFirstYear }" class="inputText"/></td>
		  				 					<td><input type="text" id="newSecondYear"  style="width:80%;" name="newSecondYear" value="${resultMap.newSecondYear }" class="inputText"/></td>
		   									<td><input type="text" id="newThirdYear" style="width:80%;" name="newThirdYear" value="${resultMap.newThirdYear }" class="inputText"/></td>
		   									<td><input type="text" id="newInfo"  style="width:80%;" name="newInfo" value="${resultMap.newInfo }" class="inputText"/></td>		
							           	</tr>
							            <tr>
							                <td style="font-weight:bold;">市财政拨款</td>
							                <td><input type="text" id="govTrCount" style="width:80%;" name="govTrCount" value="${resultMap.govTrCount }" class="inputText"/></td>
		   									<td><input type="text" id="govTrFirstYear" style="width:80%;" name="govTrFirstYear" value="${resultMap.govTrFirstYear }" class="inputText"/></td>
		   									<td><input type="text" id="govTrSecondYear" style="width:80%;" name="govTrSecondYear" value="${resultMap.govTrSecondYear }" class="inputText"/></td>
		   									<td><input type="text" id="govTrThirdYear" style="width:80%;" name="govTrThirdYear" value="${resultMap.govTrThirdYear }" class="inputText"/></td>
		   									<td><input type="text" id="govTrInfo" style="width:80%;" name="govTrInfo" value="${resultMap.govTrInfo }" class="inputText"/></td>
							            </tr>
							           	<tr>
							                <td style="font-weight:bold;">主管部门配套</td>
							                <td><input type="text" id="orgBelongTrCount" style="width:80%;" name="orgBelongTrCount" value="${resultMap.orgBelongTrCount }" class="inputText"/></td>
		   									<td><input type="text" id="orgBelongTrFirstYear" style="width:80%;" name="orgBelongTrFirstYear" value="${resultMap.orgBelongTrFirstYear }" class="inputText"/></td>
		   									<td><input type="text" id="orgBelongTrSecondYear" style="width:80%;" name="orgBelongTrSecondYear" value="${resultMap.orgBelongTrSecondYear }" class="inputText"/></td>
		   									<td><input type="text" id="orgBelongTrThirdYear" style="width:80%;" name="orgBelongTrThirdYear" value="${resultMap.orgBelongTrThirdYear }" class="inputText"/></td>
		   									<td><input type="text" id="orgBelongTrInfo" style="width:80%;" name="orgBelongTrInfo" value="${resultMap.orgBelongTrInfo }" class="inputText"/></td>
							           	</tr>
							            <tr>
							                <td style="font-weight:bold;">承办单位自筹</td>
							                <td><input type="text" id="orgDoTrCount" style="width:80%;" name="orgDoTrCount" value="${resultMap.orgDoTrCount }" class="inputText"/></td>
		   									<td><input type="text" id="orgDoTrFirstYear" style="width:80%;" name="orgDoTrFirstYear" value="${resultMap.orgDoTrFirstYear }" class="inputText"/></td>
		  	 								<td><input type="text" id="orgDoTrSecondYear" style="width:80%;" name="orgDoTrSecondYear" value="${resultMap.orgDoTrSecondYear }" class="inputText"/></td>
		  									<td><input type="text" id="orgDoTrThirdYear" style="width:80%;" name="orgDoTrThirdYear" value="${resultMap.orgDoTrThirdYear }" class="inputText"/></td>
		   									<td><input type="text" id="orgDoTrInfo" style="width:80%;" name="orgDoTrInfo" value="${resultMap.orgDoTrInfo }" class="inputText"/></td>
							            </tr>
							            <tr>
							                <td style="font-weight:bold;">银行贷款</td>
							                <td><input type="text" id="bankTrCount" style="width:80%;" name="bankTrCount" value="${resultMap.bankTrCount }" class="inputText"/></td>
		   									<td><input type="text" id="bankTrFirstYear" style="width:80%;" name="bankTrFirstYear" value="${resultMap.bankTrFirstYear }" class="inputText"/></td>
		   									<td><input type="text" id="bankTrSecondYear" style="width:80%;" name="bankTrSecondYear" value="${resultMap.bankTrSecondYear }" class="inputText"/></td>
		   									<td><input type="text" id="bankTrThirdYear" style="width:80%;" name="bankTrThirdYear" value="${resultMap.bankTrThirdYear }" class="inputText"/></td>
		   									<td><input type="text" id="bankTrInfo" style="width:80%;" name="bankTrInfo" value="${resultMap.bankTrInfo }" class="inputText"/></td>
							            </tr>
      								</table>
      							</td>
              				</tr>
              				<tr>
                				<td>
                					<table width="100%" cellspacing="0" cellpadding="0" class="bs_tb">
                						<tr>
               								<th colspan="11" class="theader">项目经费支出预算(单位：万元)<c:if test="${param.view!=GlobalConstant.FLAG_Y }"><span style="float: right;padding-right: 10px"><a href="javascript:void(0)"><img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addBudget('projBudgetTb');"></img></a>&#12288;<a href="javascript:void(0)"><img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('projBudgetTb')"></img></a></span></c:if></th>
           								</tr>
							            <tr class="th_bold">
							            	<td>序号</td>
							           		<td width="20%">栏目</td>
							                <td width="12%">预算数</td>
							                <td>财政拨款(含配套)</td>
							                <td width="15%">备注</td>
							                <!-- <td width="15%">操作</td> -->
							            </tr>
							            <tbody id="projBudgetTb">
							            	<c:if test="${! empty resultMap.projBudget}">
            								<c:forEach var="money" items="${resultMap.projBudget}">
								               <tr>
								               	 <td><input type="checkbox"/></td>	
								                 <td><input name="projBudget_name" value="${money.objMap.projBudget_name}" class="inputText"/></td>
								                 <td><input name="projBudget_sum" style="width:80%;" value="${money.objMap.projBudget_sum}" class="inputText"/></td>
								                 <td><input name="projBudget_govPostPlan" style="width:80%;" value="${money.objMap.projBudget_govPostPlan}" class="inputText"/></td>
								                 <td><input name="projBudget_remark" value="${money.objMap.projBudget_remark}" class="inputText"/></td>
								                 <!-- 
								                 <td>
								                 [<a href="javascript:void(0);" onclick="edit('${money.flow}','moneyFrom')">编辑</a>]
									             [<a href="javascript:void(0);" onclick="del('${money.flow}','moneyFrom')">删除</a>]
								                 </td>
								                  -->
								               </tr>
            								</c:forEach>
            								</c:if>
            								
            								<c:if test="${empty resultMap.projBudget}">
            								<c:forEach var="money" items="${projInfoMap.projBudget}">
								               <tr>
								               	 <td><input type="checkbox"/></td>
								                 <td><input name="projBudget_name" value="${money.objMap.projBudget_name}" class="inputText"/></td>
								                 <td><input name="projBudget_sum" value="${money.objMap.projBudget_sum}" class="inputText"/></td>
								                 <td><input name="projBudget_govPostPlan" class="inputText" /></td>
								                 <td><input name="projBudget_remark" class="inputText"/></td>
								                 <!-- 
								                 <td>
								                 [<a href="javascript:void(0);" onclick="edit('${money.flow}','moneyFrom')">编辑</a>]
									             [<a href="javascript:void(0);" onclick="del('${money.flow}','moneyFrom')">删除</a>]
								                 </td>
								                  -->
								               </tr>
            								</c:forEach>
            								</c:if>
        								</tbody>
      								</table>
       							</td>
              				</tr>
            			</table>
            			</form>
            			<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
                		<div class="button" style="width:100%;">
             				<input id="prev" type="button" onclick="nextOpt('step3')" class="search" value="上一步"/>
        	                <input id="nxt" type="button" onclick="nextOpt('file')" class="search" value="下一步"/>
      					</div>
      					</c:if>
      			   </div>
			</div>
		</div>
