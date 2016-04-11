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
	function search(){
		$("#searchForm").submit();
	}
	function save(){
		if($("#searchForm").validationEngine("validate")){
			var checkboxs = $("input[name='userFlow']:checked");
			if(checkboxs.length == 0){
				jboxTip("请选择一个研究者！");
				return false;
			}
			jboxConfirm("保存后无法修改,确认保存?",function () {
				var $user = $("input[name='userFlow']:checked");
				var userFlow = $user.val();
				var deptFlow = $user.parent().next().next().next().children().val();
				var url = "<s:url value='/gcp/proj/saveResearcher'/>?userFlow="+userFlow+"&deptFlow="+deptFlow+"&projFlow=${param.projFlow}";
				jboxPost(url,null,function(resp){
					if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
						window.parent.frames["mainIframe"].window.loadResearchUser();
						jboxClose();
					}
				},null,true);
			});
		}
	}
	function limitChooseOne(obj){
		var checkboxs = $("input[type='checkbox']");
		checkboxs.each(function(){
			this.checked = false;
		});
		obj.checked = !obj.checked;
	}
</script>
<style type="text/css">
	table.xllist tr th, table.xllist tr td{text-align: center;padding: 0;margin: 0;}
</style>
</head>
<body>
	<div class="mainright">
      <div class="content">
        <div class="title1 clearfix">
		<form id="searchForm" action="<s:url value='/gcp/proj/chooseUser'/>" method="post">
  			<div style="margin-bottom: 10px;">
  				<%-- 姓名：<input type="text" name="userName" class="xltext" value="${param.userName}" onchange="search()"> --%>
				&nbsp;承担科室：
				<select id="applyDeptFlow" name="deptFlow" class="validate[required] xlselect" style="width: 156px;margin-right: 3px;" onchange="search()">
					<option value="">请选择</option>
					<c:forEach items="${sysDeptList}" var="dept">
					<option value="${dept.deptFlow}" <c:if test="${param.deptFlow eq dept.deptFlow}">selected="selected"</c:if>>${dept.deptName}</option>
					</c:forEach>
				</select><font color="red">*</font>
				<!-- <input type="button" class="search" onclick="search()" value="查&#12288;询"/> -->
				<input name="recordFlow" type="hidden" value="${info.recordFlow}" />
				<input name="projFlow" type="hidden" value="${param.projFlow}" />
   			</div>
   		</form>
			     <table class="xllist" width="100%" id="irbUsers" >
		            <thead>
		            	<tr>
		            		<th width="6%" >勾选</th>
		            		<th width="10%" >姓名</th>
		            		<th width="7%" >性别</th>
		            		<th width="15%" >科室</th>
		            		<th width="15%" >职务</th>
		            		<th width="12%" >职称</th>
		            		<th width="14%" >手机</th>
		            		<th width="21%" >邮件</th>
		            	</tr>
		            </thead>
		            <c:forEach items="${userList}" var="user">
		            	<tr>
			            	<td width="6%">
			            		<input type="checkbox" name="userFlow" value="${user.userFlow}" onclick="limitChooseOne(this)"
			            				<c:if test="${proj.applyUserFlow eq user.userFlow}">checked="checked"</c:if> />
		            		</td>
			            	<td width="10%">${user.userName}</td>
			            	<td width="7%">${user.sexName}</td>
			            	<td width="15%">
			            		${user.deptName}
			            		<input type="hidden" name="deptFlow" value="${user.deptFlow}"/>
			            	</td>
			            	<td width="15%">${user.postName}</td>
			            	<td width="12%">${user.titleName}</td>
			            	<td width="14%">${user.userPhone}</td>
			            	<td width="21%">${user.userEmail}</td>
		            	</tr>
		            </c:forEach>
		            <c:if test="${empty userList}">
		            	<tr><td align="center" colspan="8">无记录</td></tr>
		            </c:if>
		            </table>
			<p align="center" style="width:100%">
				<input class="search" type="button" value="保&#12288;存"  onclick="save();" />
				<input class="search" type="button" value="关&#12288;闭"  onclick="jboxClose();" />
			</p>
		
         </div>
        
     </div> 	
   </div>
</body>
</html>