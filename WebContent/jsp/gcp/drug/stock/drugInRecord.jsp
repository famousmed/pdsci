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
    	window.location.reload();
    }
   
    function del(recordFlow){
    	jboxGet("<s:url value='/gcp/drug/delDrugInConfirm'/>?recordFlow="+recordFlow,null,function(resp){
			if(resp == '${GlobalConstant.OPERATE_SUCCESSED}'){
				jboxConfirm("确认删除该入库记录？",function(){
					var url = "<s:url value='/gcp/drug/delDrugIn'/>?recordFlow="+recordFlow;
					jboxPost(url,null,function(resp){
						if(resp=='${GlobalConstant.DELETE_SUCCESSED}'){
							window.parent.frames['mainIframe'].window.location.reload();
							search();
						}
					},null,true);
				},null);
			}else{
				jboxInfo(resp);
			}
		},null,false);
	}
</script>
</head>
<body>
	<div class="mainright">
		<div class="content" style="padding-top: 10px;">
		    <table width="100%" class="xllist" style="margin-top: 10px;">
		     <thead>
		       <tr>
		        <th width="16%">药物名称</th>
		        <th width="9%">药物规格</th>
		        <th width="7%">有无编码</th>
		        <th width="13%">药物编码</th>
		        <th width="10%">入库日期</th>
		        <th width="9%">数量</th>
		        <th width="12%">批号</th>
		        <th width="9%">操作者</th>
		        <th width="7%">操作</th>
		       </tr>
		     </thead>
		     <tbody>
		     <c:if test="${empty drugInList}">
		         <tr>
		           <td colspan="9">无记录！</td>
		         </tr>
		     </c:if>
		    <c:forEach items="${drugInList }" var="in" >
			   <tr>
			     <td width="16%" title="${drug.drugName }">${pdfn:cutString(drug.drugName,7,true,3 )}</td>
			     <td width="9%">${drug.spec }</td>
			     <td width="7%">
			       <c:if test="${empty in.drugPack }">
			                             无
			       </c:if>
			       <c:if test="${!empty in.drugPack }">
			                             有
			       </c:if>
			     </td>
			     <td width="13%">
			       <c:if test="${empty in.drugPack }">
			         ——
			       </c:if>
			       ${in.drugPack }
			     </td>
			     <td width="10%">${in.inDate }</td>
			     <td width="9%">${in.drugAmount }</td>
			     <td width="12%">${in.lotNo}</td>
			     <td width="9%">${in.inOperator}</td>
			     <td width="7%">
				    <a href="javascript:void(0)" onclick="del('${in.recordFlow}');">[删除]</a> 
			     </td>
			   </tr>
		   </c:forEach>
		     </tbody>
		   </table>	
		</div> 
		</div>
</body>
</html>