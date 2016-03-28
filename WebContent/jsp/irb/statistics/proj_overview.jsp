<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<tr>
					<th width="200" style="background:#ECF2FA; ">研究类别</th>
					<th width="100" style="background:#ECF2FA; ">会议审查</th>
					<th width="100" style="background:#ECF2FA; ">会议报告</th>
					<th width="100" style="background:#ECF2FA; ">合计</th>
				</tr>
				<c:set var="gcpFastAmount" value="0"/>
				<c:set var="gcpMmeetingAmount" value="0"/>
				<c:set var="gcpFastAndMeetingAmount" value="0"/>
				<c:forEach items="${gcpProjSubTypeEnumList}" var="type" varStatus="status">
					<tr>
						<td>${type.name}</td>
						<td>
							${gcpMeetingTypeCountMap[type.id][status.index]}
						</td>
						<td>
							${gcpFastTypeCountMap[type.id][status.index]}
						</td>
						<td>
							${gcpFastTypeCountMap[type.id][status.index] + gcpMeetingTypeCountMap[type.id][status.index]}
						</td>
					</tr>
					
					<c:set var="gcpFastAmount" value="${gcpFastAmount  + gcpFastTypeCountMap[type.id][status.index]}"/>
					<c:set var="gcpMmeetingAmount" value="${gcpMmeetingAmount + gcpMeetingTypeCountMap[type.id][status.index]}"/>
					<c:set var="gcpFastAndMeetingAmount" value="${gcpFastAndMeetingAmount  + gcpFastTypeCountMap[type.id][status.index] + gcpMeetingTypeCountMap[type.id][status.index]}"/>
				</c:forEach>	
				<tr >
					<td>合计</td>
					<td><c:out value="${gcpMmeetingAmount}"/></td>
					<td><c:out value="${gcpFastAmount}"/></td>
					<td><c:out value="${gcpFastAndMeetingAmount}"/></td>
				</tr>