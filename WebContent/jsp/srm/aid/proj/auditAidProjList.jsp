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
		var id = $(".selectTag").children().attr("id");
		var currentPage = $("#currentPage").val();
		var url ="<s:url value="/srm/aid/proj/loadAidProjList/${sessionScope.projListScope}"/>?isCountry=${isCountry}&projSubCategoryId=" + id + "&currentPage=" + currentPage;
		jboxPostLoad("contentDiv", url, $("#searchForm").serialize(), true);
	}
	
	function toPage(page) {
		if(page!=undefined){
			$("#currentPage").val(page);			
		}
		var id = $(".selectTag").children().attr("id");
		loadList(id);
	}
	
	function addProj(){
	  var url="<s:url value='/srm/aid/proj/edit?isCountry=${isCountry}'/>";
	  window.location=url;
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
	//加载申请单位
	function loadApplyOrg(){
		//清空
		var org = $('#org');
		org.html('<option value="">请选择</option>');
		var chargeOrgFlow = $('#chargeOrg').val();
		if(!chargeOrgFlow){
			return ;
		}
		var url = "<s:url value='/sys/org/loadApplyOrg'/>?orgFlow="+chargeOrgFlow;
		jboxStartLoading();
		jboxGet(url , null , function(data){
			$.each(data , function(i , n){
				org.append('<option value="'+n.orgFlow+'">'+n.orgName+'</option>');
			});
		} , null , false);
	}
	
	//************加载列表*********
	function loadList(id){
		var currentPage = $("#currentPage").val();
		var url ="<s:url value="/srm/aid/proj/loadAidProjList/${sessionScope.projListScope}"/>?isCountry=${isCountry}&projSubCategoryId=" + id + "&currentPage=" + currentPage;
		selectTag(url, id);
	}
	
	function selectTag(url, id) {
	    // 操作标签
	    var tag = document.getElementById("tags").getElementsByTagName("li");
	    var taglength = tag.length;
	    for (i = 0; i < taglength; i++) {
	        tag[i].className = "ui-bluetag";
	    }
	    document.getElementById(id).parentNode.className = "selectTag";
	    // 操作内容
	    jboxLoad("contentDiv", url, true);
	}
	
	$(document).ready(function(){
		var id = $(".selectTag").children().attr("id");
		if(id == null || id == ""){
			$("#contentDiv").html("<span style='font-size: 14px;'>无记录</span>");
			return false;
		}
		loadList(id);
	});
	
	function audit(projFlow){
		jboxConfirm("确认审核通过?" ,  function(){
			jboxStartLoading();
			var url = "<s:url value='/srm/aid/proj/auditAidProj?projFlow='/>" + projFlow;
			jboxPost(url , null , function(resp){
				var id = $(".selectTag").children().attr("id");
				loadList(id);
				jboxClose();
			} , null , true);
		});
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<form id="searchForm" method="post">
			<div class="title1 clearfix">
					立项年度：<input type="text" class="xltext" name="projYear" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy'})" value="${param.projYear }"/>
					项目编号：<input type="text" name="projNo" value="${param.projNo}" class="xltext" />
				<c:if test='${sessionScope.projListScope eq GlobalConstant.PROJ_STATUS_SCOPE_GLOBAL}'>
				        主管部门：
            		<select id="chargeOrg" name="chargeOrgFlow" onchange="loadApplyOrg();" class="xlselect">
            			<option value="">请选择</option>
            			<c:forEach var="chargeOrg" items="${childrenOrgList}">
            				<option value="${chargeOrg.orgFlow}" <c:if test="${param.chargeOrgFlow==chargeOrg.orgFlow}">selected</c:if>>${chargeOrg.orgName}</option>
            			</c:forEach>
            		</select>
            		申报单位：
            		<select id="org" name="orgFlow" class="xlselect">
            			<option value="">请选择</option>
            			<c:forEach var="org" items="${orgList}">
            				<option value="${org.orgFlow}" <c:if test="${param.orgFlow==org.orgFlow}">selected</c:if>>${org.orgName}</option>
            			</c:forEach>
            		</select>
				</c:if>
				
		    	<c:if test='${sessionScope.projListScope eq GlobalConstant.PROJ_STATUS_SCOPE_CHARGE}'>
	           		申报单位：
	           		<select name="orgFlow" class="xlselect">
	           			<option value="">请选择</option>
	           			<c:forEach var="org" items="${childrenOrgList}">
	           				<option  value="${org.orgFlow}" <c:if test="${param.orgFlow==org.orgFlow}">selected</c:if>>${org.orgName}</option>
	           			</c:forEach>
	           		</select>
           	   </c:if>
           	   <p>
					项目名称：<input type="text" name="projName" value="${param.projName}" class="xltext" style="width: 417px" />
					<input id="currentPage" type="hidden" name="currentPage" value=""/>
					<input type="button" class="search" onclick="searchProj();" value="查&#12288;询">
			   </p>
			</div>
		
			<ul id="tags" style="padding-top: 10px;">
				<c:forEach items="${dictTypeEnumAidProjTypeList}" var="aidProjType" varStatus="status">
					<li <c:if test="${status.first}">class="selectTag"</c:if>>
						<a onclick="loadList('${aidProjType.dictId}');" href="javascript:void(0)" id="${aidProjType.dictId}">${aidProjType.dictName}</a>
					</li>
				</c:forEach>
		    </ul>
		    
		    <div id="tagContent" class="divContent" align="center">
				<div id="contentDiv" style="border:none;">
					<!-- 加载列表 -->
				</div>
			</div>
		</form>
		
	</div>
</div>
</body>
</html>