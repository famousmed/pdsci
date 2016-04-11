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
function setExpert(){
	var parent = window.parent.frames['mainIframe'].document;
	var tr = $('#expertsTb').find("input[name='userFlow']:checked").parent('td').parent('tr');
	tr.append('<td></td><td></td>');
	var count = $(parent.getElementById('expertInfoListTb')).children().length;
	$.each(tr , function(i , n){
		var tds = $(n).children();
		var index = count+i;
		tds.eq(0).find("input[name='userFlow']").attr('name' , 'srmExpertProjList['+index+'].userFlow');
		tds.eq(tds.length-1).append('<input type="checkbox" name="srmExpertProjList['+index+'].phoneNotifyFlag" value="Y">');
		tds.eq(tds.length-2).append('<input type="checkbox" name="srmExpertProjList['+index+'].emailNotifyFlag"  value="Y">');
	});
	$(parent.getElementById('expertInfoListTb')).append(tr);
	var countTr=$(parent.getElementById('expertInfoListTb')).children().length;
	if(countTr!=0){
		$(parent.getElementById('msg')).hide();
	}else{
		$(parent.getElementById('msg')).show();
	}
}

function searchExpert(){
	var groupFlow = $('#expertGroup').val();
	var projFlow = $("#projFlow").val();
	var url = "";
	if(groupFlow){
		url = "<s:url value='/srm/proj/evaluation/groupProjConfigExpert'/>?groupFlow="+groupFlow+'&evalSetFlow=';
		if($('#evalSetFlow').val()){
			url+=$('#evalSetFlow').val();
		}
		
		jboxGet(url , null ,function(data){
			$('#expertsTb').html(data);
		} , null , false);
	}else{
		url = "<s:url value='/srm/proj/evaluation/chooseExpert'/>?projFlow="+projFlow+"&evalSetFlow=";
		if($('#evalSetFlow').val()){
			url+=$('#evalSetFlow').val();
		}
		window.location.href=url;
	}
}
function saveExpert(){
	jboxStartLoading();
	jboxPost("<s:url value='/srm/proj/evaluation/saveExpert'/>" , $('#expertForm').serialize() , function(){
		window.parent.frames['mainIframe'].location.reload(true);
		jboxClose();
	} , null , true);
}
</script>
</head>
<body>
<div id="main">
   <div class="mainright">
      <div class="content">
        <div class="title1 clearfix">
        <c:if test="${evalSetFlowExists eq GlobalConstant.FLAG_N}">
        	对不起！请先提交评审设置才能添加评审专家，评审设置提交后不能更改，请按实填写！
        </c:if>
        <c:if test="${evalSetFlowExists eq GlobalConstant.FLAG_Y}">
           <div style="margin-bottom: 10px;">
        	<span style="font-weight: bold;color: #333;">按专家组查找：</span>
        	<select id="expertGroup" class="xlselect" onchange="searchExpert();">
        		<option value="">全部</option>
        		<c:forEach items="${expertGroupList}" var="expertGroup">
        			<option value="${expertGroup.groupFlow}" <c:if test='${param.groupFlow==expertGroup.groupFlow}'>selected="selected"</c:if>>${expertGroup.groupName}</option>
        		</c:forEach>
        	</select>
        	</div>
        	<form id="expertForm">
        	<table class="xllist" >
               <tr>
                   <th></th>
                   <th>姓名</th> 
                   <th>性别</th>
                   <th>专业</th>
                   <th>学历</th>
				   <th>工作单位</th>
				   <th>手机</th>
				   <th>邮箱</th>
               </tr>
               <tbody id="expertsTb">
               	   <c:forEach items="${expertInfoList}" var="expert" varStatus="sta">
	               <tr>
	                	<td width="5%">
	                		<input type="checkbox" name="userFlow"  value="${expert.userFlow}"/>
	                	</td>
	                	<td width="10%">${expert.userName}</td>
	                	<td width="7%">
	                		<c:if test='${expert.sexId=="1"}'>男</c:if>
	                		<c:if test='${expert.sexId=="2"}'>女</c:if>
	                	</td>
	                	<td width="15%">${expert.expert.majorName}</td>
	                	<td width="10%">${expert.expert.education}</td>
	                	<td width="20%">${expert.orgName}</td>
	                	<td width="15%">${expert.userPhone}</td>
	                	<td >${expert.userEmail}</td>
	            	</tr>
	            	</c:forEach>
            	</tbody>
        	</table>
        	<p style="text-align: center;">
        		 <input id="evalSetFlow" name="evalSetFlow" type="hidden" value="${param.evalSetFlow}"/>
        		 <input id="projFlow" name="projFlow" type="hidden" value="${param.projFlow}"/>
        		<input type="button" class="search" onclick="saveExpert();" value="保&#12288;存"/>
        		<input type="button" class="search" onclick="jboxClose();" value="关&#12288;闭" />
        	</p>
        	</form>
        	</c:if>
        	
       </div>
     </div> 	
   </div>
</div>
</body>
</html>
