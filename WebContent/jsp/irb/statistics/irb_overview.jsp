<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <tr><th class="th_sp" colspan="4">年度审查情况</th></tr>
				<tr>
					<th width="200" style="background:#ECF2FA; ">伦理审查类别</th>
					<th width="100" style="background:#ECF2FA; ">会议审查</th>
					<th width="100" style="background:#ECF2FA; ">会议报告</th>
					<th width="100" style="background:#ECF2FA; ">合计</th>
				</tr>
				<c:set var="fastAmount" value="0"/>
				<c:set var="meetingAmount" value="0"/>
				<c:set var="fastAndMeetingAmount" value="0"/>
				<c:forEach items="${irbTypeEnumList}" var="type" varStatus="status">
					<tr>
						<td>${type.scName}</td>
						<td>
							${meetingTypeCountMap[type.id][status.index]}
						</td>
						<td>
							${fastTypeCountMap[type.id][status.index]}
						</td>
						<td>
							${fastTypeCountMap[type.id][status.index] + meetingTypeCountMap[type.id][status.index]}
						</td>
					</tr>
					
					<c:set var="fastAmount" value="${fastAmount  + fastTypeCountMap[type.id][status.index]}"/>
					<c:set var="meetingAmount" value="${meetingAmount + meetingTypeCountMap[type.id][status.index]}"/>
					<c:set var="fastAndMeetingAmount" value="${fastAndMeetingAmount  + fastTypeCountMap[type.id][status.index] + meetingTypeCountMap[type.id][status.index]}"/>
				</c:forEach>
				<tr >
					<td>合计</td>
					<td><c:out value="${meetingAmount}"/></td>
					<td><c:out value="${fastAmount}"/></td>
					<td><c:out value="${fastAndMeetingAmount}"/></td>
				</tr>