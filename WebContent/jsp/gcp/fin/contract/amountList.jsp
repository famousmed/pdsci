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
	<jsp:param name="jquery_scrollTo" value="true"/>
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
    function search(){
    	$("#searchForm").submit();
    	
    }
	function down(){
		
	}
		
</script>
</head>
<body>
	<div class="mainright">
		<div class="content" style="padding-top: 10px;">
		
		    <form id="searchForm" action="<s:url value='/gcp/fin/contractList'/>" method="post">
		    <dl>   
		      
		      <dt style="float: left;margin-left: 10px;">项目名称：</dt>
		      <dt style="float: left;margin-left: 5px;"><input type="text" name="projName" value="${param.projName }" class="xltext"/></dt>
		      <dt style="float: left;margin-left: 10px;">合同编号：</dt>
		      <dt style="float: left;margin-left: 5px;"><input type="text" name="contractNo" value="${param.contractNo }" class="xltext" style="width:100px;"/></dt>
		      <dt style="float: left;margin-left: 10px;">合同名称：</dt>
		      <dt style="float: left;margin-left: 5px;"><input type="text" name="contractName" value="${param.contractName }" class="xltext" style="width:100px;"/></dt>
		      <dt style="float: left;margin-left: 10px;">专业组：</dt>
		      <dt style="float: left;margin-left: 5px;">
		        <select name="applyDeptFlow" class="xlselect" onchange="search();">
		           <option value="">请选择</option>
		           <c:forEach items="${deptList }" var="dept">
		             <option value="${dept.deptFlow }" <c:if test="${dept.deptFlow eq param.applyDeptFlow }">selected="selected"</c:if>>${dept.deptName }</option>
		           </c:forEach>
		        </select>
		      </dt>
		      <dt>
		         <input type="button" onclick="search();" value="查&#12288;询" class="search">
		      </dt>
		    </dl>
		    </form>
		    <table width="100%" class="xllist" style="margin-top: 10px;">
		     <thead>
		       <tr>
		        <th width="20%">项目名称</th>
		        <th width="10%">合同编号</th>
		        <th width="20%">合同名称</th>
		        <th width="10%">合同类型</th>
		        <th width="10%">合同经费</th>
		        <th width="10%">合同病例数</th>
		        <th width="10%">盖章日期</th>
		        <th>附件</th>
		       </tr>
		     </thead>
		     <tbody id="fundTb">
		     <c:if test="${empty contractList}">
		         <tr>
		           <td colspan="8">无记录！</td>
		         </tr>
		     </c:if>
		    <c:forEach items="${contractList }" var="cont">
			   <tr>
			     <td>${cont.projName }</td>
			     <td>${cont.contractNo }</td>
			     <td>${cont.contractName }</td>
			     <td>
			       <c:forEach items="${gcpContractTypeEnumList }" var="type">
			          <c:if test="${type.id eq cont.contractTypeId }">
			            ${type.name }
			          </c:if>
			       </c:forEach>
			     </td>
			     <td>${cont.contractFund }</td>
			     <td>${cont.caseNumber }</td>
			     <td>${cont.stampDate }</td>
			     <td>
			         <a title="${cont.fileName }" href='<s:url value="/pub/file/down?fileFlow=${cont.fileFlow}"/>'>
					 <span>${pdfn:cutString(cont.fileName,4,true,3 )}</span>
					 </a>
			     </td>
			   </tr>
		   </c:forEach>
		       
		     </tbody>
		   </table>	
		</div> 
		</div>
		
	
	  
</body>
</html>