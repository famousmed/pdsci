<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_ui_sortable" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
</jsp:include>

<style type="text/css">
	.selDoc{color: red;}
	#main{
	   width: 100%;
	   height: 98%;
	   padding-top: 1%;
	 }
	.side1{margin:0;}
</style>

<script type="text/javascript">
	//按条件查询
	function search(){
		if($("[name='doctorCategoryId']").val()!="${recDocCategoryEnumIntern.id}"){
			$("[name='rosteringType']").attr("disabled",true);
		}
		$("#doctorForm").submit();
	}
	
	//轮转方案说明
	function openDetail(rotationName, rotationFlow){
		var url = "<s:url value='/sch/template/editRotation'/>?roleFlag=${param.roleFlag}&viewFlag=${GlobalConstant.FLAG_Y}&rotationFlow="+rotationFlow;
		jboxOpen(url, rotationName, 800, 500);
	}
	
	//选择医师加载排班
	function selDoc(tr,doctorFlow){
		checkRelStatus(tr,function(result){
			if(result)return jboxInfo("请先完成<font color='blue'>"+$(tr).attr("rotationName")+"</font>方案调整！");
			
			$(".selDoc").removeClass("selDoc");
			$(tr).addClass("selDoc");
			
			jboxLoad("rosteringHand","<s:url value='/sch/arrange/rosteringHandDept'/>?doctorFlow="+doctorFlow,true);
		});
	}
	
	//选择医师加载选科
	function toSelDept(tr,doctorFlow){
		checkRelStatus(tr,function(result){
			if(result)return jboxInfo("请先完成<font color='blue'>"+$(tr).attr("rotationName")+"</font>方案调整！");
			
			$(".selDoc").removeClass("selDoc");
			$(tr).addClass("selDoc");
			
			jboxLoad("rosteringHand","<s:url value='/sch/doc/toSelDept'/>?doctorFlow="+doctorFlow,true);
		});
	}
	
	//加载小组选科排班
	function groupSelAndRostering(tr,groupId){
		$(".selDoc").removeClass("selDoc");
		$(tr).addClass("selDoc");
		
		jboxLoad("rosteringHand","<s:url value='/sch/arrange/groupSelAndRostering'/>?doctorCategoryId=${doctor.doctorCategoryId}&groupId="+groupId,true);
	}
	
	function checkRelStatus(tr,func){
		var orgFlow = $(tr).attr("orgFlow") || "";
		var rotationFlow = $(tr).attr("rotationFlow") || "";
		if(orgFlow && rotationFlow){
			jboxGet("<s:url value='/sch/template/getUnrelCount'/>?orgFlow="+orgFlow+"&rotationFlow="+rotationFlow,null,function(resp){
				func(resp>0);
			},null,false);
		}else{
			func(false);
		}
	}
</script>
</head>
<body>
<div class="main_fix" style="overflow: hidden; top: 0">
		<div id="main">
<!-- 		<div style="margin-top: 10px;"> -->
<!-- 			Tip： -->
<%-- 			<c:if test="${!(param.rosteringType eq GlobalConstant.FLAG_Y)}"> --%>
<!-- 				<font color="red">*</font>表示未完成选科学员！ -->
<%-- 			</c:if> --%>
<%-- 			<c:if test="${param.rosteringType eq GlobalConstant.FLAG_Y}"> --%>
<!-- 				<font color="red">红色</font>学员为已选科或排班的学员,若要按组选科排班需<a style="cursor: pointer;color: blue;" onclick="clearSelAndRostering();">清空</a>组员的选科排班！ -->
<%-- 			</c:if> --%>
<!-- 		</div> -->
		<div class="side" style="width: 20%;">
			<form id="doctorForm" method="post" action="<s:url value='/sch/arrange/rosteringHand'/>">
			<table class="xllist" style="margin-bottom: 20px;">
				<tr style="display: none;"><td></td></tr>
				
				<tr>
					<td style="text-align: left;padding-left: 10px;">
						人员类型：
						<select name="doctorCategoryId" style="width: 60%;" onchange="search();">
							<option/>
							<c:forEach items="${recDocCategoryEnumList}" var="category">
								<c:set var="res_doctor_category_key" value="res_doctor_category_${category.id }"/>
								<c:if test="${sysCfgMap[res_doctor_category_key]==GlobalConstant.FLAG_Y}">
								<option value="${category.id}" ${doctor.doctorCategoryId eq category.id?'selected':''}>${category.name}</option>
								</c:if>
							</c:forEach>
						</select>
					</td>
				</tr>
			<tr class="rosteringType" <c:if test="${!(doctor.doctorCategoryId eq recDocCategoryEnumIntern.id)}">style="display: none;"</c:if>>
					<td style="text-align: left;padding-left: 10px;">
						排班形式：
						<label>
							<input type="radio" name="rosteringType" value="${GlobalConstant.FLAG_N}" <c:if test="${!(param.rosteringType eq GlobalConstant.FLAG_Y)}">checked</c:if> onchange="search();"/>按人
						</label>
						&#12288;
						<label>
							<input type="radio" name="rosteringType" value="${GlobalConstant.FLAG_Y}" <c:if test="${param.rosteringType eq GlobalConstant.FLAG_Y}">checked</c:if> onchange="search();"/>按组
						</label>
					</td>
				</tr>
				<tbody class="byDoctor" <c:if test="${param.rosteringType eq GlobalConstant.FLAG_Y}">style="display: none;"</c:if>>
					<tr>
						<td style="text-align: left;padding-left: 10px;">
							届&#12288;&#12288;数：
							<select name="sessionNumber" style="width: 60%;" onchange="search();">
								<option/>
								<c:forEach items="${dictTypeEnumDoctorSessionNumberList}" var="dict">
									<option value="${dict.dictName}" ${doctor.sessionNumber eq dict.dictName?'selected':''}>${dict.dictName}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					
					<tr>
						<td style="text-align: left;padding-left: 10px;">
							培训专业：
							<select name="trainingSpeId" style="width: 60%;" onchange="search();">
								<option/>
								<c:forEach items="${dictTypeEnumDoctorTrainingSpeList}" var="dict">
									<option value="${dict.dictId}" ${doctor.trainingSpeId eq dict.dictId?'selected':''}>${dict.dictName}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					
					<tr>
						<td style="text-align: left;padding-left: 10px;">
							医师姓名：
							<input type="text" name="doctorName" value="${doctor.doctorName}" style="width: 58%;" onchange="search();"/>
						</td>
					</tr>
				</tbody>
<%-- 				<tbody class="byGroup"  <c:if test="${!(param.rosteringType eq GlobalConstant.FLAG_Y)}">style="display: none;"</c:if>> --%>
<!-- 					<tr> -->
<!-- 						<td style="text-align: left;padding-left: 10px;"> -->
<!-- 							组&#12288;&#12288;别： -->
<!-- 							<select name="groupId"  style="width: 60%;" onchange="search();"> -->
<!-- 								<option/> -->
<%-- 								<c:forEach items="${dictTypeEnumResGroupList}" var="dict"> --%>
<%-- 									<option value="${dict.dictId}" ${doctor.groupId eq dict.dictId?'selected':''}>${dict.dictName}</option> --%>
<%-- 								</c:forEach> --%>
<!-- 							</select> -->
<!-- 						</td> -->
<!-- 					</tr> -->
<!-- 				</tbody> -->
				
				<c:if test="${!(param.rosteringType eq GlobalConstant.FLAG_Y)}">
					<c:forEach items="${doctorList}" var="doctor">
						<tr style="cursor: pointer;" onclick="${(GlobalConstant.FLAG_Y eq doctor.selDeptFlag || empty doctor.rotationFlow)?'selDoc':'toSelDept'}(this,'${doctor.doctorFlow}');" orgFlow="${doctor.orgFlow}" rotationFlow="${doctor.rotationFlow}" rotationName="${doctor.rotationName}">
							<td>
							<c:if test="${!(doctor.selDeptFlag eq GlobalConstant.FLAG_Y) && !empty doctor.rotationFlow}">
								<font id="${doctor.doctorFlow}WaitSel" color="red">*</font>
							</c:if>
							${doctor.doctorName}
							</td>
						</tr>
					</c:forEach>
					<c:if test="${empty doctorList}">
						<tr><td>无记录</td></tr>
					</c:if>
				</c:if>
				
				<c:if test="${param.rosteringType eq GlobalConstant.FLAG_Y}">
					<c:forEach items="${dictTypeEnumResGroupList}" var="dict">
						<tr style="cursor: pointer;" onclick="groupSelAndRostering(this,'${dict.dictId}');">
							<td>
								${dict.dictName} (${groupCountMap[dict.dictId]+0})
							</td>
						</tr>
					</c:forEach>
					<c:if test="${empty dictTypeEnumResGroupList}">
						<tr><td>无记录</td></tr>
					</c:if>
				</c:if>
			</table>
			</form>
		</div>
		<div id="rosteringHand" style="width: 78%;position: absolute;right: 0px;" class="side">
			<table class="basic" style="margin-left: 10px;width: 98%;">
				<tr>
					<td>
						<c:if test="${!(param.rosteringType eq GlobalConstant.FLAG_Y)}">
							请选择医师！
						</c:if>
						<c:if test="${param.rosteringType eq GlobalConstant.FLAG_Y}">
							请选择小组！
						</c:if>
					</td>
				</tr>
			</table>
		</div>
	</div>
</div>
</body>
</html>