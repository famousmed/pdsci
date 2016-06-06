<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style type="text/css">
.ui-recent-footer {
	padding: 12px 9px;
	height: 16px;
	line-height: 16px;
	text-align: right;
}
</style>
<script type="text/javascript">
<!--
function editApplyFile(projFlow){
	jboxOpen("<s:url value='/gcp/rec/editApplyFile'/>?projFlow="+projFlow,"上传项目文件",900,400);
}
function aliveRemark(obj,fileFlow){
	if(obj.checked){
		$("#"+fileFlow+"_remark").attr("disabled",false);
	}else {
		$("#"+fileFlow+"_remark").attr("disabled",true);
	}
}
function viewFile(fileFlow,fileName){
		
	  var url ='<s:url value='/pub/file/swfview'/>?fileFlow='+fileFlow+"&projFlow=${param.projFlow}";
	  
	  if($("#newWindow").attr("checked")=="checked"){
		  window.open(url,fileName);   
	  }else {
		  var mainIframe = window.parent.frames["mainIframe"];
		 	var width = mainIframe.document.body.scrollWidth;
		   var height = mainIframe.document.body.scrollHeight;
		   var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='"+width+"px' height='"+height+"px' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	   		jboxMessager(iframe,fileName,width,height);
	  }
	   
}
//-->
</script>
<div class="i-trend-main-div">
	<table class="i-trend-main-table i-trend-main-div-table"  border="0" cellpadding="0" cellspacing="0" width="100%">
		<col width="10%" />
        <col width="25%" />
        <col width="15%" />
        <col width="20%" />
        <tr>
		    <th colspan="5" class="ith">
			    <span>文件信息	&#12288;&#12288;<input type="checkbox" id="newWindow" checked="checked"/>新窗口打开</span>
			    <c:if test="${proj.projStatusId == gcpProjStatusEnumEdit.id||proj.projStatusId == gcpProjStatusEnumNoPassed.id }"><i class="i-trend-main-back" ><a href="javascript:void(0)" onclick="editApplyFile('${param.projFlow}')" title="点击修改"></a></i></c:if>
		    
		    </th>
        </tr>
         <c:if test="${!empty fileList }">
        <tr>
	     <th>序号</th>
	     <th>文件名称</th>
	     <th>版本号</th>
	     <th>版本/发布日期</th>
	     <c:if test="${param.auditFlag == 'Y' }">
	    	 <th>审核意见</th>
	     </c:if>
	   </tr>
	     </c:if>
	     <c:forEach items="${fileTemplateList}" var="file" varStatus="status">
	     	<tr <c:if test="${status.count%2==0}"> class="odd" </c:if>>
	     		<td>${status.count}</td>
	     		<td>
		     		<c:if test="${!empty fileFormMap[file.id]}">
		     			<%-- <a href="${ctxPath}/pub/file/down?fileFlow=${fileFormMap[file.id].fileFlow}">${file.fileName }</a> --%>
		     			 <a href="javascript:viewFile('${fileFormMap[file.id].fileFlow}','${file.fileName }');">${file.fileName }</a> 
		     		</c:if>
		     		<c:if test="${empty fileFormMap[file.id]}">
		     			${file.fileName }<font color=red>(未上传)</font>
		     		</c:if>
	     		</td>
	     		<td>${!empty  fileFormMap[file.id]? fileFormMap[file.id].version:'' }</td>
	     		<td>${!empty  fileFormMap[file.id]? fileFormMap[file.id].versionDate :''}</td>
	     		 <c:if test="${param.auditFlag == 'Y' }">
					<td><label><input type="checkbox"  onclick="aliveRemark(this,'${!empty fileFormMap[file.id]?fileFormMap[file.id].fileFlow:file.id}');">不合格&#12288;</label> <input name="${!empty fileFormMap[file.id]?fileFormMap[file.id].fileFlow:file.id }_remark" id="${!empty fileFormMap[file.id]?fileFormMap[file.id].fileFlow:file.id }_remark" disabled="disabled" type="text" style="width: 200px;"/></td>
				</c:if>
	     	</tr>
	     </c:forEach>
	  
	   <c:if test="${empty fileList }">
	   		<tr>
	   			<td colspan="5" >无记录</td>
	   		</tr>
	   </c:if>
	</table>
</div>
