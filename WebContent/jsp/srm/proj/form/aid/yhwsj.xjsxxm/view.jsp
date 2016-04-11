<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
</jsp:include>
<script type="text/javascript">

$(function(){
	  	$('.content input[type!=button]').attr('readonly' , "readonly");
	  	$('.content textarea').attr('readonly' , "readonly");
	  	$('.content select').attr('disabled' , "disabled");
	  	$(".ctime").removeAttr("onclick");
});
</script>

</head>
<body>
<div id="main" >
    <div class="mainright">
        <div class="content">
    	    <form  method="post" action="<s:url value="/srm/aid/proj/saveStepForKy"/>" id="projAidForm"  style="position: relative;" enctype="multipart/form-data">
                <input type="hidden" id="pageName" name="pageName" value="step1" >
            	<input type="hidden" id="projFlow" name="projFlow" value="${aidProj.projFlow}"/>
            	<input type="hidden" id="projSubCategoryId" name="projSubCategoryId" value="${param.typeId}"/>
            	
				<table width="100%" class="bs_tb"> 
					<tr>
						<th class="theader" colspan="4" style="text-align: left;padding-left: 20px">基本信息</th>
					</tr>
					<tbody>
					<tr>
						<td width="15%" style="text-align: right;">单位：</td>
						<td colspan="3" style="text-align: left; padding-left: 2%;">
							<input type="text" class="inputText" name="orgName" value="${resultMap.orgName}" style="width:90%;text-align: left;"/>
						</td>
					</tr>
					<tr>
						<td style="text-align: right;">项目名称：</td>
						<td colspan="3" style="text-align: left; padding-left: 2%;">
							<input type="text" class="inputText" name="projName" value="${resultMap.projName}" style="width:90%;text-align: left;"/>
						</td>
					</tr>
					<tr>
						<td style="text-align: right;">项目负责人：</td>
						<td width="35%">
							<input type="text" class="inputText" name="applyUserName" value="${resultMap.applyUserName}" style="width:90%;text-align: left;"/>
						</td>
						<td width="15%" style="text-align: right;">科室：</td>
						<td width="35%">
							<input type="text" class="inputText" name="applyDeptName" value="${resultMap.applyDeptName}" style="width:90%;text-align: left;"/>
						</td>
					</tr>
					<tr>
						<td style="text-align: right;">申请日期：</td>
						<td style="text-align: left; padding-left: 2%;">
							<input type="text" name="applyDate" value="${resultMap.applyDate}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputText ctime" style="width:150px;" readonly="readonly"/>
						</td>
						<td style="text-align: right;">开展时间：</td>
						<td style="text-align: left; padding-left: 2%;">
							<input type="text" name="launchTime" value="${resultMap.launchTime}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputText ctime" style="width:150px;" readonly="readonly"/>
						</td>
					</tr>
					<tr>
						<td style="text-align: right;">项目简介：</td>
						<td colspan="3" style="text-align:left;">
							<textarea placeholder=""  class="xltxtarea" name="projIntroduction">${resultMap.projIntroduction}</textarea>
						</td>
					</tr>
					<tr>
						<td style="text-align: right;">技术水平：</td>
						<td colspan="3" style="text-align: left; padding-left: 2%;">
							<select name="technologyLevel" class="inputText" style="width: 120px;">
								<option value="">请选择</option>
								<option value="国内" <c:if test="${resultMap.technologyLevel eq '国内'}">selected="selected"</c:if> >国内</option>
								<option value="省内" <c:if test="${resultMap.technologyLevel eq '省内'}">selected="selected"</c:if> >省内</option>
								<option value="市区" <c:if test="${resultMap.technologyLevel eq '市区'}">selected="selected"</c:if> >市区</option>
								<option value="区内" <c:if test="${resultMap.technologyLevel eq '区内'}">selected="selected"</c:if> >区内</option>
								<option value="院内" <c:if test="${resultMap.technologyLevel eq '院内'}">selected="selected"</c:if> >院内</option>
							</select>
						</td>
					</tr>
					</tbody>
				</table>
    	        
    	    </form>
        </div>
    </div>
</div>
</body>
</html>