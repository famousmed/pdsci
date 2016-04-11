<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<jsp:include page="/jsp/njmuedu/htmlhead-edu.jsp">
	<jsp:param name="findCourse" value="true"/>
</jsp:include>
</head>
<body>
<div style="margin-top: 10px;">
	<table border="0" cellpadding="0" cellspacing="0" class="course-table">
		<tr>
			<th width="23%">测试得分</th>
			<th width="23%">及格分</th>
			<th width="23%">总分</th>
			<th width="31%">考试日期</th>
		</tr>
		<tr>
			<td>50</td>
			<td>60</td>
			<td>100</td>
			<td>2015-04-04 9:00</td>
		</tr>
		<tr>
			<td>70</td>
			<td>60</td>
			<td>100</td>
			<td>2015-04-04 9:30</td>
		</tr>
	</table>
	</div>
</body>
</html>