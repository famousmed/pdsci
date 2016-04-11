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
   function search(){
	 jboxStartLoading();
	$("#budgetList").submit();
   }
   function save(budgetFlow,obj){
	   
   }
 
   function edit(projFlow){
	    var w = $('#mainright').width();
		var url ='<s:url value="/srm/fund/scheme/applyEdit?projFlow="/>'+projFlow;
		var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='330px' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
		jboxMessager(iframe,'预算项设置',w,400);
   }
   function view(projFlow){
	    var w = $('#mainright').width();
		var url ='<s:url value="/srm/fund/scheme/applyEdit?projFlow="/>'+projFlow+"&look=look";
		var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='330px' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
		jboxMessager(iframe,'预算项查看',w,400);
  }

</script>
</head>
<body>
  <div class="mainright" id="mainright">
   <div class="content">
       <form id="budgetList" action="<s:url value="/srm/fund/scheme/applyList"/>" method="post">
       <div class="title1 clearfix">
	    <p>
		    项目名称：
		    <input type="text" name="projName" class="xltext" value="${param.projName}">
	 		&nbsp;项目类型：
			<select name="projTypeId"  class="xlselect">
               <option value="">请选择</option>
                <c:forEach items="${dictTypeEnumProjTypeList }" var="dict">
                	<option value="${dict.dictId }" <c:if test="${dict.dictId==param.projTypeId}">selected="selected"</c:if> >${dict.dictName }</option>
                </c:forEach>
               </select>
            <%--  &nbsp;审核状态：
			<select name="budgetStatusId"  class="xlselect" style="width:100px;">
               <option value="">请选择</option>
               <option value="${achStatusEnumSubmit.id}" <c:if test="${achStatusEnumSubmit.id==param.budgetStatusId}">selected="selected"</c:if> >${achStatusEnumSubmit.name }</option>
               <option value="${achStatusEnumFirstAudit.id}" <c:if test="${achStatusEnumFirstAudit.id==param.budgetStatusId}">selected="selected"</c:if> >${achStatusEnumFirstAudit.name }</option>
               <option value="${achStatusEnumRollBack.id}" <c:if test="${achStatusEnumRollBack.id==param.budgetStatusId}">selected="selected"</c:if> >${achStatusEnumRollBack.name }</option>
               </select> --%>
             <input type="button" class="search" onclick="search();" value="查询">
         </p>
         </div>
         
  <table class="xllist" id="mubiao">
   <!--  <tr>
       <th colspan="7" class="bs_name">项目列表</th>
    </tr> -->
   <thead>
    <tr>
       <th>项目名称</th>
       <th style="width:150px;">项目编号</th>
       <th style="width:150px;">项目类型</th>
       <th style="width:100px;">开始时间</th>
       <th style="width:100px;">结束时间</th>
       <th style="width:70px;">预算总金额(万元)</th>
       <th style="width:100px;">审核状态</th>
       <th style="width:100px;">操作</th>
    </tr>
    </thead>
    <c:forEach var="proj" items="${projList }"> 
    <tr>
       <td>${proj.projName}</td>
       <td>${proj.projNo}</td> 
       <td>${proj.projTypeName}</td>     
       <td>${proj.projStartTime}</td>     
       <td>${proj.projEndTime}</td>
       <td>
          ${fundMap[proj.projFlow].budgetAmount}
       </td>
       <td>
          ${fundMap[proj.projFlow].budgetStatusName }
       </td>
       <td>
       <c:if test='${empty fundMap[proj.projFlow].budgetStatusId or fundMap[proj.projFlow].budgetStatusId eq achStatusEnumRollBack.id}'>
       		<a href="javascript:void(0)" onclick="edit('${proj.projFlow}');" >编辑&nbsp;|</a>
       </c:if>
	   		<a href="javascript:void(0);" onclick="view('${proj.projFlow}');">查看</a>
       </td>         
    </tr>
    </c:forEach>
   
   </table>
  
  </form>
   
   </div>
   </div>
</body>