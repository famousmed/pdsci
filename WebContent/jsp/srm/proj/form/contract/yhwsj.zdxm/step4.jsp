<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:if test="${param.view!=GlobalConstant.FLAG_Y}">
<script type="text/javascript">
	$(document).ready(function(){
		if($("#pmTb tr").length<=0){
			add('pm');
		}
	});
	function nextOpt(step){
		if(false==$("#projForm").validationEngine("validate")){
			return false;
		}
		var form = $('#projForm');
		var action = form.attr('action');
		action+="?nextPageName="+step;
		form.attr("action" , action);
		form.submit();
	}
	
	function add(tb){
		var length = $("#"+tb+"Tb").children().length;
		if(length > 7){
			jboxTip("不超过8人!");
			return false; 
		}
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

	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" style="position: relative;"
		id="projForm">
		<input type="hidden" id="pageName" name="pageName" value="step4" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>

		<font style="font-size: 14px; font-weight:bold;color: #333; ">四、项目负责人及项目组成员</font>
		<table class="bs_tb" style="width: 100%;margin-top: 10px;">
			<tr>
				<td rowspan="9">项目负责人</td>
				<td>姓名</td>
				<td colspan="3" style="text-align: left; padding-left: 3%;"><input type="text" name="responsiblePersonName" value="${empty resultMap.responsiblePersonName?sessionScope.currUser.userName:resultMap.responsiblePersonName}" class="inputText" style="width: 80%;text-align: left;"/></td>
			</tr>
			<tr>
				<td>身份证号码</td>
				<td colspan="3" style="text-align: left; padding-left: 3%;"><input type="text" name="responsiblePersonIDNo" value="${empty resultMap.responsiblePersonIDNo?sessionScope.currUser.idNo:resultMap.responsiblePersonIDNo}" class="validate[custom[chinaIdLoose]] inputText" style="width: 80%;text-align: left;"/></td>
			</tr>
			<tr>
				<td>联系电话、手机</td>
				<td colspan="3" style="text-align: left; padding-left: 3%;"><input type="text" name="responsiblePersonContactNumber" value="${empty resultMap.responsiblePersonContactNumber?sessionScope.currUser.userPhone:resultMap.responsiblePersonContactNumber}" class="inputText" style="width: 80%;text-align: left;"/></td>
			</tr>
			<tr>
				<td>E-mail</td>
				<td colspan="3" style="text-align: left; padding-left: 3%;"><input type="text" name="responsiblePersonEmail" value="${empty resultMap.responsiblePersonEmail?sessionScope.currUser.userEmail:resultMap.responsiblePersonEmail}" class="validate[custom[email]] inputText" style="width: 80%;text-align: left;"/></td>
			</tr>
			<tr>
				<td width="15%">学历</td>
				<td>
					<select name="responsiblePersonEdu" class="inputText" style="width: 80%;">
	                   <option value="">请选择</option>
	                   <c:forEach var="dict" items="${dictTypeEnumUserEducationList}">
	                   		<option value="${dict.dictName}" <c:if test="${resultMap.responsiblePersonEdu eq dict.dictName or sessionScope.currUser.educationName eq dict.dictName}">selected="selected"</c:if>>${dict.dictName}</option> 
	                   </c:forEach>
	                </select>
				</td>
				<td width="15%">学位</td>
				<td>
					<select name="responsiblePersonDegree" class="inputText" style="width: 80%;">
	                   <option value="">请选择</option>
	                   <c:forEach var="dict" items="${dictTypeEnumUserDegreeList}">
	                   		<option value="${dict.dictName}" <c:if test="${resultMap.responsiblePersonDegree eq dict.dictName or sessionScope.currUser.degreeName eq dict.dictName}">selected="selected"</c:if>>${dict.dictName}</option> 
	                   </c:forEach>
	                </select>
				</td>
			</tr>
			<tr>
				<td>职称、职务</td>
				<c:set var="titlePostName" value="${sessionScope.currUser.titleName}、${sessionScope.currUser.postName}"/>
				<td><input type="text" name="responsiblePersonTitle" value="${empty resultMap.responsiblePersonTitle?titlePostName:resultMap.responsiblePersonTitle}" class="inputText" style="width: 80%;text-align: left;"/></td>
				<td>专业</td>
				<td><input type="text" name="responsiblePersonMajor" value="${resultMap.responsiblePersonMajor}" class="inputText" style="width: 80%;text-align: left;"/></td>
			</tr>
			<tr>
				<td>在本项目中的分工</td>
				<td colspan="3" style="text-align: left; padding-left: 3%;"><input type="text" name="responsiblePersonLabour" value="${resultMap.responsiblePersonLabour}" class="inputText" style="width: 80%;text-align: left;"/></td>
			</tr>
			<tr>
				<td>工作单位</td>
				<td colspan="3" style="text-align: left; padding-left: 3%;"><input type="text" name="responsiblePersonWorkOrg" value="${empty resultMap.responsiblePersonWorkOrg?proj.applyOrgName:resultMap.responsiblePersonWorkOrg}" class="inputText" style="width: 80%;text-align: left;"/></td>
			</tr>
			<tr>
				<td>单位法人代码</td>
				<td colspan="3" style="text-align: left; padding-left: 3%;"><input type="text" name="responsiblePersonLegalPersonCode" value="${resultMap.responsiblePersonLegalPersonCode}" class="inputText" style="width: 80%;text-align: left;"/></td>
			</tr>
		</table>
		
		<table class="bs_tb" style="width: 100%; border-bottom-style: none;">
			<tr>
				<th colspan="10" class="theader">项目组成员
					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
					<span style="float: right;padding-right: 10px">
					<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('pm')"></img>&#12288;
					<img title="删除" style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('pm');"></img></span>
					</c:if>
				</th>
			</tr>
			<tr>
				<td width="4%"></td>
				<td width="5%">序号</td>
				<td width="8%">姓名</td>
				<td width="8%">年龄</td>
				<td width="12%">专业技术职务</td>
				<td width="15%">专业</td>
				<td width="15%">工作单位</td>
				<td width="12%">在本项目中分工</td>
			</tr>
			<tbody id="pmTb">
			<c:if test="${not empty resultMap.projMember}">
				<c:forEach var="pm" items="${resultMap.projMember}" varStatus="status">
				<tr>
		             <td width="4%" style="text-align: center;"><input name="pmIds" type="checkbox"/></td>
		             <td width="5%" style="text-align: center;" class="pmSerial">${status.count}</td>
		             <td><input type="text" name="projMember_userName" value="${pm.objMap.projMember_userName}" class="inputText" style="width: 80%"/></td>
		             <td><input type="text" name="projMember_age" value="${pm.objMap.projMember_age}" class="inputText validate[custom[integer]]" style="width: 80%"/></td>
		             <td>
		             	 <select class="inputText" name="projMember_duty" style="width: 80%">
							<option value="">请选择</option>
							<c:forEach items="${dictTypeEnumUserPostList}" var="post">
								<option value="${post.dictName}" <c:if test='${pm.objMap.projMember_duty==post.dictName}'>selected="selected"</c:if>>${post.dictName}</option>
							</c:forEach>
						 </select>
		             </td>
		             <td><input type="text" name="projMember_major" value="${pm.objMap.projMember_major}" class="inputText" style="width: 80%"/></td>
		             <td><input type="text" name="projMember_org" value="${pm.objMap.projMember_org}" class="inputText" style="width: 80%"/></td>
		             <td><input type="text" name="projMember_labor" value="${pm.objMap.projMember_labor}" class="inputText" style="width: 80%"/></td>
				</tr>
			    </c:forEach>
	    	</c:if>
			</tbody>
		</table>
	</form>
	
	<!-------------------------------------------------------------------------------------------------------->
		
	<div style="display: none">
		<!-- 模板 -->
		<table class="basic" id="pmTemplate" style="width: 100%">
        <tr>
             <td width="4%" style="text-align: center;"><input name="pmIds" type="checkbox"/></td>
             <td width="5%" style="text-align: center;" class="pmSerial"></td>
             <td><input type="text" name="projMember_userName" class="inputText" style="width: 80%"/></td>
             <td><input type="text" name="projMember_age" class="inputText validate[custom[integer]]" style="width: 80%"/></td>
             <td>
             	<select class="inputText" name="projMember_duty" style="width: 80%">
					<option value="">请选择</option>
					<c:forEach items="${dictTypeEnumUserPostList}" var="post">
						<option value="${post.dictName}">${post.dictName}</option>
					</c:forEach>
				 </select>
             </td>
             <td><input type="text" name="projMember_major" class="inputText" style="width: 80%"/></td>
             <td><input type="text" name="projMember_org" class="inputText" style="width: 80%"/></td>
             <td><input type="text" name="projMember_labor" class="inputText" style="width: 80%"/></td>
		</tr>
		</table>
	</div>	
   	<c:if test="${param.view!=GlobalConstant.FLAG_Y}">
		<div align="center" style="margin-top: 10px">
		    <input id="prev" type="button" onclick="nextOpt('step3')" class="search" value="上一步"/>
		    <input id="nxt" type="button" onclick="nextOpt('step5')" class="search" value="下一步"/>
       	</div>
    </c:if>

		