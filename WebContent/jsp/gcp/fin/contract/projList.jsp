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
	$(function(){
		if('${param.projFlow}'!=''){
			showDetail('${param.projFlow}');
		}
		if('${projFlow}'!=''){
			showDetail('${projFlow}');
		}
	});
	function add(projFlow){
		var url = "<s:url value ='/gcp/fin/editContract'/>?projFlow="+projFlow;
		jboxOpen(url,"新增合同",800,380);
	}
	function showDetail(projFlow){
		var divId = "div_"+projFlow;
		var contentId = "content_"+projFlow;
		var div = $("#"+divId);
		var content = $("#"+contentId);
		var url = "<s:url value ='/gcp/fin/contList'/>?projFlow="+projFlow+"&contractNo=${param.contractNo}&mainView=${param.mainView}";
		if($.trim(content.html())==""){
			jboxLoad(contentId,url,false);
		}
		div.slideToggle("slow");
	}
	function editContract(contractFlow,projFlow){
		var url = "<s:url value ='/gcp/fin/editContract'/>?contractFlow="+contractFlow+"&projFlow="+projFlow;
		jboxOpen(url,"修改合同",800,380);
	}
	function reload(){
		window.location.reload();
	}
	function delContract(contractFlow,projFlow){
		jboxConfirm("确认删除该合同？",function(){
			var url = "<s:url value='/gcp/fin/delContract'/>?contractFlow="+contractFlow;
			jboxPost(url,null,function(resp){
				if(resp=='${GlobalConstant.DELETE_SUCCESSED}'){
					var url = "<s:url value='/gcp/fin/projList'/>?projFlow="+projFlow;
					window.location.href=url;
				}
			},null,true);
		},null);
	}
	function search(){
		$("#searchForm").submit();
	}
</script>
</head>
<body>
	<div class="mainright">
		<div class="content" style="padding-top: 10px;">
		 <div style="margin-bottom: 10px;">
		 <form id="searchForm" action="<s:url value='/gcp/fin/projList'/>" method="post">
		     <input type="hidden" id="projFlow" name="projFlow" value="${param.projFlow }"/>
		    <dl>   
		      <dt style="float: left;margin-left: 10px;">项目名称：</dt>
		      <dt style="float: left;margin-left: 5px;"><input type="text" name="projName" value="${param.projName }" class="xltext"/></dt>
		      <dt style="float: left;margin-left: 10px;">合同编号：</dt>
		      <dt style="float: left;margin-left: 5px;"><input type="text" name="contractNo" value="${param.contractNo }" class="xltext" style="width:100px;"/></dt>
		      <dt style="float: left;margin-left: 10px;">专业组：</dt>
		      <dt style="float: left;margin-left: 5px;">
		        <select name="applyDeptFlow" class="xlselect">
		           <option value="">请选择</option>
		           <c:forEach items="${deptList}" var="dept">
		             <option value="${dept.deptFlow }" <c:if test="${dept.deptFlow eq param.applyDeptFlow}">selected="selected"</c:if>>${dept.deptName}</option>
		           </c:forEach>
		        </select>
		      </dt>
		      <dt>
		         <input type="button" onclick="search();" value="查&#12288;询" class="search">
		      </dt>
		    </dl>
		    </form>
		   </div>
		<c:forEach items="${projList }" var="proj" varStatus="status">
			<div class="cont_list" >
				<div class="left" onclick="showDetail('${proj.projFlow}')">项目名称：<span class="name">${proj.projShortName}</span>合同总经费：<span class="zje"><c:out value="${countMap[proj.projFlow]['fundTotal'] }" default="0"/></span>合同总例数：<span class="zls"><c:out value="${countMap[proj.projFlow]['caseTotal'] }" default="0"/></span></div>
				<c:if test="${param.mainView!=GlobalConstant.FLAG_Y }">
				<div class="right"><a href="javascript:void(0)"  onclick="add('${proj.projFlow}')" title="点击添加合同"><img alt="新增合同" src="<s:url value='/css/skin/Blue/images/add5.png'/>"></a></div>
				</c:if>
			</div>
			<div id="div_${proj.projFlow }" style="display: none;">
				 <div class="i-trend" style="padding-top: 0px;">
			      <table class="i-trend-table" style="border-top: none;border-bottom: none;" border="0" cellpadding="0" cellspacing="0">
			      <tbody>
			        <tr>
			          <td>
			             <div class="selectTag" id="content_${proj.projFlow }">
			             </div>
			          </td>
			        </tr>
			      </tbody>
			      </table>
 				 </div>
			</div>
			<div class="cont_spe"></div>
		</c:forEach>
		<c:if test="${empty projList }">
		  <div class="cont_list" align="center">
		  	<div class="left" >无记录！</div>
		  </div>
		</c:if>
		</div> 
	</div>
</body>
</html>