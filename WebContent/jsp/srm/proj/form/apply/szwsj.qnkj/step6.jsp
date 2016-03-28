<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<c:if test="${param.view != GlobalConstant.FLAG_Y}">
<script type="text/javascript">
function nextOpt(step){
	if(false==$("#projForm").validationEngine("validate")){
		return false;
	}
	var form = $('#projForm');
	form.append('<input type="hidden" name="nextPageName" value="'+step+'"/>');
	$('#nxt').attr({"disabled":"disabled"});
	$('#prev').attr({"disabled":"disabled"});
	jboxStartLoading();
	form.submit();
}

function add(tb){
 	$("#"+tb+"Tb").append($("#"+tb+"Template tr:eq(0)").clone());
 	
 	var length = $("#"+tb+"Tb").children().length;
 	//序号
	$("#"+tb+"Tb").children("tr").last().children("td").eq(1).text(length);
}


function delTr(tb){
	//alert("input[name="+tb+"Ids]:checked");
	var checkboxs = $("input[name='"+tb+"Ids']:checked");
	if(checkboxs.length==0){
		jboxTip("请勾选要删除的！");
		return false;
	}
	jboxConfirm("确认删除?",function () {
		var trs = $('#'+tb+'Tb').find(':checkbox:checked');
		$.each(trs , function(i , n){
			$(n).parent('td').parent("tr").remove();
		});
		//删除后序号
		var serial = 0;
		$("."+tb+"Serial").each(function(){
			serial += 1;
			$(this).text(serial);
		});
	});
}
</script>
</c:if>

 	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post"
		id="projForm" style="position: relative;">
		<input type="hidden" id="pageName" name="pageName" value="step6"/>
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
        <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" name="recTypeId" value="${param.recTypeId}"/>
		
		<font style="font-size: 14px; font-weight:bold;color: #333; ">七、项目主要研究人员</font>  
       	<table class="bs_tb" style="width: 100%; margin-top: 10px;">
			<tr>
		   		<th colspan="10" style="text-align: left;padding-left: 15px;" class="theader">课题负责人
		   			<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
		   			<span style="float: right;padding-right: 10px">
		   				<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('projMainPeop');"></img>
	   					<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('projMainPeop');"></img>
		   			</span> 
		   			</c:if>
		   		</th>
	   		</tr>
			<tr>	
				<td style="text-align: center;" width="5%"></td>
				<td style="text-align: center;" width="5%">序号</td>
				<td style="text-align: center;" width="10%">姓名</td>
				<td style="text-align: center;" width="10%">性别</td>
				<td style="text-align: center;" width="5%">年龄</td>
				<td style="text-align: center;" width="10%">职务职称</td>
				<td style="text-align: center;" width="10%">业务专业</td>
				<td style="text-align: center;" width="10%">为本项目工作时间（月/年）</td>
				<td style="text-align: center;" width="15%">所在单位</td>
				<td style="text-align: center;" >项目分工</td>
			</tr>
			
   			<tbody id="projMainPeopTb">
   			    <c:choose>
   			        <c:when test="${param.view == GlobalConstant.FLAG_Y}">
   			        <c:forEach var="projMainPeop" items="${resultMap.projMainPeop}" varStatus="status">
			        <tr>
			        	<td style="text-align: center;"><input name="projMainPeopIds" type="checkbox"/></td>
	            		<td style="text-align: center;" class="projMainPeopSerial">${status.count}</td>
						<td style="text-align: center;">${projMainPeop.objMap.projMainPeop_name}</td>
						<td style="text-align: center;">
			                   <c:forEach var="sex" items="${userSexEnumList}">
			                   		<c:if test="${sex.id != userSexEnumUnknown.id}">
			                   			<c:if test="${projMainPeop.objMap.projMainPeop_sex eq sex.id}">${sex.name}</c:if>
			                   		</c:if>	 
			                   </c:forEach>
		           		</td>
						<td style="text-align: center;">${projMainPeop.objMap.projMainPeop_age}</td>
						<td style="text-align: center;">${projMainPeop.objMap.projMainPeop_jobTitle}</td>
						<td style="text-align: center;">${projMainPeop.objMap.projMainPeop_major}</td>
						<td style="text-align: center;">${projMainPeop.objMap.projMainPeop_workTime}</td>
						<td style="text-align: center;" width="400px">${projMainPeop.objMap.projMainPeop_workOrg}</td>
						<td >${projMainPeop.objMap.projMainPeop_division}</td>
			        </tr>
			        </c:forEach>
   			        </c:when>
   			        <c:otherwise>
   			            <c:if test="${empty resultMap.projMainPeop}">
		   			     <tr>
					        	<td style="text-align: center;"><input name="projMainPeopIds" type="checkbox"/></td>
			            		<td style="text-align: center;" class="projMainPeopSerial">1</td>
								<td style="text-align: center;"><input type="text" name="projMainPeop_name"  class="inputText validate[required]"  value="${user.userName }" style="width: 80%;"/></td>
								<td style="text-align: center;">
					                <select name="projMainPeop_sex" class="inputText validate[required]">
					                   <option value="">请选择</option>
					                   <c:forEach var="sex" items="${userSexEnumList}">
					                   		<c:if test="${sex.id != userSexEnumUnknown.id}">
					                   			<option value="${sex.id}" <c:if test="${user.sexId eq sex.id}">selected="selected"</c:if>>${sex.name}</option>
					                   		</c:if>	 
					                   </c:forEach>
					                </select>
				           		</td>
								<td style="text-align: center;"><input type="text" name="projMainPeop_age"  class="validate[custom[integer]] inputText" style="width: 80%;" value="${pdfn:calculateAge(user.userBirthday) }"/></td>
								<td style="text-align: center;"><input type="text" name="projMainPeop_jobTitle"  class="inputText validate[required]" style="width: 80%;" value="${user.titleName }"/></td>
								<td style="text-align: center;"><input type="text" name="projMainPeop_major"  class="inputText" style="width: 80%;" /></td>
								<td style="text-align: center;"><input type="text" name="projMainPeop_workTime"  class="inputText validate[required]" style="width: 80%;"/></td>
								<td style="text-align: center;"><input type="text" name="projMainPeop_workOrg"  class="inputText validate[required]" style="width: 80%;" value="${user.orgName }"/></td>
								<td style="text-align: center;"><input type="text" name="projMainPeop_division"  class="inputText" style="width: 80%;"/></td>
					        </tr>
		   			  </c:if>
		   			  <c:if test="${! empty resultMap.projMainPeop}">
						<c:forEach var="projMainPeop" items="${resultMap.projMainPeop}" varStatus="status">
					        <tr>
					        	<td style="text-align: center;"><input name="projMainPeopIds" type="checkbox"/></td>
			            		<td style="text-align: center;" class="projMainPeopSerial">${status.count}</td>
								<td style="text-align: center;"><input type="text" name="projMainPeop_name" value="${projMainPeop.objMap.projMainPeop_name}" class="inputText validate[required]" style="width: 80%;"/></td>
								<td style="text-align: center;">
					                <select name="projMainPeop_sex" class="inputText validate[required]">
					                   <option value="">请选择</option>
					                   <c:forEach var="sex" items="${userSexEnumList}">
					                   		<c:if test="${sex.id != userSexEnumUnknown.id}">
					                   			<option value="${sex.id}" <c:if test="${projMainPeop.objMap.projMainPeop_sex eq sex.id}">selected="selected"</c:if>>${sex.name}</option>
					                   		</c:if>	 
					                   </c:forEach>
					                </select>
				           		</td>
								<td style="text-align: center;"><input type="text" name="projMainPeop_age" value="${projMainPeop.objMap.projMainPeop_age}" class="validate[custom[integer]] inputText" style="width: 80%;"/></td>
								<td style="text-align: center;"><input type="text" name="projMainPeop_jobTitle" value="${projMainPeop.objMap.projMainPeop_jobTitle}" class="inputText validate[required]" style="width: 80%;"/></td>
								<td style="text-align: center;"><input type="text" name="projMainPeop_major" value="${projMainPeop.objMap.projMainPeop_major}" class="inputText" style="width: 80%;"/></td>
								<td style="text-align: center;"><input type="text" name="projMainPeop_workTime" value="${projMainPeop.objMap.projMainPeop_workTime}" class="inputText validate[required]" style="width: 80%;"/></td>
								<td style="text-align: center;"><input type="text" name="projMainPeop_workOrg" value="${projMainPeop.objMap.projMainPeop_workOrg}" class="inputText validate[required]" style="width: 80%;"/></td>
								<td style="text-align: center;"><input type="text" name="projMainPeop_division" value="${projMainPeop.objMap.projMainPeop_division}" class="inputText" style="width: 80%;"/></td>
					        </tr>
					    </c:forEach>
					</c:if>
   			        </c:otherwise>
   			    </c:choose>
   			</tbody>
		</table>
		
       	<table class="bs_tb" style="width: 100%; margin-top: 10px;">
			<tr>
		   		<th colspan="10" style="text-align: left;padding-left: 15px;" class="theader">主要研究人员
		   			<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
		   			<span style="float: right;padding-right: 10px">
		   				<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('projPeop');"></img>
	   					<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('projPeop');"></img>
		   			</span> 
		   			</c:if>
		   		</th>
	   		</tr>
	   		<tr>	
				<td style="text-align: center;" width="5%"></td>
				<td style="text-align: center;" width="5%">序号</td>
				<td style="text-align: center;" width="10%">姓名</td>
				<td style="text-align: center;" width="10%">性别</td>
				<td style="text-align: center;" width="5%">年龄</td>
				<td style="text-align: center;" width="10%">职务职称</td>
				<td style="text-align: center;" width="10%">业务专业</td>
				<td style="text-align: center;" width="10%">为本项目工作时间（月/年）</td>
				<td style="text-align: center;" width="15%">所在单位</td>
				<td style="text-align: center;" >项目分工</td>
			</tr>
   			<tbody id="projPeopTb">
   			    <c:choose>
   			        <c:when test="${param.view == GlobalConstant.FLAG_Y}">
   			            <c:forEach var="projPeop" items="${resultMap.projPeop}" varStatus="status">
					        <tr>
					        	<td style="text-align: center;"><input name="projPeopIds" type="checkbox"/></td>
			            		<td style="text-align: center;" class="projPeopSerial">${status.count}</td>
								<td style="text-align: center;">${projPeop.objMap.projPeop_name}</td>
								<td style="text-align: center;">
					                   <c:forEach var="sex" items="${userSexEnumList}">
					                   		<c:if test="${sex.id != userSexEnumUnknown.id}">
					                   			<c:if test="${projPeop.objMap.projPeop_sex eq sex.id}">${sex.name}</c:if>
					                   		</c:if>	 
					                   </c:forEach>
				           		</td>
								<td style="text-align: center;">${projPeop.objMap.projPeop_age}</td>
								<td style="text-align: center;">${projPeop.objMap.projPeop_jobTitle}</td>
								<td style="text-align: center;">${projPeop.objMap.projPeop_major}</td>
								<td style="text-align: center;">${projPeop.objMap.projPeop_workTime}</td>
								<td style="text-align: center;">${projPeop.objMap.projPeop_workOrg}</td>
								<td width="400px;">${projPeop.objMap.projPeop_division}</td>
					        </tr>
					    </c:forEach>
   			        </c:when>
   			        <c:otherwise>
   			            <c:if test="${empty resultMap.projPeop}">
		   			        <tr>
					        	<td style="text-align: center;"><input name="projPeopIds" type="checkbox"/></td>
			            		<td style="text-align: center;" class="projPeopSerial">1</td>
								<td style="text-align: center;"><input type="text" name="projPeop_name"  class="inputText validate[required]" style="width: 80%;"/></td>
								<td style="text-align: center;">
					                <select name="projPeop_sex" class="inputText validate[required]">
					                   <option value="">请选择</option>
					                   <c:forEach var="sex" items="${userSexEnumList}">
					                   		<c:if test="${sex.id != userSexEnumUnknown.id}">
					                   			<option value="${sex.id}" >${sex.name}</option>
					                   		</c:if>	 
					                   </c:forEach>
					                </select>
				           		</td>
								<td style="text-align: center;"><input type="text" name="projPeop_age"  class="validate[custom[integer]] inputText" style="width: 80%;"/></td>
								<td style="text-align: center;"><input type="text" name="projPeop_jobTitle"  class="inputText validate[required]" style="width: 80%;"/></td>
								<td style="text-align: center;"><input type="text" name="projPeop_major"  class="inputText" style="width: 80%;"/></td>
								<td style="text-align: center;"><input type="text" name="projPeop_workTime"  class="validate[required] inputText" style="width: 80%;"/></td>
								<td style="text-align: center;"><input type="text" name="projPeop_workOrg"  class="inputText validate[required]" style="width: 80%;"/></td>
								<td style="text-align: center;"><input type="text" name="projPeop_division"  class="inputText" style="width: 80%;"/></td>
					        </tr>
		   			    </c:if>
		   			    <c:if test="${! empty resultMap.projPeop}">
							<c:forEach var="projPeop" items="${resultMap.projPeop}" varStatus="status">
						        <tr>
						        	<td style="text-align: center;"><input name="projPeopIds" type="checkbox"/></td>
				            		<td style="text-align: center;" class="projPeopSerial">${status.count}</td>
									<td style="text-align: center;"><input type="text" name="projPeop_name" value="${projPeop.objMap.projPeop_name}" class="inputText validate[required]" style="width: 80%;"/></td>
									<td style="text-align: center;">
						                <select name="projPeop_sex" class="inputText validate[required]">
						                   <option value="">请选择</option>
						                   <c:forEach var="sex" items="${userSexEnumList}">
						                   		<c:if test="${sex.id != userSexEnumUnknown.id}">
						                   			<option value="${sex.id}" <c:if test="${projPeop.objMap.projPeop_sex eq sex.id}">selected="selected"</c:if>>${sex.name}</option>
						                   		</c:if>	 
						                   </c:forEach>
						                </select>
					           		</td>
									<td style="text-align: center;"><input type="text" name="projPeop_age" value="${projPeop.objMap.projPeop_age}" class="validate[custom[integer]] inputText" style="width: 80%;"/></td>
									<td style="text-align: center;"><input type="text" name="projPeop_jobTitle" value="${projPeop.objMap.projPeop_jobTitle}" class="inputText validate[required]" style="width: 80%;"/></td>
									<td style="text-align: center;"><input type="text" name="projPeop_major" value="${projPeop.objMap.projPeop_major}" class="inputText" style="width: 80%;"/></td>
									<td style="text-align: center;"><input type="text" name="projPeop_workTime" value="${projPeop.objMap.projPeop_workTime}" class="validate[required] inputText" style="width: 80%;"/></td>
									<td style="text-align: center;"><input type="text" name="projPeop_workOrg" value="${projPeop.objMap.projPeop_workOrg}" class="inputText validate[required]" style="width: 80%;"/></td>
									<td style="text-align: center;"><input type="text" name="projPeop_division" value="${projPeop.objMap.projPeop_division}" class="inputText" style="width: 80%;"/></td>
						        </tr>
						    </c:forEach>
						</c:if>
   			        </c:otherwise>
   			    </c:choose>
   			</tbody>
		</table>
		
     	
       	<c:if test="${param.view != GlobalConstant.FLAG_Y}">
       	<div align="center" style="margin-top: 10px">
       	    <input id="prev" type="button" onclick="nextOpt('step5')" class="search" value="上一步"/>
       	    <input id="nxt" type="button" onclick="nextOpt('step7')" class="search" value="下一步"/>
       	</div>
       	</c:if>	          
	</form>
	
	<div style="display: none">
		<!-- 课题负责人模板 -->
		<table  id="projMainPeopTemplate" style="width: 100%">
	        <tr>
				<td style="text-align: center;"><input name="projMainPeopIds" type="checkbox"/></td>
				<td style="text-align: center;" class="projMainPeopSerial"></td>
				<td style="text-align: center;"><input type="text" name="projMainPeop_name" value="${projMainPeop.objMap.projMainPeop_name}" class="inputText validate[required]" style="width: 80%;"/></td>
				<td style="text-align: center;">
	                <select name="projMainPeop_sex" class="inputText validate[required]">
	                   <option value="">请选择</option>
	                   <c:forEach var="sex" items="${userSexEnumList}">
	                   		<c:if test="${sex.id != userSexEnumUnknown.id}">
	                   			<option value="${sex.id}">${sex.name}</option>
	                   		</c:if>	 
	                   </c:forEach>
	                </select>
           		</td>
				<td style="text-align: center;"><input type="text" name="projMainPeop_age" class="validate[custom[integer]] inputText" style="width: 80%;"/></td>
				<td style="text-align: center;"><input type="text" name="projMainPeop_jobTitle" class="inputText validate[required]" style="width: 80%;"/></td>
				<td style="text-align: center;"><input type="text" name="projMainPeop_major" class="inputText" style="width: 80%;"/></td>
				<td style="text-align: center;"><input type="text" name="projMainPeop_workTime" class="validate[required] inputText" style="width: 80%;"/></td>
				<td style="text-align: center;"><input type="text" name="projMainPeop_workOrg" class="inputText validate[required]" style="width: 80%;"/></td>
				<td style="text-align: center;"><input type="text" name="projMainPeop_division" class="inputText" style="width: 80%;"/></td>
			</tr>
		</table>
		
		
		<!-- 主要研究人员模板 -->
		<table  id="projPeopTemplate" style="width: 100%">
	        <tr>
				<td style="text-align: center;" style="text-align: center;"><input name="projPeopIds" type="checkbox"/></td>
				<td style="text-align: center;" style="text-align: center;" class="projPeopSerial"></td>
				<td style="text-align: center;"><input type="text" name="projPeop_name" class="inputText validate[required]" style="width: 80%;"/></td>
				<td style="text-align: center;">
	                <select name="projPeop_sex" class="inputText">
	                   <option value="">请选择</option>
	                   <c:forEach var="sex" items="${userSexEnumList}">
	                   		<c:if test="${sex.id != userSexEnumUnknown.id}">
	                   			<option value="${sex.id}">${sex.name}</option>
	                   		</c:if>	 
	                   </c:forEach>
	                </select>
           		</td>
				<td style="text-align: center;"><input type="text" name="projPeop_age" class="validate[custom[integer]] inputText" style="width: 80%;"/></td>
				<td style="text-align: center;"><input type="text" name="projPeop_jobTitle" class="inputText validate[required]" style="width: 80%;"/></td>
				<td style="text-align: center;"><input type="text" name="projPeop_major" class="inputText" style="width: 80%;"/></td>
				<td style="text-align: center;"><input type="text" name="projPeop_workTime" class="inputText validate[required]" style="width: 80%;"/></td>
				<td style="text-align: center;"><input type="text" name="projPeop_workOrg" class="inputText validate[required]" style="width: 80%;"/></td>
				<td style="text-align: center;"><input type="text" name="projPeop_division" class="inputText" style="width: 80%;"/></td>
			</tr>
		</table>
	</div>