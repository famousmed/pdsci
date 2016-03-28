<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="ueditor" value="true"/>
</jsp:include>
<script type="text/javascript">
function save() {
	if(false==$("#saveCfgForm").validationEngine("validate")){
		return ;
	}
	var url = "<s:url value='/sys/cfg/save'/>";
	var data = $('#saveCfgForm').serialize();
	jboxPost(url, data, function() {
		window.location.href="<s:url value='/sys/cfg/main'/>?tagId=${param.tagId}";
	});
}
</script>
<div class="mainright">
	<div class="content">
 		<form id="saveCfgForm" >
 		<div class="title1 clearfix">
			<div><font color="red">&#12288;&#12288;所有参数保存后，需刷新内存才能生效!!!</font></div>
			<jsp:include page="/jsp/sys/cfg/sysCfg.jsp"/>
			<c:if test="${'systemFuncs'==param.tagId }">
			<fieldset>
			<legend>公共文档配置</legend>
			<table class="xllist">
				<thead>
					<tr>
						<th width="20%">配置项</th>
						<th width="80%">配置内容</th>
					</tr>
				</thead>	
				<tr>
					<td style="text-align: right" width="100px">允许上传文档大小(M)：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
						<input type="hidden" name="cfgCode" value="erp_doc_limit_size">
						<c:if test="${not empty sysCfgMap['erp_doc_limit_size']}">
						<input type="text" class="validate[custom[number]] xltext" name="erp_doc_limit_size" value="${sysCfgMap['erp_doc_limit_size']}" style="width: 400px;" placeholder=""/>
						</c:if>
						<c:if test="${empty sysCfgMap['erp_doc_limit_size']}">
						<input type="text" class="validate[custom[number]] xltext" name="erp_doc_limit_size" value="100" style="width: 400px;" placeholder=""/>
						</c:if>
					    <input type="hidden" name="erp_doc_limit_size_desc"  value="允许上传文档大小(M)">
					</td>
				</tr>
			</table>
			</fieldset>
			</c:if>
			<div class="button" >
				<input type="button" class="search" onclick="save();" value="保&#12288;存">
			</div>
		</div>	
		</form>
	</div> 
</div>