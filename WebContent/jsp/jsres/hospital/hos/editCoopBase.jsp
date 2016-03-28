<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>江苏省住院医师规范化培训管理平台</title>
<jsp:include page="/jsp/jsres/htmlhead-jsres.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="font" value="true"/>
</jsp:include>
<script type="text/javascript">
function addCoopBase(){
	jboxOpen("<s:url value='/jsp/jsres/hospital/hos/addCoopBase.jsp'/>","添加协同基地",600,200);
}
function choose(){
	var length=$("input[name='choose']:checked").length;
	if(length>0){
		$("input[name='speId']").attr("checked",true); 
		return;
	}else{
		$("input[name='speId']").attr("checked",false); 
		return;
	}
}
</script>
</head>
<body>
	<div class="main_bd">
		<div class="div_search" style="text-align:right;">	     
			<a onclick="addCoopBase();" class="btn_green">添加协同基地</a>
		</div>
<c:if test="${! empty jointOrgs }">
	<c:forEach items="jointOrgs" var="joint">
    <ul class="search_table">
        <li class="score_frame">${ joint.jointOrgName}
            <h1><span style="float: right;"><input type="checkbox"   onclick=" choose();"name="choose" />全选 </span></h1>
			<c:forEach items="${trainCategoryEnumList }" var="trainCategory" varStatus="status">
			<c:if test="${trainCategory.typeId eq trainCategoryTypeEnumAfter2014.id }">
			<c:set var="dictName" value="dictTypeEnum${trainCategory.id }List" />
			<div>
				<table border="0" cellpadding="0" cellspacing="0" class="base_info" style="border: 0;">
                	<tr>
                		<th style="width: 20%;text-align: center;">${trainCategory.name }</th>
                		<td style="width: 80%;border-top: 0;border-right: 0;">
                			<ul>
						        <c:forEach items="${applicationScope[dictName] }" var="dict">
						            <li style="width: 220px;float: left;line-height: 25px;">
						            	<label><input type="checkbox" id="trainingSpe_${dict.dictId }" name="trainingSpe" value="${dict.dictId }" />
						            	${dict.dictName }</label>
						            </li>
								</c:forEach>
							</ul>
                		</td>
                	</tr>
                </table>
			</div>
			</c:if>
		</c:forEach>
        </li>
    </ul>
    </c:forEach>
    </c:if>
    <c:if test="${empty jointOrgs }"><div style="text-align: center;"><strong>没有协同基地</strong></div></c:if>
</div>

<div class="btn_info">
	<div   style="display:${!empty jointOrgs?'':'none'}"><input class="btn_blue" style="width:100px;" onclick="" type="button" value="保存"/></div>
</div>
</body>
</html>