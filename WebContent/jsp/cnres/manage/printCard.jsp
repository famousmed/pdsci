<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>国家住院医师规范化培训示范性基地招录系统</title>
<jsp:include page="/jsp/cnres/htmlhead-cnres.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="font" value="true"/>
</jsp:include>
<script type="text/javascript">

</script>
</head>
<body style="width:100%; min-width: inherit; height:100%;background-image:none; background:#fff;">

	<div class="infoAudit" >
	
		<table border="0" width="100%" cellspacing="0" cellpadding="0" style="margin-top: -20px;">
			<caption>准考证</caption>
			<tr>
				<td colspan="4">
					<div style="width: 100px;height: 130px;padding-top: 10px;">
						<img src="${sysCfgMap['upload_base_url']}/${doctor.doctorHeadImg}" style="width: 100%;height: 100%;"/>
					</div>
				</td>
			</tr>
	     	 <tr>
				<td width="15%">姓名：</td>
				<td width="85%">${user.userName}</td>
			</tr>
	     	 <tr>
				<td>性别：</td>
				<td>${user.sexName}</td>
			</tr>
	     	 <tr>
				<td>年龄：</td>
				<td>${pdfn:calculateAge(user.userBirthday)}</td>
			</tr>
	     	 <tr>
				<td>准考证号：</td>
				<td>00000222222</td>
			</tr>
		</table>
		
		<div align="center" style="margin-top: 20px; margin-bottom:20px;" id="but">
			<a class="btn_blue" href="javascript:$('#but').hide();window.print();$('#but').show();">打&nbsp;印</a>
			<a class="btn_grey" href="javascript:jboxClose();">关&nbsp;闭</a>
		</div>
	</div>
</body>
</html>