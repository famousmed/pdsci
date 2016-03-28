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
		function doSave(){
			if(false==$("#projOrgForm").validationEngine("validate")){
				return ;
			}
			var projOrgTab = $('#projOrgTable');
			var trs = projOrgTab.children();
			var datas = [];
			$.each(trs , function(i , n){
				var recordFlow = $(n).find("input[name='recordFlow']").val();
				var centerNo = $(n).find("input[name='centerNo']").val();
				var orgName = $(n).find("input[name='orgName']").val();
				var orgTypeId =  $(n).find("select[name='orgTypeId']").val();
				var patientCount =  $(n).find("input[name='patientCount']").val();
				var researcher =  $(n).find("input[name='researcher']").val();
				var data = {
						"recordFlow":recordFlow,
						"centerNo":centerNo,
						"orgName":orgName,
						"orgTypeId":orgTypeId,
						"patientCount":patientCount,
						"researcher":researcher,
				};
				datas.push(data);
				
			});
			var t = {'projOrgList':datas};
			var url = "<s:url value='/irb/researcher/saveProjOrgBatch'/>";
			jboxPostJson(url , JSON.stringify(t) , function(){
				window.parent.frames['mainIframe'].showProjOrg();
				window.location.reload(true);
			} , null , true);
		}
		
		function addTr(){
			$('#projOrgTable').append($("#template tr:eq(0)").clone());
			$('#noRecordTr').css("display","none");
		}
		function delEmptyTr(obj){
			   //var tr=obj.parentNode.parentNode;
			   var tr = $(obj).closest("tr");
	           tr.remove();
	           var trs =  $('#projOrgTable').children();
	           if (trs.length == 0) {
	        	   $('#noRecordTr').css("display",""); 
	           }
		}
		   function delProjOrg(recordFlow,obj){
			   jboxConfirm("确认删除？" ,function(){
				   jboxGet("<s:url value='/irb/researcher/delProjOrg?recordFlow='/>" + recordFlow,null,function(){
					   var tr = $(obj).closest("tr");
		    	        tr.remove();
		    	        window.parent.frames['mainIframe'].showProjOrg();
		    	        window.location.reload(true);
				   },null,true);
			   }); 
		   }
	function doClose() {
		jboxClose();
	}
</script>
<style type="text/css">
	.edit3{text-align: center;border:none;}
</style>
</head>
<body>
	<div class="mainright">
		<div class="content">
	<div>
		<form id="projOrgForm" >
			<table class="xllist">
				<thead>
				<tr>
					<th width="60px">序号</th>
					<th width="120px">机构名称</th>
					<th width="80px">机构角色</th>
					<th width="80px">承担例数</th>
					<th width="100px">主要研究者</th>
					<th width="60px">操作</th>
				</tr>
				</thead>
				<tbody  id="projOrgTable">
					<c:forEach items="${ projOrgList}" var="projOrg">
						<tr>
							<td width="60px">
								<input type="text" style="width: 50px;text-align: center;" class="validate[custom[number]] text" name="centerNo" value="${projOrg.centerNo }"/>
							 	<input type="hidden" name="recordFlow" value="${projOrg.recordFlow }"/>
							</td>
							<td width="120px">
								<input type="text" style="width: 120px" class="validate[required]" name="orgName" value="${projOrg.orgName }"/>
							</td>
							<td width="80px">
								<select name="orgTypeId"  class="text" style="width: 60px">
									<option value="${projOrgTypeEnumParti.id }"  <c:if test="${projOrg.orgTypeId eq projOrgTypeEnumParti.id}">selected</c:if>>${projOrgTypeEnumParti.name }</option>
									<option value="${projOrgTypeEnumLeader.id }"  <c:if test="${projOrg.orgTypeId eq  projOrgTypeEnumLeader.id }">selected</c:if>>${projOrgTypeEnumLeader.name }</option>
								</select>
							</td>
							<td width="80px">
								<input type="text" style="width: 80px" name="patientCount" value="${projOrg.patientCount }"/>
							</td>
							<td width="100px">
								<input type="text" style="width: 100px" name="researcher" value="${projOrg.researcher }"/>
							</td>
							<td width="60px">
							 [<label onclick="delProjOrg('${projOrg.recordFlow}',this)" style="color:blue;cursor: pointer;" >删除</label>]
							 </td>
						</tr>
					</c:forEach>
				</tbody>
				<c:if test="${projOrgList == null || projOrgList.size()==0 }"> 
					<tr id="noRecordTr" style="display: "> 
						<td align="center" colspan="6">无记录</td>
					</tr>
				</c:if>
			</table>
		</form>
               <div align="center" style="margin-top: 20px">
                <input type="button" class="search" value="新&#12288;增" onclick="addTr();" />
				<input type="button" class="search" value="保&#12288;存" onclick="doSave();" />
				<input type="button" class="search" value="关&#12288;闭" onclick="doClose();" />
		</div>
   </div>
   </div></div>
   <table style="display: none" id="template" name="template">
 <tr >
	   		<td width="60px"><input type="text" style="width: 50px;text-align: center;" class="validate[custom[number]] text" name="centerNo" value=""/></td>	 
	   		<td width="120px">
	   			<input type="text" style="width: 120px" class="validate[required]" name="orgName" value=""/>
	   		</td> 
			<td width="80px">
				<select name="orgTypeId"  class="text" style="width: 60px">
					<option value="${projOrgTypeEnumParti.id }" >${projOrgTypeEnumParti.name }</option>
					<option value="${projOrgTypeEnumLeader.id }">${projOrgTypeEnumLeader.name }</option>
				</select>
			</td>
			<td width="80px">
				<input type="text" style="width: 80px" name="patientCount" value=""/>
			</td>
			<td width="100px">
				<input type="text" style="width: 100px" name="researcher" value=""/>
			</td>
			<td width="60px">	
				  [<label onclick="delEmptyTr(this)" style="color:blue;cursor: pointer;" >删除</label>]
			</td>
	   </tr>
</table>
</body>
</html>