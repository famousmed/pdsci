<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
</jsp:include>
<script type="text/javascript">
	function searchProj() {
		jboxStartLoading();
		$("#searchForm").submit();
	}
	
	function toPage(page) {
		if(page!=undefined){
			$("#currentPage").val(page);			
		}
		searchProj();
	}
	
	function addProj(){
		var url = "<s:url value='/srm/aid/proj/addAidProj'/>";
	  	jboxOpen(url, "添加备案项目" , 300 , 200 , true);
	}
	
	function delAidProj(projFlow) {
		url="<s:url value='/srm/aid/proj/delete?projFlow='/>" + projFlow;
		jboxConfirm("确认删除？", function() {
			jboxStartLoading();
			jboxGet(url , null , function(){
				window.parent.frames['mainIframe'].location.reload(true);
			} , null , true);
			
		});
	}

	function add(typeId){
        var url="<s:url value='/srm/aid/proj/add?typeId='/>"+typeId;
        window.parent.frames['mainIframe'].location=url;
        jboxClose();
    }
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
		<c:set var="aidProjTypeListSize" value="${dictTypeEnumAidProjTypeList.size()}"/>
			<form id="searchForm" action="<s:url value="/srm/aid/proj/list"/>"
				method="post">
				<p>
					立项年度：
					<input type="text" class="xltext ctime" name="projYear" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy'})" value="${param.projYear }"/>
					项目编号： <input type="text" name="projNo" value="${param.projNo}" class="xltext" />
				</p>
				<p>
					项目名称：
					<input type="text" name="projName" value="${param.projName}" class="xltext" style="width: 420px" />
					<input id="currentPage" type="hidden" name="currentPage" value=""/>
					<input type="button" class="search" onclick="searchProj();" value="查&#12288;询">
					<c:choose>
						<c:when test="${aidProjTypeListSize == 1}">
							<input type="button" class="search" onclick="add('${dictTypeEnumAidProjTypeList[0].dictId}');" value="添&#12288;加">  
						</c:when>
						<c:when test="${aidProjTypeListSize != 1}">
							<input type="button" class="search" onclick="addProj();" value="添&#12288;加">  
						</c:when>
					</c:choose>
				</p>
			</form>
		</div>
		<table class="xllist">
			<thead>
				<tr>
					<th width="5%">年份</th>
					<th width="15%">项目编号</th>
					<th width="20%">项目名称</th>
					<th width="10%">项目分类</th>
					<th width="20%">项目类型</th>
					<th width="17%">起止时间</th>
					<th width="13%">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${aidProjList}" var="aidProj">
					<tr>
						<td><span>${aidProj.projYear }</span></td>
						<td>${aidProj.projNo }</td>
						<td>${aidProj.projName}</td>
						<td>${aidProj.projCategoryName}</td>
						<td>${aidProj.projTypeName }</td>
						<td>&#12288;${aidProj.projStartTime}~${aidProj.projEndTime}</td>
						<td>
							<a href="<s:url value='/srm/aid/proj/view?projFlow=${aidProj.projFlow}&typeId=${aidProj.projSubCategoryId}'/>">[查看]</a>
							<c:if test="${aidProjStatusEnumPass.id != aidProj.statusId}">
								<a href="<s:url value='/srm/aid/proj/edit?projFlow=${aidProj.projFlow}&typeId=${aidProj.projSubCategoryId}'/>">[编辑]</a>
							  	<a href="javascript:void(0)" onclick="delAidProj('${aidProj.projFlow}');">[删除]</a> 
					  		</c:if>
						</td>
					</tr>
				</c:forEach>
				
			<c:if test="${empty aidProjList}">
				<tr>
					<td colspan="10">无记录</td>
				</tr>
			</c:if>
			</tbody>
		</table>
		<c:set var="pageView" value="${pdfn:getPageView(aidProjList)}" scope="request"></c:set>
			<pd:pagination toPage="toPage"/>	
	</div>
</div>
<div id="chooseAidProjType" style="display: none;">
	<p style="text-align: center;margin-top: 40px;">
		<c:if test="${aidProjTypeListSize > 1}">
		   	类型：<select id="aidProjTypeId" class="xlselect">
		        <option value=''>请选择</option>
		        <c:forEach items="${dictTypeEnumAidProjTypeList}" var="aidProjType">
		            <option value='${aidProjType.dictId}'>${aidProjType.dictName}</option>
		        </c:forEach>
		    </select><br/>
		    <input type="button" onclick="doAddProj();" class="search" value="确&#12288;定" style="margin-top: 20px;"/>	
		</c:if>
		<c:if test="${aidProjTypeListSize == 0}">
			无备案项目类型！
		</c:if>
    </p>
</div>
</body>
</html>