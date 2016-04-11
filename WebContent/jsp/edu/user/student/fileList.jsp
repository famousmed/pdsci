<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/jsp/edu/htmlhead-edu.jsp">
	<jsp:param name="jquery_form" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
</jsp:include>

<script type="text/javascript">

function searchFile(){
	var url ="<s:url value='/edu/user/studentCourseFile?courseFlow=${param.courseFlow}'/>";
	jboxPostLoad("content3",url,$("#searchForm").serialize(),false);
}

</script>

<div class="DySearch clearfix">
	<div class="fl DySeleft">
		<form id="searchForm" action="<s:url value='/edu/user/studentCourseFile?courseFlow=${courseFlow}'/>" method="post">
			<input class="Inp fl" placeholder="请输入关键字"
				<c:if test="${empty param.fileName}">value=""</c:if>
				<c:if test="${not empty param.fileName}">value="${param.fileName}"</c:if>
				id="searchName" name="fileName" onfocus="this.value=''" onblur="if(this.value==''){this.placeholder='请输入关键字'}" type="text">
			<input  class="sub fr" value=" " type="button" onclick="searchFile();">
		</form>
	</div>
</div>

<c:if test="${empty courseFileList}">
			<div class="nomessage" style="text-align: center;"> 
				<img src="${ctxPath }/jsp/edu/css/images/tanhao.png"/>           
				<p>暂无课程资料！</p>
			</div>
</c:if>

<c:if test="${not empty courseFileList}">
<a class="trTop_left" href="">全部文件</a>
<div class="ZYCon">
<table class="zlTable" id="zlTable" width="100%" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<th class="fileName">文件名</th>
			<th width="70">上传者</th>
			<th align="center" width="95">创建日期</th>
			<th align="center" width="100">操作</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${courseFileList}" var="courseFile">
			<tr>
				<td class="fileInfo">
					<c:set var="suffix" value="${pdfn:split(courseFile.fileName,'.')[1] }"/>
					<c:choose>
						<c:when test="${(suffix eq 'doc') or (suffix eq 'docx')}">
							<img src="<s:url value='/jsp/edu/css/images/wicon.png'/>" width="30" height="27" />
						</c:when>
						<c:when test="${suffix eq 'xls'}">
							<img src="<s:url value='/jsp/edu/css/images/sicon.png'/>" width="30" height="27" />
						</c:when>
						<c:when test="${suffix eq 'ppt' or suffix eq 'pptx'}">
							<img src="<s:url value='/jsp/edu/css/images/picon.png'/>" width="30" height="27" />
						</c:when>
						<c:otherwise>
							<img src="<s:url value='/jsp/edu/css/images/folder.png'/>" width="30" height="27" />
						</c:otherwise>
					</c:choose>
					${courseFile.fileName}
				</td>
				<td>${courseFile.userName}</td>
				<td>${pdfn:transDate(courseFile.createTime)}</td>
				<td>
				<a href="${sysCfgMap['upload_base_url']}${courseFile.fileDir}" title="下载"><img src="<s:url value='/jsp/edu/css/images/download.png'/>" width="14" height="14" /></a>
				<c:if test="${courseFile.userFlow eq sessionScope.currUser.userFlow}">
				<%-- <a href="#"><img src="<s:url value='/jsp/edu/css/images/seticon.png'/>" width="14" height="14" /></a> --%>
				<a href="javascript:void(0);" onclick="delCourseFile('${courseFile.recordFlow}');" title="删除"><img src="<s:url value='/jsp/edu/css/images/delicon.png'/>" width="14" height="14" /></a>
				</c:if>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
</div>
</c:if>