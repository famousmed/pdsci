<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(document).ready(function(){
		if ($("[name='archiveFile']").length==0) {
			$("#saveButton").hide();
		}
	});

   function save(projFlow){
	   var datas = [];
	   var infos=$(".infos");
	   $.each(infos , function(i , n){
		   var fileName=$(n).children("input[name=fileName]").val();
		   var stage=$(n).children("input[name=stage]").val();
		   var id=$(n).children("select[name=archiveFile]").val();
		   if(id){
			 var data={
				"id":id,
				"stage":stage,
				"fileName":fileName,
			 };
			 datas.push(data);
		   }
	   });
	  if(datas.length<=0){
		  jboxTip("请选择一个文件进行归档！");
		  return false;
	  }
	   var requestData = JSON.stringify(datas);
	   var url='<s:url value="/gcp/rec/saveArchive"/>?projFlow='+projFlow;
	   jboxStartLoading();
		jboxPostJson(url,requestData,function(){
			window.parent.frames['mainIframe'].window.loadProjFile();
		},null,true); 
	 
   }
</script>
<div class="ui-box-container" >
	<div class="ui-box-title">
		<div class="ui-box-title-border sl-linear">
			<table  class="i-trend-main-table i-trend-main-div-table"  border="0" cellpadding="0" cellspacing="0" width="100%">
												  <col width="15%"/>
												  <col width="55%"/>
												  <col width="30%"/>
												  <tr>
														<th align="center">序号</th>
														<th align="center">技术文件材料名称</th>
														<th align="center">状态</th>
													</tr>
												
												  <c:forEach items="${gcpProjStageEnumList }" var="stage">
												  <c:if test="${!(stage.id eq gcpProjStageEnumTerminate.id)}">
													<tr>
													  <th class="ith" colspan="3" style="padding-left: 20px;text-align: left;">
													    <span>${stage.name }</span></th>
													</tr>
													<c:forEach items="${fileList }" var="file" varStatus="num">
													  <c:if test="${file.stage eq stage.id }">
													 <tr>
													   <td style="text-align: center;">${num.count }</td>
													   <td style="text-align: left;padding-left: 40px;">${file.fileName }</td>
													   <td style="text-align: center;" class="infos">
													     <input type="hidden" name="stage" value="${stage.id }"/>
													     <input type="hidden" name="fileName" value="${file.fileName }"/>
													     <c:choose>
													        <c:when test="${map[file.id] eq GlobalConstant.RECORD_STATUS_Y }">
													                                归档
													        </c:when>
													        <c:otherwise>
													           <select name="archiveFile">
													               <option value=""></option>
													               <option value="${file.id }">归档</option>
													           </select>
													        </c:otherwise>
													     </c:choose>
													   </td>
													   </tr>
													   </c:if>
													</c:forEach>
													</c:if>
													</c:forEach>   
											
											</table>
										<c:if test="${param.roleScope eq GlobalConstant.ROLE_SCOPE_GO }">
										    <div style="width: 100%;margin-top: 10px;" align="center" >
				                         		<input class="search" type="button" id="saveButton" value="保&#12288;存" onclick="save('${param.projFlow}')"/>
				                            </div>
				                        </c:if>
								</div> 
</div>
</div>