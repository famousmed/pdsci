<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <jsp:include page="/jsp/common/htmlhead.jsp"> --%>
<%-- 	<jsp:param name="basic" value="true"/> --%>
<%-- 	<jsp:param name="jbox" value="true"/> --%>
<%-- </jsp:include> --%>
<script type="text/javascript">
function print(doctorFlow){
	var trainYear = $("select[name='trainYear']").val();
	<c:if test="${empty recList}">
		jboxTip("无记录！");
		return false;
	</c:if>
	if(!trainYear){
		jboxTip("请选择培训年度！");
		return false;
	}
	jboxTip("打印中,请稍等...");
	var url = "<s:url value='/res/doc/printAnnualTrain'/>"
				+"?userFlow="+doctorFlow +
				"&trainYear="+trainYear;
	window.location.href = url;
}

function search(){
	var trainYear = $("select[name='trainYear']").val();
	var url = "<s:url value='/res/doc/annualtrainShow'/>?doctorFlow=${param.doctorFlow}&trainYear="+trainYear;
	jboxLoad("tagContent",url,true);
}
</script>
<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
			培训年度：<select name="trainYear" onchange="search();">
						<option value="">请选择</option>
						<c:forEach items="${dictTypeEnumDoctorSessionNumberList}" var="dict">
							<option value="${dict.dictName}" ${param.trainYear eq dict.dictName?'selected':''}>${dict.dictName}</option>
						</c:forEach>
					</select>
			<input type="button" value="打&#12288;印" class="search" onclick="print('${param.doctorFlow}');" style="float: right;margin-bottom: 10px;"/>
			<table class="xllist" style="width: 100%;">
				<thead>
			 			<tr>
			 				<th style="width: 16%;">轮转科室</th>
			 				<th style="width: 16%;">学习类型</th>
			 				<th style="width: 16%;">培训内容</th>
			 				<th style="width: 16%;">培训日期</th>
			 				<th style="width: 16%;">学分数/学时数</th>
			 				<th style="width: 20%;">备注</th>
			 			</tr>
			 	</thead>
			 	<c:set var="academicSum" value="0"/>
			 	<c:set var="academicSum_I" value="0"/>
			 	<c:set var="academicSum_II" value="0"/>
			 	<c:set var="classHourSum" value="0"/>
			 	<tbody>
		 			<c:forEach items="${recList}" var="rec">
		 				<c:set var="studyType" value="${recContentMap[rec.recFlow]['studyType']}"/>
		 				<c:set var="academicScore" value="${recContentMap[rec.recFlow]['academicScore']}"/>
		 				<c:set var="classHourScore" value="${recContentMap[rec.recFlow]['classHourScore']}"/>
		 				<tr>
		 					<td>${rec.schDeptName}</td>
		 					<td>
		 						${studyType}
		 						<c:set var="academicSum" value="${academicSum + academicScore}"/>
		 						<c:if test="${studyType == '继续教育I类'}">
									<c:set var="academicSum_I" value="${academicSum_I + academicScore}"/>
								</c:if>
								<c:if test="${studyType == '继续教育II类'}">
									<c:set var="academicSum_II" value="${academicSum_II + academicScore}"/>
								</c:if>
		 					</td>
	 						<td>${recContentMap[rec.recFlow]['trainContent']}</td>
	 						<td>${recContentMap[rec.recFlow]['trainDate']}</td>
	 						<td>
	 							${academicScore} / ${classHourScore}
	 							<c:set var="classHourSum" value="${classHourSum + classHourScore}"/>
	 						</td>
	 						<td>${recContentMap[rec.recFlow]['remarks']}</td>
		 				</tr>
		 			</c:forEach>
		 			<c:if test="${not empty recList}">
						<tr>
							<td rowspan="2">合计</td>
							<td>学时数：</td>
							<td>${classHourSum}</td>
							<td>其中，I类学分：</td>
							<td>${academicSum_I}</td>
							<td></td>
						</tr>
						<tr>
							<td>总学分：</td>
							<td>${academicSum}</td>
							<td>其中，II类学分：</td>
							<td>${academicSum_II}</td>
							<td></td>
						</tr>
					</c:if>
		 			<c:if test="${empty recList}">
		 				<tr>
		 					<td colspan="10">无记录</td>
		 				</tr>
		 			</c:if>
				</tbody>
		 	</table>
		 	</div>
	  </div>
</div>
