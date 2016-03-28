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
function add(tb){
	var html = '<tr>'+
	'<td><input type="checkbox"/></td>'+
	'<td><input name="'+tb+'_steps" type="text" class="inputText" style="width:80%"/></td>'+
	'<td><input style="width:80%;" class="inputText"  name="'+tb+'_moneyPlanAndTestRule" type="text"/></td>'+
'</tr>'; 
	$('#planRule').append(html);
}


function delTr(tb){
	var trs = $('#'+tb).find(':checkbox:checked');
	$.each(trs , function(i , n){
		$(n).parent('td').parent("tr").remove();
		
	});
}
</script>
</c:if>

<div id="main">
	<div class="mainright">
		<div class="content">
            		<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm">
						<input type="hidden" id="pageName" name="pageName" value="step3"/>
						<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
                        <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
						<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
                		<table width="100%" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
              				<tr>
                				<td>
                					<table width="100%" cellspacing="0" cellpadding="0" class="bs_tb">
           								<tr>
               								<th colspan="11" class="theader">三、计划指标<c:if test="${param.view!=GlobalConstant.FLAG_Y }"><span style="float: right;padding-right: 10px"><a href="javascript:void(0)"><img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('planRule');"></img></a>&#12288;<a href="javascript:void(0)"><img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('planRule');"></img></a></span> </c:if> </th>
           								</tr>
							           	<tr>
							           		<td width="50" style="font-weight:bold;">序号</td>
							                <td width="20%" style="font-weight:bold;">阶段</td>
							                <td style="font-weight:bold;">计划和考核指标</td>
							           	</tr>
							           	 <tbody id="planRule">
							           	 <c:if test="${not empty resultMap.planRule}">
	      								 <c:forEach var="plan" items="${resultMap.planRule}" varStatus="num">
									        <tr>
									           <td><input type="checkbox"/></td>
									          <td><input type="text"  name="planRule_steps" class="inputText" style="width:80%" value="${plan.objMap.planRule_steps }"/></td>
									           
									           <td><input type="text" style="width:80%" class="inputText" name="planRule_moneyPlanAndTestRule" value="${plan.objMap.planRule_moneyPlanAndTestRule }"/></td>
									           
									        </tr>
	      								</c:forEach>
	      								</c:if>
	      						         <c:if test="${empty resultMap.planRule }">
	      						         <tr>
	      						              <td><input type="checkbox"/></td>
									          <td><input type="text"  name="planRule_steps" class="inputText" style="width:80%" /></td>
									           
									           <td><input type="text" style="width:80%" class="inputText"  name="planRule_moneyPlanAndTestRule" /></td>
									            
	      						         </tr>
	      						         </c:if>
	   									</tbody>
      								</table> 
      							</td>
              				</tr>
              				<tr>
                				<td>
                					<table width="100%" cellspacing="0" cellpadding="0" class="bs_tb">
							           <tr>
							               <th colspan="11" class="theader">项目主要目标任务</th>
							           </tr>
							           <tr>
							                <td><textarea placeholder="此处填写项目主要目标和任务" name="mainTarget" class="xltxtarea" >${resultMap.mainTarget }</textarea></td>
							           </tr>
							           <tr>
							               <th colspan="11" class="theader">研究主要内容</th>
							           </tr>
							           <tr>
							                <td><textarea placeholder="此处填写项目主要研究内容" name="projContentContent" class="xltxtarea"><c:if test='${! empty resultMap.projContentContent}'>${resultMap.projContentContent}</c:if><c:if test="${empty resultMap.projContentContent}">${projInfoMap.projContentContent}</c:if></textarea></td>
							           </tr>
							           <tr>
							               <th colspan="11" class="theader">验收内容和考核指标</th>
							           </tr>
							           <tr>
							                <td><textarea placeholder="此处填写项目验收内容和考核指标" name="projContentTarget" class="xltxtarea"><c:if test='${! empty resultMap.projContentTarget}'>${resultMap.projContentTarget}</c:if><c:if test='${empty resultMap.projContentTarget}'>${projInfoMap.projContentTarget}</c:if></textarea></td>
							           </tr>
      								</table>
      							</td>
              				</tr>
            			</table>
                	</form>	
                	<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
                		<div class="button" style="width:100%;">
             				<input id="prev" type="button" onclick="nextOpt('step2')" class="search" value="上一步"/>
        	                <input id="nxt" type="button" onclick="nextOpt('step4')" class="search" value="下一步"/>
      					</div>
      					</c:if>
      				</div>
			</div>
		</div>
