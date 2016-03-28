<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<jsp:include page="/jsp/hbres/htmlhead-hbres.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="font" value="true"/>
</jsp:include>
<head>
<script type="text/javascript">
$(document).ready(function(){
	checkedExamSite();
});

function doClose(){
	var openDialog = top.dialog.get('openDialog');
	if(openDialog !=null && openDialog.open){
		openDialog.close().remove();
	}
}

function chooseExamSite(id, sourse){
	var $examSiteId = $("#examSite_" + id);
	if("tr" != sourse){
		if(!$examSiteId.attr("checked")) {
			$examSiteId.attr("checked",true);
		}else{
			$examSiteId.attr("checked",false);
		}
		return false;
	}
	if(!$examSiteId.attr("checked")){
		$examSiteId.attr("checked",true);
	}else{
		$examSiteId.attr("checked",false);
	}
}

function save(){
	jboxStartLoading();
	var trs = $("input[name='recordFlow']:checked").parent("td").parent("tr");
	var datas = [];
	$.each(trs, function(i,n){
		var recordFlow = $(n).find("input[name='recordFlow']").val();
		var siteCode = $(n).find("input[name='siteCode']").val();
		var siteName = $(n).find("input[name='siteName']").val();
		var siteAddress = $(n).find("input[name='siteAddress']").val();
		var data = {
				"recordFlow" : recordFlow,
				"siteCode" : siteCode,
				"siteName" : siteName,
				"siteAddress" : siteAddress,
				"examFlow" : "${sessionScope.currExam.examFlow}"
		};
		datas.push(data);
	});
	var requestData = JSON.stringify(datas);
	//alert(JSON.stringify(requestData));
 	$("#saveButton").attr("disabled",true);
	var url = "<s:url value='/hbres/singup/exam/saveExamSiteList'/>";
	jboxPostJson(
			url,
			requestData,
			function(resp){
				if("${GlobalConstant.SAVE_FAIL}" != resp){
					jboxEndLoading();
					window.parent.examSitePlan();
					setTimeout(function(){
						doClose();
					},1000);
				}
			}, null, true);
}

/**
 * 回显已有考点
 */
function checkedExamSite(){
	var jboxIfram = window.parent;
	jboxIfram.$("input[name='siteCode']").each(function(){
		var recordFlow = $(this).val();
		$("#examSite_" + recordFlow).attr("checked",true);
	});
}
</script>
</head>
<body>
<div class="main_bd" id="div_table_0" >
    <div class="div_table">
        <table border="0" cellpadding="0" cellspacing="0" class="grid">
            <tr>
                <th width="10%"></th>
                <th width="90%">院校名称</th>
            </tr>
            <c:forEach items="${dictTypeEnumExamSiteList}" var="dict">
            <tr onclick="chooseExamSite('${dict.dictId}','tr')" style="cursor: pointer;">
                <td>
                	<input type="checkbox" name="recordFlow" id="examSite_${dict.dictId}" value="${examSiteList.recordFlow}" onclick="chooseExamSite('${dict.dictId}','')" />
                	<input type="hidden" name="siteCode" value="${dict.dictId}"/> 
                	<input type="hidden" name="siteName" value="${dict.dictName}"/> 
                	<input type="hidden" name="siteAddress" value="${dict.dictDesc}"/> 
                </td>
                <td>${dict.dictName}</td>
            </tr>
            </c:forEach>
            <c:if test="${empty dictTypeEnumExamSiteList}">
            	<tr>
	                <td colspan="2">无记录</td>
	            </tr>
            </c:if>
        </table>
		<p style="text-align: center;">
			<a class="btn" href="javascript:save();" style="margin-left: 140px;">&#12288;保&#12288;存&#12288;</a>&#12288;
			<a class="btn" href="javascript:doClose();">&#12288;关&#12288;闭&#12288;</a>
		</p>
    </div>
</div>
</body>
</html>