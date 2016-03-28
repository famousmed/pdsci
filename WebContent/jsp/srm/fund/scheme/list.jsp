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
   function save(budgetFlow,obj){
	   
   }
   function search(){
	   jboxStartLoading();
	   $('#schemeForm').submit();
   }
   
   function cancel(){
	   jboxStartLoading();
	   window.location.reload(true);
   }
   function edit(projTypeId,obj){
	    var tr = $(obj).parent("td").parent('tr');
		var tdBudgetName = tr.find('td').eq(0);
		var tdProjType = tr.find('td').eq(1);
		var BudgetNameValue=tdBudgetName.text();
		tdBudgetName.empty();
		tdProjType.empty();
		
		var input=$("<input>");   
	    input.attr("value",BudgetNameValue).attr("name" , "");  
	    tdBudgetName.append(input); 
	    
	    var select=$("<select>");
	    select.attr("name","projTypeId").attr("id","f1"); 
	    tdProjType.append(select);
	    <c:forEach var="dict" items='${dictTypeEnumProjTypeList}'>
	    var option=$("<option>");
	    option.attr("value",'${dict.dictId}');
	    option.text('${dict.dictName}');
	    $("#f1").append(option);
	    </c:forEach>
	    var options=$("#f1").children();
	    $.each(options , function(i , n){
	    	if($(n).val()==projTypeId){
	    		$(n).attr("selected","selected");
	    	}
	    });
	    $(obj).nextAll().hide();
	    $(obj).hide().prevAll().show();
   }
   function setBudgetItem(schemeFlow){
	    var w = $('#mainright').width();
		var url ='<s:url value="/srm/fund/scheme/itemList?schemeFlow="/>'+schemeFlow;
		var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='330px' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
		jboxMessager(iframe,'预算项设置',w,400);
   }
   function startScheme(schemeFlow){
	   var url = '<s:url value="/srm/fund/scheme/startScheme"/>?schemeFlow='+schemeFlow;
		jboxConfirm("确认启用？" , function(){
			jboxStartLoading();
			jboxGet(url , null , function(){
				window.parent.frames['mainIframe'].location.reload(true);
			}, null , true);
		});
   }
   function add(){
	   jboxStartLoading();
	   jboxOpen("<s:url value='/srm/fund/scheme/edit'/>", "添加预算方案", 500, 200);
   }
   function stopScheme(schemeFlow){
	   var url = '<s:url value="/srm/fund/scheme/stopScheme"/>?schemeFlow='+schemeFlow;
		jboxConfirm("确认停用？" , function(){
			jboxStartLoading();
			jboxGet(url , null , function(){
				window.parent.frames['mainIframe'].location.reload(true);
			}, null , true);
		});
   }
   function updateScheme(schemeFlow , obj) {
		var tr = $(obj).parent("td").parent('tr');
		var tdInput = tr.find('td').eq(0);
		var tdSelect = tr.find('td').eq(1);
		var schemeName=tdInput.find("input").val();
		var projTypeId = tdSelect.find('select[name="projTypeId"]').val();
		var scheme = {
				"schemeFlow":schemeFlow,
				"schemeName":schemeName,
				"projTypeId":projTypeId,
		};
		var url = '<s:url value="/srm/fund/scheme/updateScheme"/>';
		jboxStartLoading();
		jboxPost(url , scheme , function(){
			$("#schemeForm").submit();
		} , null , true);
		
	}
</script>
</head>
<body>
  <div class="mainright" id="mainright">
   <div class="content">
   <div class="title1 clearfix">
       <form id="schemeForm" action="<s:url value="/srm/fund/scheme/list"/>" method="post">
	    <p>
		 		方案名称
		 		<input type="text" name="schemeName"  class="xltext" value="${param.schemeName}"/>
		 		项目类型:
                <select name="projTypeId">
                <option value="">请选择</option>
                <c:forEach items="${dictTypeEnumProjTypeList }" var="dict">
                <option value="${dict.dictId}" <c:if test="${dict.dictId eq param.projTypeId}">selected="selected"</c:if> >${dict.dictName}</option>
                </c:forEach>
              </select>
              <input type="button" class="search" onclick="search();" value="查&nbsp;&nbsp;询">
              <input type="button" class="search" onclick="add();" value="添&nbsp;&nbsp;加">	   
         </p>
          </form>
          </div>
  <table class="xllist" id="mubiao">
    <tr style="height: 20px">
       <th>方案名称</th>
       <th>项目类型</th>
       <th>方案状态</th>
       <th width="200px">操作</th>
    </tr>
    <c:forEach var="scheme" items="${schemeList }">
    <tr>
       <td>${scheme.schemeName}</td> 
       <td id="${scheme.projTypeId }">${scheme.projTypeName}</td>     
       <td>
       <c:choose>
        <c:when test="${scheme.recordStatus eq 'Y'}">
                         启用
        </c:when>
        <c:otherwise>
                        停用
        </c:otherwise>
        </c:choose>
       </td>     
       <td>
       <a href="javascript:void(0)" onclick="updateScheme('${scheme.schemeFlow }',this);" style="display: none;">保存</a>
	   <a href="javascript:void(0)" onclick="cancel();" style="display: none;">取消</a> 
	   <a href="javascript:void(0)" onclick="edit('${scheme.projTypeId}',this);" >编辑</a>
	   <c:choose>
        <c:when test="${scheme.recordStatus eq 'Y'}">
        <a href="javascript:stopScheme('${scheme.schemeFlow }');" >停用</a>               
        </c:when>
        <c:otherwise>
         <a href="javascript:void(0)" onclick="startScheme('${scheme.schemeFlow }');" >启用</a>              
        </c:otherwise>
        </c:choose>
	   <a href="javascript:void(0);" onclick="setBudgetItem('${scheme.schemeFlow}')" >预算项设置</a>
       </td>         
    </tr>
    </c:forEach> 
  </table>
   </div>
   </div>
</body>