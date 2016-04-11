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
	<jsp:param name="jquery_cxselect" value="true"/>
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
$(document).ready(function(){
	var parentTrs = window.parent.frames['mainIframe'].$("#linkManTb").children();
	if(!parentTrs.html()){
		parentTrs = window.top.frames['jbox-message-iframe'].$("#linkManTb").children();
	}
	var trs=$("#userTb").children();
	$.each(parentTrs,function(i,n){
		var parentUserFlow=$(n).find("input[name='userFlow']").val();
		var parentRecordFlow=$(n).find("input[name='recordFlow']").val();
		if(parentUserFlow!="" || parentRecordFlow!=""){
			$.each(trs,function(j,k){
				var nowUserFlow=$(k).find("input[name='id']").val();
				if(parentUserFlow==nowUserFlow || parentRecordFlow==nowUserFlow){
					$(k).remove();
				}
			});
			var nowTrsLength=$("#userTb").children().length;
			if(nowTrsLength==0){
				$("#userTb").append('<tr><td colspan="6">无记录</td></tr>');
				$("#saveButton").hide();
			}
		}
	});
});
  function add(){
	  var flows = $("input[name='id']:checked");
		var ids="";
		if(flows.length == 0){
			jboxTip("请勾选要添加的客户联系人！");
			return false;
		}
		jboxConfirm("确认添加？", function(){
				$.each(flows,function(i,n){
				  if($(n).val()!=""){
					  if(flows.length-1==i){
							ids=ids+$(n).val();
						}else{
							ids=ids+$(n).val()+",";
						} 	
				  }
				});
				$("#saveButton").attr("disabled",true);
				var url='<s:url value="/erp/crm/searchCustomerUserByUserFlows"/>?userFlows=' + ids;
				jboxPost(url , null , function(data){
					
					var tb = window.parent.frames['mainIframe'].$("#linkManTb");
					var array=[];
						 for(var i=0;i<data.length;i++){
							 var userFlow=data[i].userFlow;
							 if(userFlow==null){
								 userFlow="";
							 }
							 var userName=data[i].userName;
							 if(userName==null){
								 userName="";
							 }
							 var sexId=data[i].sexId;
							 if(sexId==null){
								 sexId="";
							 }
							 var deptName=data[i].deptName;
							 if(deptName==null){
								 deptName="";
							 }
							 var postName=data[i].postName;
							 if(postName==null){
								 postName="";
							 }
							 var userTelphone=data[i].userTelphone;
							 if(userTelphone==null){
								 userTelphone="";
							 }
							 var userCelphone=data[i].userCelphone;
							 if(userCelphone==null){
								 userCelphone="";
							 }
							 var userEmail=data[i].userEmail;
							 if(userEmail==null){
								 userEmail="";
							 }
							 var isMain=data[i].isMain;
							 if(isMain==null){
								 isMain="";
							 }
							 var remark=data[i].remark;
							 if(remark==null){
								 remark="";
							 }
							  var content='<tr>'+
								'<td><input type="checkbox" name="id"/><input type="hidden" name="userFlow" value="'+userFlow+'"></td>'+
								'<td><input style="width:90%;" name="userName" type="text" class="inputText validate[required,maxSize[20]]" value="'+userName+'" readonly/></td>'+
								'<td>'+
								 '<select name="sexId" class="inputText" style="width:90%;">'+
								    <c:forEach items="${userSexEnumList }" var="sex">
								    	<c:if test="${!(sex.id eq userSexEnumUnknown)}">
								    		'<option value="${sex.id}" '+((sexId=="${sex.id}")?'selected':'')+'>${sex.name}</option>'+
								    	</c:if>
							        </c:forEach>
							        '<option value=""></option>'+
								 '</select></td>'+
								 '<td><input style="width:90%;" name="deptName" type="text" class="inputText validate[maxSize[100]]" value="'+deptName+'"/></td>'+
								 '<td><input type="text" class="inputText validate[maxSize[50]]" name="postName" style="width:90%;" value="'+postName+'"/></td>'+
								 /* '<td><select class="inputText" name="userCategoryId" style="width:90%;">'+
								 '<option value=""></option>'+
									<c:forEach var="userCategory" items="${dictTypeEnumUserCategoryList}">
										'<option value="${userCategory.dictId}">${userCategory.dictName}</option>'+
									</c:forEach>+
								 '</select></td>'+ */
								 '<td><input type="text" class="inputText validate[custom[phone2],maxSize[20]]" name="userTelphone" style="width:90%;" value="'+userTelphone+'"/></td>'+
								 '<td><input type="text" class="inputText validate[custom[mobile],maxSize[20]]" name="userCelphone" style="width:90%;" value="'+userCelphone+'"/></td>'+
								 '<td><input type="text" class="inputText validate[custom[email],maxSize[50]]" name="userEmail" style="width:90%;" value="'+userEmail+'"/></td>'+
								 /* '<td>'+
									'<select name="isMain" class="inputText" style="width:90%;">'+
									    '<option value=""></option>'+
										'<option value="${GlobalConstant.FLAG_Y}" '+((isMain=="${GlobalConstant.FLAG_Y}")?'selected':'')+'>是</option>'+
										'<option value="${GlobalConstant.FLAG_N}" '+((isMain=="${GlobalConstant.FLAG_N}")?'selected':'')+'>否</option>'+
									'</select>'+
								'</td>'+ */
								'<td><input type="text" class="inputText validate[maxSize[200]]" name="remark" style="width:90%;" value="'+remark+'"/></td></tr>';	
								tb.append(content);
							 }
						 window.parent.frames['mainIframe'].window.jboxEndLoading();	
						 jboxClose();
		 		}, null , false);
		});
  }
  function doBack(){
	  jboxClose();
  }
  
  function save(contractFlow){
	  var flows = $("input[name='id']:checked");
		var ids="";
		if(flows.length == 0){
			jboxTip("请勾选要添加的客户联系人！");
			return false;
		}
		jboxConfirm("确认添加？", function(){
				$.each(flows,function(i,n){
				  if($(n).val()!=""){
					  if(flows.length-1==i){
							ids=ids+$(n).val();
						}else{
							ids=ids+$(n).val()+",";
						} 	
				  }
				});
				$("#saveButton").attr("disabled",true);
				var url='<s:url value="/erp/crm/searchAndSaveCustomerUserByUserFlows"/>?userFlows=' + ids+"&contractFlow="+contractFlow;
				jboxPost(url , null , function(resp){
				   window.parent.frames['jbox-message-iframe'].window.search();	
				  jboxClose();
		 		}, null , true);
		});
  }
  function checkTr(obj){
	  var checkBox=$(obj).find("td").eq(0).find("input[name='id']");
	  if(checkBox.prop("checked")){
		  checkBox.removeAttr("checked");
	  }else{
		  checkBox.attr("checked","checked");
	  }
	  
  }
  function checkValue(obj){
	  if($(obj).prop("checked")){
		  $(obj).removeAttr("checked");
	  }else{
		  $(obj).attr("checked","checked");
	  }
  }
</script>
</head>
<body>
<div class="mainright">
<div class="content">
	<div class="title1 clearfix">
<table cellpadding="0" cellspacing="0" class="xllist" style="width: 100%;">
	<colgroup>
		<col width="5%"/>
		<col width="20%"/>
		<col width="20%"/>
		<col width="20%"/>
		<col width="20%"/>
		<col width="15%"/>
	</colgroup>
	<tr>
		<th></th>
		<th>姓名</th>
		<th>性别</th>
		<th>科室</th>
		<th>职务</th>
		<th>部门负责人</th>			
	</tr>
	<tbody id="userTb">
	<c:if test="${empty customerUserList }">
	    <tr><td colspan="6">无记录</td></tr>
	</c:if>
	<c:forEach items="${customerUserList}" var="user" varStatus="status">
		<tr onclick="checkTr(this);" style="cursor: pointer;">
			<td>
			<input type="checkbox" id="${user.userFlow }" name="id" value="${user.userFlow }" onclick="checkValue(this);"/>
			</td>
			<td>${user.userName}</td>
			<td>${user.sexName}</td>
			<td>${user.deptName}</td>
			<td>${user.postName}</td>
			<td>
				<c:if test="${user.isMain eq GlobalConstant.FLAG_Y}">是</c:if>
				<c:if test="${user.isMain eq GlobalConstant.FLAG_N}">否</c:if>
			</td>
		</tr>
	</c:forEach>
	</tbody>
	
</table>
          <div class="button" style="width: 100%">
            <c:if test="${param.type != 'edit'}">
              <c:if test="${!empty customerUserList}">
                <input id="saveButton" class="search" type="button" value="保&#12288;存" onclick="save('${param.contractFlow}');" />
              </c:if>
             <input class="search" type="button" value="关&#12288;闭" onclick="doBack();"/>
            </c:if>
            <c:if test="${param.type == 'edit'}">
              <c:if test="${!empty customerUserList}"> 
                <input id="saveButton" class="search" type="button" value="确&#12288;认" onclick="add();"/>
              </c:if>
             <input class="search" type="button" value="关&#12288;闭" onclick="jboxClose();"/>
		    </c:if>
		  </div>
</div>
</div>
</div>
</body>
</html>