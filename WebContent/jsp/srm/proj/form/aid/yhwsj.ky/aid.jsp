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
	<jsp:param name="jquery_ztree" value="true"/>
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

function add(tb){
 	$("#"+tb+"Tb").append($("#"+tb+"Template tr:eq(0)").clone());
 	
 	var length = $("#"+tb+"Tb").children().length;
 	//序号
	$("#"+tb+"Tb").children("tr").last().children("td").eq(1).text(length);
}

function delTr(tb){
	//alert("input[name="+tb+"Ids]:checked");
	var checkboxs = $("input[name='"+tb+"Ids']:checked");
	if(checkboxs.length==0){
		jboxTip("请勾选要删除的！");
		return false;
	}
	jboxConfirm("确认删除?",function () {
		var trs = $('#'+tb+'Tb').find(':checkbox:checked');
		$.each(trs , function(i , n){
			$(n).parent('td').parent("tr").remove();
		});
		//删除后序号
		var serial = 0;
		$("."+tb+"Serial").each(function(){
			serial ++;
			$(this).text(serial);
		});
	});
}

function delFile(obj){
	jboxConfirm("确认删除?",function () {
		$(obj).parent().parent().remove();
		//删除后序号
		var serial = 0;
		$(".fileListSerial").each(function(){
			serial ++;
			$(this).text(serial);
		});
	});
	
}
function delFile1(obj){
	jboxConfirm("确认删除?",function () {
		var $td = $(obj).parent();
		$td.html(null);
		$td.prev().html(null);
		var fileInput = "<input type='file' name='fileEdit_file'/>";
		$td.append(fileInput);
	});
}

function nextOpt(step){
	var projTypeName = $("select[name=projTypeId] :selected").text();
	$("#projTypeName").val(projTypeName);
	if(projTypeName=="请选择"){
		$("#projTypeName").val("");
	}
	var form = $("#projAidForm");
	if(false==form.validationEngine("validate")){
		return false;
	}
	jboxStartLoading();
	form.append("<input name='nextPageName' value='"+step+"' type='hidden'/>");
	form.submit();
}

function showDelayDate(projStatus){
	if(projStatus == "延期"){
		$("#delayDate").show();
	}else{
		$("#delayDate").hide();
	}
}
$(function(){
	showDelayDate("${resultMap.projStatus}");
	var projDeclarer = $("select[name='projDeclarer']");
	searchProjCategory(projDeclarer, "selected");//"selected"选中回显
});

function searchProjCategory(obj, selected){
	var dictFlow = $("select[name='projDeclarer'] option:selected").attr("dictFlow");
	var dictTypeId = $(obj).val();
	var data = {
			dictFlow : dictFlow,
			dictTypeId : dictTypeId
	};
	var url = "<s:url value='/sys/dict/getCategoryDictByDeclarer'/>";
	jboxPost(url , data , function(data){
		//清空原类别！
		$("select[name=projTypeId] option[value != '']").remove();
		var dataObj = data; 
		for(var i =0;i<dataObj.length;i++){
			var cId =dataObj[i].dictId;
			var cName =dataObj[i].dictName;
			$option =$("<option></option>");
			$option.attr("value",cId);
			$option.text(cName);
			if(selected && "${resultMap.projTypeId}" == cId){
				$option.attr("selected","selected");
			}
			$("select[name='projTypeId']").append($option);
		}
	} , null , false);
}

</script>

</head>
<body>
<div id="main" >
    <div class="mainright">
        <div class="content">
    	    <ul id="tags">
                <li class="selectTag" id="tag0"><a onclick="selectTag('tagContent0','tag0')" href="javascript:void(0)">项目基本情况</a></li>
                <li id="tag1"><a onclick="selectTag('tagContent1','tag1')" href="javascript:void(0)">项目经费</a></li>
                <li id="tag2"><a onclick="selectTag('tagContent2','tag2')" href="javascript:void(0)">附件上传</a></li>
            </ul>
    	    <form  method="post" action="<s:url value="/srm/aid/proj/saveStepForKy"/>" id="projAidForm"  style="position: relative;" enctype="multipart/form-data">
                <input type="hidden" id="pageName" name="pageName" value="step1">
            	<input type="hidden" id="projFlow" name="projFlow" value="${aidProj.projFlow}"/>
            	<input type="hidden" id="projSubCategoryId" name="projSubCategoryId" value="${param.typeId}"/>
            	
            	<input type="hidden" name="projYear" value="${pdfn:getCurrYear()}"/>
            	<input type="hidden" id="projTypeName" name="projTypeName"/>
            	
    	        <div id="tagContent">
                    <div class="tagContent selectTag" id="tagContent0">
    	                <table width="100%" class="bs_tb"> 
    	                    <tr>
    	                        <th class="theader" colspan="4" style="text-align: left;padding-left: 20px">项目信息</th>
    	                    </tr>
    	                    <tbody>
    	                        <tr>
    	                            <td width="15%" style="text-align: right;">序号：</td>
    	                            <td width="35%">
    	                            	<input type="text" class="inputText" name="projSerialNum" value="${resultMap.projSerialNum}" style="width:90%;text-align: left;"/>
    	                            </td>
    	                            <td width="15%" style="text-align: right;">单位：</td>
    	                            <td width="35%">
    	                            	<input type="text" class="inputText" name="applyOrgName" value="${empty resultMap.applyOrgName?sessionScope.currUser.orgName:resultMap.applyOrgName}" style="width:90%;text-align: left;"/>
    	                            </td>
    	                        </tr>
    	                        
    	                        <tr>
    	                            <td style="text-align: right;">项目来源：</td>
    	                            <td>
    	                            	<select name="projDeclarer" class="inputText" style="width:90%;text-align: left;" onchange="searchProjCategory(this);">
    	                            	    <option value="">请选择</option>
    	                            	    <c:forEach items="${dictTypeEnumYhBAProjCategoryList}" var="dict" varStatus="status">
    	                            	        <option dictFlow="${dict.dictFlow}" value="${dict.dictId}" <c:if test="${resultMap.projDeclarer eq dict.dictId}">selected="selected"</c:if>>${dict.dictName}</option>
    	                            	    </c:forEach>
    	                            	</select>
    	                            </td>
    	                            <td style="text-align: right;">项目类别：</td>
    	                            <td>
    	                            	<select name="projTypeId" class="inputText" style="width:90%;text-align: left;">
    	                            		<option value="">请选择</option>
    	                            	</select>
    	                            </td>
    	                        </tr>
    	                        
    	                        <tr>
    	                            <td style="text-align: right;"><span style="color: red;">*</span>项目名称：</td>
    	                            <td>
    	                            	<input type="text" class="validate[required] inputText" name="projName" value="${aidProj.projName}" style="width:90%;text-align: left;"/>
    	                            </td>
    	                            <td style="text-align: right;">项目负责人：</td>
    	                            <td>
    	                            	<input type="text" class="inputText" name="projLeader" value="${empty resultMap.projLeader?sessionScope.currUser.userName:resultMap.projLeader}" style="width:90%;text-align: left;"/>
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
    	                                 <input type="text"  name="projStartTime" value="${empty aidProj.projStartTime?pdfn:getCurrDate():aidProj.projStartTime}" readonly="readonly" class="inputText ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="margin-left: 20px;">
    	                            </td>
    	                            <td style="text-align: right;">结束日期：</td>
    	                            <td style="text-align: left;">
    	                                 <input type="text" name="projEndTime" value="${empty aidProj.projEndTime?pdfn:getCurrDate():aidProj.projEndTime}" readonly="readonly" class="inputText ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="margin-left: 20px;">
    	                            </td>
    	                        </tr>
    	                        <tr>
    	                            <td style="text-align: right;">项目状态：</td>
    	                            <td>
    	                                <select name="projStatus" class="inputText" onchange="showDelayDate(this.value)" style="width: 90%;">
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
    	                <div class="button" style="width: 100%; text-align: center;margin-top: 20px;">
    	                    <input type="button" onclick="selectTag('tagContent1','tag1')" class="search" value="下一步"/>
	                    </div>
    	            </div>
    	        
    	        <div class="tagContent" id="tagContent1">
    	            <div id="fund"> 
    	                <table width="100%" class="bs_tb" > 
    	                    <tr>
    	                        <th class="theader" colspan="7">项目经费（单位：万元）
    	                            <c:if test="${param.view!=GlobalConstant.FLAG_Y }">
										<span style="float: right;padding-right: 10px">
										<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('funds')"></img>&#12288;
										<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('funds');"></img></span>
									</c:if>
    	                        </th>
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
    	                    </tbody>
    	                </table>
    	            </div>
    	            <div class="button" style="width: 100%;text-align: center;margin-top: 20px;">
    	            	<input type="button" onclick="selectTag('tagContent0','tag0')" class="search" value="上一步"/>
    	            	<input type="button" onclick="selectTag('tagContent2','tag2')" class="search" value="下一步"/>
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
                				<c:if test="${param.view!=GlobalConstant.FLAG_Y}">
                					<span style="float: right;padding-right: 10px">
									<a href="javascript:void(0)"><img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('fileList')"></img></a>&#12288;
									<a href="javascript:void(0)"><img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('fileList')"></img></a>
									</span>
								</c:if>
			                </th>
			            </tr>
					    <tr>
			           		<td width="3%"></td>
			           		<td width="5%" style="font-weight:bold;padding: 0px;">序号</td>
			                <td width="50%" style="font-weight:bold;padding: 0px;">附件名称</td>
			                <td width="15%">有（√）</td>
			                <c:if test="${param.view!=GlobalConstant.FLAG_Y }">
			                	<td width="30%">操作</td>
			                </c:if>
			            </tr>
						<tbody id="fileListTb">
		    			<tr>
			   				 <td width="3%"></td>
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
							<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
								<td style="padding-left: 20px;">
									<c:if test="${not empty file1}">
										[<a href="javascript:void(0)" onclick="delFile1(this)">删除</a>]
										<input type="hidden" name="fileEdit_file" value="${file1}"/>
									</c:if>
									<c:if test="${empty file1}">
									   <input type="file" name="fileEdit_file" />
									   <input type="hidden" name="fileEdit_fileRemark" value="1"/>
									   <input type="hidden" name="fileEdit_fileName" value="立项文件"/>
									</c:if>
								</td>
							</c:if>
						</tr>
						
						<c:set var="count" value="1"/>
						<c:forEach items="${resultMap.fileEdit}" var="fe">
						<c:if test="${fe.objMap.fileEdit_fileRemark =='other'}">
						<tr>
							<td></td>
							<td class="fileListSerial">${count+1}<c:set var="count" value="${count+1}"/></td>
							<td>
								<a href='<s:url value="/pub/file/down?fileFlow=${fe.objMap.fileEdit_file}"/>'>${fe.objMap.fileEdit_fileName}</a>
								<input type="hidden" name="fileEdit_fileRemark" value="${fe.objMap.fileEdit_fileRemark}"/>
								<input type="hidden" name="fileEdit_fileName" value="${fe.objMap.fileEdit_fileName}"/>
								<input type="hidden" name="fileEdit_file" value="${fe.objMap.fileEdit_file}"/>
							</td>
							<td><img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/></td>
							<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
								<td style="padding-left: 20px;">
									[<a href="javascript:void(0)" onclick="delFile(this)">删除</a>]
								</td>
							</c:if>
						</tr>
						</c:if>
						</c:forEach>
						</tbody>
					</table>
    	            <div class="button" style="width: 100%;text-align: center; margin-top: 20px;">
    	            	<input type="button" onclick="selectTag('tagContent1','tag1')" class="search" value="上一步"/>
    	            	<input type="button" onclick="nextOpt('finish')" class="search" value="保&#12288;存"/>
	                </div>
    	        </div>
   	        </div>
    	    </form>
        </div>
    </div>
</div>

<div style="display: none;">
   		<!-- 项目经费  模板 -->
  		<table id="fundsTemplate" width="100%" class="bs_tb" style="margin-top: 20px;">
		<tr>
			<td width="20px" style="text-align: center;"><input name="fundsIds" type="checkbox"/></td>
			<td width="40px" style="text-align: center;" class="fundsSerial"></td>
			<td><input type="text" class="inputText ctime"  style="width:90%;" name="fund_year" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy'})"  readonly="readonly"></td>
			<td><input type="text" class="validate[custom[number]] inputText" style="width:90%;" name="fund_provinceCity"></td>
			<td><input type="text" class="validate[custom[number]] inputText" style="width:90%;" name="fund_district"></td>
			<td><input type="text" class="validate[custom[number]] inputText" style="width:90%;" name="fund_orgMating"></td>
			<td><input type="text" class="validate[custom[number]] inputText" style="width:90%;" name="fund_selfRaised"></td>
		</tr>
  		</table>
  		
  		<!-- 文件 -->
  		<table class="basic" id="fileListTemplate" style="width: 100%">
        <tr>
             <td width="3%" style="text-align: center;"><input name="fileListIds" type="checkbox"/></td>
             <td width="5%" style="text-align: center;" class="fileListSerial"></td>
             <td>
             	<input type="text" name="fileEdit_fileName" class="inputText" style="width: 80%"/>
             	<input type="hidden" name="fileEdit_fileRemark" class="validate[required]" value="other"/>
             </td>
             <td></td>
             <td style="padding-left: 20px;">
             	<input type="file" name="fileEdit_file" class="validate[required]"/>
             </td>
		</tr>
		</table>
</div>
</body>
</html>