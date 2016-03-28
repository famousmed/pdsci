<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true" />
	<jsp:param name="jbox" value="true" />
	<jsp:param name="jquery_form" value="false" />
	<jsp:param name="jquery_ui_tooltip" value="true" />
	<jsp:param name="jquery_ui_combobox" value="false" />
	<jsp:param name="jquery_ui_sortable" value="false" />
	<jsp:param name="jquery_cxselect" value="true" />
	<jsp:param name="jquery_scrollTo" value="false" />
	<jsp:param name="jquery_jcallout" value="false" />
	<jsp:param name="jquery_validation" value="true" />
	<jsp:param name="jquery_datePicker" value="true" />
	<jsp:param name="jquery_fullcalendar" value="true" />
	<jsp:param name="jquery_fngantt" value="false" />
	<jsp:param name="jquery_fixedtableheader" value="true" />
	<jsp:param name="jquery_placeholder" value="true" />
	<jsp:param name="jquery_iealert" value="false" />
	<jsp:param name="ueditor" value="true"/>
</jsp:include>
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/res/log/css/time_style.css'/>" />

<script type="text/javascript">
function editLog(logFlow){
	var url = "<s:url value='/res/log/edit'/>?logTypeId=${workLog.logTypeId}&editFlag=${GlobalConstant.FLAG_Y}&logFlow=" + logFlow;
	window.location.href = url;
}

function delLog(logFlow){
	jboxConfirm("确认删除?" ,  function(){
		jboxStartLoading();
		var url = "<s:url value='/res/log/delLog?logFlow='/>" + logFlow;
		jboxPost(url , null , function(resp){
				if("${GlobalConstant.DELETE_SUCCESSED}" == resp){
					var url = "<s:url value='/res/log/list'/>?logTypeId=${workLog.logTypeId}";
					window.location.href = url;
				}
			} , null , true);
	});
}

function doBack(){
	//返回至当前月份
	var fillDate = "${workLog.fillDate}";
	fillDate = fillDate.substring(0, 7);
	var url = "<s:url value='/res/log/list?logTypeId=${workLog.logTypeId}&fillDate='/>" + fillDate;
	window.location.href = url;
}

</script>

</head>
<body>
<div class="mainright" align="center" style="height: 100%;background-color: white;">
<div class="content" style="height:100%; padding-top:15px;">
        <div class="datework_contain">
           <div class="datework_main">
    	     <h1>工作日志</h1>
    	         <c:if test="${workLog.logTypeId eq logTypeEnumDay.id}">
    		          <h2>日&nbsp;&nbsp;志</h2>
    		          <h3>${workLog.fillDate}</h3>
    	         </c:if>
                 <c:if test="${workLog.logTypeId eq logTypeEnumWeek.id}">
    		          <h2>周&nbsp;&nbsp;记 </h2>
    		          <h3>（${workLog.fillDate}~${workLog.endDate}）&#12288;  第${workLog.weekNum}周&#12288;</h3>
    	         </c:if>
    	         <c:if test="${workLog.logTypeId eq logTypeEnumMonth.id}">
	    	          <h2>月&nbsp;&nbsp;记</h2>
	    	          <h3>${workLog.fillDate}</h3>
    	         </c:if>
    	        <div class="datework_edit">
    	              <a class="datework_cz_edit" href="javascript:void(0);" onclick="editLog('${workLog.logFlow}')">&#12288;</a>
                   	  <a class="datework_cz_delete" href="javascript:void(0);" onclick="delLog('${workLog.logFlow}')">&#12288;</a>
    	              <a class="datework_cz_back" href="javascript:void(0);" onclick="doBack()">&#12288;</a>
    	        </div>
    	        <div class="date_work">
		        <p>${workLog.logContent}</p>
		        </div>
		   </div>
		</div>
		
</div>
</div>
</body>
</html>
