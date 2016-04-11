<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>

<c:if test="${param.view != GlobalConstant.FLAG_Y}">
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="ueditor" value="true"/>
</jsp:include>
<script type="text/javascript">
function addApplyUser(tb){
	$('#'+tb).append($('#'+tb+"_model").html());
}
function delTr(tb){
	var trs = $('#'+tb).find(':checkbox:checked');
	if(trs.length==0){
		jboxTip("请勾选要删除的！");
		return false;
	}
	jboxConfirm("确认删除？" , function(){
		$.each(trs , function(i , n){
			$(n).parent('td').parent("tr").remove();
			
		});
		
	});
}
function nextOpt(step){
	if(false==$("#projForm").validationEngine("validate")){
		return false;
	}
	var form = $("#projForm");
	form.append('<input type="hidden" name="nextPageName" value="'+step+'"/>');
	$('#nxt').attr({"disabled":"disabled"});
	$('#prev').attr({"disabled":"disabled"});
	jboxStartLoading();
	form.submit();
}
</script>
</c:if>
<style type="text/css">
.title_sp{padding-left: 10px;font-size: 14px; margin-bottom:10px; font-weight: bold;color: #333;}

</style>


	        	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post"
				id="projForm" style="position: relative;">
					<input type="hidden" id="pageName" name="pageName" value="step4"/>
					<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
	                <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
					<input type="hidden" name="recTypeId" value="${param.recTypeId}"/>
					<div class="title_sp">四、项目实施人员情况</div>
			        	<!-- 项目负责人开始 -->
			        	<table class="bs_tb" width="100%">
			        		<tr>
								<th colspan="8" class="theader">项目负责人<c:if test="${param.view != GlobalConstant.FLAG_Y}"><span style="float: right;padding-right: 10px"><img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addApplyUser('projMainPeopTb');"></img>&nbsp;<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('projMainPeopTb');"></img></span></c:if></th>
							</tr>
			          		<tr>
								<td width="5%">序号</td>
							    <td width="10%">姓名</td>
							    <td width="8%">性别</td>
							    <td width="15%">出生日期</td>
							    <td width="15%">职务/职称</td>
							    <td width="15%">业务专业</td>
							    <td width="15%">为本项目工作时间（月/年）</td>
							    <td width="17%">所在单位</td>
			           		</tr>
			           		<tbody id="projMainPeopTb">
			           		<c:if test="${! empty resultMap.projMainPeop}">
			           		  <c:choose>
			           		    <c:when test="${param.view == GlobalConstant.FLAG_Y}">
			           		        <c:forEach var="mainPeop" items="${resultMap.projMainPeop}" varStatus="num">
			           		           <tr>
								        <!-- 复选框 -->
								           <td>
								             ${num.count}
								           </td>
								         <!-- 姓名 -->    
								           <td>
								           ${mainPeop.objMap.projMainPeop_name}
								           </td>
								          <!-- 性别 -->   
								           <td>
											     <c:forEach items="${userSexEnumList }" var="sex">
											     	<c:if test="${ sex.id != userSexEnumUnknown.id}">
											       	  <c:if test='${mainPeop.objMap.projMainPeop_sex eq sex.id}'>${sex.name}</c:if>
											     	</c:if>
											     </c:forEach>
								           </td>
								          <!-- 出生日期 --> 
								           <td>
								              ${mainPeop.objMap.projMainPeop_birthday}
								           </td>
								           <!-- 职务职称 --> 
								           <td>
								              ${mainPeop.objMap.projMainPeop_postAndTitle}
								           <!-- 业务专业 --> 
								           <td>
								              ${mainPeop.objMap.projMainPeop_major}
								           </td>
								          <!-- 工作时间 -->
								           <td>
								              ${mainPeop.objMap.projMainPeop_workTime}
								           </td>
								            <!-- 所在单位 -->  
								         <td>
								             ${mainPeop.objMap.projMainPeop_workOrg}
								         </td>
								        </tr>
			           		        </c:forEach>
			           		    </c:when>
			           		    <c:otherwise>
							    	<c:forEach var="mainPeop" items="${resultMap.projMainPeop}" varStatus="num">
								        <tr>
								        <!-- 复选框 -->
								           <td><input type="checkbox"/></td>
								         <!-- 姓名 -->    
								           <td><input name="projMainPeop_name" value="${mainPeop.objMap.projMainPeop_name}" class="inputText validate[required]" style="width:80%;"/></td>
								          <!-- 性别 -->   
								           <td>
								              <select name="projMainPeop_sex" style="width:95%;" class="validate[required]">
								               <option value="">请选择</option>
											     <c:forEach items="${userSexEnumList }" var="sex">
											     	<c:if test="${ sex.id != userSexEnumUnknown.id}">
											       	  <option value="${sex.id }" <c:if test='${mainPeop.objMap.projMainPeop_sex eq sex.id}'>selected="selected"</c:if>>${sex.name }</option>     
											     	</c:if>
											     </c:forEach>
											</select>		
								           </td>
								          <!-- 出生日期 --> 
								           <td><input name="projMainPeop_birthday" value="${mainPeop.objMap.projMainPeop_birthday}" style="width:80%;" class="inputText validate[required]" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/></td>
								           <!-- 职务职称 --> 
								           <td><input name="projMainPeop_postAndTitle" value="${mainPeop.objMap.projMainPeop_postAndTitle}" class='inputText validate[required]' style="width:80%;" /></td>
								           <!-- 业务专业 --> 
								           <td>
								               <input name="projMainPeop_major" value="${mainPeop.objMap.projMainPeop_major}" class="inputText validate[required]" style="width:80%;"  />	
								           </td>
								          <!-- 工作时间 -->
								           <td>
								             <input name="projMainPeop_workTime" value="${mainPeop.objMap.projMainPeop_workTime}" class="inputText validate[required]" style="width:80%;"  />
								           </td>
								            <!-- 所在单位 -->  
								         <td><input name="projMainPeop_workOrg" value="${mainPeop.objMap.projMainPeop_workOrg}" class="inputText validate[required]" style='width:84%;'/></td>
								        </tr>
								      </c:forEach>
								       </c:otherwise>
								       </c:choose>
								  </c:if>
								
								  <!-- 项目基本信息里填写的主要负责人 -->
								  <c:if test="${empty resultMap.projMainPeop and param.view != GlobalConstant.FLAG_Y}">
								  	<c:forEach items="${projInfoMap.projMainPeop}" var="mainPeop">
								  		<c:set var="curr" value='${mainPeop.objMap}'></c:set>
								        <tr>
								        <!-- 复选框 -->
								           <td><input type="checkbox"/></td>
								         <!-- 姓名 -->    
								           <td><input name="projMainPeop_name" class="inputText validate[required]" style="width:80%;" value="${curr.projMainPeop_name}"/></td>
								          <!-- 性别 -->   
								           <td>
								              <select name="projMainPeop_sex" style="width:95%;" class="validate[required]">
								               <option value="">请选择</option>
											     <c:forEach items="${userSexEnumList }" var="sex">
											     	<c:if test="${ sex.id != userSexEnumUnknown.id}">
												       <option value="${sex.id }" <c:if test='${curr.projMainPeop_sex eq sex.id}'>selected="selected"</c:if>>${sex.name }</option>     
											     	</c:if>
											     </c:forEach>
											</select>		
								           </td>
								          <!-- 出生日期 --> 
								           <td><input name="projMainPeop_birthday" value="${curr.projMainPeop_birthday}" style="width:80%;" class="inputText validate[required]" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/></td>
								           <!-- 职务职称 --> 
								           <td><input name="projMainPeop_postAndTitle" class="inputText validate[required]" style="width:80%;" /></td>
								           <!-- 业务专业 --> 
								           <td>
								               <input name="projMainPeop_major" class="inputText validate[required]" style="width:80%;"/>	
								           </td>
								          <!-- 工作时间 -->
								           <td>
								             <input name="projMainPeop_workTime" class="inputText validate[required]" style="width:80%;" value="${curr.projMainPeop_workTime}"/>
								           </td>
								            <!-- 所在单位 -->  
								         <td><input name="projMainPeop_workOrg" class="inputText validate[required]" style="width:84%;" value="${curr.projMainPeop_workOrg}"/></td>
								        </tr>
								        </c:forEach>
								  </c:if>
							</tbody>
      					</table> 
      					<!-- 项目负责人结束 -->
      					<!-- 主要参加人员开始 -->
      					<table class="bs_tb" style="margin-top: 10px;" width="100%">
      						<tr>
								<th colspan="8" class="theader">主要参加人员<c:if test="${param.view != GlobalConstant.FLAG_Y}"><span style="float: right;padding-right: 10px"><img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addApplyUser('projPeopTb');"></img>&nbsp;<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('projPeopTb');"></img></span></c:if></th>
							</tr>
			          		<tr>
								<td width="5%">序号</td>
							    <td width="10%">姓名</td>
							    <td width="8%">性别</td>
							    <td width="15%">出生日期</td>
							    <td width="15%">职务/职称</td>
							    <td width="15%">业务专业</td>
							    <td width="15%">为本项目工作时间（月/年）</td>
							    <td width="17%">所在单位</td>
			           		</tr>
			           		<tbody id="projPeopTb">
			           			<c:if test="${! empty resultMap.projPeop}">
			           			  <c:choose>
			           		       <c:when test="${param.view == GlobalConstant.FLAG_Y}">
			           		         <c:forEach var="mainPeop" items="${resultMap.projPeop}" varStatus="num">
								        <tr>
								        <!-- 复选框 -->
								           <td>
								             ${num.count }
								           </td>
								         <!-- 姓名 -->    
								           <td>
								             ${mainPeop.objMap.projPeop_name}
								           </td>
								          <!-- 性别 -->   
								           <td>
											     <c:forEach items="${userSexEnumList }" var="sex">
											     	<c:if test="${ sex.id != userSexEnumUnknown.id}">
											         <c:if test='${mainPeop.objMap.projPeop_sex eq sex.id}'>${sex.name}</c:if> 
											     	</c:if>
											     </c:forEach>
								           </td>
								          <!-- 出生日期 --> 
								           <td>
								             ${mainPeop.objMap.projPeop_birthday}
								           </td>
								           <!-- 职务职称 --> 
								           <td>
								             ${mainPeop.objMap.projPeop_postAndTitle}
								           </td>
								           <!-- 业务专业 --> 
								           <td>
								             ${mainPeop.objMap.projPeop_major}	
								           </td>
								          <!-- 工作时间 -->
								           <td>
								             ${mainPeop.objMap.projPeop_workTime}
								           </td>
								            <!-- 所在单位 -->  
								         <td>
								             ${mainPeop.objMap.projPeop_workOrg}
								           </td>
								        </tr>
								      </c:forEach>
			           		       </c:when>
			           		       <c:otherwise>
							    	<c:forEach var="mainPeop" items="${resultMap.projPeop}" varStatus="num">
								        <tr>
								        <!-- 复选框 -->
								           <td><input type="checkbox"/></td>
								         <!-- 姓名 -->    
								           <td><input name="projPeop_name" value="${mainPeop.objMap.projPeop_name}" class="inputText validate[required]" style="width:80%;"/></td>
								          <!-- 性别 -->   
								           <td>
								              <select name="projPeop_sex" style="width:95%;" class="validate[required]">
								               <option value="">请选择</option>
											     <c:forEach items="${userSexEnumList }" var="sex">
											     	<c:if test="${sex.id != userSexEnumUnknown.id}">
											         <option value="${sex.id }" <c:if test='${mainPeop.objMap.projPeop_sex eq sex.id}'>selected="selected"</c:if>>${sex.name }</option>     
											     	</c:if>
											     </c:forEach>
											</select>		
								           </td>
								          <!-- 出生日期 --> 
								           <td><input name="projPeop_birthday" value="${mainPeop.objMap.projPeop_birthday}" style="width:80%;" class="inputText validate[required]" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/></td>
								           <!-- 职务职称 --> 
								           <td><input name="projPeop_postAndTitle" value="${mainPeop.objMap.projPeop_postAndTitle}" class="inputText validate[required]" style="width:80%;"/></td>
								           <!-- 业务专业 --> 
								           <td>
								               <input name="projPeop_major" value="${mainPeop.objMap.projPeop_major}" class="inputText validate[required]" style="width:80%;"  />	
								           </td>
								          <!-- 工作时间 -->
								           <td>
								             <input name="projPeop_workTime" value="${mainPeop.objMap.projPeop_workTime}" class="inputText validate[required]" style="width:80%;"  />
								           </td>
								            <!-- 所在单位 -->  
								         <td><input name="projPeop_workOrg" value="${mainPeop.objMap.projPeop_workOrg}" class="inputText validate[required]" style='width:84%;'/></td>
								        </tr>
								      </c:forEach>
								      </c:otherwise>
								      </c:choose>
								  </c:if>
								  <!-- 默认一条 -->
								  <c:if test="${empty resultMap.projPeop and param.view != GlobalConstant.FLAG_Y}">
								        <tr>
								        <!-- 复选框 -->
								           <td><input type="checkbox"/></td>
								         <!-- 姓名 -->    
								           <td><input name="projPeop_name" class="inputText validate[required]" style="width:80%;"/></td>
								          <!-- 性别 -->   
								           <td>
								              <select name="projPeop_sex" style="width:95%;" class="validate[required]">
								               <option value="">请选择</option>
											     <c:forEach items="${userSexEnumList }" var="sex">
											     	<c:if test="${ sex.id != userSexEnumUnknown.id}">
											        <option value="${sex.id }">${sex.name }</option>     
											       </c:if>
											     </c:forEach>
											</select>		
								           </td>
								          <!-- 出生日期 --> 
								           <td><input name="projPeop_birthday" style="width:80%;  " class="inputText validate[required]" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/></td>
								           <!-- 职务职称 --> 
								           <td><input name="projPeop_postAndTitle" class="inputText validate[required]" style="width:80%;"/></td>
								           <!-- 业务专业 --> 
								           <td>
								               <input name="projPeop_major" class="inputText validate[required]" style="width:80%;"/>	
								           </td>
								          <!-- 工作时间 -->
								           <td>
								             <input name="projPeop_workTime" class="inputText validate[required]" style="width:80%;"/>
								           </td>
								            <!-- 所在单位 -->  
								         <td><input name="projPeop_workOrg" class="inputText validate[required]" style="width:84%;"/></td>
								        </tr>
								  </c:if>
							</tbody>
      					</table>
      					<!-- 主要参加人员结束 -->
      					<c:if test="${param.view != GlobalConstant.FLAG_Y}">
      					<div align="center" style="margin-top: 10px; width: 100%">
      					 <input id="prev" type="button" onclick="nextOpt('step3')" class="search" value="上一步"/>
        	             <input id="nxt" type="button" onclick="nextOpt('step5')" class="search" value="下一步"/>
			        	</div>
			        	</c:if>
				</form>
				<div style="display: none;width: 100%;">
					<table class="bs_tb" width="100%">
						<tbody id="projMainPeopTb_model">
							 <tr>
					        <!-- 复选框 -->
					           <td><input type="checkbox"/></td>
					         <!-- 姓名 -->    
					           <td><input name="projMainPeop_name" class='validate[required] inputText' style="width:80%;"/></td>
					          <!-- 性别 -->   
					           <td>
					              <select name="projMainPeop_sex" class="validate[required]" style="width:95%;">
								     <option value="">请选择</option>
								     <c:forEach items="${userSexEnumList }" var="sex">
								     	<c:if test="${ sex.id != userSexEnumUnknown.id}">
								        <option value="${sex.id }">${sex.name }</option>     
								       </c:if>
								     </c:forEach>
								</select>		
					           </td>
					          <!-- 出生日期 --> 
					           <td><input name="projMainPeop_birthday" style="width:80%;margin: 0px" class="validate[required] inputText" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/></td>
					           <td><input name="projMainPeop_postAndTitle" class='inputText validate[required]' style="width:80%;"/></td>
					           <!-- 业务专业 --> 
					           <td>
					               <input name="projMainPeop_major" class='inputText validate[required]' style="width:80%;"/>	
					           </td>
					          <!-- 工作时间 -->
					           <td>
					             <input name="projMainPeop_workTime" class='inputText validate[required]' style="width:80%;"/>
					           </td>
					            <!-- 所在单位 -->  
					         <td><input name="projMainPeop_workOrg" class='inputText validate[required]' style="width:84%;"/></td>
					        </tr>
						</tbody>
					</table>
	
					<table class="bs_tb" width="100%">
						<tbody id="projPeopTb_model">
							<tr>
					        <!-- 复选框 -->
					           <td><input type="checkbox"/></td>
					         <!-- 姓名 -->    
					           <td><input name="projPeop_name" class='inputText validate[required]' style="width:80%;"/></td>
					          <!-- 性别 -->   
					           <td>
					              <select name="projPeop_sex" style="width:95%;" class="validate[required]">
					               <option value="">请选择</option>
								     <c:forEach items="${userSexEnumList }" var="sex">
								     	<c:if test="${ sex.id != userSexEnumUnknown.id}">
								        <option value="${sex.id }">${sex.name }</option>     
								       </c:if>
								     </c:forEach>
								</select>		
					           </td>
					          <!-- 出生日期 --> 
					           <td><input name="projPeop_birthday" style="width:80%;margin: 0px" class="inputText validate[required]" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/></td>
					           <td><input name="projPeop_postAndTitle" class='inputText validate[required]' style="width:80%;"/></td>
					           <!-- 业务专业 --> 
					           <td>
					               <input name="projPeop_major" class='inputText validate[required]' style="width:80%;"/>	
					           </td>
					          <!-- 工作时间 -->
					           <td>
					             <input name="projPeop_workTime" class='inputText validate[required]' style="width:80%;"/>
					           </td>
					            <!-- 所在单位 -->  
					         <td><input name="projPeop_workOrg" class='inputText validate[required]' style="width:84%;"/></td>
					        </tr>
						</tbody>
					</table>
				</div>