<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ztree" value="true"/>
</jsp:include>

<c:if test="${param.view != GlobalConstant.FLAG_Y}">
<script type="text/javascript">
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
	
	function checkTeltphone(obj){
		var r, reg; 
		var s = obj.value;
		reg =/^[1][34578]\w*$/; //正则表达式模式。
		r = reg.test(s); 
		if(r){
			$(obj).addClass("validate[custom[mobile]]");
			$(obj).removeClass("validate[custom[phone2]]");
		}else{
			$(obj).addClass("validate[custom[phone2]]");
			$(obj).removeClass("validate[custom[mobile]]");
		}       
	}
</script>
</c:if>

	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" style="position: relative;"
		id="projForm">
		<input type="hidden" id="pageName" name="pageName" value="step1" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
		<font style="font-size: 14px; font-weight:bold;color: #333;">一、基本信息</font>
		<table class="basic" style="width: 100%; margin-top: 10px;" >
			<colgroup>
				<col width="11%"/>
				<col width="39%"/>
				<col width="10%"/>
				<col width="40%"/>
			</colgroup>
			<tr>
				<td style="text-align: right;">申报单位：</td>
				<td><input type="text" name="applyOrgName" value="${empty resultMap.applyOrgName?proj.applyOrgName:resultMap.applyOrgName}" class="inputText" style="width: 80%"/></td>
           		<td style="text-align: right;">项目主持人：</td>
				<td><input type="text" name="projCompere" value="${empty resultMap.projCompere?sessionScope.currUser.userName:resultMap.projCompere}" class="inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td style="text-align: right;">项目名称：</td>
				<td><input type="text" name="projName" value="${empty resultMap.projName?proj.projName:resultMap.projName}" class="inputText" style="width: 80%"/></td>
           		<td style="text-align: right;">起止年限：</td>
				<td>
					<input class="inputText ctime" type="text" name="projStartYear" value="${empty resultMap.projStartYear?proj.projStartTime:resultMap.projStartYear}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width: 35%"/>
					~ <input class="inputText ctime" type="text" name="projEndYear" value="${empty resultMap.projEndYear?proj.projEndTime:resultMap.projEndYear}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width: 35%"/>
				</td>
			</tr>
			<tr>
				<td style="text-align: right;">联系电话：</td>
				<td><input type="text" name="telephone" value="${empty resultMap.telephone?sessionScope.currUser.userPhone:resultMap.telephone}" class="inputText" style="width: 80%" onchange="checkTeltphone(this);"/></td>
           		<td style="text-align: right;">项目类别：</td>
				<td>
					<select name="projCategory" class="inputText" style="width: 80%">
						<option value="">请选择</option>
						<c:forEach items="${dictTypeEnumYhProjCategoryList }" var="dict">
						<option value="${dict.dictName}" <c:if test="${resultMap.projCategory eq dict.dictName}">selected="selected"</c:if>>${dict.dictName}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td style="text-align: right;">项目拟投入经费：</td>
				<td><input type="text" name="investmentFund" value="${resultMap.investmentFund}" class="validate[custom[number]] inputText" style="width: 80%;"/>万元</td>
           		<td style="text-align: right;">技术领域：</td>
				<td>
					<select name="technologyField" class="inputText" style="width: 80%">
						<option value="">请选择</option>
						<c:forEach items="${dictTypeEnumYhTechnologyFieldList }" var="dict">
						<option value="${dict.dictName}" <c:if test="${resultMap.technologyField eq dict.dictName}">selected="selected"</c:if>>${dict.dictName}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td style="text-align: right;">技术依托单位：</td>
				<td><input type="text" name="technologyRelyOrg" value="${resultMap.technologyRelyOrg}" class="inputText" style="width: 80%"/></td>
           		<td style="text-align: right;">技术来源：</td>
				<td>
					<select name="technologySource" class="inputText" style="width: 80%">
						<option value="">请选择</option>
						<c:forEach items="${dictTypeEnumYhTechnologySourceList }" var="dict">
						<option value="${dict.dictName}" <c:if test="${resultMap.technologySource eq dict.dictName}">selected="selected"</c:if>>${dict.dictName}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
		     	<td colspan="6">
		     		<textarea placeholder="项目简介（研究背景、技术水平、主要研究内容、技术指标、预期社会效益及成果）" style="height: 300px;" class="validate[maxSize[1000]] xltxtarea" name="projIntroduction">${resultMap.projIntroduction}</textarea>
		     	</td>
	     	</tr>
			<tr>
		</table>
	</form>
	
	
    <c:if test="${param.view!=GlobalConstant.FLAG_Y}">
		<div align="center" style="margin-top: 10px">
		    <input id="nxt" type="button" onclick="nextOpt('step2')" class="search" value="下一步"/>
       	</div>
    </c:if>

		