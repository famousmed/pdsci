<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype-mobile.jsp"%>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead-mobile.jsp"></jsp:include>
</head>
<body>
<div data-role="page">
	<jsp:include page="/jsp/common/page-common-mobile.jsp"></jsp:include>
	<script>
	function doVisit(){
		var option = {
				type:"post" , 
				data: $("#visitForm").serialize() ,
				showLoadMsg:true,
				transition: "slide",
				reverse: false,
				changeHash: true,
				reloadpage:true
			};
		$.mobile.changePage("<s:url value='/app/crs/doVisit?projFlow=${param.projFlow}&userFlow=${param.userFlow}&patientFlow=${param.patientFlow}'/>",option);
	}
	$(document).delegate('#visitDialog', 'click', function() {
		if(false==$("#visitForm").validationEngine("validate")){
			return ;
		}
		$("#selectFactor").html("");
		
		$.each($('input:radio:checked'),function(i , radio){ 
			$("#selectFactor").html($("#selectFactor").html()+$(radio).attr("text")+"<br>");
		});
		$('#inlinecontent').simpledialog2();
	});
	</script>
	<div data-role="header" data-position="fixed">
		<a href="<s:url value="/app/crs/patient?userFlow=${param.userFlow}&projFlow=${param.projFlow}&patientFlow=${param.patientFlow}"/>" data-icon="back" data-transition="slide" data-direction="reverse">返回</a>
	    <h1>${projName}</h1>
	    <a href="<s:url value="/app/crs/login"/>" data-icon="home" data-transition="slide" data-direction="reverse">退出</a>
	</div>

	<div data-role="content">
		<form id="visitForm" name="visitForm" data-transition="slide">
			<div data-role="fieldcontain">
				<h3>${patientInfo['namePy']}[${patientInfo['sex']}-${patientInfo['birthday']}]&nbsp;</h3>
				<c:if test="${not empty factorItemList }">
				<ul data-role="listview" data-theme="c">
				  	<li data-role="list-divider">请填写${factorName }</li>
					
					<c:forEach items="${factorItemList}" var="item">
					<li>
						<span>
						${item['name']}:
						<input data-theme="c" name='factoritem' type="hidden" value="${item['id']}">
						</span>
						<span>
							<c:choose>
								<c:when test="${item['type']=='text'}">
									<input class="validate[required]" data-theme="c" name="${item['id']}" type="text" placeholder="${item['placeholder']}">
								</c:when>
								<c:when test="${item['type']=='number'}">
									<input class="validate[required]" data-theme="c" name="${item['id']}" type="text" placeholder="${item['placeholder']}">
								</c:when>
								<c:when test="${item['type']=='bool'}">
									<input class="validate[required]" data-theme="c" id="${item['id']}_Y" name="${item['id']}" type="radio" value="true" placeholder="${item['placeholder']}">&nbsp;<label for="${item['id']}_Y">是</label>&#12288;
									<input class="validate[required]" data-theme="c" id="${item['id']}_N" name="${item['id']}" type="radio" value="false" placeholder="${item['placeholder']}">&nbsp;<label for="${item['id']}_N">否</label>
								</c:when>
								<c:when test="${item['type']=='radio'}">
									<c:forEach items="${item['optionList']}" var="option">
										<input class="validate[required]" data-theme="c" id="${item['id']}_${option['id']}" name="${item['id']}" type="radio" value="${option['id']}" placeholder="${item['placeholder']}" text="${option['text']}">&nbsp;<label for="${item['id']}_${option['id']}">${option['text']}</label>&#12288;
									</c:forEach>
								</c:when>
							</c:choose>
						</span>
						</li>
					</c:forEach>
				</ul>
				</c:if>
				<div id="inlinecontent" style="display:none"  data-options='{"mode":"blank","headerText":"确认随访申请?","headerClose":false,"blankContent":true,"fullScreen":false,"fullScreenForce":false}'>
				    <div class="ui-content">
					    <h3> ${patientInfo['namePy']}[${patientInfo['sex']}-${patientInfo['birthday']}]</h3>
					    <p>您的选择分层是：</p>
					    <span id="selectFactor"></span>
					    <a rel='' data-role='button' href='javascript:doVisit();'>申请</a>
					    <a rel='close' data-role='button' href='#'>取消</a>
				    </div>
				</div>
				<p><br><a href="#" id="visitDialog" data-role="button">随访申请</a></p>
			</div>
		</form>
	</div>
</div>
</body>
</html>