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
	<jsp:param name="jquery_ui_sortable" value="true"/>
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
	<c:choose>
		<c:when test="${param.regulationCategoryId eq regulationCategoryEnumCountry.id}">
			<c:set var="dictTypeEnumList" value="${dictTypeEnumRegulationCountryList}"/>
		</c:when>
		<c:when test="${param.regulationCategoryId eq regulationCategoryEnumLocal.id}">
			<c:set var="dictTypeEnumList" value="${dictTypeEnumRegulationLocalList}"/>
		</c:when>
		<c:when test="${param.regulationCategoryId eq regulationCategoryEnumOrg.id}">
			<c:set var="dictTypeEnumList" value="${dictTypeEnumRegulationOrgList}"/>
		</c:when>
		<c:when test="${param.regulationCategoryId eq regulationCategoryEnumDept.id}">
			<c:set var="dictTypeEnumList" value="${dictTypeEnumRegulationDeptList}"/>
		</c:when>
	</c:choose>
	
	$(function() {
		<c:forEach items="${dictTypeEnumList}" var="dictType">
		<c:if test="${param.regulationTypeFlag eq dictType.dictId}">
			slideDown('${param.regulationTypeFlag}');
		</c:if>
		</c:forEach>
	});

	function reload(){
		window.location.reload();
	}
		
	function addFile(regulationTypeId){
		var url = "<s:url value ='/gcp/workFile/addRegulationFile'/>?regulationCategoryId=${param.regulationCategoryId}&regulationTypeId=" + regulationTypeId +"&deptFlow=${param.deptFlow}";
		jboxOpen(url,"新增法规文件",450,300);
	}
	
	function showDetail(dictType){
		$("#"+dictType+"_div").slideToggle("slow");
	}
	
	function slideDown(dictType){
		$("#"+dictType+"_div").slideDown("slow");
	}
	
	function delFile(regulationFlow, fileFlow, regulationTypeId){
		jboxConfirm("确认删除？", function(){
			var url = "<s:url value ='/gcp/workFile/delRegulationFile'/>?regulationFlow=" +regulationFlow +"&fileFlow=" +fileFlow;
			jboxGet(url , null , 
					function(resp){
						if(resp=='${GlobalConstant.DELETE_SUCCESSED}'){
							var url = "<s:url value='/gcp/workFile/regulationFiles?regulationCategoryId=${param.regulationCategoryId}'/>&regulationTypeFlag="+regulationTypeId;
							window.parent.frames['mainIframe'].window.location.href = url;
						}
					},
					null , true);
		});
	}
	
	function search(){
		var regulationYear = $("input[name=regulationYear]").val();
		var regulationCode = $("input[name=regulationCode]").val();
		var regulationName = $("input[name=regulationName]").val();
		if($.trim(regulationYear) =="" && $.trim(regulationCode) == "" && $.trim(regulationName)==""){
			jboxTip("请输入查询条件！");
			return false;
		}
		$("#searchForm").submit();
	}
	
	
	//***************************************************************
	var fixHelper = function(e, ui) {
	     ui.children().each(function() {
	    	//在拖动时，拖动行的cell（单元格）宽度会发生改变。在这里做了处理就没问题了  
	         $(this).width($(this).width());
	     });
	     return ui;
	};
	
	$(function() {

   	var oldPostData = "";
   	<c:forEach items="${dictTypeEnumList}" var="dictType">
	    $( "#sortable_${dictType.dictId}" ).sortable({
	    	helper: fixHelper,  
	    	create: function(e, ui){
	    		var oldSortedIds = $( "#sortable_${dictType.dictId}" ).sortable( "toArray" );
	    		$.each(oldSortedIds,function(i,sortedId){
	    			oldPostData = oldPostData+"&regulationFlow="+sortedId;
	    		});
	    	},
	    	start:function(e, ui){
	    	     //拖动时的行，要用ui.helper
	    	    ui.helper.css({"background":"#eee"});
	    	    return ui; 
	    	}, 
	    	stop: function( event, ui ) {
	    		ui.item.css({"background":"#fff"});
	    		var sortedIds = $( "#sortable_${dictType.dictId}" ).sortable( "toArray" );
	    		var postdata = "";
	    		$.each(sortedIds,function(i,sortedId){
	    			postdata = postdata+"&regulationFlow="+sortedId;
	    		});
	    		if(oldPostData==postdata){
	    			return;
	    		}
	    		var url = "<s:url value='/gcp/workFile/saveOrder'/>";
	    		jboxPost(url, postdata, function() {
	    			/* var url = "<s:url value='/gcp/workFile/regulationFiles?regulationCategoryId=${param.regulationCategoryId}&regulationTypeId=${dictType.dictId}&searchFlag=${GlobalConstant.FLAG_Y}'/>";
					window.parent.frames['mainIframe'].window.location.href = url; */
	    			},null,false);
	    		oldPostData = postdata;
	    	}
	    });
	    </c:forEach>
	    $( "#sortable_${dictType.dictId}" ).disableSelection();
	});

	//展开有记录的DIV,其余隐藏
	$(function() {	
		<c:if test="${not empty param.searchFlag}">
			$(".cont_div").each(function(){
				var trSize = $(this).children().children().children().next().children().size();
				if(trSize > 0){
					$(this).slideDown("slow");
				}else{
					$(this).prev().css("display","none");
				}
			});
		</c:if>
	});
</script>

</head>
<body>
<div class="mainright">
	<div class="content">
		<form id="searchForm" action="<s:url value ='/gcp/workFile/regulationFiles?searchFlag=${GlobalConstant.FLAG_Y}'/>" method="post">
		<p style="margin:5px 0px;">
			<%-- 按拼音检索： <input type="text" class="xltext" name="py" value="${param.py}" style="width: 100px;"/>  --%> 
			按年份检索：<input type="text" name="regulationYear" value="${param.regulationYear}" class="xltext" style="width: 100px;"/>    
			文件编码：<input type="text" name="regulationCode" value="${param.regulationCode}" class="xltext" style="width: 100px;"/> 
			文件名称： <input type="text" name="regulationName" value="${param.regulationName}" class="xltext"/> 
			<input type="hidden" name="regulationCategoryId" value="${param.regulationCategoryId}"/> 
			<input type="hidden" name="deptFlow" value="${param.deptFlow}"/> 
			<input type="button" class="search" onclick="search();" value="查&#12288;询">
		</p>
		</form>
		
		<c:if test="${empty dictTypeEnumList}">
			<div class="cont_list" style="margin-top: 10px;">
				<div class="left" style="text-align: center;">无记录！</div>
			</div>
		</c:if>
		<c:if test="${empty regulationFileList and param.searchFlag eq GlobalConstant.FLAG_Y}">
			<div class="cont_list" style="margin-top: 10px;">
				<div class="left" style="text-align: center;">无记录！</div>
			</div>
		</c:if>
		
		<c:forEach items="${dictTypeEnumList}" var="dictType">
		
		<div class="cont_list" style="margin-top: 10px;">
			<div class="left" onclick="showDetail('${dictType.dictId}')">
				<span class="name">${dictType.dictName}</span>
			</div>
			<div class="right">
				<a href="javascript:void(0)"  onclick="addFile('${dictType.dictId}')"><img alt="新增" title="新增" src="<s:url value='/css/skin/Blue/images/add5.png'/>"></a>
			</div>
		</div>
			
		<div id="${dictType.dictId}_div" class="cont_div" style="display: none;">
			<div class="i-trend" style="padding-top: 0px;">
			<c:if test="${not empty regulationMap[dictType.dictId]}">
			<table class="i-trend-table i-trend-main-table i-trend-main-div-table" style="width: 100%; border-top: none;">
				<thead>
				<tr>
					<td><b>排序码</b></td>
					<td><b>文件编码</b></td>
					<td><b>文件名称</b></td>
					<td><b>文件年份</b></td>
					<td><b>操作</b></td>
				</tr>
				</thead>
				<tbody id="sortable_${dictType.dictId}">
					<c:forEach items="${regulationMap[dictType.dictId]}" var="regulation" varStatus="status">
					<tr id="${regulation.regulationFlow}" style="cursor: pointer;">
						<td width="10%">${regulation.ordinal}</td>
						<td width="20%">${regulation.regulationCode}</td>
						<td width="40%" class="regulationNameTD" style="text-align: left;">
							<a href='<s:url value="/pub/file/down?fileFlow=${regulation.fileFlow}"/>'>
							<span style="color:blue;">${regulation.regulationName}</span>
							</a>
						</td>
						<td width="20%">${regulation.regulationYear}</td>
						<td width="10%">
							<a onclick="delFile('${regulation.regulationFlow}','${regulation.fileFlow}','${dictType.dictId}')"><img alt="删除" title="删除" src="<s:url value="/css/skin/Blue/images/del2.png"/>"></a>
						</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			</c:if>
			<c:if test="${empty regulationMap[dictType.dictId]}">
				<table class="i-trend-table i-trend-main-table i-trend-main-div-table" style="width: 100%; border-top: none;">
					<tr><td>无记录！</td></tr>
				</table>
			</c:if>
			</div>
		</div>
		</c:forEach>
		
	</div>
</div>
</body>
</html>