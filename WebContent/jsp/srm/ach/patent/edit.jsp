<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="true"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
	<jsp:param name="jquery_ui_sortable" value="false"/>
	<jsp:param name="jquery_cxselect" value="false"/>
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
<script type="text/javascript">
function savePatent(){
  	if(false==$("#srmPatent").validationEngine("validate")){
		return false;
	}
  	if(false==$("#srmPatentAuthor").validationEngine("validate")){
		return false;
	}
  	var patent = $("#srmPatent").serializeJson();
  	var achFile = $("#srmAchFile").serializeJson();
  	var authTab = $('#test');
	var trs = authTab.children();
	var datas = [];
  	$.each(trs , function(i , n){
		var authorFlow = $(n).find("input[name='authorFlow']").val();
		var typeName =  $(n).find("input[name='typeName']").val();
		var authorName= $(n).find("input[name='authorName']").val();
		var sexId =  $(n).find("select[name='sexId']").val();
		var educationId= $(n).find("select[name='educationId']").val();
		var titleId= $(n).find("select[name='titleId']").val();
		var degreeId= $(n).find("select[name='degreeId']").val();
		var data = {
				"authorFlow":authorFlow,
				"typeName":typeName,
				"authorName":authorName,
				"sexId":sexId,
				"educationId":educationId,
				"titleId":titleId,
				"degreeId":degreeId
		};
		datas.push(data);
	});
  	

	var t = {'achPatentList':datas,'patent':patent,"srmAchFile":achFile};
   	$("#jsondata").val(JSON.stringify(t));
   	var url = "<s:url value='/srm/ach/patent/save'/>";
   	jboxStartLoading();
	jboxSubmit($('#srmPatent'),url,function(resp){
			window.parent.frames['mainIframe'].location.reload(true);
			jboxClose();
		},
		function(resp){
 			alert("error");
		});
}
    
function addAuthor(){
 	$('#test').append($("#moban tr:eq(0)").clone());
}

function delAuthorTr(obj){
	jboxConfirm("确认删除？" , function(){
	 	var tr=obj.parentNode.parentNode;
	    tr.remove();
	});
}

function delAuthor(authorFlow,obj) {
 	var url = '<s:url value="/srm/ach/patent/deleteAuthor?authorFlow="/>' + authorFlow;
 	jboxConfirm("确认删除？" , function(){
 		jboxGet(url , null , function(){
 			var tr=$(obj).parent("td").parent("tr");
	      		tr.remove();
 		} , null , true);
 	});
}
    
function reCheck(obj){
 	   $(obj).hide();
 	   $("#down").hide();
 	   $("#file").show();
}

$(function(){
 	  <c:if test="${param.editFlag == GlobalConstant.FLAG_N}">
 	  	$('#look input[type!=button]').attr('disabled' , "disabled");
 	  	$('#look textarea').attr('readonly' , "readonly");
 	  	$('#look select').attr('disabled' , "disabled");
 	  	$("#reCheck").css("display", "none");
 	  </c:if>
});
  
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
		<div id="look">
		<form id="srmPatent" style="position: relative;" enctype="multipart/form-data" method="post">
			<input id="jsondata" type="hidden" name="jsondata" value=""/>
			<table class="basic" style="width: 100%">
				<tr class="bs_name" style="height: 26px">
					<td colspan="4">基本信息</td>
				</tr>
                <tr>
                 	<th width="17%">专利名称：</th>
                 	<td colspan="3">
                 	<input type="hidden" name="patentFlow" value="${patent.patentFlow }" >
                 	<input class="validate[required] name xltext" type="text" name="patentName" value="${patent.patentName }" style="width: 97%;"></td>
                </tr>
                <tr>
              	<th>所属单位：</th>
                	<td colspan="3">
	                    <c:forEach var="dict" items="${dictTypeEnumOrgBelongList }">
	                    <input type="radio" name="orgBelongId" <c:if test="${patent.orgBelongId eq dict.dictId }">checked="checked"</c:if> id="patentOrgBelong_${dict.dictId }" value="${dict.dictId }"><label for="patentOrgBelong_${dict.dictId }">&nbsp;${dict.dictName}</label>&nbsp; 
	                    </c:forEach>
                	 </td>
                </tr>
                <tr>
                	<th>专利类型：</th>
                 	<td>
						<c:forEach var="dict" items="${dictTypeEnumPatentTypeList }">
						<input type="radio" name="typeId" <c:if test="${patent.typeId eq dict.dictId }">checked="checked"</c:if> id="patentType_${dict.dictId }" value="${dict.dictId }"><label for="patentType_${dict.dictId }">&nbsp;${dict.dictName }</label>&nbsp;
						</c:forEach>
                  	</td>
                  	<th>专利范围：</th>
    				<td>
						<c:forEach var="dict" items="${dictTypeEnumPatentRangeList }">
						<input type="radio" name="rangeId" <c:if test="${patent.rangeId eq dict.dictId }">checked="checked"</c:if> id="patentRange_${dict.dictId }" value="${dict.dictId }"><label for="patentRange_${dict.dictId }">&nbsp;${dict.dictName }</label>&nbsp;
						</c:forEach>
					</td>
				</tr>
                <tr>
              		<th>专利状态：</th>
					<td>
						<c:forEach var="dict" items="${dictTypeEnumPatentStatusList }">
						<input type="radio" name="statusId" <c:if test="${patent.statusId eq dict.dictId }">checked="checked"</c:if> id="patentStatus_${dict.dictId }" value="${dict.dictId }"><label for="patentStatus_${dict.dictId }">&nbsp;${dict.dictName }</label>&nbsp;
						</c:forEach>
                 	</td>
              		<th>申请号：</th>
                  	<td><input class="xltext" type="text" name="applyCode" value="${patent.applyCode }"></td>
                </tr>
                <tr>
                    <th>申请日期：</th>
                    <td><input class="xltext ctime" style="width:160px;" type="text" name="applyDate" value="${patent.applyDate }" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  readonly="readonly"></td>
                    <th>公开号：</th>
                    <td><input class="xltext" type="text" name="openCode" value="${patent.openCode }"></td>
                </tr>
                <tr>
                  	<th>公开日期：</th>
             		<td><input class="xltext ctime" style="width:160px;" type="text" name="openDate" value="${patent.openDate }" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"   readonly="readonly"></td>
                 	<th>授权号：</th>
                  	<td><input class="xltext" type="text" name="authorizeCode" value="${patent.authorizeCode }"></td>
                </tr>
                <tr>
					<th>授权日期：</th>
					<td><input class="xltext ctime" style="width:160px;" type="text" name="authorizeDate" value="${patent.authorizeDate }" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"   readonly="readonly"></td>
					<th>是否为PTC专利：</th>
					<td>
						<input type="radio" name="isPtc" id="isPtc_1" <c:if test="${patent.isPtc eq 1 }">checked="checked"</c:if> value="1"><label for="isPtc_1">&nbsp;是</label>&nbsp;
						<input type="radio"  name="isPtc" id="isPtc_0" <c:if test="${patent.isPtc eq 0 }">checked="checked"</c:if> value="0"><label for="isPtc_0">&nbsp;否</label>&nbsp;
					</td>
                </tr>
                <tr>
					<th>专利权人：</th>
					<td><input class="xltext" type="text" name="patentee" value="${patent.patentee }"></td>
					<th>是否失效：</th>
					<td>
						<input type="radio" name="isExpired" id="isExpired_1"  <c:if test="${patent.isExpired eq 1 }">checked="checked"</c:if> value="1"><label for="isExpired_1">&nbsp;是</label>&nbsp;
						<input type="radio" name="isExpired" id="isExpired_0"  <c:if test="${patent.isExpired eq 0 }">checked="checked"</c:if> value="0"><label for="isExpired_0">&nbsp;否</label>&nbsp;
					</td>
                </tr>
				<tr>
					<th>合作类型：</th>
					<td>
						<c:forEach var="dict" items="${dictTypeEnumPatentCooperTypeList }">
						<input type="radio" name="cooperTypeId" <c:if test="${patent.cooperTypeId eq dict.dictId }">checked="checked"</c:if> id="patentCooperType_${dict.dictId }" value="${dict.dictId }"><label for="patentCooperType_${dict.dictId }">&nbsp;${dict.dictName }</label>&nbsp;
						</c:forEach>
					</td>
					<th>是否为职务专利：</th>
					<td>
						<input type="radio" name="isPost" id="isPost_1" <c:if test="${patent.isPost eq 1 }">checked="checked"</c:if> value="1"><label for="isPost_1">&nbsp;是</label>&nbsp;
						<input type="radio" name="isPost" id="isPost_0" <c:if test="${patent.isPost eq 0 }">checked="checked"</c:if> value="0"><label for="isPost_0">&nbsp;否</label>&nbsp;
					</td>
				</tr>
			</table>
          
          
			<table class="basic" style="width: 100%">
				<thead>
					<tr>
						<th colspan="4" class="bs_name">附件上传（上传的附件为证书扫描件，格式为JPG格式）</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th width="17%">附件：</th>
						<td colspan="3">
							<c:choose>
								<c:when test="${not empty file.fileName}">
								<a id="down" href='<s:url value="/pub/file/achDown?fileFlow=${file.fileFlow}"/>'>${file.fileName}</a>
								<input type="file" id="file" name="file" style="display: none;"/>
								<span style="float: right; padding-right: 10px;">
								<a id="reCheck" href="javascript:void(0);" onclick="reCheck(this);">[重新选择文件]</a>
								</span>
							</c:when>
							<c:otherwise>
								<input type="file" id="file" name="file"/>     
							</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</tbody>
			</table>
			      
			<table class="basic" style="width: 100%">
				<thead>
				    <tr>
				        <th colspan="4" class="bs_name">备注信息</th>
				    </tr>
				</thead>
				<tbody>
				    <tr>
						<th width="17%">备注信息：</th>
						<td>
							<textarea class="validate[maxSize[100]] xltxtarea" style="margin-left: 0px;" name="remark" >${patent.remark}</textarea>
						</td>
					</tr>
			 	</tbody>
			</table>
    </form>
    
	<form id="srmAchFile">
		<input type="hidden" name="fileFlow" value="${file.fileFlow }"/>
	</form>
	
     <!-- 专利作者表单 -->
    <form id="srmPatentAuthor">
		<table class="basic" id="mubiao" style="width: 100%">
			<tr >
   				<td class="bs_name" colspan="7">专利作者<c:if test="${param.editFlag != GlobalConstant.FLAG_N}"><a href="javascript:void(0)"><img src="${ctxPath}/css/skin/${skinPath}/images/add.png" onclick="addAuthor();" title="添加"></img></a></c:if></td>
  			</tr>
            <tr>
	            <th width="10%;" style="text-align: center;">署名顺序</th>
	            <th width="15%;" style="text-align: center;">发明(设计)人姓名</th>
	            <th width="15%;" style="text-align: center;">性别</th>
	            <th width="15%;" style="text-align: center;">学历</th>
	            <th width="15%;" style="text-align: center;">学位</th>
	            <th width="15%;" style="text-align: center;">职称</th>
	            <c:if test="${param.editFlag != GlobalConstant.FLAG_N}">
	            <th style="text-align: center;" style="text-align: center;">操作</th>
	            </c:if>
            </tr>
            <tbody id="test">
            	<%-- 默认作者 --%>
        		<c:if test="${empty param.patentFlow}">
      			<tr>
					<td>
						<input class="xltext" style="width: 85%;"  type="text" name="typeName"/>
					</td>
					<td>
                    	<input class="xltext" style="width: 85%;" type="text" name="authorName" value="${sessionScope.currUser.userName }"/>
                   	</td>
                    <td>
						<select name="sexId" class="validate[required] xlselect" style="width: 85%;">
							<option value="">请选择</option>
							<c:forEach var="dict" items="${userSexEnumList}">
							<c:if test="${dict.id != userSexEnumUnknown.id}">
							<option value="${dict.id }" <c:if test="${sessionScope.currUser.sexId eq dict.id }">selected="selected"</c:if>>${dict.name }</option>
							</c:if>	 
							</c:forEach>
						</select>
                    </td>
                    <td>
						<select name="educationId" class="xlselect" style="width: 85%;">
							<option value="">请选择</option>
							<c:forEach var="dict" items="${dictTypeEnumUserEducationList }">
							<option value="${dict.dictId }" <c:if test="${sessionScope.currUser.educationId eq dict.dictId }">selected="selected"</c:if>>${dict.dictName }</option> 
							</c:forEach>
						</select>
                    </td>
                    <td>
						<select name="degreeId" class="xlselect" style="width: 85%;">
							<option value="">请选择</option>
							<c:forEach var="dict" items="${dictTypeEnumUserDegreeList }">
							<option value="${dict.dictId }" <c:if test="${sessionScope.currUser.degreeId eq dict.dictId }">selected="selected"</c:if>>${dict.dictName }</option> 
							</c:forEach>
						</select> 
                    </td>
                    <td>
						<select name="titleId" class="xlselect" style="width: 85%;">
							<option value="">请选择</option>
							<c:forEach var="dict" items="${dictTypeEnumUserTitleList }">
							<option value="${dict.dictId }" <c:if test="${sessionScope.currUser.titleId eq dict.dictId }">selected="selected"</c:if>>${dict.dictName }</option> 
							</c:forEach>
						</select> 
                    </td>
                    <c:if test="${param.editFlag != GlobalConstant.FLAG_N}">
                    <td style="text-align: center;">
                    	 [<a onclick="delAuthorTr(this)" style="cursor: pointer;">删除</a>] 
                    </td>
                    </c:if>
                 </tr>
      		</c:if>
            
			<c:forEach var="author" items="${authorList }">
			<tr>
				<td>
					<input type="hidden" name="authorFlow" value="${author.authorFlow }">
					<input class="xltext" style="width: 85%;"  type="text" name="typeName" value="${author.typeName}"/>
				</td>
				<td>
					<input class="xltext" style="width: 85%;" type="text" name="authorName" value="${author.authorName }"/>
				</td>
				<td>
					<select name="sexId" class="validate[required] xlselect" style="width: 85%;">
						<option value="">请选择</option>
						<c:forEach var="dict" items="${userSexEnumList}">
						<c:if test="${dict.id != userSexEnumUnknown.id}">
						<option value="${dict.id }" <c:if test="${author.sexId eq dict.id }">selected="selected"</c:if>>${dict.name }</option>
						</c:if>	 
						</c:forEach>
					</select>
				</td>
				<td>
					<select name="educationId" class="xlselect" style="width: 85%;">
						<option value="">请选择</option>
						<c:forEach var="dict" items="${dictTypeEnumUserEducationList }">
						<option value="${dict.dictId }" <c:if test="${author.educationId eq dict.dictId }">selected="selected"</c:if>>${dict.dictName }</option> 
						</c:forEach>
					</select>
				</td>
				<td>
					<select name="degreeId" class="xlselect" style="width: 85%;">
						<option value="">请选择</option>
						<c:forEach var="dict" items="${dictTypeEnumUserDegreeList }">
						<option value="${dict.dictId }" <c:if test="${author.degreeId eq dict.dictId }">selected="selected"</c:if>>${dict.dictName }</option> 
						</c:forEach>
					</select> 
				</td>
				<td>
					<select name="titleId" class="xlselect" style="width: 85%;">
						<option value="">请选择</option>
						<c:forEach var="dict" items="${dictTypeEnumUserTitleList }">
						<option value="${dict.dictId }" <c:if test="${author.titleId eq dict.dictId }">selected="selected"</c:if>>${dict.dictName }</option> 
						</c:forEach>
					</select> 
				</td>
				
				<c:if test="${param.editFlag != GlobalConstant.FLAG_N}">
				<td style="text-align: center;">
					[<label onclick="delAuthor('${author.authorFlow}',this)">删除</label>]
				</td>
				</c:if>
			</tr>
			</c:forEach>
			</tbody>
		</table>
	</form>
    
	<!-- 作者模板 -->
	<table class="basic" id="moban" style="display: none" style="width: 100%">
	<tr>
		<td style="text-align: center;">
			<input class="xltext" style="width: 85%;"  type="text" name="typeName" />
		</td>
		<td style="text-align: center;">
			<input class="validate[required] xltext" style="width: 85%;" type="text" name="authorName" value="${author.authorName }"/>
		</td>
		<td>
	  	 	<select name="sexId" class="validate[required] xlselect" style="width: 85%;">
				<option value="">请选择</option>
				<c:forEach var="dict" items="${userSexEnumList }">
				<c:if test="${dict.id != userSexEnumUnknown.id}">
				<option value="${dict.id }" >${dict.name}</option>
				</c:if>	 
				</c:forEach>
		   </select>
		</td>
		<td style="text-align: center;">
			<select name="educationId" class="xlselect" style="width: 85%;">
				<option value="">请选择</option>
				<c:forEach var="dict" items="${dictTypeEnumUserEducationList }">
				<option value="${dict.dictId }">${dict.dictName }</option> 
				</c:forEach>
		   	</select>
		</td>
		<td style="text-align: center;">
			<select name="degreeId" class="xlselect" style="width: 85%;">
				<option value="">请选择</option>
				<c:forEach var="dict" items="${dictTypeEnumUserDegreeList }">
				<option value="${dict.dictId }" >${dict.dictName }</option> 
				</c:forEach>
	   		</select> 
		</td>
		<td style="text-align: center;">
			<select name="titleId" class="xlselect" style="width: 85%;">
				<option value="">请选择</option>
				<c:forEach var="dict" items="${dictTypeEnumUserTitleList }">
				<option value="${dict.dictId }" >${dict.dictName }</option> 
				</c:forEach>
		   	</select> 
		</td>
		<td style="text-align: center;">
			[<label onclick="delAuthorTr(this)">删除</label>] 
	   	</td>
	</tr>
	</table>

		<p align="center">
			<c:if test="${param.editFlag != GlobalConstant.FLAG_N}">   
			<input type="button" onClick="savePatent();" value="保&#12288;存" class="search"/>
			<input type="button" value="关&#12288;闭" onclick="jboxClose();" class="search"/> 
			</c:if> 
			
		</p>
		
		</div>
		</div>
	</div> 	
</div>
</body>
</html>