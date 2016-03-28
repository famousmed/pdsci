<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<jsp:include page="/jsp/cnres/htmlhead-cnres.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="font" value="true"/>
</jsp:include>
<head>
<script type="text/javascript">
function chooseCollege(cId, cName, sourse){
	var $collegeId = $("#college_"+cId);
	if("tr" != sourse){
		if(!$collegeId.attr("checked")) {
			$collegeId.attr("checked",true);
		}else{
			$collegeId.attr("checked",false);
		}
		return false;
	}
	if(!$collegeId.attr("checked")) {
		$collegeId.attr("checked",true);
	}else{
		$collegeId.attr("checked",false);
	}
}

function doClose(){
	var openDialog = top.dialog.get('openDialog');
	if(openDialog !=null && openDialog.open){
		openDialog.close().remove();
	}
}

/**
 * 添加院校回显
 */
function checkedColleges(){
	var recordFlow = "${param.recordFlow}";
	var jboxIfram = window.parent;
	jboxIfram.$("#td_"+recordFlow).find("input[name='college']").each(function(){
		var college = $(this).val();
		$("#college_" + college).attr("checked",true);
	});
}

/**
 * 过滤院校
 */
function filterColleges(){
	<c:forEach items="${collegeList}" var="college">
		$("#tr_${college}").hide();
	</c:forEach>
}

function save(){
	jboxStartLoading();
	var colleges = "";
	$("input[name='college']:checked").each(function(){
		colleges += "," + $(this).val();
	});
	colleges = colleges.substring(1);
	var data = {
		recordFlow : "${param.recordFlow}",
		colleges : colleges
	};
	var url = "<s:url value='/cnres/singup/exam/modifyColleges'/>";
	jboxPost(url, data, function(resp){
		if("${GlobalConstant.OPRE_SUCCESSED}" == resp){
			jboxEndLoading();
			window.parent.examSitePlan();
			setTimeout(function(){
				doClose();
			},1000);
		}
	}, null, true); 
}

$(document).ready(function(){
	checkedColleges();
	filterColleges();
});
</script>
</head>
<body>
<div class="main_bd" id="div_table_0"  style="overflow:auto; position:relative; height:500px;">
    <div class="div_table">
        <table border="0" cellpadding="0" cellspacing="0" class="grid">
            <tr>
                <th style="text-align: center;" width="5%"></th>
                <th style="text-align: center;" width="95%">院校名称</th>
            </tr>
            <c:forEach items="${dictTypeEnumGraduateSchoolList}" var="dict">
            <tr id="tr_${dict.dictId}" onclick="chooseCollege('${dict.dictId}','tr')" style="cursor: pointer;">
                <td>
                	<input type="checkbox" name="college" id="college_${dict.dictId}" value="${dict.dictId}" onclick="chooseCollege('${dict.dictId}','')" />
                </td>
                <td style="text-align: center;">${dict.dictName}</td>
            </tr>
            </c:forEach>
            <tr id="tr_00" onclick="chooseCollege('00','tr')" style="cursor: pointer;">
                <td>
                	<input type="checkbox" name="college" id="college_00" value="00" onclick="chooseCollege('00','')"/>
                </td>
                <td style="text-align: center;">其它</td>
            </tr>
            <c:if test="${empty dictTypeEnumGraduateSchoolList}">
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