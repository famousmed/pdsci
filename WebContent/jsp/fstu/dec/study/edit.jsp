<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="true"/>
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
<style type="text/css">
	#boxHome .item:HOVER{background-color: #eee;}
</style>
<script type="text/javascript">
	/**
	*模糊查询加载
	*/
	(function($){
		$.fn.likeSearchInit = function(option){
			option.clickActive = option.clickActive || null;
			
			var searchInput = this;
			searchInput.on("keyup focus",function(){
				$("#boxHome").show();
				if($.trim(this.value)){
					$("#boxHome .item").hide();
					var items = $("#boxHome .item[value*='"+this.value+"']").show();
					if(!items){
						$("#boxHome").hide();
					}
				}else{
					$("#boxHome .item").show();
				}
			});
			searchInput.on("blur",function(){
				if(!$("#boxHome.on").length){
					$("#boxHome").hide();
				}
			});
			$("#boxHome").on("mouseenter mouseleave",function(){
				$(this).toggleClass("on");
			});
			$("#boxHome .item").click(function(){
				$("#boxHome").hide();
				var value = $(this).attr("value");
				$("#itemName").val(value);
				searchInput.val(value);
				if(option.clickActive){
					option['clickActive']($(this).attr("flow"));
				}
			});
		};
	})(jQuery);
	//======================================

   function save(flow){
	   if(!$("#editForm").validationEngine("validate")){
			return;
		}
		var form=$("#editForm").serialize();
		jboxPost("<s:url value='/fstu/dec/saveStudy'/>",form,function(obj){
				if(obj=="${GlobalConstant.SAVE_SUCCESSED}"){
					window.parent.document.mainIframe.search();
					jboxClose();
				}
				if(obj=="${GlobalConstant.OPRE_SUCCESSED}"){
					window.parent.document.mainIframe.search();
					jboxClose();
				}
			});
   } 
   function readUser(userFlow){
	   jboxPost("<s:url value='/fstu/dec/readUser'/>?userFlow="+userFlow,null,function(obj){
		   for(var key in obj){
			   var value = obj[key];
			   if(null!=value){
				   $("#"+key).text(value);
			   }
		   }
		},null,false);
   }
   
   //$(function(){});页面加载完成时调用
   $(function(){
	   $("#userSel").change();
	   <c:if test="${!(empty study.auditStatusId || achStatusEnumRollBack.id == study.auditStatusId)}">
	   		$(".toggleView").toggle();
	   </c:if>
	   <c:if test="${study.auditStatusId!=achStatusEnumFirstAudit.id}">
 			$(".searchAuditStatusId").show();
 		</c:if>
 		
 		$("#studyUserFlow").change();
 		$("#userSel").likeSearchInit({
 			clickActive:function(flow){
 				$("#studyUserFlow").val(flow).change();
 			} 
 		});
   });
   
   function submitStudy(){
	   jboxConfirm("是否确认提交？", function() {
		   $("#auditStatusId").val("${achStatusEnumSubmit.id}");
		   $("#auditStatusName").val("${achStatusEnumSubmit.name}");
		   save();  
	   });
   }
   function verifySubmit(id,name){
	   jboxConfirm("是否"+name+"?", function() {
	   url="<s:url value='/fstu/dec/saveStudy'/>?studyFlow=${study.studyFlow}"+"&auditStatusId="+id+"&auditStatusName="+name;
	   jboxPost(url,null,function(obj){
			if(obj=="${GlobalConstant.OPRE_SUCCESSED}"){
				window.parent.document.mainIframe.search();
				jboxClose();
			}
		});
	   });  
   }

	function saveForm(){
		$("#auditStatusId,#auditStatusName").remove();
		save(); 
	}
</script>
</head>
<body>
<div class="mainright">
  <div class="content">
    <div class="title1 clearfix">
    <form id="editForm"  method="post" action="<s:url value='/fstu/dec/edit/'/>">
    	<input type="hidden" name="studyFlow" value="${study.studyFlow }"/>
    	<input id="auditStatusId" type="hidden" name="auditStatusId" value="${study.auditStatusId}"/>
    	<input id="auditStatusName" type="hidden" name="auditStatusName" value="${study.auditStatusName}"/>
    	<input id="studyUserFlow" type="hidden" name="userFlow" value="${study.userFlow}" onchange=" "/>
    <table class="basic" style="width: 100%">
      <tr>
          <th width="16%"><span class="red">*</span>姓名：</th>
           <td style="width: 180px;" >
          		 <label style="display: none;" class="toggleView">${study.userName}</label>
          		 <input id="userSel" class="toggleView validate[required] xltext" type="text" name="userName" value="${study.userName}" autocomplete="off"/>
               	<div style="width: 0px;height: 0px;overflow: visible;">
               		<div id="boxHome" style="max-height: 250px;overflow: auto;border: 1px #ccc solid;background-color: white;min-width: 167px;border-top: none;position: relative;display: none;">
               			<c:forEach items="${userList}" var="user">
               				<p class="item <c:if test="${user.userFlow ==study.userFlow}">selItem</c:if>" flow="${user.userFlow}" value="${user.userName}" style="height: 30px;padding:0;padding-left: 10px;">${user.userName}</p>
               			</c:forEach>
               		</div>
               	</div>
<!--           		<select id="userSel" class="toggleView" name="userFlow" style="width: 165px;" onchange="readUser(this.value);"> -->
<!--   					<option value="">请选择</option> -->
<%--   					<c:forEach items="${userList}" var="user"> --%>
<%--   						 <option value="${user.userFlow}"  <c:if test="${user.userFlow ==study.userFlow}">selected</c:if>>${user.userName}</option>  --%>
<%--   					</c:forEach> --%>
<!--           		</select> -->
          </td> 
         <th width="16%">单位：</th>
         <td style="width: 200px;">
         	<label id="orgName" ></label>
         </td>
         <th width="16%">科室：</th>
         <td >
         	<label id="deptName"></label>
         </td>
       </tr>
      <tr>
      	<th width="16%">职称：</th>
         <td><label id="titleName"></label>
         </td>
         <th width="16%">职务：</th>
         <td>
         	<label id="postName"></label>
         </td>
         <th width="16%">性别：</th>
         <td>
         	<label id="sexName"></label>
         </td>
       </tr>
      <tr>
      	 <th width="16%"><span class="red">*</span>出生日期：</th>
         <td><label id="userBirthday" ></label>
         </td>
         <th width="16%"><span class="red">*</span>进修单位：</th>
         <td >
        	  <input class="validate[required] xltext toggleView" type="text" name="studyOrgName" value="${study.studyOrgName}"/> 
        	  <label style="display: none;" class="toggleView">${study.studyOrgName}</label>
         </td>
         <th width="16%"><span class="red">*</span>进修科目：</th>
         <td style="width: 130px;">
        
        	 <input class="validate[required]  xltext toggleView" type="text" name="studySubject" value="${study.studySubject}"/>
         	 <label style="display: none;" class="toggleView">${study.studySubject}</label>
         </td>
       </tr>
      <tr>
         <th width="16%"><span class="red">*</span>开始时间：</th>
         <td>
        	  <input type="text" name="startDate" value="${study.startDate}" class="validate[required] xltext ctime toggleView" style="width:159px;" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
         	  <label style="display: none;" class="toggleView">${study.startDate}</label>
         </td>
          <th width="16%"><span class="red">*</span>结束时间：</th>
         <td>
        	  <input type="text" name="endDate" value="${study.endDate}" class="validate[required] xltext ctime toggleView" style="width:159px;" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
         	  <label style="display: none;" class="toggleView">${study.endDate}</label>
         </td>
         <th width="16%"><span class="red">*</span>进修月份：</th>
         <td>
        	 <input class="validate[required]  xltext toggleView" type="text" name="studyMonth" value="${study.studyMonth}"/>
        	 <label style="display: none;" class="toggleView">${study.studyMonth}</label>
         </td>
       </tr>
       
      <tr>
         <th width="16%">备注：</th>
         <td colspan="5">
        	  <textarea name="remark" class="toggleView" rows="5" style="width:98%;margin: 8px 0px;">${study.remark}</textarea>
        	  <label style="display: none;" class="toggleView">${study.remark}</label>
         </td>
       </tr>
    </table>
       <p class="button" >
       	<c:if test="${empty study.auditStatusId || achStatusEnumRollBack.id == study.auditStatusId}">
	       <input type="button" value="保&#12288;存" onclick="saveForm();" class="search"/>
       	   <input type="button" value="提&#12288;交" onclick="submitStudy();" class="search"/>
       	 </c:if>
	     <c:if test="${param.roleFlag eq GlobalConstant.USER_LIST_CHARGE}">
		   	<input type="button" style="display: none;" value="审核通过" onclick="verifySubmit('${achStatusEnumFirstAudit.id}','${achStatusEnumFirstAudit.name}');" class="search searchAuditStatusId"/>
		   	<input type="button" style="display: none;" value="审核不通过" onclick="verifySubmit('${achStatusEnumRollBack.id}','${achStatusEnumRollBack.name }');" class="search searchAuditStatusId"/>
		 </c:if>
		  <input type="button" value="关&#12288;闭" onclick="jboxClose();" class="search"/>
	    </p>
	    </form>
      </div>
  </div> 	
</div>

</body>
</html>