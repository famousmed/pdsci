<html>
<head>
<title></title>
<style type="text/css">
body {
	margin-left: 45px;
	margin-right: 45px;
	font:13px;
	font-family: Arial Unicode MS;
}

table {
	margin: auto;
	width: 100%;
	border-collapse: collapse;
	border: none;
}

th,td {
	border: none;
	font-size: 12px;
	margin-left: 5px;
}

.title {
	text-align: center;
	font-size: 18px;
	margin-top:10px;
	margin-bottom:10px;
}

.table_title {
	width: 100%;
	margin: 0 auto;
}
.table_title td{
	font-size: 13px;
}

.basic{
	border:1px solid #D0E3F2;
}

.basic th,.basic td { border-right:1px solid #000; border-bottom:1px solid #000;
						border-left:1px solid #000; border-top:1px solid #000;}
.basic tbody th { background:#000; color:#000; height:35px; text-align:right; padding-right:10px;}
.basic td { text-align:left; padding-left:10px; line-height:35px;}

.page_bottom {
	vertical-align:bottom;
	text-align: center;
}

@page {   
    size: A4;
    margin-left:70px;
 	margin-right:70px;
 	margin-top:10px;
    
    @top-center {  
    	content: element(header);
    };  
    @bottom-center{  
        content:"第" counter(page) "页/共" counter(pages) "页";  
        font-family: Arial Unicode MS;   
        font-size: 12px;  
        color:#000;  
    };  
}  
             
div#myheader {
	display: block;  
	text-align:center;
    position: running(header);  
    margin-left:70px;
 	margin-right:70px;
}   
  
#pagenumber:before {  
content: counter(page);   
}  
  
#pagecount:before {  
content: counter(pages);    
}  

</style>
</head>
<body>
<div class="mainright"  >
	<div class="content" style="margin-left: 10px;margin-right: 10px;">
		<div>
		<div style="text-align: center;margin-top: 10px;margin-bottom: 10px;">
			<font style="font-size: 16px;">会议议程</font>
		</div>
		<div>
			<table class="basic" style=" nofix">
				<tr>
					<td width="20%" style="text-align: center;">日期
					</td>
					<td width="30%">${meeting.meetingDate!'' }
					</td>
					<td width="10%" style="text-align: center;">时间
					</td>
					<td width="40%">${meeting.meetingStartTime!'' } ～ ${meeting.meetingEndTime!'' }
					</td>
				</tr>
				<tr>
					<td width="20%" style="text-align: center;">地点
					</td>
					<td colspan="3">${meeting.meetingAddress!'' }
					</td>
				</tr>
				<#if meetingUserMap?exists>
				<#list meetingUserMap?keys as roleFlow> 
					<tr>
						<td width="20%" style="text-align: center;">${meetingUserMap[roleFlow][0].roleName }
						</td>
						<td colspan="3">
							<#assign userStatus=0 >
							<#list meetingUserMap[roleFlow] as meetingUser>
								<#assign userStatus=userStatus+1 >
								${meetingUser.userName }<#if meetingUserMap[roleFlow]?size gt 1 && userStatus != meetingUserMap[roleFlow]?size>、</#if>
							</#list>
						</td>
					</tr>
				</#list>
				</#if>
				<tr>
					<td width="20%" style="text-align: center;">主持人
					</td>
					<td colspan="3">${meeting.meetingHost!'' }
					</td>
				</tr>
				<tr>
					<td width="20%" style="text-align: center;">伦理委员会名称
					</td>
					<td colspan="3">${meeting.irbName!'' }
					</td>
				</tr>
			</table>
		</div>
		<div style="line-height:20px;margin-top: 5px;margin-bottom: 20px;text-align: left;">
			秘书核对本次到会委员是否符合法定人数要求。主持人询问是否有与本次审查项目存在利益冲突的委员，如有，请声明。
		</div>
		</div>
		<div style="margin-top: 5px;margin-bottom: 5px;">
			一、会议报告，由秘书进行会议报告
		</div>
		<div style="margin-top: 5px;margin-bottom: 5px;">
			&#12288;（一）快速审查<#if fastFormList?exists><#else>(无)</#if>
		</div>
		<#assign fastStatus=0 >
		<#if fastFormList?exists>
		<#list fastFormList as form>
		 	<#assign fastStatus=fastStatus+1 >	 
			<table class="basic" style="table-layout:fixed; word-break:break-strict;">
					<tr>
						<td width="8%">（${fastStatus}）</td>
						<td width="20%">伦理审查类别：</td>
						<td width="72%">${form.irb.irbTypeName!'' }</td>
					</tr>
					<tr>
						<td></td>
						<td>项目：</td>
						<td>${form.irb.projName!'' }</td>
					</tr>
					<tr>
						<td></td>
						<td>受理号：</td>
						<td>${form.irb.irbNo!'' }</td>
					</tr>
					<tr>
						<td></td>
						<td>主要研究者：</td>
						<td>${form.proj.applyUserName!'' }</td>
					</tr>
					<tr>
						<td></td>
						<td>主审委员：</td>
						<td>
							<#assign statu=0 >
							<#if committeesMap[form.irb.irbFlow]?exists>
							<#list committeesMap[form.irb.irbFlow] as irbUser>
								<#assign statu=statu+1 >
					            ${irbUser.userName!''}<#if committeesMap[form.irb.irbFlow]?size gt 1 && statu != committeesMap[form.irb.irbFlow ]?size>、</#if>
					          </#list> 
					         </#if>
				         </td>
					</tr>
					<tr>
						<td></td>
						<td>审查概要：</td>
						<td><#if minutesMap[form.irb.irbFlow]?exists>${minutesMap[form.irb.irbFlow].reportMinutes!'' }</#if></td>
					</tr>
					<tr>
						<td></td>
						<td>审查决定：</td>
						<td>${form.irb.irbDecisionName!''}</td>
					</tr>
			</table>
		<div>
			&#12288;
		</div>
		</#list>
		</#if> 
		<div style="margin-top: 5px;margin-bottom: 5px;">
			二、会议审查项目
		</div> 
		<#assign typeStatus=0 >
		<#list irbTypeEnumList as dict>
		<#assign typeStatus=typeStatus+1 >
			<div style="margin-top: 5px;margin-bottom: 5px;">
				&#12288;(${transNum(typeStatus) }) ${dict.dictName}<#if irbTypeMap[dict.dictId]?exists><#else>(无)</#if>
			</div>
			<#assign status=0 >
			<#if irbTypeMap[dict.dictId]?exists>
			<#list irbTypeMap[dict.dictId] as form>
				<#assign status=status+1 >
				<table class="basic" style="table-layout:fixed; word-break:break-strict;">
					<tr>
						<td width="8%">（${status}）</td>
						<td width="20%">项目：</td>
						<td width="72%">${form.irb.projName!'' }</td>
					</tr>
					<tr> 
						<td></td>
						<td>受理号：</td>
						<td>${form.irb.irbNo!'' }</td>
					</tr>
					<tr>
						<td></td>
						<td>机构角色：</td>
						<td>
						</td>
					</tr>
					<tr>
						<td></td>
						<td>主要研究者：</td>
						<td>${form.proj.applyUserName!'' }</td>
					</tr>
					<tr>
						<td></td>
						<td>主审委员：</td>
						<td>
						<#assign statu=0 >
						<#if committeesMap[form.irb.irbFlow]?exists>
						<#list committeesMap[form.irb.irbFlow] as irbUser>
							<#assign statu=statu+1 >
				            ${irbUser.userName!''}<#if committeesMap[form.irb.irbFlow]?size gt 1 && statu != committeesMap[form.irb.irbFlow ]?size>、</#if>
				          </#list> 
				         </#if>
						</td>
					</tr>
					<tr>
						<td></td>
						<td>独立顾问：</td>
						<td><#if consultantMap[form.irb.irbFlow]?exists>${consultantMap[form.irb.irbFlow].userName!'' }</#if></td>
					</tr>
				</table>
				<div>
					&#12288;
				</div>	
				</#list> 
				</#if>
		</#list> 
	</div>
	</div>
</body>
</html>