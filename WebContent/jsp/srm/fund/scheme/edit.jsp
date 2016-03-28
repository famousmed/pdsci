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
  function save(){
	  if($("#newScheme").validationEngine("validate")){
		  var url = "<s:url value='/srm/fund/scheme/saveScheme'/>";
		  jboxStartLoading();
	      jboxPost(url , $('#newScheme').serialize() , function(){
		  $("#schemeForm",window.parent.frames['mainIframe'].document).submit(); jboxClose(); } , null , true);
	  }
  }
 
</script>
</head>
<body>
    <div class="mainright">
        <div class="content">
        <div class="title1 clearfix">
            <form id="newScheme" action="<s:url value="/srm/fund/scheme/saveScheme"/>" method="post">      
                <table class="xllist">
                    <tr>
                        <th>预算方案名称：</th>
                        <td><input type="text" name="schemeName" style="width: 90%;" class="validate[required]"></td>
                    </tr>
                    <tr>
                        <th>项目类型：</th>
                        <td>
                            <select name="projTypeId" style="width: 90%;" class="validate[required]">
                                <option value="">请选择</option>
                                    <c:forEach items="${existProjTypeIds}" var="dict">
                                        <option value="${dict.dictId }">${dict.dictName }</option>
                                    </c:forEach>
                            </select>
                        </td>
                    </tr>
                </table>
            </form>
            </div>
            <div class="button" style="width: 400px;">
                <input type="button" class="search" onclick="save();" value="保存"/>
                <input type="button" onclick="jboxClose();" class="search" value="关闭"/>
            </div>
       </div>
   </div>
</body>