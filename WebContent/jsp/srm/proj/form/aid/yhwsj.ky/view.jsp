<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
</jsp:include>
<script type="text/javascript">

function back(){
	history.back();
}
function selectTag(showContent, selfObj) {
	if(false==$("#projAidForm").validationEngine("validate")){
		return false;
	}
    // 操作标签
    var tag = document.getElementById("tags").getElementsByTagName("li");
    var taglength = tag.length;
    for (var i = 0; i < taglength; i++) {
        tag[i].className = "";
    }
    $('#'+selfObj).addClass("selectTag");
    // 操作内容
    for (var i = 0; j = document.getElementById("tagContent" + i); i++) {
        j.style.display = "none";
    }
    document.getElementById(showContent).style.display = "block";
    $("#flag").val("flag");
}

function showDelayDate(projStatus){
	if(projStatus == "延期"){
		$("#delayDate").show();
	}else{
		$("#delayDate").hide();
	}
}
$(function(){
  	$('#main input[type!=button]').attr('readonly', "readonly");
  	$('.ctime').attr('disabled', "disabled");
  	$('#main textarea').attr('readonly', "readonly");
  	$('#main select').attr('disabled', "disabled");
  	$(".ctime").removeAttr("onclick");
  	showDelayDate("${resultMap.projStatus}");
});
</script>

</head>
<body>
<div id="main" >
    <div class="mainright">
        <div class="content">
    	    <ul id="tags">
                <li class="selectTag" id="tag0"><a onclick="selectTag('tagContent0','tag0')" href="javascript:void(0)">项目基本情况</a></li>
                <li id="tag1"><a onclick="selectTag('tagContent1','tag1')" href="javascript:void(0)">项目经费</a></li>
                <li id="tag2"><a onclick="selectTag('tagContent2','tag2')" href="javascript:void(0)">附件信息</a></li>
            </ul>
            
                <input type="hidden" id="projFlow" name="projFlow" value="${aidProj.projFlow }">
                <input type="hidden" name="pageName" value="step1">
    	        <div id="tagContent">
                    <div class="tagContent selectTag" id="tagContent0">
    	                <table width="100%" class="bs_tb"> 
    	                    <tr>
    	                        <th class="theader" colspan="4" style="text-align: left;padding-left: 20px">项目信息</th>
    	                    </tr>
    	                    <tbody>
    	                        <tr>
    	                            <td style="text-align: right;">序号：</td>
    	                            <td>
    	                            	<input type="text" class="inputText" name="projSerialNum" value="${resultMap.projSerialNum}" style="width:90%;text-align: left;"/>
    	                            </td>
    	                            <td style="text-align: right;">单位：</td>
    	                            <td>
    	                            	<input type="text" class="inputText" name="applyOrgName" value="${empty resultMap.applyOrgName?sessionScope.currUser.orgName:resultMap.applyOrgName}" style="width:90%;text-align: left;"/><input type="text" class="inputText" name="projOrgName" value="${resultMap.projOrgName}" style="width:90%;text-align: left;"/>
    	                            </td>
    	                        </tr>
    	                        <tr>
    	                            <td style="text-align: right;"><span style="color: red;">*</span>项目名称：</td>
    	                            <td>
    	                            	<input type="text" class="validate[required] inputText" name="projName" value="${aidProj.projName}" style="width:90%;text-align: left;"/>
    	                            </td>
    	                            <td style="text-align: right;">项目负责人：</td>
    	                            <td>
    	                            	<input type="text" class="inputText" name="projLeader" value="${resultMap.projLeader}" style="width:90%;text-align: left;"/>
    	                            </td>
    	                        </tr>
    	                        <tr>
    	                            <td style="text-align: right;">承担科室：</td>
    	                            <td>
    	                            	<input type="text" class="inputText" name="applyDeptName" value="${empty resultMap.applyDeptName?sessionScope.currUser.deptName:resultMap.applyDeptName}" style="width:90%;text-align: left;"/>
    	                            </td>
    	                            <td style="text-align: right;">项目级别：</td>
    	                            <td>
    	                            	<input type="text" class="inputText" name="projRank" value="${resultMap.projRank}" style="width:90%;text-align: left;"/>
    	                            </td>
    	                        </tr>
    	                        <tr>
    	                            <td style="text-align: right;">开始日期：</td>
    	                            <td style="text-align: left;">
    	                                 <input type="text"  name="projStartTime" value="${aidProj.projStartTime }" readonly="readonly" class="inputText ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="margin-left: 20px;">
    	                            </td>
    	                            <td style="text-align: right;">结束日期：</td>
    	                            <td style="text-align: left;">
    	                                 <input type="text" name="projEndTime" value="${aidProj.projEndTime}" readonly="readonly" class="inputText ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="margin-left: 20px;">
    	                            </td>
    	                        </tr>
    	                        <tr>
    	                            <td style="text-align: right;">项目状态：</td>
    	                            <td>
    	                                <select name="projStatus" class="validate[required] inputText" onchange="showDelayDate(this.value)" style="width: 90%;">
										<option value="">请选择</option>
    	                                <c:forEach var="dict" items="${dictTypeEnumYhProjStatusList}">
					                   		<option value="${dict.dictName}" <c:if test="${resultMap.projStatus eq dict.dictName}">selected="selected"</c:if>>${dict.dictName}</option> 
					                    </c:forEach>
					                    </select>
    	                            </td>
    	                            <td style="text-align: right;"><span style="color: red;">*</span>项目编号：</td>
    	                            <td>
    	                                <input type="text" name="projNo" value="${aidProj.projNo}"  class="validate[maxSize[25]] inputText" style="width:90%;text-align: left;">
    	                            </td>
    	                        </tr>
   	                         	<tr style="display: none;" id="delayDate">
    	                            <td style="text-align: right;">延期日期：</td>
    	                            <td style="text-align: left;" colspan="3">
    	                                 <input type="text"  name="projDelayDate" value="${resultMap.projDelayDate}" readonly="readonly" class="inputText ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="margin-left: 20px;">
    	                            </td>
    	                        </tr>
    	                    </tbody>
    	                </table>
    	                
    	                <table width="100%" class="basic" style="margin-top: 20px;"> 
    	                    <tr>
    	                        <th style="text-align: left;padding-left: 20px">项目简介</th>
    	                    </tr>
    	                    <tr>
    	                        <td>
    	                            <textarea name="projIntr" placeholder="此处填写项目简介" rows="10" cols="20" class="xltxtarea">${resultMap.projIntr }</textarea>
    	                        </td>
    	                    </tr>
    	                    <tr>
    	                        <td style="text-align: left;padding-left: 20px;">备注</td>
    	                    </tr>
    	                    <tr>
    	                        <td>
    	                            <textarea name="projRemark" placeholder="这里填写备注信息" rows="10" cols="20" class="xltxtarea">${resultMap.projRemark }</textarea>
    	                        </td>
    	                    </tr>
    	                </table>
    	            </div>

    	        
    	        
    	        <div class="tagContent" id="tagContent1">
    	            <div id="fund"> 
    	                <table width="100%" class="bs_tb" > 
    	                    <tr>
    	                        <th class="theader" colspan="7">项目经费（单位：万元）</th>
    	                    </tr>
    	                    <tr>
    	                        <td width="20px"></td>
		       					<td width="40px">序号</td>
    	                        <td width="13%">年度</td>
    	                        <td width="20%">省市</td>
    	                        <td width="20%">区级</td>
    	                        <td width="20%">单位配套</td>
    	                        <td width="20%">自筹</td>
    	                    </tr>
    	                    <tbody id="fundsTb">
   	                        <c:forEach items="${resultMap.fund}" var="fund" varStatus="status">
                            <tr>
                                <td width="20px" style="text-align: center;"><input name="fundsIds" type="checkbox"/></td>
								<td width="40px" style="text-align: center;" class="fundsSerial">${status.count}</td>
                                <td><input type="text" class="inputText ctime"  style="width:90%;" name="fund_year" value="${fund.objMap.fund_year}" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy'})"  readonly="readonly"></td>
                                <td><input type="text" class="validate[custom[number]] inputText" style="width:90%;" name="fund_provinceCity" value="${fund.objMap.fund_provinceCity}"></td>
                                <td><input type="text" class="validate[custom[number]] inputText" style="width:90%;" name="fund_district" value="${fund.objMap.fund_district}"></td>
                                <td><input type="text" class="validate[custom[number]] inputText" style="width:90%;" name="fund_orgMating" value="${fund.objMap.fund_orgMating}"></td>
                                <td><input type="text" class="validate[custom[number]] inputText" style="width:90%;" name="fund_selfRaised" value="${fund.objMap.fund_selfRaised}"></td>
                            </tr>
                            </c:forEach>
                            <c:if test="${empty resultMap.fund}">
                            <tr>
                                <td colspan="7">无记录</td>
                            </tr>
                            </c:if>
    	                    </tbody>
    	                </table>
    	            </div>
    	        </div>
    	        <div class="tagContent" id="tagContent2">
   	        		<c:set var="file1"/>
    	        	<c:forEach items="${resultMap.fileEdit}" var="fe">
						<c:if test="${fe.objMap.fileEdit_fileRemark eq '1'}">
							<c:set var="file1" value="${fe.objMap.fileEdit_file}"/>
						</c:if>
					</c:forEach>
			        <table class="bs_tb" style="width: 100%">
					    <tr>
			                <th colspan="5" class="theader">附件
			                </th>
			            </tr>
					    <tr>
			           		<td width="5%" style="font-weight:bold;padding: 0px;">序号</td>
			                <td width="80%" style="font-weight:bold;padding: 0px;">附件名称</td>
			                <td>有（√）</td>
			            </tr>
						<tr>
				             <td style="text-align: center;" class="fileListSerial">1</td>
				             <td>
				             	<c:if test="${not empty file1}">
									<a href='<s:url value="/pub/file/down?fileFlow=${file1}"/>'>立项文件</a>
									<input type="hidden" name="fileEdit_fileRemark" value="1"/>
									<input type="hidden" name="fileEdit_fileName" value="立项文件"/>
								</c:if>
				             	<c:if test="${empty file1}">立项文件</c:if>
				             </td>
				             <td>
								<c:if test="${not empty file1}">
									<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/>
								</c:if>
				             </td>
						</tr>
						
				        <c:set var="count" value="1"/>
						<c:forEach items="${resultMap.fileEdit}" var="fe">
						<c:if test="${fe.objMap.fileEdit_fileRemark =='other'}">
						<tr>
							<td class="fileListSerial">${count+1}<c:set var="count" value="${count+1}"/></td>
							<td>
								<a href='<s:url value="/pub/file/down?fileFlow=${fe.objMap.fileEdit_file}"/>'>${fe.objMap.fileEdit_fileName}</a>
								<input type="hidden" name="fileEdit_fileRemark" value="${fe.objMap.fileEdit_fileRemark}"/>
								<input type="hidden" name="fileEdit_fileName" value="${fe.objMap.fileEdit_fileName}"/>
								<input type="hidden" name="fileEdit_file" value="${fe.objMap.fileEdit_file}"/>
							</td>
							<td><img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/></td>
						</tr>
						</c:if>
						</c:forEach>
					</table>
    	        </div>
        	</div>
        </div>
    </div>
</div>
</body>
</html>