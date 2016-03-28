<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
	<jsp:param name="jquery_ui_sortable" value="false"/>
	<jsp:param name="jquery_cxselect" value="true"/>
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>

<script type="text/javascript">
	function saveFundPlan(flag){
		if(false==$("#fundPlanForm").validationEngine("validate")){
			return false;
		}
		jboxConfirm("确认操作？" , function(){
			var fundPlanForm = $('#fundPlanForm');
			var action = fundPlanForm.attr("action");
			action+="?flag="+flag;
			fundPlanForm.attr('action' , action);
			jboxStartLoading();
			jboxPost(action , fundPlanForm.serialize() , function(){
				window.parent.frames['mainIframe'].window.searchProj();
				jboxClose();
			} , null , true);
		});
	}
	
	function calculate(){
		var sumVal = 0;
		$(".fund").each(function(){
			var val = $(this).val();
			if (val == null || val == undefined || val == '' || isNaN(val)){
				val = 0;
			}
			sumVal += parseFloat(val);
		});
		$("input[name='sumAmount']").val(parseFloat(sumVal.toFixed(3)));
	}
</script>
</head>
<body>
<c:choose>
	<c:when test="${proj.projTypeId =='wxwsj.qnxm'}">
		<c:set var="showNum" value="3"/>
	</c:when>
	<c:when test="${proj.projTypeId =='wxwsj.zdxm' or proj.projTypeId =='wxwsj.msxm'}">
		<c:set var="showNum" value="4"/>
	</c:when>
	<c:otherwise>
		<c:set var="showNum" value="5"/>
	</c:otherwise>
</c:choose>

    <div class="mainright">
        <div class="content">
	        <div class="title1 clearfix">
		        <div>
        		    <table>
        		        <tr height="30px">
        			        <td style="font-weight: bold;">项目名称：</td><td colspan="3"><a target="_blank" style="color:blue;" href="<s:url value='/srm/proj/mine/auditProjView?projFlow=${proj.projFlow}'/>">${proj.projName}</a></td>
        		        </tr> 
        		        <tr  height="30px">
        			        <td style="font-weight: bold;">项目类型：</td>
        			        <td width="200px">${proj.projTypeName}</td>
        			        <td style="font-weight: bold;">起止时间：</td>
        			        <td>${proj.projStartTime}~${proj.projEndTime}</td>
        		        </tr>
        		        <tr  height="30px">
        			        <td style="font-weight: bold;">承担单位：</td>
        			        <td>${proj.applyOrgName}</td>
        			        <td style="font-weight: bold;">负责人：</td>
        			        <td>${proj.applyUserName}</td>
        		        </tr>
                    </table>
                </div>
		        <form id="fundPlanForm" action='<s:url value="/srm/proj/approve/saveFundPlan"/>' method="post">
		            <input type="hidden" name="projFlow" value="${param.projFlow}"/>
		                <table class="bs_tb" style="margin-top: 10px;width:100%;">
			                <c:choose>
		                        <c:when test="${empty projFundPlanList}">
		      	                    <tr>
		      		                    <th colspan="2" class="theader">&#12288;总经费(万元)</th>
		      	                    </tr>
		      	                    <tr>
		      		                    <td>市卫生局拨款：<input name="sumAmount" class="validate[custom[number],max[100000000]] xltext" readonly="readonly"/></td>
		      		                    <td>配套金额：<input name="matchingAmount" class="validate[custom[number],max[100000000]] xltext"/></td>
		      	                    </tr>
		      	                    <tr>
		      		                    <th colspan="2"class="theader">&#12288;年度下拨计划(万元)</th>
		      	                    </tr>
		                            <tr>
					                    <td style="font-weight:bold;">第1年：</td>
					                    <td><input name="yearAmount" class="validate[custom[number],max[100000000]] xltext fund" onchange="calculate()"/></td>
				                    <tr>
				                    <tr>
				                        <td style="font-weight:bold;">第2年：</td>
				                        <td><input name="yearAmount" class="validate[custom[number],max[100000000]] xltext fund" onchange="calculate()"/></td>
				                    </tr>
				                    <tr>
					                    <td style="font-weight:bold;">第3年：</td>
					                    <td><input name="yearAmount" class="validate[custom[number],max[100000000]] xltext fund" onchange="calculate()"/></td>
				                    <tr>
				                    
				                    <c:choose>
				                    	<c:when test="${showNum==3}">
				                    		<input type="hidden" name="yearAmount"/>
				                    		<input type="hidden" name="yearAmount"/>
				                    	</c:when>
				                    	<c:when test="${showNum==4}">
				                    		<tr>
						                        <td style="font-weight:bold;">第4年：</td>
							                    <td><input name="yearAmount" class="validate[custom[number],max[100000000]] xltext fund" onchange="calculate()"/></td>
						                    </tr>
						                    <input type="hidden" name="yearAmount"/>
				                    	</c:when>
				                    	<c:when test="${showNum==5}">
						                    <tr>
						                        <td style="font-weight:bold;">第4年：</td>
							                    <td><input name="yearAmount" class="validate[custom[number],max[100000000]] xltext fund" onchange="calculate()"/></td>
						                    </tr>
						                    <tr>
							                    <td style="font-weight:bold;">第5年：</td>
							                    <td><input name="yearAmount" class="validate[custom[number],max[100000000]] xltext fund" onchange="calculate()"/></td>
						                    <tr>
				                    	</c:when>
				                    </c:choose>
		                        </c:when>
			                    <c:otherwise> 
					                <tr>
			      		                <th colspan="2" class="theader">&#12288;总经费(万元)</th>
			      	                </tr>
					                <tr>
					                    <td>市卫生局拨款：<input name="sumAmount" value="${sumAmount.amount}" class="validate[custom[number],max[100000000]] xltext"  readonly="readonly"/></td>
					                    <td>配套金额：<input name="matchingAmount" value="${matchingAmount.amount}"  class="validate[custom[number],max[100000000]] xltext" /></td>
					                </tr>
			      	                <tr>
			      		                <th colspan="2" class="theader">&#12288;年度下拨计划(万元)</th>
			      	                </tr>
				                    <c:forEach items="${yearAmountList}" var="fundPlan" varStatus="status">
				                    	<c:if test="${status.index < showNum}">
					                        <tr>
						                        <td style="font-weight:bold;">第${fundPlan.year+1}年：</td>
						                        <td><input name="yearAmount" value="${fundPlan.amount}"  class="validate[custom[number],max[100000000]] xltext fund" onchange="calculate()"/></td>
					                        </tr>
				                    	</c:if>
				                    </c:forEach>
				                    <c:choose>
				                    	<c:when test="${showNum==3}">
				                    		<input type="hidden" name="yearAmount"/>
				                    		<input type="hidden" name="yearAmount"/>
				                    	</c:when>
				                    	<c:when test="${showNum==4}">
						                    <input type="hidden" name="yearAmount"/>
				                    	</c:when>
				                    </c:choose>
			                    </c:otherwise>
			                </c:choose>
		                </table>
		                <p style="text-align: center;">
			                <input type="button" class="search" onclick="saveFundPlan('${projApproveStatusEnumConfirm.id}');" value="提&#12288;交"/>
			                <input type="button" class="search" onclick="jboxClose();" value="关&#12288;闭"/>
		                </p>
	                </form>
                </div>
            </div>
        </div>
    </body>
</html>