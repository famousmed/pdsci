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
</jsp:include>
<script type="text/javascript">
var width=(window.screen.width)*0.7;
var height=(window.screen.height)*0.7;
function search(){
	$("#searchForm").submit();
}

function toPage(page){
	var form = $("#searchForm");
	$("#currentPage").val(page);
	form.submit();
}

function showCertificate(trainFlow){
	//alert(trainFlow);
	jboxOpen("<s:url value='/irb/office/certificate?trainFlow='/>" + trainFlow +"&lock=lock","培训证书", width,height);
}

</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
		<form id="searchForm" action="<s:url value="/irb/office/searchTrain" />" method="POST">
			<p>
				培训类型：
				<c:forEach items="${irbTrainCategoryEnumList}" var="dict">
					<input type="checkbox" name="trainCategoryId" value="${dict.id}" id="trainCategory_${dict.id}" 
						<c:forEach items='${categoryIdList}' var='cId'>
							<c:if test="${cId eq dict.id}">checked="checked"</c:if> 
						</c:forEach>
						/><label for="trainCategory_${dict.id}">${dict.name}</label>&#12288;
				</c:forEach>
				培训日期：
				<input type="text" name="trainDate" value="${param.trainDate}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="ctime" readonly="readonly" style="margin-right: 0px;width:100px"/>~<input type="text" name="endTrainDate"  value="${param.endTrainDate}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="ctime" readonly="readonly" style="width:100px"/> 
				培训类别：
				<c:forEach items="${irbTrainTypeEnumList}" var="dict">
					<input type="checkbox" name="trainTypeId" value="${dict.id}" id="trainType_${dict.id}" 
						<c:forEach items="${typeIdList}" var="tId">
							<c:if test="${tId eq dict.id}">checked="checked"</c:if>
						</c:forEach> 
						/><label for="trainType_${dict.id}">${dict.name}</label>&#12288;
				</c:forEach>
				&#12288;参与人员：
				<input type="text" class="xltext" style="width: 80px" name="userName" value="${param.userName}" />
				<input type="button" value="查&#12288;询"  class="search" onclick="search();"/>
			</p><br/>
			<table class="xllist">
				<thead>
					<tr>
						<th width="5%">序号</th>
						<th>主办单位</th>
						<th>培训名称</th>
						<th>培训类别</th>
						<th>培训日期</th>
						<th>培训地点</th>
						<th>培训天数</th>
						<th>参加人数</th>
						<!-- <th>参加人员</th>
						<th>备注</th> -->
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${trainList}" var="train" varStatus="status">
						<tr>
							<td width="5%">${status.count}</td>
							<td width="10%">${train.trainOrg}</td>
							<td width="10%">${train.trainName}</td>
							<td width="5%">${train.trainTypeName}</td>
							<td width="10%">${train.trainDate}</td>
							<td width="10%">${train.trainAddress}</td>
							<td width="5%">${train.trainDays}</td>
							<td width="5%">
								<%-- ${fn:length(trainUserMap)} --%>
								<c:forEach items="${trainUserMap}" var="entry">
								     <c:if test="${entry.key==train.trainFlow}">
								     	<a href="javascript:void(0);" onclick="showCertificate('${train.trainFlow}');" style="cursor: pointer;">[${entry.value.size()}]</a>
								     </c:if>
							    </c:forEach>
							</td>
							
							<%-- <td width="20%">
								<c:forEach items="${trainUserMap}" var="entry">
								     <c:if test="${entry.key==train.trainFlow}">
								     	<c:forEach items="${entry.value}" var="trainUser">
								    	 ${trainUser.userName}&nbsp;
								    	</c:forEach>
								     </c:if>
							    </c:forEach>
							</td>
							<td width="6%">
								<c:set var="hasFile" value="0"/>
								<c:forEach items="${trainUserMap}" var="entry">
								     <c:if test="${entry.key==train.trainFlow}">
								     	<c:forEach items="${entry.value}" var="trainUser" varStatus="status">
								     		<c:if test="${empty trainUser.fileFlow}"><c:set var="hasFile" value="${hasFile+1}"/></c:if>
								    	</c:forEach>
								    	<c:choose>
								    		<c:when test="${entry.value.size() == hasFile}">无证书</c:when>
									    	<c:otherwise>有证书</c:otherwise>
									    </c:choose>
								     </c:if>
							    </c:forEach> --%>
							    
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<p>
				<input type="hidden" id="currentPage" name="currentPage">
			    <c:set var="pageView" value="${pdfn:getPageView2(trainList , 10)}" scope="request"></c:set>
				<pd:pagination toPage="toPage"/>
			</p>
			
		</form>
		</div>
	</div>
</div>
</body>
</html>