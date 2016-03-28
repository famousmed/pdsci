<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
	<jsp:param name="jquery_ui_sortable" value="false"/>
	<jsp:param name="jquery_cxselect" value="false"/>
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="false"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>

<script type="text/javascript">
function saveAudit(agreeFlag,fundDetailFlow){
	var realityBalance = parseFloat($('#realityBalance').html());
	var money = parseFloat($('#money').html());
	var msg = "";
	if(money>realityBalance){
		msg = "<span style='color:red;'>报销金额大于余额</span> ,";
	}
	var tip =  agreeFlag=="${GlobalConstant.FLAG_Y}"?msg+"确认审核通过":"确认退回";
	var url = "<s:url value='/srm/payment/saveAudit'/>?agreeFlag="+agreeFlag+"&fundDetailFlow="+fundDetailFlow;
	jboxConfirm(tip+"?" ,  function(){
		jboxStartLoading();
		jboxPost(url , $('#auditForm').serialize() , function(resp){
			window.parent.frames['mainIframe'].location.reload(true); 
			doClose();} , null , true);
		
	});
}
function doClose() {
	jboxClose();
}
</script>
<style type="text/css">
	.xllist td,.xllist th{text-align: left;padding-left: 15px;}
	.xllist td span{font-weight: bold;color:#333;font-size: 13px;}
	table{margin-bottom: 10px;}
</style>
</head>
<body>
    <div id="main">
        <div class="mainright">
            <div class="content">
                <div class="title1 clearfix">
                    <div>
			   	        <table class="xllist nofix">
			   		        <tr><th colspan="4" style="font-size: 14px;">项目信息</th></tr>
					        <tr>
			        	        <td><span>项目名称：</span>${detailExt.proj.projName}</td>
			                    <td><span>年&#12288;份：</span>${detailExt.proj.projYear}</td>
			                    <td colspan="2"><span>项目类型：</span>${detailExt.proj.projTypeName}</td>
			                </tr>
					        <tr>
			        	        <td><span>承担单位：</span>${detailExt.proj.applyOrgName}</td>
			                    <td><span>负责人：</span>${detailExt.proj.applyUserName}</td>
			                    <td colspan="2"><span>起止日期：</span>${detailExt.proj.projStartTime}~${detailExt.proj.projEndTime}</td>
			                </tr>
			                <tr>
			                    <td><span>项目编号：</span>${detailExt.proj.projNo}</td>
			                    <td><span>经费方案：</span>${detailExt.schemeDetail.schemeName}</td>
			                    <td colspan="2"></td>
			                </tr>
				        </table>
	   		        </div>
	   		        
	   		        <div>
	   		            <table class="xllist nofix">
			   		        <tr><th colspan="4" style="font-size: 14px;">报销明细</th></tr>
					        <tr>
					            <td><span>预算总额(万元)：</span><span>${detailExt.projFundInfo.budgetAmount}</span></td>
			                    <td><span>到账总额(万元)：</span><span>${detailExt.projFundInfo.realityAmount}</span></td>
			                    <td><span>到账余额(万元)：</span><span id="realityBalance">${detailExt.projFundInfo.realityBalance}</span></td>
			                </tr>
					        <tr>
					             <td><span>报销项目：</span><span>${detailExt.schemeDetail.itemName}</span></td>
			        	         <td><span>预算金额(万元)：</span><span>${budget.money}</span></td>
			        	         <td><span>报销金额(万元)：</span><span id="money">${detailExt.money}</span></td>
			                </tr>
			                <tr>
			                    <td colspan="3"><span>报销内容：</span>${detailExt.content}</td>
			                </tr>
				        </table>
	   		        </div>
	   		    </div>
                <h2 style="margin-top:5px;">审核意见：</h2>
                <hr/>
                <div style="text-align: center;">
                <form method="post" id="auditForm">
	                <textarea id="auditContent" name="content" cols="25" rows="3" style="margin-top: 10px; width:100%; height:150px; border:1px solid #D0E3F2" ></textarea>
	                <p style="text-align: center;padding-top: 10px;">
                    <input class='search' onclick="saveAudit('${GlobalConstant.FLAG_Y}','${fundDetailFlow }')" type='button'  value='通&nbsp;&nbsp;过' />&#12288;
	                <input class='search' onclick="saveAudit('${GlobalConstant.FLAG_N}','${fundDetailFlow }')" type='button' value='退&nbsp;&nbsp;回'/>&#12288;
                    </p>
                </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>