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
		function doApply(){
			var option = {
					type:"post" , 
					data: $("#applyForm").serialize() ,
					showLoadMsg:true,
					transition: "slide",
					reverse: false,
					changeHash: true,
					reloadpage:true
				};
			$.mobile.changePage("<s:url value='/app/crs/doApply?projFlow=${param.projFlow}&userFlow=${param.userFlow}'/>",option);
		}
		
		$(document).delegate('#applyDialog', 'click', function() {
		
			if(false==$("#applyForm").validationEngine("validate")){
				return ;
			}
			<c:if test="${not empty includeItemList }">
				<c:set var="nInclude" value="0" scope="page"></c:set>
				<c:forEach items="${includeItemList}" var="item">
					<c:if test="${item['type']=='bool'}">
						<c:set var="nInclude" value="${nInclude+1}" scope="page"></c:set>
					</c:if>
				</c:forEach>
			
			var nInclude = ${nInclude};
			
			var iInclude = 0;
			$.each($("#includeName input[value='true']:radio:checked"),function(i , radio){ 
				iInclude++;
			});
			if(iInclude!=nInclude){
				$("#selectInclude").html((nInclude-iInclude));
				$('#inlinecontentInclude').simpledialog2();
				return;
			}
			</c:if>
			
			<c:if test="${not empty excludeItemList }">
				<c:set var="nExclude" value="0" scope="page"></c:set>
				<c:forEach items="${excludeItemList}" var="item">
					<c:if test="${item['type']=='bool'}">
						<c:set var="nExclude" value="${nExclude+1}" scope="page"></c:set>
					</c:if>
				</c:forEach>
			var nExclude = ${nExclude};
			
			var iExclude = 0;
			$.each($("#excludeName input[value='false']:radio:checked"),function(i , radio){ 
				iExclude++;
			});
			if(iExclude!=nExclude){
				$("#selectExclude").html((nExclude-iExclude));
				$('#inlinecontentExclude').simpledialog2();
				return;
			}
			</c:if>
			
			$("#selectPatientiInfo").html("");
			$("#selectFactor").html("");
		
			var newHtml = $("#selectPatientiInfo").html()+"姓名:"+$("input:text[name='namePy']").val()+"<br>";
			$("#selectPatientiInfo").html(newHtml);
			newHtml = $("#selectPatientiInfo").html()+"出生年月日："+$("input:text[name='birthday']").val()+"<br>";
			$("#selectPatientiInfo").html(newHtml);
			newHtml = $("#selectPatientiInfo").html()+"性别:"+$("input:radio:checked").attr("text")+"<br>";
			$("#selectPatientiInfo").html(newHtml);
			
			$.each($('#factorName input:radio:checked'),function(i , radio){ 
				$("#selectFactor").html($("#selectFactor").html()+$(radio).attr("text")+"<br>");
			});
			
			$('#inlinecontent').simpledialog2();
		});
	</script>
	<div data-role="header" data-position="fixed">
		<a href="<s:url value="/app/crs/patientList?userFlow=${param.userFlow}&projFlow=${param.projFlow}"/>" data-icon="back" data-transition="slide" data-direction="reverse">返回</a>
	    <h1>${projName}</h1>
	    <a href="<s:url value="/app/crs/login"/>" data-icon="home" data-transition="slide" data-direction="reverse">退出</a>
	</div>

	<div data-role="content">
		<form id="applyForm" name="applyForm" data-transition="slide">
		<div data-role="fieldcontain">
			<c:if test="${not empty patientInfoItemList }">
			<ul id="patientInfoName" data-role="listview" data-theme="c">
				<li data-role="list-divider">请填写${patientInfoName }</li>
				<c:forEach items="${patientInfoItemList}" var="item">
				<li>
					<span>
					${item['name']}:
					<input data-theme="c" name='patientInfoitem' type="hidden" value="${item['id']}">
					</span>
					<span>
						<c:choose>
							<c:when test="${item['type']=='text'}">
								<br>
								<input class="validate[required<c:if test="${item['id']=='namePy'}"></c:if>]" data-theme="c" name="${item['id']}" type="text"  placeholder="${item['placeholder']}"><p></p>
							</c:when>
							<c:when test="${item['type']=='number'}">
								<br>
								<input class="validate[required<c:if test="${item['id']=='birthday'}">,custom[date2]</c:if>]" data-theme="c" name="${item['id']}" type="text" placeholder="${item['placeholder']}">
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
			<p></p>
			<c:if test="${not empty factorItemList }">
			<ul id="factorName" data-role="listview" data-theme="c">
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
			<p></p>
			<c:if test="${not empty includeItemList }">
			<ul id="includeName" data-role="listview" data-theme="c">
				<li data-role="list-divider">请填写${includeName }</li>
				<c:forEach items="${includeItemList}" var="item">
				<li>
					<span>
					${item['text']}:
					<input data-theme="c" name='includeitem' type="hidden" value="${item['id']}">
					</span>
					<span>
						<c:choose>
							<c:when test="${item['type']=='text'}">
								<input class="validate[required]" data-theme="c" name="${item['id']}" type="text" placeholder="${item['placeholder']}">
							</c:when>
							<c:when test="${item['type']=='number'}">
								<input class="validate[required<c:if test="${not empty item['maxValue']}">,custom[number],max[${item['maxValue'] }]</c:if><c:if test="${not empty item['minValue']}">,custom[number],min[${item['minValue'] }]</c:if>]" data-theme="c" name="${item['id']}" type="text" placeholder="${item['placeholder']}">
							</c:when>
							<c:when test="${item['type']=='bool'}">
								<%-- <c:choose>
									<c:when test="${item['passedValue']=='true' }">
										<input class="validate[required]" data-theme="c" id="${item['id']}_Y" name="${item['id']}" type="radio" value="true" placeholder="${item['placeholder']}">&nbsp;<label for="${item['id']}_Y">是</label>&#12288;
									</c:when>
									<c:when test="${item['passedValue']=='false'}">
										<input class="validate[required]" data-theme="c" id="${item['id']}_N" name="${item['id']}" type="radio" value="false" placeholder="${item['placeholder']}">&nbsp;<label for="${item['id']}_N">否</label>
									</c:when>
									<c:otherwise>
										<input class="validate[required]" data-theme="c" id="${item['id']}_Y" name="${item['id']}" type="radio" value="true" placeholder="${item['placeholder']}">&nbsp;<label for="${item['id']}_Y">是</label>&#12288;
										<input class="validate[required]" data-theme="c" id="${item['id']}_N" name="${item['id']}" type="radio" value="false" placeholder="${item['placeholder']}">&nbsp;<label for="${item['id']}_N">否</label>
									</c:otherwise>
								</c:choose> --%>
								<input class="validate[required]" data-theme="c" id="${item['id']}_Y" name="${item['id']}" type="radio" value="true" placeholder="${item['placeholder']}">&nbsp;<label for="${item['id']}_Y">是</label>&#12288;
								<input class="validate[required]" data-theme="c" id="${item['id']}_N" name="${item['id']}" type="radio" value="false" placeholder="${item['placeholder']}">&nbsp;<label for="${item['id']}_N">否</label>
							</c:when>
							<c:when test="${item['type']=='radio'}">
								<c:forEach items="${item['optionList']}" var="option">
									<input class="validate[required]" data-theme="c" id="${item['id']}_${option['id']}" name="${item['id']}" type="radio" value="${option['id']}" placeholder="${item['placeholder']}">&nbsp;<label for="${item['id']}_${option['id']}">${option['text']}</label>&#12288;
								</c:forEach>
							</c:when>
						</c:choose>
					</span>
				</li>
				</c:forEach>
			</ul>
			</c:if>
			<p></p>
			<c:if test="${not empty excludeItemList }">
			<ul id="excludeName" data-role="listview" data-theme="c">
				<li data-role="list-divider">请填写${excludeName }</li>
				<c:forEach items="${excludeItemList}" var="item">
				<li>
					<span>
					${item['text']}:
					<input data-theme="c" name='excludeitem' type="hidden" value="${item['id']}">
					</span>
					<span>
						<c:choose>
							<c:when test="${item['type']=='text'}">
								<input class="validate[required]" data-theme="c" name="${item['id']}" type="text" placeholder="${item['placeholder']}">
							</c:when>
							<c:when test="${item['type']=='number'}">
								<input class="validate[required<c:if test="${not empty item['maxValue']}">,custom[number],max[${item['maxValue'] }]</c:if><c:if test="${not empty item['minValue']}">,custom[number],min[${item['minValue'] }]</c:if>]" data-theme="c" name="${item['id']}" type="text" placeholder="${item['placeholder']}">
							</c:when>
							<c:when test="${item['type']=='bool'}">
								<%-- <c:choose>
									<c:when test="${item['passedValue']=='true' }">
										<input class="validate[required]" data-theme="c" id="${item['id']}_Y" name="${item['id']}" type="radio" value="true" placeholder="${item['placeholder']}">&nbsp;<label for="${item['id']}_Y">是</label>&#12288;
									</c:when>
									<c:when test="${item['passedValue']=='false'}">
										<input class="validate[required]" data-theme="c" id="${item['id']}_N" name="${item['id']}" type="radio" value="false" placeholder="${item['placeholder']}">&nbsp;<label for="${item['id']}_N">否</label>
									</c:when>
									<c:otherwise>
										<input class="validate[required]" data-theme="c" id="${item['id']}_Y" name="${item['id']}" type="radio" value="true" placeholder="${item['placeholder']}">&nbsp;<label for="${item['id']}_Y">是</label>&#12288;
										<input class="validate[required]" data-theme="c" id="${item['id']}_N" name="${item['id']}" type="radio" value="false" placeholder="${item['placeholder']}">&nbsp;<label for="${item['id']}_N">否</label>
									</c:otherwise>
								</c:choose>	 --%>
								<input class="validate[required]" data-theme="c" id="${item['id']}_N" name="${item['id']}" type="radio" value="false" placeholder="${item['placeholder']}">&nbsp;<label for="${item['id']}_N">否</label>
								<input class="validate[required]" data-theme="c" id="${item['id']}_Y" name="${item['id']}" type="radio" value="true" placeholder="${item['placeholder']}">&nbsp;<label for="${item['id']}_Y">是</label>&#12288;
										
							</c:when>
							<c:when test="${item['type']=='radio'}">
								<c:forEach items="${item['optionList']}" var="option">
									<input class="validate[required]" data-theme="c" id="${item['id']}_${option['id']}" name="${item['id']}" type="radio" value="${option['id']}" placeholder="${item['placeholder']}">&nbsp;<label for="${item['id']}_${option['id']}">${option['text']}</label>&#12288;
								</c:forEach>
							</c:when>
						</c:choose>
					</span>
				</li>
				</c:forEach>
			</ul>
			</c:if>
			
			
			
			<div id="inlinecontentInclude" style="display:none" data-options='{"mode":"blank","headerText":"纳入标准不符合?","headerClose":false,"blankContent":true}'>
			    <div class="ui-content">
				    <p>共有：<span id="selectInclude"></span>条纳入标准不符合，不能入组申请！</p>
				    
				    <a rel='close' data-role='button' href='#'>取消</a>
			    </div>
			</div>
			
			<div id="inlinecontentExclude" style="display:none" data-options='{"mode":"blank","headerText":"排除标准不符合?","headerClose":false,"blankContent":true}'>
			    <div class="ui-content">
				    <p>共有：<span id="selectExclude"></span>条排除标准不符合，不能入组申请！</p>
				    
				    <a rel='close' data-role='button' href='#'>取消</a>
			    </div>
			</div>
			
			
			<div id="inlinecontent" style="display:none" data-options='{"mode":"blank","headerText":"确认入组申请?","headerClose":false,"blankContent":true}'>
			    <div class="ui-content">
				    <p>您输入的基本信息是：</p>
				    <span id="selectPatientiInfo"></span>
				    <p>您的选择分层是：</p>
				    <span id="selectFactor"></span>
				    <a rel='' data-role='button' href='javascript:doApply();'>申请</a>
				    <a rel='close' data-role='button' href='#'>取消</a>
			    </div>
			</div>
			<p><br><a href="#" id="applyDialog" data-role="button">入组申请</a></p>
		</div>
		</form>
	</div>
</div>
</body>
</html>