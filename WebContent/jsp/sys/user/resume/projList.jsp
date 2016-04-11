<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div>
	<table class="xllist" style="width: 100%">
		<tr>
			<th colspan="5" style="text-align: left;padding-left: 20px;" onclick="slideToggle('proj');">
				课题情况
			</th>
		</tr>
		<c:choose>
			<c:when test="${!empty projList }">
				<%-- 若当前工作站是伦理 --%>
				<c:choose>
					<c:when test="${sessionScope.currWsId==GlobalConstant.IRB_WS_ID }">
						<tr>
							<th style="width: 130px;">起始时间</th>
							<c:if test="${GlobalConstant.FLAG_Y eq pdfn:getSysCfg('irb_projno_flag') }">
								<th style="width: 100px;">项目编号</th>
							</c:if>
							<th style="width: 270px;">项目名称</th>
							<th style="width: 100px;">期类别</th>
							<th style="width: 100px;">项目来源</th>
						</tr>
						<c:forEach var="proj" items="${projList}">
							<tr class="proj">
								<td style="width: 130px;">
									${proj.projStartTime}&#12288;~&#12288;${proj.projEndTime}
								</td>
								<c:if test="${GlobalConstant.FLAG_Y eq pdfn:getSysCfg('irb_projno_flag') }">
									<td style="width: 100px">${proj.projNo}</td>
								</c:if>
								<td style="width: 270px">${proj.projName}</td>
								<td style="width: 100px">${proj.projSubTypeName}</td>
								<td style="width: 100px">${proj.projDeclarer}</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<th style="width: 130px;">起始时间</th>
							<th style="width: 80px;">项目编号</th>
							<th style="width: 240px;">项目名称</th>
							<th style="width: 130px;">项目类别</th>
							<th style="width: 80px;">项目阶段</th>
						</tr>
						<c:forEach var="proj" items="${projList}">
							<tr class="proj">
								<td style="width: 130px;">
									${proj.projStartTime}&#12288;~&#12288;${proj.projEndTime}
								</td>
								<td style="width: 80px">${proj.projNo}</td>
								<td style="width: 240px">${proj.projName}</td>
								<td style="width: 130px">${proj.projTypeName}</td>
								<td style="width: 80px">${proj.projStageName}</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>
				<tr>
	             	<td colspan="5">无记录</td>
				</tr>
			</c:otherwise>
		</c:choose>
	</table>
</div>
	

		
