<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="true"/>
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
<style type="text/css">
	.basic tbody th{text-align: left;padding-left: 10px;}
	.basic td.title_td{text-align: right;padding:0;}
</style>
<script type="text/javascript">
	 function save(){
		var form = $("#saveForm");
		if(form.validationEngine("validate")){
			var url = "<s:url value='/gcp/fin/saveFund'/>";
			jboxSubmit(form,url,function(resp){
				if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
					window.parent.frames['mainIframe'].window.search('${param.projFlow}');
					jboxClose();
				}
			},function(){
				jboxTip('${GlobalConstant.SAVE_FAIL}');
			},true);
		}
	} 
	function doClose(){
		jboxClose();
	}
	function changeTbody(){
	    var fundTypeId=$("#fundTypeId").val();
		$("#fundContent").html("");
	    $("#"+fundTypeId).children().clone().prependTo($("#fundContent"));	
	}
	$(document).ready(function(){
		changeTbody();
	
	});
</script>
</head>
<body>
	<div class="mainright">
	<div class="content">
			<div class="title1 clearfix">
				<form id="saveForm"  method="post" style="position: relative;"> 
				<input type="hidden" name="projFlow" value='${param.projFlow}'/>
				<input type="hidden" name="fundFlow" value='${fund.fundFlow}'/>
				<table width="100%" cellpadding="0" cellspacing="0" class="basic">
					<tr>
					   <th colspan="4">经费信息</th>
					</tr>
					<tr>
					   <td style="text-align: right;">经费类型：</td>
					   <td colspan="3">
					    <c:choose>
					      <c:when test="${!empty fund.fundTypeId }">
					          <c:forEach items="${gcpFundTypeEnumList }" var="fundType">
					          <c:if test="${fundType.id eq fund.fundTypeId }"><input type="hidden" id="fundTypeId" name="fundTypeId " value="${fund.fundTypeId }"/>${fund.fundTypeName }</c:if> 
					          </c:forEach>
					      </c:when>
					      <c:otherwise>
					     <select id="fundTypeId" name="fundTypeId" class="xlselect" onchange="changeTbody();">
					         <option value="${gcpFundTypeEnumIn.id}" <c:if test="${empty fund.fundFlow or fund.fundTypeId eq gcpFundTypeEnumIn.id}">selected="selected"</c:if>>${gcpFundTypeEnumIn.name }</option>
					         <option value="${gcpFundTypeEnumOut.id}" <c:if test="${fund.fundTypeId eq gcpFundTypeEnumOut.id}">selected="selected"</c:if>>${gcpFundTypeEnumOut.name }</option>
					     </select>
					     </c:otherwise>
					    </c:choose>
					   </td>
					</tr>
					<tbody id="fundContent">
					   
					</tbody>
				</table>
			</form>
			<table style="display: none;" width="100%" class="basic">
			   <tbody id="${gcpFundTypeEnumIn.id }">
			   <tr>
			      <td style="text-align: right;">票&#12288;&#12288;号：</td>
				  <td>
					 <input type="text" name="fundNo" value="${fund.fundNo }" class="xltext"/>
				  </td>
				  <td style="text-align: right;">金&#12288;&#12288;额：</td>
				  <td>
				     <input type="text" name="fundAmount" value="${fund.fundAmount }" class="xltext validate[custom[number]] validate[required]" style="margin-right: 5px;"/>元&nbsp;&nbsp;<span class="red">*</span>
				  </td>
               </tr>
               <tr>
                  <td style="text-align: right;">日&#12288;&#12288;期：</td>
                  <td><input type="text" name="fundDate" value="${fund.fundDate }" class="xltext validate[required]" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="margin-right: 5px;">&nbsp;<span class="red">*</span></td>
                  <td colspan="2"></td>
               </tr>
               <tr>
                  <td style="text-align: right;">内&#12288;&#12288;容：</td>
                  <td colspan="3">
                     <textarea name="fundNote" style="width: 490px;">${fund.fundNote}</textarea>
                  </td>
               </tr>
			   </tbody>
			   
			   <tbody id="${gcpFundTypeEnumOut.id }">
			     <tr>
			      <td style="text-align: right;">金&#12288;&#12288;额：</td>
				  <td>
				     <input type="text" name="fundAmount" value="${fund.fundAmount }" class="xltext validate[custom[number]] validate[required]"style="margin-right: 5px;"/>元&nbsp;<span class="red">*</span>
				  </td>
			      <td style="text-align: right;">日&#12288;&#12288;期：</td>
                  <td><input type="text" name="fundDate" value="${fund.fundDate }" class="xltext validate[required]" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="margin-right: 5px;">&nbsp;<span class="red">*</span></td>
			     </tr>
			     <tr>
			      <td style="text-align: right;">用&#12288;&#12288;途：</td>
			      <td>
			      <select name="fundUsesId" class="xlselect">
			         <c:forEach items="${dictTypeEnumGcpFundUsesList}" var="dict">
			             <option value="${dict.dictId }" <c:if test="${dict.dictId eq fund.fundUsesId}">selected="selected"</c:if>>${dict.dictName }</option>
			         </c:forEach>
			      </select>
			      </td>
			      <td style="text-align: right;">其他用途：</td>
			      <td><input type="text" name="fundUsesOther" value="${fund.fundUsesOther }" class="xltext"></td>
			     </tr>
			     <tr>
			       <td style="text-align: right;">内&#12288;&#12288;容：</td>
			       <td colspan="3">
			          <textarea name="fundNote" style="width: 510px;">${fund.fundNote }</textarea>
			       </td>
			     </tr>
			   </tbody>
			</table>
		</div>
		<div style="width: 100%;margin-top: 10px;" align="center" >
			<input class="search" type="button" value="保&#12288;存" onclick="save()"  />
			<input class="search" type="button" value="关&#12288;闭" onclick="doClose()"  />
		</div>
</div></div>
</body>
</html>