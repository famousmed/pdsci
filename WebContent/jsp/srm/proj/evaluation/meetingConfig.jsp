<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
<!--

//-->
</script>
	    		<table class="xllist">
	    			<tr><th colspan="4" style="font-size: 14px" >会议信息</th></tr>
		             <tr>
	                         <td width="200px" ><span>开始时间：</span>${group.meetingStartTime}</td>
	                         <td width="200px" colspan="7"><span>结束时间：</span>${group.meetingEndTime}</td>
                 	</tr>
					<tr>
                        <td width="400px"  ><span>会议地点：</span>${group.meetingAddress }</td>
                        <td width="400px"  colspan="2"><span>会议名称：</span>${group.groupName }</td>
                    </tr>
		     	</table>
		     	<table  class="xllist">
		     		<tr><th colspan="9" style="font-size: 14px;">参会专家</th></tr>
						<tr>
							<th width="80px">姓名</th> 
		                   <th width="80px">性别</th>
		                    <th width="100px">职称</th>
	                    	 <th width="100px">职务</th>
		                   <th width="100px">专业</th>
		                   <th width="100px">学历</th>
						   <th width="150px">工作单位</th>
						   <th width="100px">手机</th>
						   <th width="100px">邮箱</th>
						</tr>
						<c:forEach items="${expertMeetingInfoList}" var="expert">
							<tr>
								<td>${expert.user.userName}</td>
								<td>${expert.user.sexName}</td>
								<td>${expert.user.titleName}</td>
								<td>${expert.user.postName}</td>
								<td>${expert.expert.majorName}</td>
								<td>${expert.expert.education}</td>
								<td>${expert.user.orgName}</td>
								<td>
								${expert.user.userPhone}</td>
								<td>
								${expert.user.userEmail}</td>
							</tr>
						</c:forEach>
		     	</table>
