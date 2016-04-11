<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	<jsp:param name="jquery_fixedtable" value="true"/>
</jsp:include>
<script type="text/javascript">
	function changeDecision(obj){
		var irbTypeId = obj.value;
		var url = "<s:url value='/gcp/proj/irbDecisionList'/>?irbTypeId="+irbTypeId+"&projFlow=${param.projFlow}";
		window.location.href=url;
	}
	function save(){
		var form = $("#irbForm");
		if(form.validationEngine("validate")){
			var url = "<s:url value='/gcp/proj/addIrb' />";
			var requestData = form.serialize();
			jboxPost(url,requestData,function(resp){
				if(resp=="${GlobalConstant.SAVE_SUCCESSED}"){
					window.parent.frames["mainIframe"].window.reload();
					jboxClose();
				}
			},null,true);
		}
	}
</script>
</head>
<style>
.edit3{text-align: left;border:none;}
</style>
<body>
	<div class="mainright">
	<div class="content">
		<form id="irbForm">
		<div class="title1 clearfix">
			<div class="title1 clearfix">
				<table width="100%" cellpadding="0" cellspacing="0" class="basic">
					<tr>
						<th width="18%">伦理审查类型：</th>
						<td width="32%">
							<c:choose>
								<c:when test="${empty param.irbFlow }">
									<select class="validate[required] inputText" name="irbTypeId" onchange="changeDecision(this)">
										<option value="">请选择</option>
										<c:forEach items="${irbTypeEnumList}" var="irbType">
											<option value="${irbType.id }" <c:if test="${irbType.id==param.irbTypeId}">selected="selected"</c:if> >${irbType.name}</option>
										</c:forEach>
									</select><font color="red">*</font>
								</c:when>
								<c:otherwise>${irb.irbTypeName}</c:otherwise>
							</c:choose>
						</td>
						<th width="18%">受理号：</th>
						<td width="32%">
						<c:choose>
							<c:when test="${empty param.irbFlow }">
								<input type="text" name="irbNo" class="inputText" />
							</c:when>
							<c:otherwise>${irb.irbNo}</c:otherwise>
						</c:choose>
						</td>
					</tr>
					<tr>
						<th width="18%">主审委员：</th>
						<td id="member" colspan="3">
						<c:choose>
							<c:when test="${empty param.irbFlow }">
								<c:choose>
									<c:when test="${empty param.irbTypeId }">请先选择伦理审查类型！</c:when>
									<c:when test="${param.irbTypeId==irbTypeEnumInit.id }">
										方案：<input type="text" name="committeePRO" class="inputText" />&#12288;知情同意书：<input type="text" name="committeeICF" class="inputText" />
									</c:when>
									<c:otherwise>
										<input type="text" name="committee" class="inputText" />
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>${committee}</c:otherwise>
						</c:choose>
						</td>
					</tr>
					<tr>
						<th width="18%">审查日期：</th>
						<td
						<c:if test="${param.irbTypeId==irbTypeEnumTerminate.id||param.irbTypeId==irbTypeEnumFinish.id }"> colspan="3" </c:if> >
						<c:choose>
							<c:when test="${empty param.irbFlow }">
								<input type="text" name="irbReviewDate" class="inputText" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" />
							</c:when>
							<c:otherwise>${irb.irbReviewDate}</c:otherwise>
						</c:choose>
						</td>
						<c:if test="${param.irbTypeId!=irbTypeEnumTerminate.id&&param.irbTypeId!=irbTypeEnumFinish.id }">
						<th  width="18%">跟踪审查日期：</th>
						<td  width="32%">
						<c:choose>
							<c:when test="${empty param.irbFlow }">
								<input type="text" name="trackDate" class="inputText" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" />
							</c:when>
							<c:otherwise>${irb.trackDate}</c:otherwise>
						</c:choose>
						</td>
						</c:if>
					</tr>
					<tr>
						<th  width="18%">审查决定：</th>
						<td colspan="3" id="decision">
						<c:choose>
								<c:when test="${empty param.irbFlow }">
									<c:choose>
										<c:when test="${empty param.irbTypeId }">请先选择伦理审查类型！</c:when>
										<c:otherwise>
											<c:forEach items="${decisionList}" var="dec">
												<input type='radio' name='irbDecisionId' class="validate[required]" value='${dec.id }' id='dec_${dec.id }'><label for='dec_${dec.id }'>${dec.name }</label>&#12288;
											</c:forEach><font color="red">*</font>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>${irb.irbDecisionName}</c:otherwise>
						</c:choose>
						</td>
					</tr>
				</table>
		</div>
		<div style="width: 100%;" align="center" >
			<input type="hidden" name="projFlow" value="${param.projFlow}">
			<c:choose>
				<c:when test="${empty param.irbFlow }">
					<input class="search" type="button" value="保&#12288;存" onclick="save()" />
				</c:when>
				<c:otherwise>
					<input class="search" type="button" value="关&#12288;闭" onclick="jboxClose()" />
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	</form>
</div></div>
</body>
</html>