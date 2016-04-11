<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
$(document).ready(function(){
var id=$("#content").attr("id");
	var url="<s:url value ='/edu/user/showCollection'/>?collectionTypeId=${eduCollectionTypeEnumCourse.id}";
	jboxLoad(id,url,false);
	//$("#a-stuCourse").addClass("cur");
});

function selectCollectionTypeId(typeId){
	var id=$("#content").attr("id");
	var url="<s:url value ='/edu/user/showCollection'/>?collectionTypeId=" + typeId;
	$("#content").html("");
	jboxLoad(id,url,false);
}

function delConllection(resourceFlow, collectionTypeId){
	jboxConfirm("确认删除？", function(){
		var url = "<s:url value ='/edu/course/delCollection'/>?resourceFlow=" + resourceFlow +"&collectionTypeId=" + collectionTypeId;
		jboxPost(url,null,
				function(resp){
					if(resp == "${GlobalConstant.DELETE_SUCCESSED}"){
						selectCollectionTypeId(collectionTypeId);
					}
				},null,true);
	});
}
</script>
<div class="registerMsg-m fl">
<div class="registerMsg-m-inner registerBgg">
<div class="registerMsg-tabs"> 

<div class="module-tabs" style="display: block;">
      <ul class="fl">
         <c:forEach items="${eduCollectionTypeEnumList}" var="type">
            <li <c:if test="${param.collectionTypeId eq type.id }">class="on"</c:if> ><a onclick="selectCollectionTypeId('${type.id}');" >${type.name}</a></li>
      	</c:forEach>
      </ul>
</div>

	<div id="content">
    	<!-- 这里填充根据条件查询的课程列表 -->
    </div>
</div>
</div>
</div>