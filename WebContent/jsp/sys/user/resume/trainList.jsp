<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div>
	<table class="xllist" style="width: 100%">
		<tr>
			<th colspan="7" style="text-align: left;padding-left: 20px;" onclick="slideToggle('train');">
				培训情况
			</th>
		</tr>
		<tr>
			<th style="width: 110px;">培训日期</th>
			<th style="width: 60px;">培训天数</th>
			<th style="width: 100px;">培训名称</th>
			<th style="width: 100px;">主办单位</th>
			<th style="width: 100px;">培训地点</th>
			<th style="width: 100px;">培训类别</th>
			<th style="width: 110px;">培训分类</th>
		</tr>
		<tbody id="trainTb" class="train">
		<c:if test="${! empty trainList}">
		<tbody class="train">
		<c:forEach var="train" items="${trainList}">
			<tr>
				<td style="width: 110px;">${train.trainDate}</td>
				<td style="width: 60px">${train.trainDays}</td>
				<td style="width: 100px">${train.trainName}</td>
				<td style="width: 100px">${train.trainOrg}</td>
				<td style="width: 100px">${train.trainAddress}</td>
				<td style="width: 100px">${train.trainTypeName}</td>
				<td style="width: 110px">${train.trainCategoryName}</td>
			</tr>
		</c:forEach>
		</tbody>
		</c:if>
		<c:if test="${empty trainList}">
				<tr>
		             <td colspan="7">无记录</td>
				</tr>
		</c:if>
		</tbody>
	</table>
</div>
	

		
