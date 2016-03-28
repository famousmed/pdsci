<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<tr>
					<th width="200" style="background:#ECF2FA; ">决定类别</th>
					<th width="100" style="background:#ECF2FA; ">会议审查</th>
					<th width="100" style="background:#ECF2FA; ">会议报告</th>
					<th width="100" style="background:#ECF2FA; ">合计</th>
				</tr>
				<c:set var="decFastAmount" value="0"/>
				<c:set var="decMmeetingAmount" value="0"/>
				<c:set var="decFastAndMeetingAmount" value="0"/>
				<c:forEach items="${irbDecisionEnumList}" var="type" varStatus="status">
					<tr>
						<td>${type.name}</td>
						<td>
							${decMeetingTypeCountMap[type.id][status.index]}
						</td>
						<td>
							${decFastTypeCountMap[type.id][status.index]}
						</td>
						<td>
							${decFastTypeCountMap[type.id][status.index] + decMeetingTypeCountMap[type.id][status.index]}
						</td>
					</tr>
					
					<c:set var="decFastAmount" value="${decFastAmount  + decFastTypeCountMap[type.id][status.index]}"/>
					<c:set var="decMmeetingAmount" value="${decMmeetingAmount + decMeetingTypeCountMap[type.id][status.index]}"/>
					<c:set var="decFastAndMeetingAmount" value="${decFastAndMeetingAmount  + decFastTypeCountMap[type.id][status.index] + decMeetingTypeCountMap[type.id][status.index]}"/>
				</c:forEach>	
				<tr >
					<td>合计</td>
					<td><c:out value="${decMmeetingAmount}"/></td>
					<td><c:out value="${decFastAmount}"/></td>
					<td><c:out value="${decFastAndMeetingAmount}"/></td>
				</tr>