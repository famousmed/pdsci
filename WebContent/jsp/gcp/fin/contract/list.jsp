<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<style type="text/css">
.i-trend-main-div-table th{color: #333;}
</style>
<div class="i-trend-main-div">
	<table class="i-trend-main-table i-trend-main-div-table"  border="0" cellpadding="0" cellspacing="0" width="100%">
		<c:if test="${!empty contList }">
		<col width="5%" />
        <col width="10%" />
        <col width="15%" />
        <col width="10%" />
        <col width="10%" />
        <col width="10%" />
        <col width="10%" />
        <col width="10%" />
        <col width="10%"/>
        <col width="10%" />
        <tr>
	     <th>序号</th>
	     <th>合同编号</th>
	     <th>合同名称</th>
	     <th>合同类型</th>
	     <th>合同经费</th>
	     <th>合同份数</th>
	     <th>合同例数</th>
	     <th>盖章日期</th>
	     <th>附件</th>
	     <c:if test="${param.mainView!=GlobalConstant.FLAG_Y }">
	     <th>操作</th>
	     </c:if>
	   </tr>
	   <c:forEach items="${contList}" var="cont" varStatus="status">
		<tr <c:if test="${status.count%2==0}"> class="odd" </c:if> >
			<td>${status.count}</td>
			<td>${cont.contractNo}</td>
			<td>${cont.contractName}</td>
			<td>
			  <c:forEach items="${gcpContractTypeEnumList }" var="type">
			          <c:if test="${type.id eq cont.contractTypeId }">
			            ${type.name }
			          </c:if>
			  </c:forEach>
			</td>
			<td>${cont.contractFund}</td>
			<td>${cont.contractCopies}</td>
			<td>${cont.caseNumber}</td>
			<td>${cont.stampDate}</td>
			<td>
			   <c:if test="${empty cont.fileName}">——</c:if>
			         <a title="${cont.fileName }" href='<s:url value="/pub/file/down?fileFlow=${cont.fileFlow}"/>'>
					 <span>${pdfn:cutString(cont.fileName,5,true,3 )}</span>
					 </a>
			</td>
			<c:if test="${param.mainView!=GlobalConstant.FLAG_Y }">
			<td style="text-align: left;">
			<a href="javascript:void(0)"  onclick="editContract('${cont.contractFlow}','${cont.projFlow}')" title="点击修改"><img alt="修改合同" src="<s:url value="/css/skin/Blue/images/modify.png"/>"></a>&nbsp;
			<a href="javascript:void(0)"  onclick="delContract('${cont.contractFlow}','${cont.projFlow}')" title="点击删除"><img alt="删除合同" src="<s:url value="/css/skin/Blue/images/del2.png"/>"></a>
			<c:if test="${!empty cont.contractFile }">&nbsp;<a href="<s:url value='/pub/file/down'/>?fileFlow=${cont.contractFile}" title="点击下载附件"><img alt="下载合同附件" src="<s:url value="/css/skin/Blue/images/dload.png"/>"></a></c:if>
			</td>
			</c:if>
		</tr>
	   </c:forEach>
	   </c:if>
	   <c:if test="${empty contList }">
	   <tr><td>无记录！</td></tr>
	   </c:if>
	</table>
</div>
