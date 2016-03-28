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
<script type="text/javascript">
function save(){
	if(false==$("#fileForm").validationEngine("validate")){
		return false;
	}
	var url = "<s:url value='/gcp/rec/saveMultipartFiles'/>";
	jboxSubmit(
			$("#fileForm"),
			url,
			function(resp){
				window.parent.frames['mainIframe'].window.loadApplyFile();
				jboxClose();				
			},
			function(resp){
				jboxTip("${GlobalConstant.SAVE_FAIL}");
			}
	);
}

function reCheck(obj){
	$(obj).hide();//[重新选择文件]隐藏
	$(obj).prev().hide();//[下载]隐藏
	$(obj).prev().prev().show();//文件按钮显示
	$(obj).prev().prev().addClass("validate[required]");//文件按钮加验证
}

function del(){
	var checkboxs =$("input[name='delId']:checked");
	if(checkboxs.length == 0){
		jboxTip("请勾选要删除的！");
		return false;
	}
	jboxConfirm("确认删除？", function() {
		var ids = "";
		checkboxs.each(function(){
			var id = this.value;
			if(id != ''){
				ids = ids + "id=" + id + "&";
			}
		});
		if(ids != ''){
			var url = "<s:url value='/gcp/rec/delFileByIds'/>?projFlow=${param.projFlow}";
			var requestData = ids;
			jboxPost(
					url,
					requestData,
					function(resp){
						if(resp=='${GlobalConstant.DELETE_SUCCESSED}'){
							window.parent.frames['mainIframe'].window.loadApplyFile();
							jboxClose();
						}
					},
					null,true
			);
		}
	});
}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<form id="fileForm" style="position: relative;" enctype="multipart/form-data" method="post">
				<input type="hidden" name="projFlow" value="${param.projFlow}"/> 
				<table class="xllist" id="append" style="width: 100%">
					<tr>
						<th style="width: 4%">勾选</th>
						<th style="width: 4%">序号</th>
						<th style="width: 6%">已上传</th>
						<th style="width: 31%">文件名称</th>
						<th style="width: 10%">版本号</th>
						<th style="width: 15%">版本日期</th>
						<th style="width: 30%">浏览</th>
					</tr>
					<tbody id="fileTbody">
					<c:forEach items="${fileTemplateList}" var="template" varStatus="status">
					<tr>
						<td style="width: 4%">
							<input type="hidden" name="id" value="${template.id}"/>
							<input type="checkbox" name="delId" value="${template.id}"
							<c:if test="${empty fileFormMap[template.id].fileFlow}">disabled="disabled" </c:if>/>
						</td>
						<td style="width: 4%">${status.count}</td>
						<td style="width: 6%">
							<c:if test="${not empty fileFormMap[template.id].fileFlow}">
								<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>">
							</c:if>
						</td>
						<td style="width: 31%"> 
							<c:if test="${not empty  template.temple}">
								<a href="<s:url value='/jsp/gcp/cfg/applyFile/${template.temple }'/>">${template.fileName}
									<img title="请下载模版文件填写后上传" src="<s:url value='/css/skin/${skinPath}/images/doc.gif'/>"/>
								</a>
							</c:if>
							<c:if test="${ empty  template.temple}">
								${template.fileName}
							</c:if>
							<input type="hidden" name="fileFlow" value="${fileFormMap[template.id].fileFlow}"/>
							<input type="hidden" name="fileName" value="${template.fileName}"/>
						</td>
						<td style="width: 10%">
							<c:if test="${template.version eq GlobalConstant.FLAG_Y}">
								<input type="text"  name="version" class="inputText" value="${fileFormMap[template.id].version}" style="width: 90%;"/>
							</c:if>
							<c:if test="${template.version eq GlobalConstant.FLAG_N}">
								<input type="hidden"  name="version" />
							</c:if>
						</td>
						<td style="width: 15%">
							<c:if test="${template.versionDate==GlobalConstant.FLAG_Y}">
								<input onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputText" name="versionDate"  value="${fileFormMap[template.id].versionDate}"  type="text" readonly="readonly" style="width: 90%;"/>
							</c:if>
							<c:if test="${template.versionDate==GlobalConstant.FLAG_N}">
								<input type="hidden" name="versionDate" />
							</c:if>
						</td>
						<td style="width: 30%;text-align: center;">
						<c:choose>
							<c:when test="${not empty fileFormMap[template.id].fileFlow}">
								<input type="file" name="file" style="display: none;width: 90%;"/>
                				<a id="link" href="<s:url value='/pub/file/down'/>?fileFlow=${fileFormMap[template.id].fileFlow}">[下载]</a>
                				<a href="javascript:void(0);" onclick="reCheck(this);" class="lock">[重新上传]</a>
							</c:when>
							<c:otherwise>
								<input type="file" name="file" style="width: 90%;"/>
							</c:otherwise>
						</c:choose>
						</td>
					</tr>
					</c:forEach>
					</tbody>
				</table>
			</form>
		
			<div style="width: 100%;margin-top: 10px;" align="center" >
				<input class="search" type="button" value="保&#12288;存" onclick="save()"  />
				<input class="search" type="button" value="删&#12288;除" onclick="del()"  />
				<input class="search" type="button" value="关&#12288;闭" onclick="jboxClose();" />
			</div>
		</div>
	</div>
</div>
</body>
</html>