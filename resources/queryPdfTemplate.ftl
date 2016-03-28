<html>
<head>
<title></title>
<style type="text/css">
body {
	margin-left: 45px;
	margin-right: 45px;
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

.querylist { border:1px solid #000; width:100%;}
.querylist th { border:1px solid #000; font-size: 14px; text-align:center; background:#ECF2FA;font-weight:normal;height:25px;}
.querylist td { border:1px solid #000; font-size: 13px; text-align:center;height:30px;}

.page_bottom {
	vertical-align:bottom;
	text-align: center;
}

@page {   
    size: A4 landscape;
    margin-left:70px;
 	margin-right:70px;
 	margin-top:10px;
    
    @top-center { 
    	content: element(header);
    };  
    @bottom-center{  
        content:"第" counter(page) "页/共 " counter(pages) "页";  
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
	<#if sdvList?exists>
		<div align="center">
		<div class="title">
			数据澄清表(Data Clarification Form,DCF)
		</div>
		<div class="table_title">
			<table style="table-layout:fixed; word-break:break-strict;">
				<tr>
					<td width="50%" align="left">发行编号：${dcf.dcfNo}
					</td>
					<td width="10%" align="right">发行日期：
					</td>
					<td width="20%" align="left">${dateTrans(dcf.dcfDate,"yyyy-MM-dd")}
					</td>
					<td width="20%" align="right">询问者：${dcf.dcfUserName}
					</td>
				</tr>
				<tr>
					<td width="50%" align="left">项目名称：${projName}
					</td>
					<td width="10%" align="right">研究机构：
					</td>
					<td width="40%" align="left" colspan="2">${orgName}
					</td>
				</tr>
			</table>
		</div>
		</div>
			<table class="querylist" style="table-layout:fixed; word-break:break-strict;">
				<tr>
					<th width="10%" rowspan="2">受试者编<br/>码/序号
					</th>
					<th width="20%" rowspan="2">数据项
					</th>
					<th width="10%" rowspan="2">原值
					</th>
					<th width="20%" rowspan="2">疑问事项
					</th>
					<th width="20%" rowspan="2">变更与修改<br/>选择 有/无
					</th>
					<th width="15%" colspan="2">录入者
					</th>
				</tr>
				<tr>
					<th width="5%">签名
					</th>
					<th width="10%">确认日期
					</th>
				</tr>
				<#list sdvList as query>
					<#list queryEventMap?keys as qKey>
					    <#if qKey='${query.queryFlow }'>
						    <#assign item = queryEventMap[qKey]>   
						     <#list item as data>
						        <tr> 
									<td width="10%">${query.patientCode }/${query.querySeq }</td>
									<td width="20%">${data.elementName }.${data.attrName }</td>
									<td width="10%">${data.attrValue!'' }</td>
									<td width="20%">${query.queryContent!''}</td>
									<td width="10%">
									 <#if data.attrValue??>
									 <#assign attrValue="${data.attrValue}" >
									 <#else>
									 <#assign attrValue="" >
									 </#if>
									  <#if data.attrEventValue??>
									 <#assign attrEventValue="${data.attrEventValue}" >
									 <#else>
									 <#assign attrEventValue="" >
									 </#if>
										<#if attrValue  !=  attrEventValue>
											□无 &#12288;■有
										 </#if>
										 <#if attrValue  ==  attrEventValue>
											■无 &#12288;□有 
										</#if>
									</td>
									<td width="10%">${query.solveUserName!'' }</td>
									<td width="20%">${dateTrans(query.solveTime!'',"yyyy-MM-dd")}</td>
								</tr> 
						     </#list>
					     </#if>
					 </#list>
				</#list> 
			</table>
		</#if>
		<#if notSdvList?exists>
		 <#assign patientNum=0 >
		 <#list patientCodeList as patientCode>
		 <#assign patientNum=patientNum+1 >
		 <#assign break="always" >
		 <#if patientNum=patientCodeList?size>
		 	 <#assign break="auto" >
		 </#if>	 
		 <div style="page-break-after: ${break};">
		 	<div align="center">
		<div class="title">
			数据澄清表(Data Clarification Form,DCF)
		</div>
		<div class="table_title">
			<table style="table-layout:fixed;word-break:break-strict;">
				<tr>
					<td width="50%" align="left">发行编号：${dcf.dcfNo}
					</td>
					<td width="10%" align="right">发行日期：
					</td>
					<td width="20%" align="left">${dateTrans(dcf.dcfDate,"yyyy-MM-dd")}
					</td>
					<td width="20%" align="right">询问者：${dcf.dcfUserName}
					</td>
				</tr>
				<tr>
					<td width="50%" align="left">项目名称：${projName}
					</td>
					<td width="10%" align="right">受试者编码：
					</td>
					<td width="20%" align="left">${patientCode}
					</td>
					<td width="20%" align="right">研究机构：${orgName}
					</td>
				</tr>
			</table>
		</div>
		</div>
			<table class="querylist" style="table-layout:fixed; word-break:break-strict;">
				<tr>
					<th width="10%" rowspan="2">序号
					</th>
					<th width="20%" rowspan="2">数据项
					</th>
					<th width="10%" rowspan="2">原值
					</th>
					<th width="20%" rowspan="2">疑问事项
					</th>
					<th width="20%" rowspan="2">变更与修改<br/>选择 有/无
					</th>
					<th width="10%" rowspan="2">修改值
					</th>
					<th width="15%" colspan="2">研究者
					</th>
				</tr>
				<tr>
					<th width="5%">签名
					</th>
					<th width="10%">确认日期
					</th>
				</tr>
				<#assign queryList = patientQueryMap[patientCode]>
				<#list queryList as query>  
				<#list queryEventMap?keys as qKey>
					<#if qKey='${query.queryFlow }'>
						<#assign item = queryEventMap[qKey]>   
						 	 <#assign status=0 >
						     <#list item as data>
						        <tr> 
						        <#if status=0>
									<td rowspan="${item?size }" width="10%">${query.querySeq }</td>
								</#if>
									<td width="20%">${data.elementName }.${data.attrName }</td>
									<td width="10%">${data.attrValue!'' }</td>
								<#if status=0>
									<td rowspan="${item?size }" width="20%">${query.queryContent!''}</td>
								</#if>
									<td width="10%">
									<#if data.attrValue??>
									 <#assign attrValue="${data.attrValue}" >
									 <#else>
									 <#assign attrValue="" >
									 </#if>
									  <#if data.attrEventValue??>
									 <#assign attrEventValue="${data.attrEventValue}" >
									 <#else>
									 <#assign attrEventValue="" >
									 </#if>
										<#if attrValue  !=  attrEventValue>
											□无 &#12288;■有
										 </#if>
										 <#if attrValue  ==  attrEventValue>
											■无 &#12288;□有 
										</#if>
									</td>
									<td width="10%">
									</td>
									<#if status=0>
									<td rowspan="${item?size }" width="10%">${query.solveUserName!'' }</td>
									</#if>
									<#if status=0>
									<td rowspan="${item?size }" width="15%">${dateTrans(query.solveTime!'',"yyyy-MM-dd")}</td>
									</#if>
								</tr>
								<#assign status=status+1 >	 
						     </#list>
					 </#if>
				</#list>
				</#list>
			</table>
			</div>
			</#list>
			</#if>
</body>
</html>
