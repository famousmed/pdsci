<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
</jsp:include>
<script type="text/javascript">
	function doAddProj(){
    	var typeId = $('#aidProjTypeId').val();
    	if(!typeId){
    		jboxTip('请选择类型');
    		return;
    	}
        add(typeId);
    }
	
	function add(typeId){
        var url="<s:url value='/srm/aid/proj/add?typeId='/>"+typeId;
        window.parent.frames['mainIframe'].location=url;
        jboxClose();
    }
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<p style="text-align: center;margin-top: 40px;">
		<c:set var="aidProjTypeListSize" value="${dictTypeEnumAidProjTypeList.size()}"/>
		<c:if test="${aidProjTypeListSize > 1}">
		   	类型：<select id="aidProjTypeId" class="xlselect">
		        <option value=''>请选择</option>
		        <c:forEach items="${dictTypeEnumAidProjTypeList}" var="aidProjType">
		            <option value='${aidProjType.dictId}'>${aidProjType.dictName}</option>
		        </c:forEach>
		    </select><br/>
		    <input type="button" onclick="doAddProj();" class="search" value="确&#12288;定" style="margin-top: 20px;"/>	
		</c:if>
		<c:if test="${aidProjTypeListSize == 0}">
			无备案项目类型！
		</c:if>
    	</p>
	</div>
</div>
</body>
</html>