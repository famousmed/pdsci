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
function editTrainSpe(speId){
	$(".show").show();
	$(".input").hide();
	$("#"+speId+"Span").hide();
	$("#"+speId).show();
}
</script>
</head>
<body>
<div class="main_bd">
	<div class="div_search">
		
	</div>
	<div class="search_table">
        <table border="0" cellpadding="0" cellspacing="0" class="grid">
        	<colgroup>
        		<col style="text-align: left;padding-left: 40px;"/>
        		<col style="text-align: left;padding-left: 40px;"/>
        		<col style="text-align: left;padding-left: 40px;"/>
        	</colgroup>
        	<tr>
                <th>培训类别</th>
                <th>专业名称</th>
                <th>操作</th>
            </tr>
            <c:forEach items="${trainCategoryEnumList }" var="trainCategory" varStatus="status">
				<c:if test="${trainCategory.typeId eq trainCategoryTypeEnumAfter2014.id }">
				<c:set var="dictName" value="dictTypeEnum${trainCategory.id }List" />
		            <c:forEach items="${applicationScope[dictName] }" var="dict">
		            	<tr>
			                <td>
			                	${trainCategory.name }
			                </td>
			                <td>
			                	<span id="${dict.dictId}Span" class="show">${dict.dictName }</span>
			                	<input type="text" class="input" id="${dict.dictId}" value="${dict.dictName }" style="display: none;"/>
			                </td>
			                <td><a class="btn" onclick="editTrainSpe('${dict.dictId}');">编辑</a></td>
			            </tr>
					</c:forEach>
				</c:if>
			</c:forEach>
        </table>
	</div>
</div>
</body>
</html>