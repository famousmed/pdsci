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
	<jsp:param name="jquery_ui_sortable" value="true"/>
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
<style>
  #userSortable { list-style-type: none; margin: 0; padding: 0; width: 60%; }
  #userSortable li { margin: 0 3px 3px 3px; padding: 0.4em; padding-left: 1.5em; font-size: 1.4em; height: 18px; }
  #userSortable li tr td span { position: absolute; margin-left: -1.3em; }
.curr{color:red}
</style>
<script type="text/javascript">
	function addUser(){
		var url = '<s:url value="/irb/researcher/showAddUser" />?deptFlow=${proj.applyDeptFlow}';
		jboxOpen(url,"添加研究人员",800,500,true);
	}
	function deleteUser(recordFlow,recordStatus,userName,userFlow){
		jboxGet("<s:url value='/irb/researcher/delResUserConfirm'/>?userFlow="+userFlow,null,function(resp){
			if(resp == '${GlobalConstant.OPRE_SUCCESSED}'){
				jboxConfirm("确认删除 <b>"+userName+"</b> ?",function(){
					var url = '<s:url value="/irb/researcher/delResUser" />';
					var requestData = {"recordFlow":recordFlow,"recordStatus":recordStatus};
					jboxPost(url,requestData,function(resp){
						if(resp=='${GlobalConstant.DELETE_SUCCESSED}'){
							window.showProjUser();
						}
					},null,true);
				},null);
			} else if(resp == "${GlobalConstant.OPRE_FAIL}"){
				jboxTip("该主要研究者不能删除!");
			}
		},null,false);
	}
	function openChooseUser(userFlow,projFlow){
		var url = '<s:url value="/irb/researcher/showAllRoleUser?userFlow=" />'+userFlow+"&projFlow="+projFlow;
		jboxOpen(url,"选择删除",300,200,true);
	}
	
	<c:if test="${((sessionScope.currIrb.irbStageId==irbStageEnumApply.id && param.type != 'show') || 'edit' eq param.operType) 
		&& param.roleScope != GlobalConstant.ROLE_SCOPE_DECLARER}">
		var fixHelper = function(e, ui) {
		     ui.children().each(function() {
		    	//在拖动时，拖动行的cell（单元格）宽度会发生改变。在这里做了处理就没问题了  
		         $(this).width($(this).width());
		     });
		     return ui;
		};
		
		$(function() {
	   	var oldPostData = "";
		    $( "#userSortable" ).sortable({
		    	helper: fixHelper,  
		    	create: function(e, ui){
		    		var oldSortedIds = $( "#userSortable" ).sortable( "toArray" );
		    		$.each(oldSortedIds,function(i,sortedId){
		    			oldPostData = oldPostData+"&recordFlow="+sortedId;
		    		});
		    	},
		    	start:function(e, ui){
		    	     //拖动时的行，要用ui.helper
		    	    ui.helper.css({"background":"#eee"});
		    	    return ui; 
		    	}, 
		    	stop: function( event, ui ) {
		    		ui.item.css({"background":"#fff"});
		    		var sortedIds = $( "#userSortable" ).sortable( "toArray" );
		    		var postdata = "";
		    		$.each(sortedIds,function(i,sortedId){
		    			postdata = postdata+"&recordFlow="+sortedId;
		    		});
		    		if(oldPostData==postdata){
		    			return;
		    		}
		    		var url = "<s:url value='/irb/researcher/saveProjUserOrder'/>";
		    		jboxPost(url, postdata, function() {
		    			},null,false);
		    		oldPostData = postdata;
		    	}
		    });
		    $( "#userSortable" ).disableSelection();
		});
	</c:if>
</script>
</head>
<body>
	<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<table class="xllist">
				<thead>
					<tr>
						<th width="10%">姓名</th>
						<th width="15%">职称</th>
						<th width="15%">职务</th>
						<th width="20%">GCP培训</th>
						<th width="30%">研究岗位</th>
						<c:if test="${((sessionScope.currIrb.irbStageId==irbStageEnumApply.id && param.type != 'show') || 'edit' eq param.operType) 
							&& param.roleScope != GlobalConstant.ROLE_SCOPE_DECLARER}">
							<th width="10%">操作
							<span style="float: right;margin-right: 5px;"><img title="添加" onclick="addUser();" src="${ctxPath }/css/skin/${skinPath}/images/add3.png" style="cursor: pointer;"></span>
							</th>
						</c:if>
					</tr>
				</thead>
				<tbody id="userSortable">
					<c:forEach items="${userExtList }" var="userExt">
					<tr id="${userExt.recordFlow}" <c:if test="${((sessionScope.currIrb.irbStageId==irbStageEnumApply.id && param.type != 'show') || 'edit' eq param.operType) 
							&& param.roleScope != GlobalConstant.ROLE_SCOPE_DECLARER}">style="cursor: pointer;"</c:if>>
						<td><a href="#">${userExt.user.userName}</a></td>
						<td>${userExt.user.titleName}</td>
						<td>${userExt.user.postName}</td>
						<td></td>
						<td>${userExt.role.roleName }</td>
						<c:if test="${((sessionScope.currIrb.irbStageId==irbStageEnumApply.id && param.type != 'show') || 'edit' eq param.operType) 
							&& param.roleScope != GlobalConstant.ROLE_SCOPE_DECLARER}">
						<td>
						<a href="javascript:void(0)" 
						<c:if test="${pdfn:countMatches(userExt.role.roleName,'，')==0 }"> onclick="deleteUser('${userExt.recordFlow}','${GlobalConstant.RECORD_STATUS_N}','${userExt.user.userName}','${userExt.user.userFlow}')"</c:if>
						<c:if test="${pdfn:countMatches(userExt.role.roleName,'，')>0 }"> onclick="openChooseUser('${userExt.userFlow}','${sessionScope.currIrb.projFlow}')" </c:if> >[删除]</a>
						</td>
						</c:if>
					</tr>
					</c:forEach>
				</tbody>
			</table></div></div></div>
</body>
</html>