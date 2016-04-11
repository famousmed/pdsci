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
</head>
<script type="text/javascript">
	function showAdd(){
		var url = '<s:url value="/irb/cfg/showEdit" />';
		jboxOpen(url,"新增伦理委员会",700,300,true);
	}
	function editInfo(recordFlow){
		var url = '<s:url value="/irb/cfg/showEdit?recordFlow=" />'+recordFlow;
		jboxOpen(url,"编辑伦理委员会",700,300,true);
	}
	function reload(){
		window.location.reload();
	}
	function addUser(recordFlow){
		var url = '<s:url value="/irb/cfg/showAddUser?recordFlow=" />'+recordFlow;
		jboxOpen(url,"添加成员",900,500,true);
	}
	function deleteUser(recordFlow,recordStatus,userName){
		jboxConfirm("确认删除"+userName+"?",function(){
			var url = '<s:url value="/irb/cfg/editUser" />';
			var requestData = {"recordFlow":recordFlow,"recordStatus":recordStatus}
			jboxPost(url,requestData,function(resp){
				if(resp=='${GlobalConstant.OPRE_SUCCESSED}'){
					reload();
				}
			},null,true);
		},null);
	}
	function redirect(recordFlow){
		var url = '<s:url value="/irb/cfg/info" />?recordFlow='+recordFlow;
		window.location.href=url;
	}
	function openChooseUser(userFlow,irbInfoFlow){
		var url = '<s:url value="/irb/cfg/showAllRoleUser?userFlow=" />'+userFlow+"&irbInfoFlow="+irbInfoFlow;
		jboxOpen(url,"选择删除",300,200,true);
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
	    $( "#userSortable" ).sortable({
	    	helper: fixHelper,  
	    	create: function(e, ui){
	    		var oldSortedIds = $( "#userSortable" ).sortable( "toArray" );
	    		$.each(oldSortedIds,function(i,sortedId){
	    			oldPostData = oldPostData+"&userFlow="+sortedId;
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
	    			postdata = postdata+"&userFlow="+sortedId;
	    		});
	    		if(oldPostData==postdata){
	    			return;
	    		}
	    		var url = "<s:url value='/irb/cfg/saveIrbInfoUserOrder'/>?irbInfoFlow=${findInfo.recordFlow}";
	    		jboxPost(url, postdata, function() {
	    			},null,false);
	    		oldPostData = postdata;
	    	}
	    });
	    $( "#sortable" ).disableSelection();
	});
</script>
<body>
<div id="main">
   <div class="mainright">
      <div class="content">
        <div class="title1 clearfix">
          <ul id="tags">
          <c:if test="${fn:length(infoList)==0}"><li style="color: red">请先点击添加伦理委员会！</li></c:if>
          <c:forEach items="${infoList}" var="info" varStatus="statu">
            <li<c:if test="${ (empty param.recordFlow && statu.first)||(param.recordFlow==info.recordFlow)}"> class="selectTag" </c:if> ><a onclick="redirect('${info.recordFlow}')" href="javascript:void(0)">${info.irbName }</a></li>
           </c:forEach>
            <li><img title="添加" onclick="showAdd();" src="${ctxPath }/css/skin/${skinPath}/images/add.png" style="cursor: pointer;"></li>
        </ul>
        <div id="tagContent">
            <div class="tagContent selectTag" id="tagContent0">
            		<table class="basic" width="100%">
            			<tr>
                            <th class="td_blue" width="80px">会议地点：</th>
                            <td>${findInfo.meetingAddress}</td>
                            <th class="td_blue" width="70px">联系人：</th>
                            <td>${findInfo.contactUser}</td>
                            <th class="td_blue" width="80px">联系电话：</th>
                            <td>${findInfo.contactPhone}&#12288;${findInfo.contactMobile}</td>
                            <th class="td_blue" width="80px">联系邮件：</th>
                            <td>${findInfo.contactEmail}</td>
                             <th class="td_blue" width="120px"><a href="javascript:void(0)" onclick="addUser('${findInfo.recordFlow}')" style="color:#FF6600;">[添加成员]</a>&nbsp;<a href="javascript:void(0)" onclick="editInfo('${findInfo.recordFlow}')" style="color:#FF6600;">[修改]</a></th>
                         </tr>
            		</table>
            		<br>
					<table class="xllist">
                                <thead>
                                    <tr>
                                        <th width="10%">姓名</th>
                                        <th width="10%">性别</th>
                                        <th width="25%">单位部门</th>
                                        <th width="10%">职称</th>
                                        <th width="10%">伦理职务</th>
                                        <th width="10%">操作</th>
                                    </tr>
                                </thead>
                                <tbody id="userSortable"> 
                                <c:forEach items="${userList }" var="user">
                                    <tr id="${user.userFlow}">
                                       <td>${sysUserMap[user.recordFlow].userName }</td><td>${sysUserMap[user.recordFlow].sexName }</td><td>${sysUserMap[user.recordFlow].orgName }</td><td>${sysUserMap[user.recordFlow].titleName }</td><td>${user.roleName }</td><td><a href="javascript:void(0)" <c:if test="${pdfn:countMatches(user.roleName,'，')==0 }"> onclick="deleteUser('${user.recordFlow}','${GlobalConstant.RECORD_STATUS_N}','${user.userName}')" </c:if> <c:if test="${pdfn:countMatches(user.roleName,'，')>0 }"> onclick="openChooseUser('${user.userFlow}','${findInfo.recordFlow}')" </c:if> >[删除]</a></td>
                                    </tr>
                                 </c:forEach>   
                                </tbody>
                            </table>
            </div>
    </div>
        <p>
    </p>
      </div>
   	 </div>
	</div>
</div>
</body></html>