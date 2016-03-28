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
	<jsp:param name="jquery_placeholder" value="true"/>
</jsp:include>
<script type="text/javascript">
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

function changeType(obj){
	$("select[name='projTypeName2'] option[value!='']").remove();
	var projTypeName = obj.value;
	if(projTypeName != ""){
		var $projTypeName2 = $("select[name='projTypeName2']");
		if(projTypeName == "浙江省医学重点学科"){
			$option1 =$("<option value='重点学科群'>重点学科群</option>");
			$option2 =$("<option value='支撑学科'>支撑学科</option>");
			$option3 =$("<option value='创新学科'>创新学科</option>");
			$option4 =$("<option value='省市共建学科'>省市共建学科</option>");
			$option5 =$("<option value='县级龙头学科（全称：浙江省县级医学龙头学科）'>县级龙头学科（全称：浙江省县级医学龙头学科）</option>");
			$option6 =$("<option value='其他'>其他</option>");
			$projTypeName2.append($option1);
			$projTypeName2.append($option2);
			$projTypeName2.append($option3);
			$projTypeName2.append($option4);
			$projTypeName2.append($option5);
			$projTypeName2.append($option6);
		}else if(projTypeName == "浙江省中医药重点学科"){
			$option1 =$("<option value='学科群'>学科群</option>");
			$option2 =$("<option value='继承类'>继承类</option>");
			$option3 =$("<option value='创新类'>创新类</option>");
			$option4 =$("<option value='服务类'>服务类</option>");
			$option5 =$("<option value='基层优势类'>基层优势类</option>");
			$projTypeName2.append($option1);
			$projTypeName2.append($option2);
			$projTypeName2.append($option3);
			$projTypeName2.append($option4);
			$projTypeName2.append($option5);
		}else if(projTypeName == "杭州市医学重点学科"){
			$option1 =$("<option value='一类'>一类</option>");
			$option2 =$("<option value='二类'>二类</option>");
			$option3 =$("<option value='三类'>三类</option>");
			$projTypeName2.append($option1);
			$projTypeName2.append($option2);
			$projTypeName2.append($option3);
		}
	}
}

$(document).ready(function(){
	changeType($("#projTypeName")[0]);
	var projTypeName2 = "${resultMap.projTypeName2}";
	if(projTypeName2 != ""){
		$("select[name='projTypeName2'] option[value='"+projTypeName2+"']").attr("selected",true);
	}
	doDisabled();
});

function doDisabled(){
	$('.content input[type!=button]').attr('readonly' , "readonly");
  	$("input[name='applyResult']").attr('disabled' , "disabled");
  	$('.content textarea').attr('readonly' , "readonly");
  	$('.content select').attr('disabled' , "disabled");
  	$(".ctime").removeAttr("onclick");
}
</script>

</head>
<body>
<div id="main" >
    <div class="mainright">
        <div class="content">
    	    <ul id="tags">
                <li class="selectTag" id="tag0"><a onclick="selectTag('tagContent0','tag0')" href="javascript:void(0)">基本信息</a></li>
                <li id="tag1"><a onclick="selectTag('tagContent1','tag1')" href="javascript:void(0)">附件信息</a></li>
            </ul>
                <input type="hidden" id="pageName" name="pageName" value="step1">
            	<input type="hidden" id="projFlow" name="projFlow" value="${aidProj.projFlow}"/>
            	<input type="hidden" id="projSubCategoryId" name="projSubCategoryId" value="${param.typeId}"/>
            	
            	<input type="hidden" name="projYear" value="${pdfn:getCurrYear()}"/>
            	<input type="hidden" id="projCategoryId" name="${ProjCategroyEnumXk.id}"/>
            	<input type="hidden" id="projCategoryName" name="${ProjCategroyEnumXk.name}"/>
            	<input type="hidden" id="projSubCategoryName" name="学科备案"/>
            	
    	        <div id="tagContent">
                    <div class="tagContent selectTag" id="tagContent0">
    	                <table width="100%" class="basic"> 
    	                    <tr>
    	                        <th class="theader" colspan="4" style="text-align: left;padding-left: 20px">基本信息</th>
    	                    </tr>
   	                        <tr>
   	                            <td width="15%" style="text-align: right;"><span style="color: red;">*</span>&nbsp;学科名称：</td>
   	                            <td width="35%" colspan="3">
   	                            	<input type="text" class="validate[required] inputText" name="projName" value="${resultMap.projName}" style="width:90%;text-align: left;"/>
   	                            </td>
   	                        </tr>
    	                    <tr>
    	                    	<td width="15%" style="text-align: right;">学科类型：</td>
   	                            <td width="35%">
   	                            	<select id="projTypeName" name="projTypeName" onchange="changeType(this);" class="inputText" style="width: 90%;">
										<option value="">请选择</option>
										<option value="浙江省医学重点学科" <c:if test="${resultMap.projTypeName eq '浙江省医学重点学科'}">selected="selected"</c:if>>浙江省医学重点学科</option>
										<option value="浙江省中医药重点学科" <c:if test="${resultMap.projTypeName eq '浙江省中医药重点学科'}">selected="selected"</c:if>>浙江省中医药重点学科</option>
										<option value="杭州市医学重点学科" <c:if test="${resultMap.projTypeName eq '杭州市医学重点学科'}">selected="selected"</c:if>>杭州市医学重点学科</option>
										<option value="其他学科" <c:if test="${resultMap.projTypeName eq '其他学科'}">selected="selected"</c:if>>其他学科</option>
									</select>
   	                            </td>
   	                            <td width="15%" style="text-align: right;">详细类型：</td>
   	                            <td width="35%">
   	                            	<select id="projTypeName2" name="projTypeName2" class="inputText" style="width: 90%;">
										<option value="">请选择</option>
									</select>
   	                            </td>
   	                        </tr>
   	                        <tr>
   	                            <td style="text-align: right;">单位：</td>
   	                            <td>
   	                            	<input type="text" class="inputText" name="applyOrgName" value="${empty resultMap.applyOrgName?sessionScope.currUser.orgName:resultMap.applyOrgName}" style="width:90%;text-align: left;"/>
   	                            </td>
   	                            <td style="text-align: right;">学科带头人：</td>
   	                            <td>
   	                            	<input type="text" class="inputText" name="applyUserName" value="${empty resultMap.applyUserName?sessionScope.currUser.userName:resultMap.applyUserName}" style="width:90%;text-align: left;"/>
   	                            </td>
   	                        </tr>
   	                        <tr>
   	                            <td style="text-align: right;">建设周期：</td>
   	                            <td>
   	                            	<input type="text" class="inputText" name="buildPeriod" value="${resultMap.buildPeriod}" style="width:90%;text-align: left;"/>
   	                            </td>
   	                            <td style="text-align: right;">经费补助：</td>
   	                            <td>
   	                            	<input type="text" class="validate[custom[number]] inputText" name="fundSubsidy" value="${resultMap.fundSubsidy}" style="width:90%;text-align: left;"/>
   	                            </td>
   	                        </tr>
   	                        <tr>
   	                            <td style="text-align: right;">申报结果：</td>
   	                            <td colspan="3" style="text-align: left; padding-left: 2%;">
   	                            	<input type="checkbox" name="applyResult" id="applyResult_Y" value="通过" <c:if test="${resultMap.applyResult=='通过'}">checked="checked"</c:if>/>&nbsp;<label for="applyResult_Y">通过</label>
   	                            	&#12288;<input type="checkbox" name="applyResult" id="applyResult_N" value="不通过" <c:if test="${resultMap.applyResult=='不通过'}">checked="checked"</c:if>/>&nbsp;<label for="applyResult_N">不通过</label>
   	                            </td>
   	                        </tr>
    	                </table>
    	                
    	                <table width="100%" class="basic" style="margin-top: 20px;"> 
    	                    <tr>
    	                        <th style="text-align: left;padding-left: 20px;">中期考核结果：</th>
    	                    </tr>
    	                    <tr>
    	                        <td>
    	                            <textarea name="mediumResult" placeholder="" class="xltxtarea">${resultMap.mediumResult}</textarea>
    	                        </td>
    	                    </tr>
    	                    <tr>
    	                        <th style="text-align: left;padding-left: 20px;">验收结果：</th>
    	                    </tr>
    	                    <tr>
    	                        <td>
    	                            <textarea name="completeResult" placeholder="" class="xltxtarea">${resultMap.completeResult}</textarea>
    	                        </td>
    	                    </tr>
    	                </table>
    	            </div>
    	        
    	        
    	        <div class="tagContent" id="tagContent1">
    	        	<c:set var="file1"/>
    	        	<c:set var="file2"/>
    	        	<c:set var="file3"/>
    	        	<c:set var="file4"/>
    	        	<c:forEach items="${resultMap.fileEdit}" var="fe">
						<c:if test="${fe.objMap.fileEdit_fileRemark eq '1'}">
							<c:set var="file1" value="${fe.objMap.fileEdit_file}"/>
						</c:if>
						<c:if test="${fe.objMap.fileEdit_fileRemark eq '2'}">
							<c:set var="file2" value="${fe.objMap.fileEdit_file}"/>
						</c:if>
						<c:if test="${fe.objMap.fileEdit_fileRemark eq '3'}">
							<c:set var="file3" value="${fe.objMap.fileEdit_file}"/>
						</c:if>
						<c:if test="${fe.objMap.fileEdit_fileRemark eq '4'}">
							<c:set var="file4" value="${fe.objMap.fileEdit_file}"/>
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
						<tbody id="fileListTb">
		    			<tr>
				             <td style="text-align: center;" class="fileListSerial">1</td>
				             <td>
				             	<c:if test="${not empty file1}">
									<a href='<s:url value="/pub/file/down?fileFlow=${file1}"/>'>申报材料</a>
									<input type="hidden" name="fileEdit_fileRemark" value="1"/>
									<input type="hidden" name="fileEdit_fileName" value="申报材料"/>
								</c:if>
				             	<c:if test="${empty file1}">申报材料</c:if>
				             </td>
				             <td>
								<c:if test="${not empty file1}">
									<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/>
								</c:if>
				             </td>
						</tr>
						
		    			<tr>
				             <td style="text-align: center;" class="fileListSerial">2</td>
				             <td>
				             	<c:if test="${not empty file2}">
									<a href='<s:url value="/pub/file/down?fileFlow=${file2}"/>'>学科合同书</a>
									<input type="hidden" name="fileEdit_fileRemark" value="2"/>
									<input type="hidden" name="fileEdit_fileName" value="学科合同书"/>
								</c:if>
				             	<c:if test="${empty file2}">学科合同书</c:if>
				             </td>
				             <td>
								<c:if test="${not empty file2}">
									<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/>
								</c:if>
				             </td>
						</tr>
						
		    			<tr>
				             <td style="text-align: center;" class="fileListSerial">3</td>
				             <td>
				             	<c:if test="${not empty file3}">
									<a href='<s:url value="/pub/file/down?fileFlow=${file3}"/>'>评估检查表</a>
									<input type="hidden" name="fileEdit_fileRemark" value="3"/>
									<input type="hidden" name="fileEdit_fileName" value="评估检查表"/>
								</c:if>
				             	<c:if test="${empty file3}">评估检查表</c:if>
				             </td>
				             <td>
								<c:if test="${not empty file3}">
									<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/>
								</c:if>
				             </td>
						</tr>
						
		    			<tr>
				             <td style="text-align: center;" class="fileListSerial">4</td>
				             <td>
				             	<c:if test="${not empty file4}">
									<a href='<s:url value="/pub/file/down?fileFlow=${file4}"/>'>学科验收表</a>
									<input type="hidden" name="fileEdit_fileRemark" value="4"/>
									<input type="hidden" name="fileEdit_fileName" value="学科验收表"/>
								</c:if>
				             	<c:if test="${empty file4}">学科验收表</c:if>
				             </td>
				             <td>
								<c:if test="${not empty file4}">
									<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/>
								</c:if>
				             </td>
						</tr>
						
						<c:set var="count" value="4"/>
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
						</tbody>
					</table>
   	        </div>
        </div>
    </div>
</div>
</div>
</body>
</html>