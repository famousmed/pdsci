<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:if test="${param.view!=GlobalConstant.FLAG_Y}">
<script type="text/javascript">
	$(document).ready(function(){
		if($("#mrTb tr").length<=0){
			add('mr');
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
		if(length > 8){
			jboxTip("主要研究开发人员不超过9人!");
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
		<input type="hidden" id="pageName" name="pageName" value="step3" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>

		<font style="font-size: 14px; font-weight:bold;color: #333; ">四、项目承担单位、参加单位及主要研究开发人员</font>
		<table class="bs_tb" style="width: 100%;margin-top: 10px; border-bottom-style: none;">
			<tr>
				<th colspan="10" class="theader">项目承担单位、参加单位</th>
			</tr>
			<tr>
				<td colspan="10" style="text-align: left;">
					&#12288;项目承担单位：<input type="text" name="assumeOrg" value="${resultMap.assumeOrg}" class="inputText" style="width: 80%;text-align: left;"/>
				</td>
			</tr>
			<tr>
				<td colspan="10" style="text-align: left;">
					&#12288;项目参加单位：<input type="text" name="joinOrg" value="${resultMap.joinOrg}" class="inputText" style="width: 80%;text-align: left;"/>
				</td>
			</tr>
			<tr>
				<th colspan="10" class="theader">主要研究开发人员（不超过9人）
					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
					<span style="float: right;padding-right: 10px">
					<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('mr')"></img>&#12288;
					<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('mr');"></img></span>
					</c:if>
				</th>
			</tr>
			<tr>
				<td width="4%"></td>
				<td width="5%">序号</td>
				<td width="8%">姓名</td>
				<td width="8%">性别</td>
				<td width="8%">年龄</td>
				<td width="12%">职称</td>
				<td width="12%">职务</td>
				<td width="15%">从事专业</td>
				<td width="12%">为本项目工作时间（%）</td>
				<td width="15%">所在单位</td>
			</tr>
			<tbody id="mrTb">
			<c:if test="${not empty resultMap.mainResearcher}">
				<c:forEach var="mr" items="${resultMap.mainResearcher}" varStatus="status">
				<tr>
		             <td width="4%" style="text-align: center;"><input name="mrIds" type="checkbox"/></td>
		             <td width="5%" style="text-align: center;" class="mrSerial">${status.count}</td>
		             <td><input type="text" name="mainResearcher_userName" value="${mr.objMap.mainResearcher_userName}" class="inputText" style="width: 80%"/></td>
		             <td>
		             	 <select name="mainResearcher_gender" class="inputText" style="width: 80%;">
		                    <option value="">请选择</option>
		                    <c:forEach var="sex" items="${userSexEnumList}">
		                   		 <c:if test="${sex.id != userSexEnumUnknown.id}">
		                   			 <option value="${sex.id}" <c:if test="${mr.objMap.mainResearcher_gender eq sex.id}">selected="selected"</c:if>>${sex.name}</option>
		                   		 </c:if>	 
		                    </c:forEach>
		                 </select>
		             </td>
		             <td><input type="text" name="mainResearcher_age" value="${mr.objMap.mainResearcher_age}" class="inputText validate[custom[integer]]" style="width: 80%"/></td>
		             <td>
	             	    <select class="inputText" name="mainResearcher_title" style="width: 80%">
							<option value="">请选择</option>
							<c:forEach items="${dictTypeEnumUserTitleList}" var="title">
								<option value="${title.dictId}" <c:if test='${mr.objMap.mainResearcher_title==title.dictId}'>selected="selected"</c:if>>${title.dictName}</option>
							</c:forEach>
						</select>
		             </td>
		             <td>
		             	 <select class="inputText" name="mainResearcher_duty" style="width: 80%">
							<option value="">请选择</option>
							<c:forEach items="${dictTypeEnumUserPostList}" var="post">
								<option value="${post.dictId}" <c:if test='${mr.objMap.mainResearcher_duty==post.dictId}'>selected="selected"</c:if>>${post.dictName}</option>
							</c:forEach>
						 </select>
		             </td>
		             <td><input type="text" name="mainResearcher_major" value="${mr.objMap.mainResearcher_major}" class="inputText" style="width: 80%"/></td>
		             <td><input type="text" name="mainResearcher_workTime" value="${mr.objMap.mainResearcher_workTime}" class="inputText validate[custom[number]]" style="width: 80%"/></td>
		             <td><input type="text" name="mainResearcher_org" value="${mr.objMap.mainResearcher_org}" class="inputText" style="width: 80%"/></td>
				</tr>
			    </c:forEach>
	    	</c:if>
			</tbody>
		</table>
	</form>
	
	<!-------------------------------------------------------------------------------------------------------->
		
	<div style="display: none">
		<!-- 模板 -->
		<table class="basic" id="mrTemplate" style="width: 100%">
        <tr>
             <td width="4%" style="text-align: center;"><input name="mrIds" type="checkbox"/></td>
             <td width="5%" style="text-align: center;" class="mrSerial"></td>
             <td><input type="text" name="mainResearcher_userName" class="inputText" style="width: 80%"/></td>
             <td>
             	 <select name="mainResearcher_gender" class="inputText" style="width: 80%;">
                    <option value="">请选择</option>
                    <c:forEach var="sex" items="${userSexEnumList}">
                   		 <c:if test="${sex.id != userSexEnumUnknown.id}">
                   			 <option value="${sex.id}">${sex.name}</option>
                   		 </c:if>	 
                    </c:forEach>
                 </select>
             </td>
             <td><input type="text" name="mainResearcher_age" class="inputText validate[custom[integer]]" style="width: 80%"/></td>
             <td>
				<select class="inputText" name="mainResearcher_title" style="width: 80%">
					<option value="">请选择</option>
					<c:forEach items="${dictTypeEnumUserTitleList}" var="title">
						<option value="${title.dictId}">${title.dictName}</option>
					</c:forEach>
				</select>
             </td>
             <td>
             	<select class="inputText" name="mainResearcher_duty" style="width: 80%">
					<option value="">请选择</option>
					<c:forEach items="${dictTypeEnumUserPostList}" var="post">
						<option value="${post.dictId}">${post.dictName}</option>
					</c:forEach>
				 </select>
             </td>
             <td><input type="text" name="mainResearcher_major" class="inputText" style="width: 80%"/></td>
             <td><input type="text" name="mainResearcher_workTime" class="inputText validate[custom[number]]" style="width: 80%"/></td>
             <td><input type="text" name="mainResearcher_org" class="inputText" style="width: 80%"/></td>
		</tr>
		</table>
	</div>	
   	<c:if test="${param.view!=GlobalConstant.FLAG_Y}">
		<div align="center" style="margin-top: 10px">
		    <input id="prev" type="button" onclick="nextOpt('step2')" class="search" value="上一步"/>
		    <input id="nxt" type="button" onclick="nextOpt('step4')" class="search" value="下一步"/>
       	</div>
    </c:if>

		