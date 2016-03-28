<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<%-- <jsp:include page="/jsp/common/htmlhead.jsp"> --%>
<%-- 	<jsp:param name="basic" value="true"/> --%>
<%-- 	<jsp:param name="jbox" value="true"/> --%>
<%-- 	<jsp:param name="jquery_form" value="false"/> --%>
<%-- 	<jsp:param name="jquery_ui_tooltip" value="true"/> --%>
<%-- 	<jsp:param name="jquery_ui_combobox" value="false"/> --%>
<%-- 	<jsp:param name="jquery_ui_sortable" value="false"/> --%>
<%-- 	<jsp:param name="jquery_cxselect" value="true"/> --%>
<%-- 	<jsp:param name="jquery_scrollTo" value="false"/> --%>
<%-- 	<jsp:param name="jquery_jcallout" value="false"/> --%>
<%-- 	<jsp:param name="jquery_validation" value="true"/> --%>
<%-- 	<jsp:param name="jquery_datePicker" value="true"/> --%>
<%-- 	<jsp:param name="jquery_fullcalendar" value="false"/> --%>
<%-- 	<jsp:param name="jquery_fngantt" value="false"/> --%>
<%-- 	<jsp:param name="jquery_fixedtableheader" value="true"/> --%>
<%-- 	<jsp:param name="jquery_placeholder" value="true"/> --%>
<%-- 	<jsp:param name="jquery_iealert" value="false"/> --%>
<%-- </jsp:include> --%>
<script type="text/javascript">
	String.prototype.htmlFormart = function(){
		var html = this;
		for(var index in arguments){
			var reg = new RegExp('\\{'+index+'\\}','g');
			html = html.replace(reg,arguments[index]);
		}
		return html;
	};
	
	function addDept(){
		var deptFlow = $("#selDept").val();
		if(deptFlow){
			if($("."+deptFlow).length){
				return jboxTip("该科室已存在！");
			}else{
				var name = $("#selDept :selected").text();
				var template = $("#deptTemplate").html().htmlFormart(name,deptFlow);
				var table = $("#recordTable").clone();
				table.attr("id",deptFlow).append(template);
				$("#recordDiv").append(table);
			}
		}else{
			return jboxTip("请先选择科室！");
		}
	}
	
	function addStudy(dept){
		var html = $("#recordTemplate").html().htmlFormart(dept);
		$("."+dept+":last").after(html);
	}
	
	function delDept(deptFlow){
		jboxConfirm("确认删除科室？一旦删除科室学习内容也将一并删除！",function(){
			$("#"+deptFlow).remove();
		});
	}
	
	function delStudy(deptFlow){
		$("."+deptFlow+" :checkbox:checked").closest("."+deptFlow).remove();
	}
	
	function saveForm(){
		var data = $("#resRecGradeForm").serialize();
		jboxPost("<s:url value='/res/rec/saveAnnualTrainForm'/>",data,function(resp){
			if(resp=="${GlobalConstant.OPRE_SUCCESSED_FLAG}"){
				jboxTip("${GlobalConstant.OPRE_SUCCESSED}");
				<c:if test="${roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">
					$(".selectTag").find("a").click();
				</c:if>
				<c:if test="${roleFlag eq GlobalConstant.RES_ROLE_SCOPE_TEACHER}">
					$("#detail").rightSlideClose();
				</c:if>
			}
		},null,false);
	}
	
	$(function(){
		<c:if test="${!empty rec.auditStatusId || !(roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR)}">
			$("img").remove();
			$(":input").attr("readonly",true);
			$("select").each(function(){
				var label = $('<label/>');
				var hidden = $('<input type="hidden" name="'+this.name+'" value="'+this.value+'"/>');
				label.text(this.value).append(hidden);
				$(this).after(label).remove();
			});
		</c:if>
	});
</script>
</head>
<body>	
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				<c:if test="${roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR && empty rec.auditStatusId}">
					<div>
						<select id="selDept">
							<option>
							<c:forEach items="${deptList}" var="dept">
								<option value="${dept.deptFlow}">${dept.deptName}</option>
							</c:forEach>
						</select>
						<input type="button" class="search" value="新增科室" onclick="addDept();"/>
					</div>
				</c:if>
				<form id="resRecGradeForm">
				 	<div id="recordDiv">
				 		<c:forEach items="${deptList}" var="dept">
							<c:if test="${!empty formDataMap[dept.deptFlow]}">
				 			<table class="xllist" id="${dept.deptFlow}" style="margin-top: 10px;">
				 				<tr class="${dept.deptName}">
									<th colspan="6">
										<font style="float: left;margin-left: 10px;"><img class="opBtn" title="删除" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" style="cursor: pointer;" onclick="delDept('${dept.deptFlow}');">&nbsp;${dept.deptName}</font>
										<input type="hidden" name="deptFlow" value="${dept.deptFlow}"/>
										<span style="float: right;padding-right: 20px">
											<img class="opBtn" title="新增" src="<s:url value='/css/skin/${skinPath}/images/add3.png'/>" style="cursor: pointer;" onclick="addStudy('${dept.deptFlow}');"></img>&#12288;
											<img class="opBtn" title="删除" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" style="cursor: pointer;" onclick="delStudy('${dept.deptFlow}');"></img>
										</span>
									</th>
								</tr>
								<tr class="${dept.deptFlow}">
						 			<th width="7%">选择</th>
						 			<th width="15%">学习类型</th>
									<th width="30%">培训内容</th>
									<th width="17%">培训日期</th>
									<th width="15%">学分数/学时数</th>
									<th width="15%">备注</th>
								</tr>
									<c:forEach items="${formDataMap[dept.deptFlow]}" var="value">
										<tr class="${dept.deptFlow}">
											<td><input type="checkbox"/></td>
											<td>
												<c:set value="${dept.deptFlow}_studyType" var="name"/>
												<select name="${dept.deptFlow}_studyType">
													<option value="业务学习" <c:if test="${value[name] eq '业务学习'}">selected</c:if>>业务学习</option>
													<option value="继续教育Ⅰ类" <c:if test="${value[name] eq '继续教育Ⅰ类'}">selected</c:if>>继续教育Ⅰ类</option>
													<option value="继续教育Ⅱ类" <c:if test="${value[name] eq '继续教育Ⅱ类'}">selected</c:if>>继续教育Ⅱ类</option>
													<option value="其他" <c:if test="${value[name] eq '其他'}">selected</c:if>>其他</option>
												</select>
											</td>
											<td>
												<c:set value="${dept.deptFlow}_content" var="name"/>
												<input class="inputText" type="text" name="${dept.deptFlow}_content" style="width: 90%;" value="${value[name]}"/>
											</td>
											<td>
												<c:set value="${dept.deptFlow}_trainDate" var="name"/>
												<input class="inputText" type="text" name="${dept.deptFlow}_trainDate" value="${value[name]}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" readonly="readonly"/>
											</td>
											<td>
												<c:set value="${dept.deptFlow}_studyScore" var="name"/>
												<input class="inputText" type="text" name="${dept.deptFlow}_studyScore" style="width: 20px;" value="${value[name]}"/>
												/
												<c:set value="${dept.deptFlow}_studyHours" var="name"/>
												<input class="inputText" type="text" name="${dept.deptFlow}_studyHours" style="width: 20px;" value="${value[name]}"/>
											</td>
											<td>
												<c:set value="${dept.deptFlow}_remark" var="name"/>
												<input class="inputText" type="text" name="${dept.deptFlow}_remark" style="width: 90%;" value="${value[name]}"/>
											</td>
										</tr>
									</c:forEach>
				 			</table>
							</c:if>
				 		</c:forEach>
				 	</div>
			 		<table class="basic" style="width:100%;margin-top: 10px;">
			 			<tr>
			 				<td>
								<div style="line-height: 35px;font-weight: bold;margin: 0 10px 0 20px;">
									<span style="display: inline-block;width: 300px;">
										本人签名：
											<font style="font-weight: normal;"><c:out value="${formDataMap.doctorName}" default="${currUser.userName}"/></font>
											<input class="docCheck" type="hidden" name="doctorName" value="${empty formDataMap.doctorName?currUser.userName:formDataMap.doctorName}"/>
									</span>
										日期：
											<input class="docCheck inputText" type="text" name="doctorOperDate" value="<c:out value="${formDataMap.doctorOperDate}" default="${pdfn:getCurrDate()}"/>" readonly="readonly" 
												<c:if test="${!(rec.auditStatusId eq recStatusEnumTeacherAuditY.id)}">
													onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"
												</c:if>
											style="width: 100px;"
											/><br/>
									<span style="display: inline-block;width: 300px;">
										带教老师签名：
											<c:if test="${roleFlag eq GlobalConstant.RES_ROLE_SCOPE_TEACHER || rec.auditStatusId eq recStatusEnumTeacherAuditY.id}">
												<font style="font-weight: normal;width:200px;display: inline-block;"><c:out value="${formDataMap.teacherName}" default="${currUser.userName}"/></font>
												<input class="teacherCheck" type="hidden" name="teacherName" value="<c:out value="${formDataMap.teacherName}" default="${currUser.userName}"/>"/>
											</c:if>
									</span>
									日期： 
									<c:if test="${roleFlag eq GlobalConstant.RES_ROLE_SCOPE_TEACHER || rec.auditStatusId eq recStatusEnumTeacherAuditY.id}">
										<input class="teacherCheck inputText" type="text" name="operDate" value="<c:out value="${formDataMap.operDate}" default="${pdfn:getCurrDate()}"/>" readonly="readonly" 
										<c:if test="${!(rec.auditStatusId eq recStatusEnumTeacherAuditY.id)}">
											onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"
										</c:if>
										style="width: 100px;"
										/>
									</c:if>
									<input type="hidden" name="recFlow" value="${rec.recFlow}"/>
									<input type="hidden" name="roleFlag" value="${roleFlag}"/>
								</div>
			 				</td>
			 			</tr>
			 		</table>
			 		
				</form>
				<div style="text-align: center;margin-top: 20px;">
					<c:if test="${empty rec.auditStatusId}">
						<c:if test="${roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">
							<input type="button" value="保&#12288;存" class="search" onclick="saveForm();"/>
						</c:if>
						<c:if test="${roleFlag eq GlobalConstant.RES_ROLE_SCOPE_TEACHER}">
							<input type="button" value="审核通过" class="search" onclick="saveForm();"/>
						</c:if>
					</c:if>
					<c:if test="${roleFlag eq GlobalConstant.RES_ROLE_SCOPE_TEACHER}">
						<input type="button" class="search" value="关&#12288;闭" onclick="$('#detail').rightSlideClose();"/>
					</c:if>
				</div>
<!-- 				//////////// -->
<!-- 				<table class="basic" style="width:100%;margin-top: 10px;"> -->
<!-- 			 			<tr> -->
<!-- 			 				<th>学习类型：</th> -->
<!-- 			 				<th>培训内容：</th> -->
<!-- 			 				<th>培训日期:</th> -->
<!-- 			 				<th>学分数/学时数:</th> -->
<!-- 			 				<th>备注:</th> -->
<!-- 			 			</tr> -->
<%-- 			 			<c:forEach items="${recMap[resRecTypeEnumSkillRegistry.id]}" var="rec"> --%>
<!-- 			 				<tr> -->
<%-- 			 					<td>${recContentMap[rec.recFlow]['studyType']}</td> --%>
<%-- 		 						<td>${recContentMap[rec.recFlow]['trainContent']}</td> --%>
<%-- 		 						<td>${recContentMap[rec.recFlow]['trainDate']}</td> --%>
<%-- 		 						<td>${recContentMap[rec.recFlow]['academicScore']}</td> --%>
<%-- 		 						<td>${recContentMap[rec.recFlow]['remarks']}</td> --%>
<!-- 			 				</tr> -->
<%-- 			 			</c:forEach> --%>
<!-- 			 		</table> -->
				<table style="display: none;">
					<tbody id="deptTemplate">
						<tr class="{1}">
							<th colspan="6">
								<font style="float: left;margin-left: 10px;"><img class="opBtn" title="删除" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" style="cursor: pointer;" onclick="delDept('{1}');">&nbsp;{0}</font>
								<input type="hidden" name="deptFlow" value="{1}"/>
<!-- 								<input type="hidden" name="deptName" value="{0}"/> -->
								<span style="float: right;padding-right: 20px">
									<img class="opBtn" title="新增" src="<s:url value='/css/skin/${skinPath}/images/add3.png'/>" style="cursor: pointer;" onclick="addStudy('{1}');"></img>&#12288;
									<img class="opBtn" title="删除" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" style="cursor: pointer;" onclick="delStudy('{1}');"></img>
								</span>
							</th>
						</tr>
						<tr class="{1}">
				 			<th width="7%">选择</th>
				 			<th width="15%">学习类型</th>
							<th width="30%">培训内容</th>
							<th width="17%">培训日期</th>
							<th width="15%">学分数/学时数</th>
							<th width="15%">备注</th>
						</tr>
					</tbody>
					<tbody id="recordTemplate">
						<tr class="{0}">
							<td><input type="checkbox"/></td>
							<td>
								<select name="{0}_studyType">
									<option value="业务学习">业务学习</option>
									<option value="继续教育Ⅰ类">继续教育Ⅰ类</option>
									<option value="继续教育Ⅱ类">继续教育Ⅱ类</option>
									<option value="其他">其他</option>
								</select>
							</td>
							<td>
								<input class="inputText" type="text" name="{0}_content" style="width: 90%;"/>
							</td>
							<td>
								<input class="inputText" type="text" name="{0}_trainDate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" readonly="readonly"/>
							</td>
							<td>
								<input class="inputText" type="text" name="{0}_studyScore" style="width: 20px;"/>
								/
								<input class="inputText" type="text" name="{0}_studyHours" style="width: 20px;"/>
							</td>
							<td>
								<input class="inputText" type="text" name="{0}_remark" style="width: 90%;"/>
							</td>
						</tr>
					</tbody>
				</table>
				<div>
					<table class="xllist" id="recordTable" style="margin-top: 10px;">
				 		<colgroup>
				 			<col width="7%"/>
				 			<col width="15%"/>
				 			<col width="30%"/>
				 			<col width="17%"/>
				 			<col width="15%"/>
				 			<col width="15%"/>
				 		</colgroup>
			 		</table>
				</div>
			</div> 	
		</div>
	</div>
</body>
</html>