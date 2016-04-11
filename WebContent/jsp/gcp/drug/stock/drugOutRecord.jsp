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
    	jboxGet("<s:url value='/gcp/drug/delDrugOutConfirm'/>?recordFlow="+recordFlow,null,function(resp){
			if(resp == '${GlobalConstant.OPERATE_SUCCESSED}'){
				jboxConfirm("确认删除该出库记录？",function(){
					var url = "<s:url value='/gcp/drug/delDrugOut'/>?recordFlow="+recordFlow;
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
		        <th width="8%">药物规格</th>
		        <th width="30%">药物编码</th>
		        <th width="9%">出库日期</th>
		        <th width="8%">数量</th>
		        <th width="8%">操作者</th>
		        <th width="6%">操作</th>
		       </tr>
		     </thead>
		     <tbody>
		     <c:if test="${empty drugOutList}">
		         <tr>
		           <td colspan="9">无记录！</td>
		         </tr>
		     </c:if>
		    <c:forEach items="${drugOutList }" var="out" >
			   <tr>
			     <td width="16%" title="${drug.drugName }">${pdfn:cutString(drug.drugName,7,true,3 )}</td>
			     <td width="8%">${drug.spec }</td>
			     <td width="30%">
			       ${out.drugPack }
			     </td>
			     <td width="9%">${out.outDate }</td>
			     <td width="8%">${out.drugAmount }</td>
			     <td width="8%">${out.outOperator}</td>
			     <td width="6%">
				    <a href="javascript:void(0)" onclick="del('${out.recordFlow}');">[删除]</a> 
			     </td>
			   </tr>
		   </c:forEach>
		     </tbody>
		   </table>	
		</div> 
		</div>
</body>
</html>