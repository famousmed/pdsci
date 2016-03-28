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
$(document).ready(function(){
	changeTrainCategoryType('2016');
});
function changeTrainCategoryType(currYear){
	var trainCategoryType = "";
	if (currYear<='2013') {
		trainCategoryType = "${trainCategoryTypeEnumBefore2014.id}";
	}else if (currYear>'2013') {
		trainCategoryType = "${trainCategoryTypeEnumAfter2014.id}";
	}
	$("#trainCategoryDiv1").html($("#clone_"+trainCategoryType).html());
	$("#trainCategoryDiv2").html($("#clone_"+trainCategoryType).html());
}

</script>
</head>
<body>
<div class="infoAudit" style="padding: 0;">
	<div class="main_bd" style="margin-top: 20px;">
    <ul class="search_table">
        <li class="score_frame">
            <h1 style="text-align: left;">南京妇幼保健院</h1>
            <div id="trainCategoryDiv1">
            </div>
        </li>
    </ul>
    <ul class="search_table">
        <li class="score_frame">
            <h1 style="text-align: left;">南京市中西医结合医院</h1>
            <div id="trainCategoryDiv2">
            </div>
        </li>
    </ul>
</div>
<div class="btn_info">
	<c:if test="${'audit'==param.type }">
		<input type="button" style="width:100px;" class="btn_blue" onclick="" value="通过"></input>
		<input type="button" style="width:100px;" class="btn_red" onclick="" value="不通过"></input>
	</c:if>
	<input type="button" style="width:100px;" class="btn_grey" onclick="javascript:jboxClose();" value="关闭"></input>
</div>
</div>
<c:forEach items="${trainCategoryTypeEnumList }" var="trainCategoryType">	
	<span id="clone_${trainCategoryType.id }" style="display: none;">
		<c:forEach items="${trainCategoryEnumList }" var="trainCategory" varStatus="status">
			<c:if test="${trainCategory.typeId eq trainCategoryType.id }">
			<c:set var="dictName" value="dictTypeEnum${trainCategory.id }List" />
			<div>
				<table border="0" cellpadding="0" cellspacing="0" class="base_info" style="border: 0;margin: 0;">
                	<tr>
                		<th style="width: 20%;text-align: center;font-weight: bold;">
                		${trainCategory.name }<c:if test="${trainCategory.id==trainCategoryEnumWM.id}">（12人）</c:if>
                		</th>
                		<td style="width: 80%;border-top: 0;border-right: 0;">
                			<ul>
						        <c:forEach items="${applicationScope[dictName] }" var="dict">
						        	<c:set var="selected" value="false"/>
							        <c:if test="${dict.dictId=='0200'||dict.dictId=='1500'||dict.dictId=='2200'
							        	||dict.dictId=='2800'||dict.dictId=='1100'||dict.dictId=='0200'||dict.dictId=='0104'||dict.dictId=='2300'}">
							        	<c:set var="selected" value="true"/>
							        </c:if>
						            <li style="width: 250px;float: left;line-height: 30px;">
						            	<span style="display: inline-block;width: 150px;text-align: right;">
						            	${dict.dictName }
						            	</span>
						            	<span style="display: inline-block;width: 70px;">
						            		<c:if test="${selected}">
						            		<img src="<s:url value='/jsp/jsres/images/gou.gif'/>" />（2人）
						            		</c:if>
						            	</span>
						            </li>
								</c:forEach>
							</ul>
                		</td>
                	</tr>
                </table>
			</div>
			</c:if>
		</c:forEach>
	</span>
</c:forEach>
</body>
</html>