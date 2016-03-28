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
var height=(window.screen.height)*0.7;
var width=(window.screen.width)*0.7;
function search() {
	jboxStartLoading();
	$("#searchForm").submit();
}

function view(reseachrepFlow){
	jboxStartLoading();
	jboxOpen("<s:url value='/srm/ach/reseachrep/edit?reseachrepFlow="+reseachrepFlow+"&editFlag=${GlobalConstant.FLAG_N}'/>", "查看研究报告信息",width, height);
}

function audit(thesisFlow){
	jboxStartLoading();
	jboxOpen("<s:url value='/srm/ach/thesis/audit?thesisFlow='/>"+thesisFlow, "审核", 700, 400);
}

function loadApplyOrg(){
	//清空
	var org = $('#org');
	org.html('<option value="">请选择</option>');
	var chargeOrgFlow = $('#chargeOrg').val();
	if(!chargeOrgFlow){
		return ;
	}
	url="<s:url value='/sys/org/loadApplyOrg'/>?orgFlow="+chargeOrgFlow
	jboxGet(url,null,function(resp){
		$.each(resp , function(i , n){
			org.append('<option value="'+n.orgFlow+'">'+n.orgName+'</option>');
		});
	},null,false);			
}

function toPage(page){
	var form = $("#searchForm");
	$("#currentPage").val(page);
	jboxStartLoading();
	form.submit();
}
</script>
</head>
<body>

 <div class="mainright">
    <div class="content">
      <div class="title1 clearfix">
	  <form id="searchForm" action="<s:url value="/srm/ach/reseachrep/auditList/charge"/>" method="post">
		 <p>
	 		&#12288;报告题目：
	 		<input type="text" name="repTitle" value="${param.repTitle}" class="xltext"/>
	 		&#12288;提交时间：
	 		<input class="xltext ctime" style="width: 157px;" type="text" name="submitDate" value="${param.submitDate}"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  readonly="readonly"/>
	 		&#12288;项目来源：
	 	  	<select name="projSourceId" class="xlselect">
              	<option value="">请选择</option>
               	<c:forEach items="${dictTypeEnumProjSourceList }" var="dict">
				<option value="${dict.dictId }" <c:if test="${dict.dictId==param.projSourceId}">selected="selected"</c:if> >${dict.dictName }</option>
            	</c:forEach>
            </select>
        </p>
		<p>
           	&#12288;申报单位：
            <select id="org" name="orgFlow" class="xlselect">
    			<option value="">请选择</option>
    			<c:forEach var="org" items="${firstGradeOrgList}">
    			<option value="${org.orgFlow}" <c:if test="${org.orgFlow==param.orgFlow}">selected="selected"</c:if> >${org.orgName}</option>
    			</c:forEach>
            </select>
         	&#12288;
			<input type="button" class="search" onclick="search();" value="查询">
		</p>
	</form>
	</div>
	
	<table class="xllist">
	  	<thead>
	         <tr>
	           	<th>报告题目</th>
	            <th>所属单位</th>
	            <th>采纳对象</th>
	            <th>所属作者</th>
	            <th>提交时间</th>
	            <th>项目来源</th>
	            <th>操作</th>
	         </tr>
	     </thead>
		 <c:forEach items="${reseachreps}" var="rep">
		 <tr>
		  	<td>${rep.repTitle}</td>
		  	<td>${rep.belongOrgName}</td>
		  	<td>${rep.acceptObjectName}</td>
		  	<td>
			     <c:forEach items="${allAuthorMap}" var="entry">
				     <c:if test="${entry.key==rep.reseachrepFlow}">
				     	<c:forEach items="${entry.value}" var="author">
				    	 ${author.authorName}&nbsp;
				    	</c:forEach>
				     </c:if>
			     </c:forEach>
	      	</td>
		  	<td>${rep.submitDate}</td>
	 	 	<td>${rep.projSourceName}</td>
		  	<td>
		   		<a href="javascript:void(0)" onclick="view('${rep.reseachrepFlow}');">[查看]</a> 
		  	</td>
		</tr>
	    </c:forEach>
	</table>
 	<%-- <p>
		<input type="hidden" id="currentPage" name="currentPage">
	    <c:set var="pageView" value="${pdfn:getPageView2(reseachreps, 10)}" scope="request"></c:set>
		<pd:pagination toPage="toPage"/>
	</p> --%>
    </div>
 </div> 	
</body>
</html>