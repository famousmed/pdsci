<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>

<script type="text/javascript">
	function editAttr(attrCode){
		jboxOpen("<s:url value='/pub/module/editAttr'/>?attrCode="+attrCode+"&moduleCode=${element.moduleCode}", "属性维护", 600, 600);
	}
	function deleteAttr(attrFlow,attrCode){
		jboxGet("<s:url value='/pub/module/delAttrConfirm'/>?attrCode="+attrCode,null,function(resp){
			if(resp != '${GlobalConstant.OPRE_FAIL}'){
				jboxConfirm("确认删除？",function(){
					doDel(attrFlow);
				});
			}else{
				jboxTip("该属性已被选入项目库，不能删除!");
			}
		},null,false);
	}
	 function doDel(attrFlow) {
		 
		 jboxGet("<s:url value='/pub/module/deleteAttr?attrFlow='/>" + attrFlow,null,function(){
			 showAttr('${element.elementCode}','${element.elementName}','${element.elementVarName}');
		 },null,true);
    }
	var fixHelper = function(e, ui) {
	     ui.children().each(function() {
	    	//在拖动时，拖动行的cell（单元格）宽度会发生改变。在这里做了处理就没问题了  
	         $(this).width($(this).width());
	     });
	     return ui;
	};
	$(function() {
    	var oldPostData = "";
	    $( "#sortable" ).sortable({
	    	helper: fixHelper,  
	    	create: function(e, ui){
	    		var oldSortedIds = $( "#sortable" ).sortable( "toArray" );
	    		$.each(oldSortedIds,function(i,sortedId){
	    			oldPostData = oldPostData+"&attrFlow="+sortedId;
	    		});
	    	},
	    	start:function(e, ui){
	    	     //拖动时的行，要用ui.helper
	    	    ui.helper.css({"background":"#eee"});
	    	    return ui; 
	    	}, 
	    	stop: function( event, ui ) {
	    		ui.item.css({"background":"#fff"});
	    		var sortedIds = $( "#sortable" ).sortable( "toArray" );
	    		var postdata = "";
	    		$.each(sortedIds,function(i,sortedId){
	    			postdata = postdata+"&attrFlow="+sortedId;
	    		});
	    		if(oldPostData==postdata){
	    			return;
	    		}
	    		var url = "<s:url value='/pub/module/saveAttributeOrder'/>";
	    		jboxPost(url, postdata, function() {
	    		},null,false);
	    		oldPostData = postdata;
	    	}
	    });
	    $( "#sortable" ).disableSelection();
	});
	
	function copyAttr(attrFlow){
		jboxConfirm("确认复制?",function(){
			jboxGet("<s:url value='/pub/module/copyAttr?attrFlow="+attrFlow+"'/>"
					,null,function(){
				showAttr('${element.elementCode}','${element.elementName}','${element.elementVarName}');
			},null,true);
		});
	}
</script>
</head>
<body>
     	<table width="100%" cellspacing="0" cellpadding="0" class="xllist" >
     		<thead>
     		<tr>
     			<th width="10%">名称</th><th width="10%">变量名</th><th width="9%">数据类型</th>
     			<th width="9%">数据长度</th>
     			<th width="9%">录入方式</th>
     			<th width="10%">是否显示属性名</th>
     			<th width="20%">代码</th>
     			<th width="13%">操作</th>
     		</tr>
     		</thead>
     		<tbody id="sortable">
     		<c:forEach items="${attrList}" var="attr" >
     		<tr id="${attr.attrFlow}">
     			<td>${attr.attrName} </td> 
     			<td>${attr.attrVarName}</td>
     			<td>${attr.dataTypeName}</td>
     			<td>${attr.dataLength}</td>
     			<td>${attr.inputTypeName}</td>
     			<td>${GlobalConstant.FLAG_Y eq  attr.isViewName ?'是':'否'}</td>
     			<td>
     				<c:forEach items="${attrCodeMap[attr.attrCode] }" var="code">
          						&#12288;${code.codeValue }-${code.codeName };
     				</c:forEach>
     			</td>
     			<td>
     				[<a href="javascript:editAttr('${attr.attrCode }');">编辑</a>]
     				[<a href="javascript:deleteAttr('${attr.attrFlow }','${attr.attrCode }');">删除</a>]
     				<a href="javascript:copyAttr('${attr.attrFlow}');" >[复制]</a>
     			</td>
     		</tr>
         	</c:forEach>
         	</tbody>
         	<c:if test="${attrList == null || attrList.size()==0 }"> 
				<tr> 
					<td align="center" style="text-align: center;" colspan="8">无记录</td>
				</tr>
			</c:if>	
     	</table>
</body>
</html>