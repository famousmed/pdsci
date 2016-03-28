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
$(document).ready(function(){
	var type='${param.type}';
	var parentRamDiv=window.parent.frames['mainIframe'].$("#"+type+"UserRam");
	var parentRomDiv=window.parent.frames['mainIframe'].$("#"+type+"UserRom");
	var allCheckedUser=$(parentRomDiv).children();
	var nowCheckedUser=$(parentRamDiv).children();
	var pageUsers=$("#nowUserTb").find("input[name='userFlow']");
    //判断页面是否首次加载
	var readyFlag=$("#readyFlag");
    if(readyFlag.val()==""){
    	//把rom中的所有数据同步到ram中
    	var ramUserFlag;
    	$.each(allCheckedUser,function(i,n){
    		ramUserFlag=false;
    		$.each(nowCheckedUser,function(o,m){
    		   if($(n).attr("id")==$(m).attr("id")){
    			   ramUserFlag=true;
    		   }
    		});
    		if(ramUserFlag==false){
    			$(parentRamDiv).append($(n).clone());
    		}
    	});
    	readyFlag.val("N");
    }
	//把对应rom中的人员与当前列表比较，相符打钩
	$.each(pageUsers,function(i,n){
		$.each(allCheckedUser,function(o,m){
			if($(n).attr("id")==$(m).attr("id")){
				$(n).attr("checked","checked");
			}
		});
	});
	//把对应ram中的人员与当前列表比较，相符打钩
	$.each(pageUsers,function(i,n){
		$.each(nowCheckedUser,function(o,m){
			if($(n).attr("id")==$(m).attr("id")){
				$(n).attr("checked","checked");
			}
		});
	});
	decidePageCheck();
});
//如果当前页面所有人员都被选中，则全选框也被选中，反之同理
function decidePageCheck(){
	var checkAll=$("#checkAll");
	var pageUsers=$("#nowUserTb").find("input[name='userFlow']");
	if(pageUsers.length>0){
		var allCheckFlag=true;
		$.each(pageUsers,function(i,n){
			if($(n).attr("checked")!="checked"){
				allCheckFlag=false;
			}
		});
		if(allCheckFlag==true){
			checkAll.attr("checked",true);
		}
	}
}
function toPage(page){
	var form = $("#searchForm");
	$("#currentPage").val(page);
	form.submit();
}
function searchUser(){
	$("#searchForm").submit();
}
function deleteFromRam(){
	var type='${param.type}';
	var parentRamDiv=window.parent.frames['mainIframe'].$("#"+type+"UserRam");
	$(parentRamDiv).html("");
	jboxClose();
}
//勾选人员保存并展现在父页面
function copyToRom(){
	var type='${param.type}';
	var parentRamDiv=window.parent.frames['mainIframe'].$("#"+type+"UserRam");
	var parentRomDiv=window.parent.frames['mainIframe'].$("#"+type+"UserRom");
	var parentUserCount=window.parent.frames['mainIframe'].$("#"+type+"UserCount");
	ramToRom($(parentRamDiv),$(parentRomDiv));
	parentUserCount.html('<font color="red"> '+$(parentRomDiv).children().length+' </font>');
	$(parentRamDiv).html("");
	jboxClose();
}
//把源区域子节点移动到目标区域
function ramToRom(sourceObj,goalObj){
     $(goalObj).html($(sourceObj).html());    	
}
//及时保存勾选人员
function putUsertoParentRam(obj){
	var type='${param.type}';
	var parentRamDiv=window.parent.frames['mainIframe'].$("#"+type+"UserRam");
	var ramUserFlows=$(parentRamDiv).children();
	var thisFlag=false;
	$.each(ramUserFlows,function(i,n){
		if($(n).attr("id")==$(obj).attr("id")){
			thisFlag=true;
			if($(obj).attr("checked")!="checked"){
				$(n).remove();
			}
		}
	  });
	 if(thisFlag==false){
		 if($(obj).attr("checked")=="checked"){
		   var userInput="<input type='text' id='"+$(obj).attr('id')+"' name='"+type+"UserFlow' value='"+$(obj).attr('id')+"'/>";
		   $(parentRamDiv).append(userInput);
		 }
	 }
	 decidePageCheck();
}

function checkAll(obj){
	var userTrs=$(".userCheck");
	$.each(userTrs,function(i,n){
		if (obj.checked) {
			$(n).attr("checked",true);
		} else {
			$(n).attr("checked",false);
		}
		putUsertoParentRam($(n));
	});
}

function checkUser(obj){
	var type='${param.type}';
	var userDiv=$("#userDiv");
	var parentRamDiv=window.parent.frames['mainIframe'].$("#"+type+"UserRam");
	ramToRom($(parentRamDiv),$(userDiv));
	if($(userDiv).children().length<=0){
		jboxTip("您还没有选择人员！");
	    $(obj).attr("checked",false);
	}else{
	  if($(obj).attr("checked")=="checked"){
		$(obj).val("Y");
	  }else{
		$(obj).val("N");
		$(userDiv).html("");
	  }
		searchUser();
	}
	
}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
		<div style="padding-bottom: 10px;" >
			<form id="searchForm" 
			<c:if test="${param.show!='Y' }">action="<s:url value="/resedu/manage/course/searchUser?type=${param.type }"/>"</c:if>
			<c:if test="${param.show=='Y' }">action="<s:url value="/resedu/manage/course/searchUserInfo?type=${param.type }&show=Y&courseFlow=${param.courseFlow}"/>"</c:if>
			 method="post">
					<input type="hidden" id="readyFlag" name="readyFlag" value="${param.readyFlag }"/>
					<div>
					轮转科室：<select id="schDeptFlow" name="schDeptFlow" class="xlselect" style="width: 120px;">
		            	<option value="">请选择</option>
		            	<c:forEach items="${schDeptList }" var="schDept">
		            	    <option value="${schDept.schDeptFlow }" <c:if test="${param.schDeptFlow eq schDept.schDeptFlow }">selected</c:if>>${schDept.schDeptName }</option>
		            	</c:forEach>
		            </select>
		                                    医院科室：<select id="deptFlow" name="deptFlow" class="xlselect" style="width: 120px;">
		            	<option value="">请选择</option>
		            	<c:forEach items="${sysDeptList }" var="sysDept">
		            	    <option value="${sysDept.deptFlow }" <c:if test="${param.deptFlow eq sysDept.deptFlow }">selected</c:if>>${sysDept.deptName }</option>
		            	</c:forEach>
		            </select>
		            </div>
		            <div style="margin-top: 10px;">
			 		姓&#12288;&#12288;名：<input type="text" name="userName" value="${param.userName}"  class="xltext" style="width: 112px;"/>	
			 		工&#12288;&#12288;号：<input type="text" name="doctorCode" value="${param.doctorCode}"  class="xltext" style="width: 112px;"/>
			     	<c:if test="${param.show!='Y' }">
			     	   <input type="checkbox"  id="searchCheckUser" name="checkFlag"  title="查看已选择人员" onclick="checkUser(this);"<c:if test="${param.checkFlag=='Y' }">checked</c:if>/>
			     	   <label for="searchCheckUser">查看已选择人员</label>
			     	   <div id="userDiv" style="display: none;"></div>
			     	</c:if>
			     	<input type="button" class="search" onclick="searchUser();" value="查&#12288;询">
			        <input id="currentPage" type="hidden" name="currentPage" value=""/> 
			        </div>
			</form>
		</div>
		<table class="xllist" > 
			<tr>
				<th width="5%">
				 <c:if test="${param.show!='Y' }">
				  <input type="checkbox" value="" id="checkAll" title="全选" onclick="checkAll(this);"/>
				 </c:if>
				 <c:if test="${param.show=='Y' }">序号</c:if>  
				</th>
				<th width="15%">姓名</th>
				<th width="10%">工号</th>
				<th width="15%">医院科室</th>
				<th width="15%">职称</th>
				<th width="20%">培训专业</th>
				<th width="15%">轮转科室</th>
				<th width="15%">人员类型</th>
			</tr>
			<tbody id="nowUserTb">
			<c:forEach items="${sysUserResDoctorExtList }" var="resDoctorExt" varStatus="num">
			<tr class="userTr">
			   <td>
			   <c:if test="${param.show!='Y' }">
			   <input class="userCheck" type="checkbox" name="userFlow" id="${resDoctorExt.userFlow }"  value="${resDoctorExt.userFlow }" onclick="putUsertoParentRam(this)"/>
			   </c:if>
			   <c:if test="${param.show=='Y' }">
			   ${num.count }
			   </c:if>
			   </td>
			   <td>${resDoctorExt.userName }</td>
			   <td>${resDoctorExt.doctor.doctorCode }</td>
			   <td>${resDoctorExt.deptName }</td>
			   <td>${resDoctorExt.titleName }</td>
			   <td>${resDoctorExt.doctor.trainingSpeName }</td>
			   <td>${resDoctorExt.resDoctorSchProcessList[0].schDeptName }</td>
			   <td>${resDoctorExt.doctor.doctorCategoryName }</td>
			</tr>
			</c:forEach>
			</tbody>
	</table>
	     <%-- <c:set var="pageView" value="${pdfn:getPageView(sysUserResDoctorExtList)}" scope="request"></c:set>
	     <pd:pagination toPage="toPage"/> --%>
	<p align="center" style="width:100%">
	   <c:if test="${param.show!='Y' }">
		<input class="search" type="button" value="确&#12288;定"  onclick="copyToRom();" />
	   </c:if>	
		<input class="search" type="button" value="关&#12288;闭"  onclick="deleteFromRam();" />
	</p>
	</div>
	</div>
</div>

</body>
</html>