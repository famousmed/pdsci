<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<table class="xllist" align="center">
					<thead>
						<tr>
							<th>姓名</th>
							<th>性别/职务职称</th>
							<th>工作单位</th>
							<th>签到</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${expertInfoList}" var="expert">
						<tr>
							<td>${expert.user.userName}</td>
							<td>${expert.user.sexName}/${expert.user.titleName}</td>
							<td>${expert.user.orgName}</td>
							<td>
								<c:if test='${expert.expertGroupUser.signFlag=="N" ||empty expert.expertGroupUser.signFlag}'><a href="javascript:void(0);" onclick="sign('${expert.expertGroupUser.recordFlow}')">[签到]</a></c:if>
								<c:if test='${expert.expertGroupUser.signFlag=="Y"}'>[已签到]</c:if>
							</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>