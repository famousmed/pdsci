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
<script>
	function editGradeItem(itemFlow , obj){
		var tr = $(obj).parent("td").parent('tr');
		var tds = tr.children("td").not(":last");
		$.each(tds ,function(i , n){
			var td = $(n);
			var tdText=td.text();
			td.empty();
			var input=$("<input>");   
		    //将原来的值赋值给input文本框   
		    if(i==1){
		    	input.addClass("validate[required,custom[number],maxSize[6]] xltext");
		    }else{
		    	input.addClass("validate[required , maxSize[100]] xltext");  
		    }
		    input.attr("value",tdText);
		    //将文本框追加给单元格   
		    td.append(input);   
		    $(obj).hide().prevAll().show();
		});
		
	}
	
	function saveItem(itemFlow , obj) {
		if(false==$("#gradeItemForm").validationEngine("validate")){
			return ;
		}
		var tr = $(obj).parent("td").parent('tr');
		var tds = tr.children("td").not(":last");
		var schemeFlow = $('#schemeFlow').val();
		var item = {
				"itemFlow":itemFlow,
				"itemName":tds.eq(0).children('input').val(),
				"itemScore":tds.eq(1).children('input').val(),
				"itemScoreTip":tds.eq(2).children('input').val(),
				"itemDesc":tds.eq(3).children('input').val(),
				"schemeFlow":schemeFlow
		};
		var url = '<s:url value="/srm/grade/item/saveItem"/>';
		jboxStartLoading();
		jboxPost(url , item , function(resp){
			top.jboxTip(resp);
			window.location.reload(true);
		} , null , true);
		
	}
	
	function delGradeItem(itemFlow , obj){
		var url = '<s:url value="/srm/grade/item/delete"/>?itemFlow='+itemFlow;
		jboxConfirm("确认删除？" , function(){
			jboxStartLoading();
			jboxGet(url , null , function(resp){
				window.location.reload(true);
			} , null , true);
		});
	}
	
	function quxiao(){
		window.location.reload(true);
	}
	
	function delTr(obj){
		$(obj).parent("td").parent('tr').remove();
	}
	function addGradeItem(){
		var htm = '<tr><td><input type="text" class="validate[required , maxSize[100]] xltext"/></td><td><input type="text" class="validate[required , custom[number],maxSize[6]] xltext"/></td><td><input type="text" class="validate[required , maxSize[100]] xltext"/></td><td><input type="text" class="validate[required , maxSize[100]] xltext"/></td>'+
			'<td>'+
				'<a href="javascript:void(0);" onclick="saveItem('+"''"+' , this)">保存</a> '+
				'<a href="javascript:void(0);" onclick="delTr(this);">取消</a>'+
			'</td>'+
		'</tr>';
		$("#itemTb").append(htm);
	}
</script>
</head>
<body>
 <div class="mainright">
      <div class="content">
        <div class="title1 clearfix">
        	<span style="font-size: 14px;font-weight: bold;">方案名称：${scheme.schemeName}</span>&#12288;&#12288;
        	<span style="font-size: 14px;font-weight: bold;">适用范围：${scheme.evaluationName}</span>&#12288;&#12288;
				<input class="search" type="button" value="新&#12288;增" onclick="addGradeItem()"/>
        	<input id="schemeFlow" value="${scheme.schemeFlow}" type="hidden"/>
        </div>
        <form id="gradeItemForm" name="gradeItemForm">
       <table class="xllist">
				<tr>
					<th width="10%">评分项名称</th>
					<th width="5%">评分项分值</th>
					<th width="10%">评分项分值描述</th>
					<th width="20%">评分项描述</th>
					<th width="10%">操作</th>
				</tr>
				<tbody id="itemTb">
				<c:forEach items="${itemList}" var="item">
					<tr>
						<td>${item.itemName}</td>
						<td>${item.itemScore}</td>
						<td>${item.itemScoreTip}</td>
						<td>${item.itemDesc}</td>
						<td>
							<a href="javascript:void(0);" onclick="saveItem('${item.itemFlow}' , this);" style="display: none">保存</a>
							<a href="javascript:void(0);" onclick="quxiao();" style="display: none">取消</a>
							<a href="javascript:void(0);" onclick="editGradeItem('${item.itemFlow}' , this);">编辑</a> 
							<a href="javascript:void(0);" onclick="delGradeItem('${item.itemFlow}' , this);">删除</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		</form>
     </div> 	
   </div>
	
	</body>
</html>