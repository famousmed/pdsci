<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script defer="defer">
var fixHelper = function(e, ui) {
     ui.children().each(function() {
    	//在拖动时，拖动行的cell（单元格）宽度会发生改变。在这里做了处理就没问题了  
         $(this).width($(this).width());
     });
     return ui;
};
$(function() {
	var oldPostData = "";
    $( "#bookSortable" ).sortable({
    	helper: fixHelper,  
    	create: function(e, ui){
    		var oldSortedIds = $( "#bookSortable" ).sortable( "toArray" );
    		$.each(oldSortedIds,function(i,sortedId){
    			oldPostData = oldPostData+"&bookFlow="+sortedId;
    		});
    	},
    	start:function(e, ui){
    	     //拖动时的行，要用ui.helper
    	    ui.helper.css({"background":"#eee"});
    	    return ui; 
    	}, 
    	stop: function( event, ui ) {
    		ui.item.css({"background":"#fff"});
    		var sortedIds = $( "#bookSortable" ).sortable( "toArray" );
    		var postdata = "";
    		$.each(sortedIds,function(i,sortedId){
    			postdata = postdata+"&bookFlow="+sortedId;
    		});
    		if(oldPostData==postdata){
    			return;
    		}
    		var url = "<s:url value='/exam/manage/book/saveOrder'/>";
    		jboxPost(url, postdata, function() {
    			var treeObj = $.fn.zTree.getZTreeObj("bookTree");
    			var nodes = treeObj.getSelectedNodes();
    			if (nodes.length>0) {
    				treeObj.reAsyncChildNodes(nodes[0], "refresh");
    			}else{
        			var treeObj = $.fn.zTree.getZTreeObj("bookTree");
        			treeObj.reAsyncChildNodes(null, "refresh");
    			}
    		},null,false);
    		oldPostData = postdata;
    	}
    });
    $( "#bookSortable" ).disableSelection();
    init();
});
function init(){
	$(".viewTd").hover(function() {
		$(this).find("div").stop().animate({left: "210", opacity:1}, "slow").css("display","block");
	},function(){
		$(this).find("div").stop().animate({left: "0", opacity: 0}, "slow");
	});
}

function smartOrder(bookParentFlow){
	jboxPost("<s:url value='/exam/manage/book/smartorder'/>" , {"bookParentFlow":bookParentFlow} , function(resp){
		doOrder();
	} , null , true);
}
</script>
<table width="100%" cellspacing="0" cellpadding="0" class="basic">
		<tr>
			<th style="text-align: left;">&#12288;子书目<span style="margin-left: 10px;"><a href="javascript:void(0);" onclick="smartOrder('${param.bookParentFlow}');">【一键排序】</a></span></th>
		</tr>
	<tbody id="bookSortable">
		<c:forEach items="${bookList}" var="book" varStatus="status">
			<tr id="${book.bookFlow}" style="cursor: pointer;" width="100%">
				<td>
					<a id="${book.bookFlow }" href="" style="float: left; padding-left: 20px">${book.bookName}</a>
					<div style="display: none; float: right">
					</div>
				</td>
			</tr>
		</c:forEach>
	</tbody>
	<c:if test="${bookList == null || bookList.size()==0 }">
		<tr>
			<td align="center" style="text-align: center;">无记录</td>
		</tr>
	</c:if>
</table>