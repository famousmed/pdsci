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

function delFile(fileFlow) {
	var url = "<s:url value='/pub/file/delete?fileFlow='/>" + fileFlow;
	jboxConfirm(url , null , function(resp){
		var projFlow = $('#projFlow').val();
		jboxTip(resp);
		$('#file').load("<s:url value='/srm/proj/mine/getFileList?projFlow='/>"+projFlow);
	} , null , false);
}

function delTr(tb){
	var trs = $('#'+tb).find(':checkbox:checked');
	jboxConfirm("确认删除？" , function(){
		$.each(trs , function(i , n){
			$(n).parent('td').parent("tr").remove();
			
		});
		
	});
}
function addFundScheme(tb,type){
	alert(type);
	var htmlCountry = '<tr>'+
	'<td><input type="checkbox" style="width:90%;"/></td>'+
    '<td><input type="text" class="validate[required] inputText" style="width:90%;" name="fund_year"  onclick="WdatePicker({dateFmt:'+"'yyyy'"+'})"></td>'+
    '<td><input type="text" class="validate[required] inputText" style="width:90%;" name="fund_countryCount" value=""></td>'+
    '<td><input type="text" class="validate[required] inputText" style="width:90%;" name="fund_provinceCount" value=""></td>'+
    '<td><input type="text" class="validate[required] inputText" style="width:90%;" name="fund_cityCount" value=""></td>'+
    '<td><input type="text" class="validate[required] inputText" style="width:90%;" name="fund_areaCount" value=""></td>'+
    '</tr>';
    var htmlProvince = '<tr>'+
	'<td><input type="checkbox" style="width:90%;"/></td>'+
    '<td><input type="text" class="validate[required] inputText" style="width:90%;" name="fund_year"  onclick="WdatePicker({dateFmt:'+"'yyyy'"+'})"></td>'+
    '<td><input type="text" class="validate[required] inputText" style="width:90%;" name="fund_provinceCount" value=""></td>'+
    '<td><input type="text" class="validate[required] inputText" style="width:90%;" name="fund_cityCount" value=""></td>'+
    '<td><input type="text" class="validate[required] inputText" style="width:90%;" name="fund_areaCount" value=""></td>'+
    '</tr>';
    var htmlCity = '<tr>'+
	'<td><input type="checkbox" style="width:90%;"/></td>'+
    '<td><input type="text" class="validate[required] inputText" style="width:90%;" name="fund_year"  onclick="WdatePicker({dateFmt:'+"'yyyy'"+'})"></td>'+
    '<td><input type="text" class="validate[required] inputText" style="width:90%;" name="fund_cityCount" value=""></td>'+
    '<td><input type="text" class="validate[required] inputText" style="width:90%;" name="fund_areaCount" value=""></td>'+
    '</tr>';
    if(type=="Country"){
    	$('#'+tb+'Tb').append(htmlCountry);
    }else if(type=="Province"){
    	$('#'+tb+'Tb').append(htmlProvince);
    }else if(type=="City"){
    	$('#'+tb+'Tb').append(htmlCity);
    }
	
}
function addFile(tb){
	var html = '<tr>'+
		'<td width="50px"><input type="checkbox"/></td>'+
		'<td  style="height: 30px;text-align: left;"><input type="file" class="validate[required] " name="file"/></td>'+
	'</tr>';
	$('#'+tb).append(html);
}

function nextOpt(step){
	var form = $("#projAidForm");
	if(false==form.validationEngine("validate")){
		return false;
	}
	jboxStartLoading();
	form.append("<input name='nextPageName' value='"+step+"' type='hidden'/>");
	form.submit();
}
	
function changeType(){
  if($("#flag").val()!="" || $("#projFlow").val()!=""){
	  tip="更改项目来源将会清空资金分配信息,";
		jboxConfirm(tip+"确认修改"+"?" , function(){
			var projDeclarer=$("#projDeclarer").val();
			//切换项目类别
			if(projDeclarer!=""){
				$("#projTypeTd").text("");
				$("#projTypeTd").append($("#"+projDeclarer).html());
			}
			$('#selectBelongVal').val($("#projDeclarer").find('option:selected').val());
			var selectValue=$("#projDeclarer").find('option:selected').val();
			//切换资金分配表格
			$('#fund').text("");
			$('#fund').append($("#"+selectValue+"Tb").html());
		} , function(){
			$("#projDeclarer").val($('#selectBelongVal').val());
		}); 
  }else{
	  var projDeclarer=$("#projDeclarer").val();
		//切换项目类别
		if(projDeclarer!=""){
			$("#projTypeTd").text("");
			$("#projTypeTd").append($("#"+projDeclarer).html());
		}
		$('#selectBelongVal').val($("#projDeclarer").find('option:selected').val());
		var selectValue=$("#projDeclarer").find('option:selected').val();
		//切换资金分配表格
		$('#fund').text("");
		$('#fund').append($("#"+selectValue+"Tb").html());
  }
}
</script>

</head>
<body>
<div id="main" >
    <div class="mainright">
        <div class="content">
    	    <ul id="tags">
                <li class="selectTag" id="tag0"><a onclick="selectTag('tagContent0','tag0')" href="javascript:void(0)">项目基本情况</a></li>
                <li id="tag1"><a onclick="selectTag('tagContent1','tag1')" href="javascript:void(0)">资金分配</a></li>
                <li id="tag2"><a onclick="selectTag('tagContent2','tag2')" href="javascript:void(0)">附件上传</a></li>
            </ul>
    	    <form  method="post" action="<s:url value="/srm/aid/proj/saveStepForKy"/>" id="projAidForm"  style="position: relative;" enctype="multipart/form-data">
                <input type="hidden" id="projFlow" name="projFlow" value="${aidProj.projFlow }">
                <input type="hidden" name="pageName" value="step1">
    	        <input type="hidden" id="projSubCategoryId" name="projSubCategoryId" value="${param.typeId}"/>
    	        <div id="tagContent">
                    <div class="tagContent selectTag" id="tagContent0">
    	                <table width="100%" class="basic"> 
    	                    <tr>
    	                        <th colspan="4" style="text-align: left;padding-left: 20px">项目信息</th>
    	                    </tr>
    	                    <tbody>
    	                        <tr>
    	                            <th>立项年度：</th>
    	                            <td>
    	                                <input type="text" class="validate[required] xltext ctime" name="projYear" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy'})" value="${aidProj.projYear}"/>
    	                                <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
    	                            </td>
    	                            <th>项目来源：</th>
    	                            <td>
    	                                <select id="projDeclarer" name="projDeclarer" class="validate[required] xlselect"  onchange="changeType()">
    	                                    <option value="">请选择</option>
    	                                    <c:forEach items="${aidProjCategoryEnumList}" var="aidType">
    	                                        <option value="${aidType.id}" <c:if test="${aidType.id eq resultMap.projDeclarer}">selected="selected"</c:if>>${aidType.name}</option>
    	                                    </c:forEach>
    	                                </select> 
    	                                <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>                       
    	                            </td>
    	                        </tr>
    	                        <tr>
    	                            <th>开始年月：</th>
    	                            <td>
    	                                <input type="text"  name="projStartTime" value="${aidProj.projStartTime }" readonly="readonly" style="width:160px;" class="validate[required] xltext ctime" onClick="WdatePicker({dateFmt:'yyyy-MM'})">
    	                                <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
    	                            </td>
    	                            <th>结束年月：</th>
    	                            <td>
    	                                <input type="text" name="projEndTime" value="${aidProj.projEndTime}" readonly="readonly" style="width:160px;"   class="validate[required] xltext ctime" onClick="WdatePicker({dateFmt:'yyyy-MM'})">
    	                                <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
    	                            </td>
    	                        </tr>
    	                        <tr>
    	                            <th>承担单位：</th>
    	                            <td>
    	                                <input type="text" class="validate[required,maxSize[25]] xltext" name="applyOrgName" 
    	                                <c:choose><c:when test="${not empty aidProj }">value="${resultMap.applyOrgName }"</c:when><c:otherwise>value="${currUser.orgName}"</c:otherwise></c:choose>>
    	                                <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
    	                            </td>
    	                            <th>牵头单位：</th>
    	                            <td>
    	                                <input type="text"  class="validate[maxSize[25]] xltext" name="leadOrgName" value="${resultMap.leadOrgName}">
    	                            </td>
    	                        </tr>
    	                        <tr>
    	                            <th>项目(课题)名称：</th>
    	                            <td>
    	                                <input type="text" class="validate[required,maxSize[100]] xltext" name="projName" value="${aidProj.projName }"> 
    	                                <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
    	                            </td>
    	                            <th>项目类别：</th>
    	                            <td id="projTypeTd">
    	                                <select name="projTypeName" class="validate[required] xlselect">
    	                                    <option value="">请选择</option>
    	                                    <c:if test="${resultMap.projDeclarer eq aidProjCategoryEnumCountry.id}">
    	                                        <c:forEach items="${dictTypeEnumAidCountryProjTypeList}" var="dict">
    	                                            <option value="${dict.dictName}" <c:if test="${dict.dictName eq aidProj.projTypeName}">selected="selected"</c:if>>${dict.dictName }</option>
    	                                        </c:forEach>
    	                                    </c:if>
    	                                    <c:if test="${resultMap.projDeclarer eq aidProjCategoryEnumProvince.id}">
    	                                        <c:forEach items="${dictTypeEnumAidProvinceProjTypeList }" var="dict">
    	                                            <option value="${dict.dictName}" <c:if test="${dict.dictName eq aidProj.projTypeName}">selected="selected"</c:if>>${dict.dictName }</option>                
    	                                        </c:forEach>  	                
    	                                    </c:if>
    	                                    <c:if test="${resultMap.projDeclarer eq aidProjCategoryEnumCity.id}">
    	                                        <c:forEach items="${dictTypeEnumAidCityProjTypeList }" var="dict">
    	                                            <option value="${dict.dictName}" <c:if test="${dict.dictName eq aidProj.projTypeName}">selected="selected"</c:if>>${dict.dictName }</option>                
    	                                        </c:forEach>  	                
    	                                    </c:if> 
    	                                </select>
    	                                <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
    	                            </td>
    	                        </tr>
    	                        <tr>
    	                            <th>项目(课题)编号：</th>
    	                            <td>
    	                                <input type="text" class="validate[required,maxSize[25]] xltext" name="projNo" value="${aidProj.projNo }">
    	                                <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
    	                            </td>
    	                            <th>主管部门：</th>
    	                            <td>
    	                                <input type="text" class="validate[maxSize[25]] xltext" name="chargeOrgName" value="${resultMap.chargeOrgName }">
    	                            </td>
    	                        </tr>
    	                        <tr>
    	                            <th>项目总投入:</th>
    	                            <td>
    	                                <input type="text" class="validate[maxSize[10],custom[number]] xltext" name="totalInvestment" value="${resultMap.totalInvestment }">
    	                            </td>
    	                            <th>其中国家拨款总额:</th>
    	                            <td>
    	                                <input type="text" class="validate[maxSize[10],custom[number]] xltext" name="countryInvestment" value="${resultMap.countryInvestment }">
    	                            </td>
    	                        </tr>
    	                        <tr>
    	                            <th>其中各级配套总额:</th>
    	                            <td>
    	                                <input type="text" class="validate[maxSize[10],custom[number]] xltext" name="chargeInvestment" value="${resultMap.chargeInvestment }">
    	                            </td>
    	                            <th>其中承担单位自筹总额:</th>
    	                            <td>
    	                                <input type="text" class="validate[maxSize[10],custom[number]] xltext" name="orgInvestment" value="${resultMap.orgInvestment }">
    	                            </td>
    	                        </tr>
    	                        <tr>
    	                            <th>项目负责人：</th>
    	                            <td>
    	                                <input type="text" class="validate[required] xltext" name="applyUserName" 
    	                                <c:choose><c:when test="${not empty aidProj }">value="${resultMap.applyUserName }"</c:when><c:otherwise>value="${currUser.userName }"</c:otherwise></c:choose>>
    	                                <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
    	                            </td>
    	                            <th>负责人电话：</th>
    	                            <td>
    	                                <input type="text" class="validate[custom[phone]] xltext" name="applyUserPhone" 
    	                                <c:choose><c:when test="${not empty aidProj }">value="${resultMap.applyUserPhone }"</c:when><c:otherwise>value="${currUser.userPhone }"</c:otherwise></c:choose>>
    	                            </td>
    	                        </tr>
    	                        <tr>
    	                            <th>负责人邮箱：</th>
    	                            <td>
    	                                <input type="text" class="validate[custom[email]] xltext" name="applyUserEmail" 
    	                                <c:choose><c:when test="${not empty aidProj }">value="${resultMap.applyUserEmail }"</c:when><c:otherwise>value="${currUser.userEmail }"</c:otherwise></c:choose>>
    	                            </td>
    	                        </tr>
    	                    </tbody>
    	                </table>
    	                <table width="100%" class="basic" style="margin-top: 20px;"> 
    	                    <tr>
    	                        <th style="text-align: left;padding-left: 20px">项目简介<span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span></th>
    	                    </tr>
    	                    <tr>
    	                        <td>
    	                            <textarea name="projIntr" placeholder="此处填写项目简介" rows="10" cols="20" class="validate[required] xltxtarea">${resultMap.projIntr }</textarea>
    	                        </td>
    	                    </tr>
    	                    <tr>
    	                        <th style="text-align: left;padding-left: 20px;">备注</th>
    	                    </tr>
    	                    <tr>
    	                        <td>
    	                            <textarea name="projRemark" placeholder="这里填写备注信息" rows="10" cols="20" class="xltxtarea">${resultMap.projRemark }</textarea>
    	                        </td>
    	                    </tr>
    	                </table>
    	                <div class="button" style="width: 100%; text-align: center;margin-top: 20px;">
    	                    <a href="javascript:void(0)" target="_self"  onclick="selectTag('tagContent1','tag1')" class="search">下一步</a>
	                    </div>
    	            </div>
    	        </div>
    	        <div class="tagContent" id="tagContent1">
    	            <div id="fund"> 
    	                <table width="100%" class="bs_tb" > 
    	                    <tr>
    	                        <th style="text-align: left;padding-left: 20px" 
    	                        <c:if test="${resultMap.projDeclarer eq aidProjCategoryEnumCountry.id}">
    	                            colspan="6"
    	                        </c:if>
    	                        <c:if test="${resultMap.projDeclarer eq aidProjCategoryEnumProvince.id}">
    	                            colspan="5"
    	                        </c:if>
    	                        <c:if test="${resultMap.projDeclarer eq aidProjCategoryEnumCity.id}">
    	                            colspan="4"
    	                        </c:if>>资金分配
    	                            <span style="float: right;padding-right: 10px">
    	                                <a href="javascript:void(0)" >
					                        <img src="${ctxPath}/css/skin/${skinPath}/images/add3.png" onclick="addFundScheme('fund','${resultMap.projDeclarer}');" title="添加"></img>
					                    </a>
					                    <a href="javascript:void(0)">
					                        <img src="${ctxPath}/css/skin/${skinPath}/images/del1.png" onclick="delTr('fundTb');" title="删除"></img>
					                    </a>
                                    </span>
    	                        </th>
    	                    </tr>
    	                    <tr>
    	                        <th width="5%">序号</th>
    	                        <th width="20%">拨款年度</th>
    	                        <c:if test="${resultMap.projDeclarer eq aidProjCategoryEnumCountry.id}">
    	                        <th width="20%">国家拨款</th>
    	                        <th width="20%">省配套</th>
    	                        </c:if>
    	                        <c:if test="${resultMap.projDeclarer eq aidProjCategoryEnumProvince.id}">
    	                        <th width="20%">省配套</th>
    	                        </c:if>
    	                        <th width="20%">市配套</th>
    	                        <th width="20%">区、县配套</th>
    	                    </tr>
    	                    <tbody id="fundTb">
    	                        <c:choose>
    	                            <c:when test="${not empty resultMap.fund}">
    	                                <c:forEach items="${resultMap.fund}" var="fund" varStatus="num">
    	                                    <tr>
    	                                        <td><input type="checkbox" style="width:90%;"/></td>
    	                                        <td><input type="text" class="validate[required] inputText" style="width:90%;" name="fund_year" value="${fund.objMap.fund_year }" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy'})"></td>
    	                                        <c:if test="${resultMap.projDeclarer eq aidProjCategoryEnumCountry.id }">
    	                                            <td><input type="text" class="validate[required] inputText" style="width:90%;" name="fund_countryCount" value="${fund.objMap.fund_countryCount }"></td>
    	                                            <td><input type="text" class="validate[required] inputText" style="width:90%;" name="fund_provinceCount" value="${fund.objMap.fund_provinceCount }"></td>
    	                                        </c:if>
    	                                        <c:if test="${resultMap.projDeclarer eq aidProjCategoryEnumProvince.id}">
    	                                            <td><input type="text" class="validate[required] inputText" style="width:90%;" name="fund_provinceCount" value="${fund.objMap.fund_provinceCount }"></td>
    	                                        </c:if>
    	                                        <td><input type="text" class="validate[required] inputText" style="width:90%;" name="fund_cityCount" value="${fund.objMap.fund_cityCount }"></td>
    	                                        <td><input type="text" class="validate[required] inputText" style="width:90%;" name="fund_areaCount" value="${fund.objMap.fund_areaCount }"></td>
    	                                    </tr>
    	                                </c:forEach>
    	                            </c:when>
    	                            <c:otherwise>
    	                                <tr>
    	                                    <td><input type="checkbox" style="width:90%;"/></td>
    	                                    <td><input type="text" class="validate[required] inputText" style="width:90%;" name="fund_year"  readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy'})"></td>
    	                                    <c:if test="${resultMap.projDeclarer eq aidProjCategoryEnumCountry.id }">
    	                                        <td><input type="text" class="validate[required] inputText" style="width:90%;" name="fund_countryCount" ></td>
    	                                        <td><input type="text" class="validate[required] inputText" style="width:90%;" name="fund_provinceCount"></td>
    	                                    </c:if>
    	                                    <c:if test="${resultMap.projDeclarer eq aidProjCategoryEnumProvince.id}">
    	                                        <td><input type="text" class="validate[required] inputText" style="width:90%;" name="fund_provinceCount"></td>
    	                                    </c:if>
    	                                    <td><input type="text" class="validate[required] inputText" style="width:90%;" name="fund_cityCount" ></td>
    	                                    <td><input type="text" class="validate[required] inputText" style="width:90%;" name="fund_areaCount" ></td>
    	                                </tr>
    	                            </c:otherwise>
    	                        </c:choose> 
    	                    </tbody>
    	                </table>
    	            </div>
    	            <div class="button" style="width: 100%;text-align: center;margin-top: 20px;">
    	                <a href="javascript:void(0)" target="_self"  onclick="selectTag('tagContent0','tag0')" class="search">上一步</a>
    	                <a href="javascript:void(0)" target="_self"  onclick="selectTag('tagContent2','tag2')" class="search">下一步</a>
	                </div>
    	        </div>
    	        <div class="tagContent" id="tagContent2">
			        <table class="basic" style="width: 100%">
					    <tr>
			                <th colspan="2" style="text-align: left;padding-left: 20px" >附件（您可以上传申报书、方案等附件）&#12288;
			                    <span style="float: right;padding-right: 10px">
			                        <img title="新增" style="cursor: pointer;" src="${ctxPath}/css/skin/${skinPath}/images/add3.png" onclick="addFile('projFileTb')"></img><img title="删除" style="cursor: pointer;padding-left: 5px" src="${ctxPath}/css/skin/${skinPath}/images/del1.png" onclick="delTr('projFileTb')"></img>
			                    </span>
			                </th>
			            </tr>
					    <tr>
					        <td width="50px">序号</td>
						    <td style="text-align: left;">附件</td>
						    <!-- <td>操作</td> -->
						</tr>
						<tbody id="projFileTb">
						    <c:forEach items="${fileFlows}" var="file">
							    <tr>
							        <td width="50px"><input type="checkbox"/></td>
							        <td style="height: 30px;text-align: left;" >
							            <input name="file" value="${file}" type="hidden"/><a href='<s:url value="/pub/file/down?fileFlow=${file}"/>'>${pageFileMap[file].fileName}</a>
							        </td>
							    </tr>
							</c:forEach>
						</tbody>
					</table>
    	            <div class="button" style="width: 100%;text-align: center; margin-top: 20px;">
    	                <a href="javascript:void(0)" target="_self"  onclick="selectTag('tagContent1','tag1')" class="search">上一步</a>
             	        <a href="javascript:void(0)" target="_self"  onclick="nextOpt('finish')" class="search">保存</a>
	                </div>
    	        </div>
    	    </form>
        </div>
    </div>
</div>
<!-- 项目类型模板 -->
<div id="Country" style="display: none;">
    <select name="projTypeName" class="validate[required] xlselect">
        <option value="">请选择</option>
    	    <c:forEach items="${dictTypeEnumAidCountryProjTypeList }" var="dict">
    	        <option value="${dict.dictName}" >${dict.dictName}</option>
    	    </c:forEach>
    </select>
    <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>  
</div>
<div id="Province" style="display: none;">
    <select name="projTypeName" class="validate[required] xlselect">
        <option value="">请选择</option>
    	    <c:forEach items="${dictTypeEnumAidProvinceProjTypeList }" var="dict">
    	        <option value="${dict.dictName}" >${dict.dictName }</option>
    	    </c:forEach>
   </select>
   <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
</div>
<div id="City" style="display: none;">
    <select name="projTypeName" class="validate[required] xlselect">
        <option value="">请选择</option>
    	    <c:forEach items="${dictTypeEnumAidCityProjTypeList }" var="dict">
    	        <option value="${dict.dictName}" >${dict.dictName }</option>
    	    </c:forEach>
    </select>
    <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
</div>
<!-- 资金分配模板 -->
<!-- 国家级 -->
<div id="CountryTb">
    <table width="100%" class="bs_tb" > 
        <tr>
    	    <th style="text-align: left;padding-left: 20px" colspan="6">资金分配
    	        <span style="float: right;padding-right: 10px">
    	            <a href="javascript:void(0)">
					    <img src="${ctxPath}/css/skin/${skinPath}/images/add3.png" onclick="addFundScheme('fund','Country');" title="添加"></img>
					</a>
					<a href="javascript:void(0)">
					    <img src="${ctxPath}/css/skin/${skinPath}/images/del1.png" onclick="delTr('fundTb');" title="删除"></img>
					</a>
				</span>
    	    </th>
    	</tr>
    	<tr>
    	    <th width="5%">序号</th>
    	    <th width="20%">拨款年度</th>
    	    <th width="20%">国家拨款</th>
    	    <th width="20%">省配套</th>
    	    <th width="20%">市配套</th>
    	    <th width="20%">区、县配套</th>
    	</tr>
    	<tbody id="fundTb">
    	    <tr>
    	        <td><input type="checkbox" style="width:90%;"/></td>
    	        <td><input type="text" class="validate[required] inputText" style="width:90%;" name="fund_year" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy'})"></td>
    	        <td><input type="text" class="validate[required] inputText" style="width:90%;" name="fund_countryCount" ></td>
    	        <td><input type="text" class="validate[required] inputText" style="width:90%;" name="fund_provinceCount" ></td>
    	        <td><input type="text" class="validate[required] inputText" style="width:90%;" name="fund_cityCount" ></td>
    	        <td><input type="text" class="validate[required] inputText" style="width:90%;" name="fund_areaCount" ></td>
    	    </tr>
    	</tbody>
    </table>
</div>
<!-- 省级级 -->
<div id="ProvinceTb">
    <table width="100%" class="bs_tb" >
        <tr>
    	    <th style="text-align: left;padding-left: 20px" colspan="5">资金分配
    	        <span style="float: right;padding-right: 10px">
    	            <a href="javascript:void(0)">
					    <img src="${ctxPath}/css/skin/${skinPath}/images/add3.png" onclick="addFundScheme('fund','Province');" title="添加"></img>
					</a>
					<a href="javascript:void(0)">
					    <img src="${ctxPath}/css/skin/${skinPath}/images/del1.png" onclick="delTr('fundTb');" title="删除"></img>
					</a>
				</span>
    	    </th>
    	</tr> 
    	<tr>
    	    <th width="5%">序号</th>
    	    <th width="24%">拨款年度</th>
    	    <th width="24%">省配套</th>
    	    <th width="24%">市配套</th>
    	    <th width="23%">区、县配套</th>
    	</tr>
    	<tbody id="fundTb">
    	    <tr>
    	        <td><input type="checkbox" style="width:90%;"/></td>
    	        <td><input type="text" class="validate[required] inputText" style="width:90%;" name="fund_year" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy'})"></td>
    	        <td><input type="text" class="validate[required] inputText" style="width:90%;" name="fund_provinceCount" ></td>
    	        <td><input type="text" class="validate[required] inputText" style="width:90%;" name="fund_cityCount" ></td>
    	        <td><input type="text" class="validate[required] inputText" style="width:90%;" name="fund_areaCount" ></td>
    	    </tr>
    	</tbody>
    </table>
</div>
<!-- 市厅级 -->
<div id="CityTb">
    <table width="100%" class="bs_tb" > 
        <tr>
    	    <th style="text-align: left;padding-left: 20px" colspan="4">资金分配
    	        <span style="float: right;padding-right: 10px">
    	            <a href="javascript:void(0)">
					    <img src="${ctxPath}/css/skin/${skinPath}/images/add3.png" onclick="addFundScheme('fund','City');" title="添加"></img>
					</a>
					<a href="javascript:void(0)">
					    <img src="${ctxPath}/css/skin/${skinPath}/images/del1.png" onclick="delTr('fundTb');" title="删除"></img>
					</a>
				</span>	
    	    </th>
    	</tr>
    	<tr>
    	    <th width="5%">序号</th>
    	    <th width="32%">拨款年度</th>
    	    <th width="32%">市配套</th>
    	    <th width="31%">区、县配套</th>
    	</tr>
    	<tbody id="fundTb">
    	    <tr>
    	        <td><input type="checkbox" style="width:90%;"/></td>
    	        <td><input type="text" class="validate[required] inputText" style="width:90%;" name="fund_year" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy'})"></td>
    	        <td><input type="text" class="validate[required] inputText" style="width:90%;" name="fund_cityCount" ></td>
    	        <td><input type="text" class="validate[required] inputText" style="width:90%;" name="fund_areaCount" ></td>
    	    </tr>
    	</tbody>
    </table>
</div>
</body>
</html>