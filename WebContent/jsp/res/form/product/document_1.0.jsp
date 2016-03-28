<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:if test="${'open' eq param.type}">
	<jsp:include page="/jsp/common/htmlhead.jsp">
		<jsp:param name="basic" value="true"/>
		<jsp:param name="jbox" value="true"/>
		<jsp:param name="jquery_form" value="true"/>
		<jsp:param name="jquery_ui_tooltip" value="true"/>
		<jsp:param name="jquery_validation" value="true"/>
		<jsp:param name="jquery_datePicker" value="true"/>
	</jsp:include>
</c:if>
<html>
<head>
<script>
if ("${param.roleFlag}" != "${GlobalConstant.RES_ROLE_SCOPE_DOCTOR}") {
	$(document).ready(function(){
		hideButton();
	});
}
function hideButton() {
	$('input,textarea').attr("readonly","readonly");
	$("select,:checkbox,:radio").attr("disabled", "disabled");
	$(":button,.opBtn").hide();
}

$(document).mouseup(function(f) {
	if ($(window).width() - f.pageX < 800) {
		return
	}
	if ($(f.target).closest("div.mfp-content").length) {
		return
	}
	if (f.target.nodeName == "SELECT") {
		if ($(event.target).closest($("#report")).length) {
			return
		}
	}
	$("#report").hide();
});

function show(){
	$("#report").show();
}

function add(tb){
 	$("#"+tb+"Tb").append($("#"+tb+"Template tr:eq(0)").clone());
}

function delTr(tb){
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
	});
}

function saveForm(){
	$.each($("#teachRecordTb").children() , function(i , n){
		if($(n).find("input[name='teachRecord_teachTime']").val()=="" &&
			$(n).find("input[name='teachRecord_teacher']").val()=="" && 
			$(n).find("select[name='teachRecord_teachType']").val()=="" &&
			$(n).find("input[name='teachRecord_teachContent']").val()==""){
			$(n).remove();
		}
	});
	if($("#documentForm").validationEngine("validate")){
		jboxPost("<s:url value='/res/rec/saveRegistryForm'/>",$('#documentForm').serialize(),function(){
			window.$("#tags").find(".selectTag a").click();
		},null,true);
	}
}

function submitForm(){
	jboxConfirm("提交后不可再编辑，确认提交?",function(){
		saveForm();
	});
}
</script>
</head>
<body>
<form id="documentForm" method="post">
	<input type="hidden" name="doctorFlow" value="${param.operUserFlow}"/>
	<input type="hidden" name="schDeptFlow" value="${param.schDeptFlow}"/>
	<input type="hidden" name="formFileName" value="${formFileName}"/>
	<input type="hidden" name="recFlow" value="${rec.recFlow}"/>
	<input type="hidden" name="processFlow" value="${currRegProcess.processFlow}"/>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				<table class="basic" width="100%">
					<tr>
						<th colspan="5" style="text-align: left;">&#12288;医学文案</th>
					</tr>
					<tr >
						<td  style="text-align: left;" colspan="5">&#12288;&#12288;<font style="font-weight: bold;">教学时间：</font>
						&#12288;<input type="text" class="inputText" name="teachTime" value="<c:out value="${formDataMap['teachTime']}" default="自定"/>" 
							style="text-align:center; width:100px; border-width: 0px; border-bottom-width: 1px;"/>
						&#12288;&#12288;<font style="font-weight: bold;">负责科室：</font><input type="text" class="inputText" name="chartDept" value="<c:out value="${formDataMap['chartDept']}" default="科教科"/>"
							style="text-align:center; width:120px; border-width: 0px; border-bottom-width: 1px;"/>&#12288;&#12288;
							<font style="font-weight: bold;">总完成时间：</font><input type="text" class="inputText" name="totalCompleteTime" value="<c:out value="${formDataMap['totalCompleteTime']}" default="52周"/>" 
							style="text-align:center; width:100px; border-width: 0px; border-bottom-width: 1px;"/></td>
					</tr>

					<tr>
						<td  width="100px;" style="text-align: left;">&#12288;&#12288;<font style="font-weight: bold;">教学目标：</font></td>
						<td colspan="4">
						掌握内外妇儿科病历书写的规范要求，熟练并提高质量地完成病历书写。了解专题综述的协作方法和基本要求，能在老师的指导下独立完成综述
						</td>
					</tr>
					<tr>
						<td  width="100px;" style="text-align: left;">&#12288;&#12288;<font style="font-weight: bold;">考核内容：</font></td>
						<td style="line-height: 25px;" colspan="4">
						<div style="float: left;">
							<p>1、病历质量与数量要求</p>
							<p>&#12288;(1)完成实习大纲中规定各科书写病历数</p>
							<p>&#12288;(2)书写质量符合规范化病历标准</p>
							<p >2、在教师指导下完成一篇专题综述(字数不低于1500字)</p>
						</div>
						
						<div style="margin-right: 10px;margin-top: 5px;margin-bottom: 5px;;cursor: pointer;height:200px;width:150px;float: right;background: url('<s:url value='/css/skin/${skinPath}/images/caseinfo_edit.jpg'/>' ) no-repeat;" onclick="show();">
							<p style="margin-top: 20px;text-align: center;"><b>专题综述</b></p>
							</div>
						</td>
						
					</tr>
				</table>
				<table class="xllist" style="border-top: 0;">
					<colgroup>
					<col width="5%"/>
					<col width="15%"/>
					<col width="10%"/>
					<col width="20%"/>
					<col width="50%"/>
					</colgroup>
					<tr>
						<th colspan="5" style="text-align: left;">&#12288;教学记录
						<c:if test="${empty rec.statusId || recStatusEnumEdit.id eq rec.statusId}">
							<span style="float: right;padding-right: 20px">
								<img class="opBtn" title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('teachRecord')"></img>&#12288;
								<img class="opBtn" title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('teachRecord');"></img>
							</span>
						</c:if>
						</th>
					</tr>
					<tr style="font-weight: bold;"><td></td><td>时间</td><td>教师</td><td>形式</td><td>教学主要内容</td></tr>
					<tbody id="teachRecordTb">
					<c:if test="${not empty formDataMap.teachRecord}">
				      	<c:forEach var="teachRecord" items="${formDataMap.teachRecord}" varStatus="num">
							<tr>
								<td><input type="checkbox" name="teachRecordIds"/></td>
								<td>
									<input type="text"  name="teachRecord_teachTime" value="${teachRecord.objMap.teachRecord_teachTime}" class="inputText validate[required]" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width: 100px;"/>
								</td>
								<td>
									<input type="text" name="teachRecord_teacher" value="${teachRecord.objMap.teachRecord_teacher}" style="width:90%" class="inputText validate[required]"/>
								</td>
								<td>
									<select name="teachRecord_teachType" class="inputText validate[required]">
										<c:forEach var="dict" items="${dictTypeEnumTeachTypeList}" varStatus="num">
											<option value="${dict.dictName}" ${teachRecord.objMap.teachRecord_teachType eq dict.dictId?'selected':''}>${dict.dictName}</option>
										</c:forEach>
									</select>
								</td>
								<td>
									<input type="text" style="width:90%;text-align: left;" class="inputText validate[required]" name="teachRecord_teachContent" value="${teachRecord.objMap.teachRecord_teachContent}"/>
								</td>
							</tr>
				      	</c:forEach>
				      </c:if>
				      <c:if test="${empty formDataMap.teachRecord}">
				      	    <tr>
								<td><input type="checkbox" name="teachRecordIds"/></td>
								<td>
									<input type="text"  name="teachRecord_teachTime" value="" class="inputText validate[required]" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width: 100px;"/>
								</td>
								<td>
									<input type="text" name="teachRecord_teacher"  style="width:90%;" class="inputText validate[required]" value=""/>
								</td>
								<td>
									<select name="teachRecord_teachType" class="inputText validate[required]">
										<option value="" ></option>
										<c:forEach var="dict" items="${dictTypeEnumTeachTypeList}" varStatus="num">
											<option value="${dict.dictName}" >${dict.dictName}</option>
										</c:forEach>
									</select>
								</td>
								<td>
									<input type="text" style="width:90%;text-align: left;" class="inputText validate[required]" name="teachRecord_teachContent" value=""/>
								</td>
							</tr>
				      </c:if>
				      </tbody>
				</table>
			</div>
			<div class="button" >
				<input class="search" type="button" value="保&#12288;存" onclick="saveForm();" />
			</div>
		</div>
	</div>
 	<div id="report" style="height: 100%; 
	background: url(<s:url value='/css/skin/${skinPath}/images/detail_shadow.jpg'/>) left repeat-y;
	width: 800px;
	padding-left:11px; 
	position: fixed;
	z-index: 1000;
	display: none;
	right: 0;
	top: 0">
	 <div class="mainright" style="height: 100%;background-color: white;">
      <div class="content">
        <div class="title1 clearfix">
				<table class="basic" width="100%" >
					<tr>
						<th colspan="6" style="text-align: left;">&#12288;专题综述</th>
					</tr>
					<tr>
					<td >
						<textarea class="xltxtarea" name="thematicReview" style="height: 500px;">${formDataMap['thematicReview']}</textarea>
					</td>
					</tr>
				</table>
				</div>
				<div class="button" >
					<input class="search" type="button" value="保&#12288;存" onclick="saveForm();" />
				</div>
			</div>
	</div>
	</div>
	</form>
	
	<div style="display: none">
		<!-- 模板 -->
		<table class="xllist" id="teachRecordTemplate">
       		<tr>
				<td><input type="checkbox" name="teachRecordIds"/></td>
				<td>
					<input type="text"  name="teachRecord_teachTime" value="" class="inputText validate[required]" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width: 100px;"/>
				</td>
				<td>
					<input type="text" name="teachRecord_teacher" style="width:90%" class="inputText validate[required]" value=""/>
				</td>
				<td>
					<select name="teachRecord_teachType" class="inputText validate[required]">
						<option value="" ></option>
						<c:forEach var="dict" items="${dictTypeEnumTeachTypeList}" varStatus="num">
							<option value="${dict.dictName}" >${dict.dictName}</option>
						</c:forEach>
					</select>
				</td>
				<td>
					<input type="text" name="teachRecord_teachContent" style="width:90%;text-align: left;" class="inputText validate[required]" value=""/>
				</td>
			</tr>
		</table>
	</div>	
</body>
</html>