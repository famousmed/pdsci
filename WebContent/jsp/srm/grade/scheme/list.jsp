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
function add(){
	var url = "<s:url value='/srm/grade/scheme/edit'/>";
	jboxStartLoading();
	jboxOpen(url , "评分方案", 500, 200);
}
function editGradeScheme(schemeFlow , obj){
	var tr = $(obj).parent("td").parent('tr');
	var td = tr.find('td').eq(1);
	
	var tdText=td.text();
	td.empty();
	var input=$("<input>");   
    //将原来的值赋值给input文本框   
    input.attr("value",tdText).attr("name" , "schemeName");  
    //将文本框追加给单元格   
    td.append(input);   
    //文本框高亮选中   
    var inputdom=input.get(0);   
    inputdom.select(); 
    var td2 = tr.find('td').eq(2);
    tdText = td2.find("input[name='evaluationId']").val();
    td2.empty();
    var r1 = $('<input>' , {type:'radio',name:'evaluationId' , value:'${evaluationEnumApproveEvaluation.id}'});
    var r2 = $('<input>' , {type:'radio',name:'evaluationId' , value:'${evaluationEnumCompleteEvaluation.id}'});
    if(tdText==r1.val()){
    	r1.attr("checked" , true);
    }else if(tdText==r2.val()){
    	r2.attr("checked" , true);
    }
    td2.append(r1);
    td2.append("立项评审");
    td2.append(r2);
    td2.append("验收评审");
    $(obj).hide().prevAll().show();
    
}

function cancel(){
	jboxStartLoading();
	$("#searchGradeScheme",window.parent.frames['mainIframe'].document).submit();
}

function saveGradeScheme(schemeFlow , obj) {
	var tr = $(obj).parents("tr");
	var td = tr.find('td').eq(1);
	var td2 = tr.find('td').eq(2);
	var schemeName=td.find("input").val();
	var evaluationId = td2.find('input[name="evaluationId"]:checked').val();
	var gradeSchema = {
			"schemeFlow":schemeFlow,
			"schemeName":schemeName,
			"evaluationId":evaluationId
	};
	var url = '<s:url value="/srm/grade/scheme/saveGradeScheme"/>';
	jboxStartLoading();
	jboxPost(url , gradeSchema , function(){
		$("#searchGradeScheme",window.parent.frames['mainIframe'].document).submit();
	} , null , true);
	
}


function delGradeScheme(schemeFlow){
	var url = '<s:url value="/srm/grade/scheme/delete"/>?schemeFlow='+schemeFlow;
	jboxConfirm("确认删除？" , function(){
		jboxStartLoading();
		jboxGet(url , null , function(){
			$("#searchGradeScheme",window.parent.frames['mainIframe'].document).submit();
		} , null , true);
	});
	
}

function search(){
	jboxStartLoading();
	$("#searchGradeScheme").submit();	
}

function setGradeItem(schemaFlow){
	var w = $('#mainright').width();
	var url ='<s:url value="/srm/grade/item/list2?schemeFlow="/>'+schemaFlow;
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='330px' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,'评分项设置',w,400);

}
</script>
</head>
<body>
   <div class="mainright" id="mainright">
      <div class="content">
        <div class="title1 clearfix">
        	<form id="searchGradeScheme" action="<s:url value="/srm/grade/scheme/list"/>" method="post">
				&#12288;方案名称：	
				<input class="xltext" name="schemeName" type="text" value="${param.schemeName}"/>
				&#12288;类别：
				<input class="xltext" name="type" type="text"/>
				<input class="search" type="button" value="查&#12288;询" onclick="search()"/>
				<input class="search" type="button" value="新&#12288;增" onclick="add()"/>
			</form>	
        </div>
        <table class="xllist">
	        <thead>
	            <tr>
	            	<th width="5%">序号</th>
					<th width="20%">方案名称</th>
					<th width="20%">适用范围</th>
					<th width="15%">创建时间</th>
					<th width="15%">修改时间</th>
					<th>操作</th>
				</tr>
	        </thead>
            <tbody>
                <c:forEach items="${schemeList}" var="scheme" varStatus="sta">
					<tr>
						<td>${sta.count}</td>
						<td>${scheme.schemeName}</td>
						<td>
							${scheme.evaluationName}
							<input type="hidden" name='evaluationId' value="${scheme.evaluationId}"/>
						</td>
						<td>${pdfn:transDateTime(scheme.createTime)}</td>
						<td>${pdfn:transDateTime(scheme.modifyTime)}</td>
						<td>
							<a href="javascript:void(0)" onclick="saveGradeScheme('${scheme.schemeFlow}' , this);" style="display: none;">保存</a>
							<a href="javascript:void(0)" onclick="cancel();" style="display: none;">取消</a> 
							<a href="javascript:void(0)" onclick="editGradeScheme('${scheme.schemeFlow}' , this);">编辑</a> 
							<a href="javascript:delGradeScheme('${scheme.schemeFlow}');" >删除</a>
							<a href="javascript:void(0);"	onclick="setGradeItem('${scheme.schemeFlow}')" >评分项设置</a>
						</td>
					</tr>
				</c:forEach>
            </tbody>
      	</table>   
     </div> 	
   </div>
</body>
</html>