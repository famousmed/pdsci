<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true"%>
<c:if test="${empty exception }">				
	<c:set var="exception" value="${pageContext.exception}" scope="request"></c:set>
	<%exception.printStackTrace(); %>
</c:if>
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
	<jsp:param name="jquery_cxselect" value="false"/>
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
	$(document).ready(function(){
		jboxError("${exception.message }");
		jboxCenter();
	}); 
    function showErrors() {  
        var err_el = document.getElementById('errors');  
        if (err_el.style.display == 'none') {  
            err_el.style.display = '';  
        } else {  
            err_el.style.display = 'none';  
        }  
    } 
    function goback(){
    	jboxStartLoading();
    	window.history.back(-1); 
    } 
</script>  
</head>  
<body>  
<div class="content">
	<div class="title1 clearfix">
		<div id="tagContent">
			<div class="tagContent selectTag" id="tagContent0">
				<table width="800" cellpadding="0" cellspacing="0" class="basic">
					<tr>
						<th style="text-align: center;">发生错误啦：${exception.message }</th>
					</tr>
					<tr>
						<td style="text-align: center;">
							<input class="search" type="button" value="查看详情" onclick="showErrors();" />
							&#12288;&#12288;&#12288;&#12288;
							<input class="search" type="button" value="返&#12288;&#12288;回" onclick="goback();" />
						</td>
					</tr>
					<tr>
						<td>
							<div id="errors" style="display: none; color: red; width:800;">  
								${exception.message }
						        <c:forEach items="${exception.stackTrace }" var="e">  
						    	${e }<br />  
						        </c:forEach>  
						    </div> 
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>
</body>  
</html>  