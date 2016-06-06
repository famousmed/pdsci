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
	<jsp:param name="jquery_ui_combobox" value="true"/>
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
	function save(){
		var form = $("#saveForm");
		if(form.validationEngine("validate")){
			var inputs = $("input[name='drugPacks']");
			if (inputs == null || inputs.length==0) {
				jboxTip("请至少选择一个药物编码！");
				return;
			}
			jboxConfirm("确认该次出库操作？",function(){
				var values = [];
				inputs.each(function(){
					var value = this.value;
					var obj = {"drugPack":value};
					values.push(obj);
				});
				var url = "<s:url value='/gcp/drug/saveDrugOut'/>?drugFlow=${drug.drugFlow}&projFlow=${drug.projFlow}&outDate="
						+$("#outDate").val()+"&drugAmount="+$("#drugAmount").val();
				jboxPostJson(url,JSON.stringify(values),function(resp){
					if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
						window.parent.frames['mainIframe'].location.reload(true);
						jboxClose();
					}
				},null,true);
			},null);
		}
	}
	
	function doClose(){
		jboxClose();
	}
	
	function selDrugPack(obj,recordFlow,drugPack){
		if ($("#"+recordFlow).length == 0) {
			$(obj).css("background","pink");
			$("#"+recordFlow+"_span").html("<input type='hidden' id='"+recordFlow+"' name='drugPacks' value='"+drugPack+"'>");
		} else {
			$(obj).css("background","#fff");
			$("#"+recordFlow+"_span").html("");
		}
		$("#drugAmount").val($("[name='drugPacks']").length);
	}
	
	function allSelect(){
		$(".con_drug").click();
	}
</script>
</head>
<body>
	<div class="mainright">
	<div class="content">
			<div class="title1 clearfix">
				<form id="saveForm"  method="post" style="position: relative;"> 
				<table width="100%" cellpadding="0" cellspacing="0" class="basic">
					<tr>
					   <th colspan="4" style="text-align: left;padding-left: 10px;">药物编码
					   &#12288;<input type="checkbox" name="selAll" onclick="allSelect();"/>全选  
					   </th>
					</tr>
					<c:if test="${!empty drugStoreRecs }">
					<tr>
					   <td colspan="4" style="padding-left: auto;">
					   	<c:forEach items="${drugStoreRecs }" var="rec">
						<div class="con_drug" onclick="selDrugPack(this,'${rec.recordFlow }','${rec.drugPack}')">
							${rec.drugPack}
							<span style="display: none;" id="${rec.recordFlow }_span"></span>
						</div>
						</c:forEach>
					   </td>
					</tr>
					</c:if>
					<c:if test="${empty drugStoreRecs }">
					<tr>
					   <td colspan="4"><font color="red">该药物暂无已入库的编码，请入库！</font></td>
					</tr>
					</c:if>
					<tr>
					   <th colspan="4" style="text-align: left;padding-left: 10px;">出库信息</th>
					</tr>
					 <tr>
					   <td style="text-align: right">出库日期：</td>
					   <td>
					      <input type="text" id="outDate" name="outDate" value="${pdfn:getCurrDate() }" class="xltext validate[required]" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
					      <span class="red">*</span>
					   </td>
					   <td style="text-align: right">出库数量：</td>
					   <td>
					      <input type="text" id="drugAmount" name="drugAmount" value="${drugIn.drugAmount }"class="xltext validate[custom[number]]"/>
					   </td>
					 </tr>
				</table>
			</form>
		</div>
		<div style="width: 100%;" align="center" >
			<input class="search" type="button" value="保&#12288;存" onclick="save()"  />
			<input class="search" type="button" value="关&#12288;闭" onclick="doClose()"  />
		</div>
</div></div>
</body>
</html>