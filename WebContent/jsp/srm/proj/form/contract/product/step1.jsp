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
jboxStartLoading();
form.submit();
}

</script>
</c:if>
<style type="text/css">
#table1 .inputText{width: 200px;}
</style>


<div id="main">
	<div class="mainright">
		<div class="content">
        	    	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm">
						<input type="hidden" name="pageName" value="step1"/>
						<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
                        <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
						<input type="hidden" name="recTypeId" value="${param.recTypeId}"/>
						<table width="100%" cellpadding="0" cellspacing="0" class="basic" style="margin-top: 10px;" id="table1">
                			<tr>
               					<th colspan="11" style="text-align: left;padding-left: 15px;font-size: 14px;font-weight: bold;">一、基本信息</th>
          					</tr>
  							<tr>
    							<td width="20%" style="text-align:right;">立项编号：</td>
    							<td width="30%"><input type="text" name="projNo" value="${proj.projNo}" class="inputText" readonly="readonly"/></td>
   								<td width="20%" style="text-align:right;">项目名称：</td>
    							<td width="30%"><input type="text" name="projName" value="${proj.projName}" class="inputText" readonly="readonly"/></td>
  							</tr>
						  <tr>
						    <td style="text-align:right;">项目类型：</td>
						    <td><input type="text" name="projType" value="${proj.projTypeName}" class="inputText" readonly="readonly"/></td>
						    <td style="text-align:right;">委托部门(甲方)：</td>
						    <td><input type="text" name="invoJia" value="苏州市卫生局" class="inputText"/></td>
						  </tr>
						  <tr>
						    <td style="text-align:right;">承办单位(乙方)：</td>
						    <td><input type="text" name="optionYi" value="${user.orgName}" class="inputText" readonly="readonly"/></td>
						    <td style="text-align:right;">主管部门(丙方)：</td>
						    <td><input type="text" name="chargeOrgName" value="${resultMap.chargeOrgName}" class="inputText" /></td>
						  </tr>
						  <tr>
						    <td style="text-align:right;">承办单位地址：</td>
						    <td><input type="text" name="orgAddress" value="${org.orgAddress}" class="inputText" readonly="readonly"/></td>
						    <td style="text-align:right;">邮编：</td>
						    <td><input type="text" name="addressId" value="${resultMap.addressId }" class="inputText"/></td>
						  </tr>
						  <tr>
    					  	<td style="text-align:right;">财务负责人：</td>
    					  	<td><input type="text" name="moneyManager" value="${resultMap.moneyManager}" class="inputText"/></td>
                          	<td style="text-align:right;">电话：</td>
                          	<td><input type="text" name="tel" value="${resultMap.tel}" class="inputText"/></td>
                          </tr>
						  <tr>
						    <td style="text-align:right;">开始时间：</td>
						    <td><input type="text" name="projStartTime" <c:if test="${empty resultMap.projStartTime}">value="${applicationScope.sysCfgMap['srm_contract_start_time']}" </c:if><c:if test="${!empty resultMap.projStartTime}">value="${resultMap.projStartTime}"</c:if> class="inputText ctime"  readonly="readonly" <c:if test="${empty applicationScope.sysCfgMap['srm_contract_start_time']}">onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"</c:if>/></td>
						    <td style="text-align:right;">结束时间：</td>
						    <td><input type="text" name="projEndTime" value="<c:if test="${empty resultMap.projEndTime}">${applicationScope.sysCfgMap['srm_contract_end_time']}</c:if><c:if test="${!empty resultMap.projEndTime}">${resultMap.projEndTime}</c:if>" class="inputText ctime" readonly="readonly" <c:if test="${empty applicationScope.sysCfgMap['srm_contract_end_time']}">onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"</c:if>/></td>
						  </tr>
						  <tr>
						    <td style="text-align:right;">参加单位：</td>
						    <td><input type="text" name="friendOrg" value="${resultMap.friendOrg}" class="inputText"/></td>
						    <td style="text-align:right;">主管财政局：</td>
						    <td><input type="text" name="chargeMoneyOrg" value="${resultMap.chargeMoneyOrg }" class="inputText"/></td>
						  </tr>
					 </table>
					 </form>
					 <c:if test="${param.view!=GlobalConstant.FLAG_Y }">
                	 <div class="button" style="width:100%;">
             			<a href="javascript:void(0)" target="_self"  onclick="nextOpt('step2')" id="next" class="search">下一步</a>
      			     </div>
      			     </c:if>
      			   </div>
			</div>
		</div>
