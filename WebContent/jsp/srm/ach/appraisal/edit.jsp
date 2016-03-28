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
</head>
<script type="text/javascript">
function saveAppraisalAndAuthor() {
	if(false==$("#srmAppraisal").validationEngine("validate")){
		return false;
	}
	if(false==$("#auditList").validationEngine("validate")){
		return false;
	}
	var appraisal = $("#srmAppraisal").serializeJson();
	var achFile = $("#srmAchFile").serializeJson();
	var trs = $('#appendTbody').children();
	var datas = [];
	$.each(trs , function(i , n){
		var authorFlow = $(n).find("input[name='authorFlow']").val();
		var typeName =  $(n).find("input[name='typeName']").val();
		var authorName= $(n).find("input[name='authorName']").val();
		var sexId =  $(n).find("select[name='sexId']").val();
		var educationId= $(n).find("select[name='educationId']").val();
		var degreeId= $(n).find("select[name='degreeId']").val();
		var titleId= $(n).find("select[name='titleId']").val();
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
	var t = {'authorList':datas,'appraisal':appraisal,"srmAchFile":achFile};
	$("#jsondata").val(JSON.stringify(t));
	var url = "<s:url value='/srm/ach/appraisal/save'/>";
	jboxStartLoading();
	jboxSubmit($('#srmAppraisal'),url,function(resp){
		window.parent.frames['mainIframe'].location.reload(true);
		jboxClose();				
	},function(resp){
		alert("error");
	});
}

function addAuthor(){
	$('#appendTbody').append($("#addAuthorTable tr:eq(0)").clone());
}

function delAuthorTr(obj){
	jboxConfirm("确认删除？" , function(){
		  obj.parentNode.parentNode.remove();
	});
}

function delAuthor(authorFlow,obj) {
	var url = '<s:url value="/srm/ach/appraisal/deleteAuthor?authorFlow="/>' + authorFlow;
	jboxConfirm("确认删除？" , function(){
		jboxStartLoading();
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
<body>
<div class="mainright">
	<div class="content">
    <div class="title1 clearfix">
   	<div id="look">
	<form id="srmAppraisal" method="post" action="<s:url value="/srm/ach/appraisal/saveAppraisalAndAuthor"/>" enctype="multipart/form-data" style="position: relative;">
		<input id="jsondata" type="hidden" name="jsondata" value=""/>
		<table class="basic" style="width: 100%">
			<tr class="bs_name" style="height: 26px">
				<td style="text-align:left" colspan="4">基本信息</td>
	    	</tr>
			<tr>
                <th>鉴定名称：</th>
                <td colspan="3">
                     <input type="hidden" name="appraisalFlow" value="${appraisal.appraisalFlow }" />
                     <input class="validate[required] name xltext"  name="appraisalName" type="text" value="${appraisal.appraisalName}"style="width: 97%;" />
                </td>
            </tr>
			<tr>
				<th>鉴定部门：</th>
			<td>
				<input class="xltext" name="appraisalDept" type="text" value="${appraisal.appraisalDept}"/>
			</td>
			<th>鉴定日期：</th>
			<td>
				<input onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  class="ctime xltext" style="width:160px;" name="appraisalDate" type="text" value="${appraisal.appraisalDate}" readonly="readonly"/>
			</td>                                    
			</tr>
			<tr>
				<th>鉴定批准日期：</th>
			<td>
				<input onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width: 160px;" class="ctime" name="approvalDate" type="text" value="${appraisal.approvalDate}" readonly="readonly"/>
			</td>
			<th>鉴定结论：</th>
			<td>
				<c:forEach var="dict" items="${dictTypeEnumAppraisalResultNameList}">
				<input type="radio" name="appraisalResultId" id="appraisalResultName_${dict.dictId }" value="${dict.dictId }" <c:if test="${appraisal.appraisalResultId==dict.dictId}">checked="checked"</c:if>/><label for="appraisalResultName_${dict.dictId }">&nbsp;${dict.dictName}</label>&nbsp; 
				</c:forEach>
			</td>                                    
			</tr>
            <tr>
                <th>鉴定号：</th>
                <td>
                  	<input name="appraisalCode" class="xltext" type="text" value="${appraisal.appraisalCode}" />
				</td>
                <th>鉴定形式：</th>
                <td>
                    <c:forEach var="dict" items="${dictTypeEnumAppraisalTypeNameList}">
					<input type="radio" name="appraisalTypeId"  id="appraisalTypeName_${dict.dictId }" value="${dict.dictId }" <c:if test="${appraisal.appraisalTypeId==dict.dictId}">checked="checked"</c:if>/><label for="appraisalTypeName_${dict.dictId }">&nbsp;${dict.dictName}</label>&nbsp;
					</c:forEach>
                </td>                                    
             </tr>
             <tr>
             	<th>完成形式：</th>
             	<td>
           			<c:forEach var="dict" items="${dictTypeEnumFinishTypeNameList}">
					<input type="radio" name="finishTypeId" id="finishTypeName_${dict.dictId }" value="${dict.dictId }" <c:if test="${appraisal.finishTypeId==dict.dictId}">checked="checked"</c:if>/><label for="finishTypeName_${dict.dictId }">&nbsp;${dict.dictName}</label>&nbsp;
					</c:forEach>
				</td>
				<th>学科门类：</th>
				<td>
					<c:forEach var="dict" items="${dictTypeEnumSubjectTypeList}">
					<input type="radio" name="categoryId" id="subjectType_${dict.dictId }" value="${dict.dictId }" <c:if test="${appraisal.categoryId==dict.dictId}">checked="checked"</c:if>/><label for="subjectType_${dict.dictId}">&nbsp;${dict.dictName}</label>&nbsp;
					</c:forEach>
				</td>                                    
			</tr>
			<tr>
				<th>项目来源：</th>              
				<td>
					<select name="projSourceId" class="xlselect">
						<option value="">请选择</option>
						<c:forEach items="${dictTypeEnumProjSourceList }" var="dict">
						<option value="${dict.dictId }" <c:if test="${appraisal.projSourceId eq dict.dictId }">selected="selected"</c:if>>${dict.dictName }</option>
						</c:forEach>
					</select>
				</td>
				<th>所属单位：</th>
				<td>
					<c:forEach var="dict" items="${dictTypeEnumOrgBelongList}">
					<input type="radio" name="orgBelongId" id="orgBelong_${dict.dictId }" value="${dict.dictId }" <c:if test="${appraisal.orgBelongId==dict.dictId}">checked="checked"</c:if>/><label for="orgBelong_${dict.dictId }">&nbsp;${dict.dictName}</label>&nbsp;
					</c:forEach>
				</td>
			</tr>		
		</table>
                
                
		<table class="basic" style="width: 100%">
			<thead>
				<tr><th colspan="4" class="bs_name">备注信息</th></tr>
	        </thead>
	        <tbody>
            <tr>
		    	<th width="16%">备注信息：</th>
		     	<td>
		     		<textarea class="validate[maxSize[100]] xltxtarea" style="margin-left: 0px;" name="remark" >${appraisal.remark }</textarea>
		     	</td>
		    </tr>
	       	</tbody>
		</table>   
          
		<table class="basic" style="width: 100%">
            <thead>
               <tr><th colspan="4" class="bs_name">附件上传</th></tr>
            </thead>
        	<tbody>
            <tr>
            	<th width="16%">附件：</th>
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
		</form>
		
		<form id="srmAchFile">
		    <input type="hidden" name="fileFlow" value="${file.fileFlow }"/>
		</form>
          
	<%-- 论文作者 --%>
		<form id="auditList">
			<table class="basic" style="width: 100%">
				<tr class="bs_name" style="height: 26px">
					<td style="text-align:left" colspan="8">鉴定作者<c:if test="${param.editFlag != GlobalConstant.FLAG_N}"><a href="javascript:void(0)"><img src="${ctxPath}/css/skin/${skinPath}/images/add.png" onclick="addAuthor();" title="添加"></img></a></c:if></td>
		    	</tr>
                <tr>
					<th width="10%" style="text-align: center;">署名顺序</th>
					<th width="15%" style="text-align: center;">作者名称</th>
					<th width="15%" style="text-align: center;">性别</th>
					<th width="15%" style="text-align: center;">学历</th>
					<th width="15%" style="text-align: center;">学位</th>
					<th width="15%" style="text-align: center;">职称</th>
					<c:if test="${param.editFlag != GlobalConstant.FLAG_N}">
					<th width="10%" style="text-align: center;">操作</th>
					</c:if>
				</tr>
					
				<tbody id="appendTbody">
			 	<%-- 默认作者 --%>
       			<c:if test="${empty param.appraisalFlow}">
   				<tr>
			  		<td>
           				<input class="xltext" style="width: 85%;"  type="text" name="typeName" />
                    </td>
  					<td>
   						<input class="xltext" style="width: 85%;" type="text" name="authorName" value="${sessionScope.currUser.userName}"/>
       				</td>
      				<td>
		                <select name="sexId" class="validate[required] xlselect" style="width: 85%;">
		                   <option value="">请选择</option>
		                   <c:forEach var="dict" items="${userSexEnumList }">
		                   		<c:if test="${dict.id != userSexEnumUnknown.id}">
		                   			<option value="${dict.id}" <c:if test="${sessionScope.currUser.sexId eq dict.id}">selected="selected"</c:if>>${dict.name}</option>
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
					
					
					
					
				<c:forEach items="${appraisalAuthorList}" var="author">
				<tr>
				<td>
					<input class="xltext" style="width: 85%;"  type="text" name="typeName" value="${author.typeName}"/>
                </td>
				<td>
     				<input class="xltext" style="width: 85%;" type="text" name="authorName" value="${author.authorName}"/>
				</td>
   				<td>
	                <select name="sexId" class="validate[required] xlselect" style="width: 85%;">
	                   <option value="">请选择</option>
	                   <c:forEach var="dict" items="${userSexEnumList }">
	                   		<c:if test="${dict.id != userSexEnumUnknown.id}">
	                   			<option value="${dict.id}" <c:if test="${author.sexId eq dict.id}">selected="selected"</c:if>>${dict.name}</option>
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
   					<input type="hidden" name="authorFlow" value="${author.authorFlow}"/>
					[<a onclick="delAuthor('${author.authorFlow}',this)" style="cursor: pointer;">删除</a>]
				</td>
				</c:if>
			</tr> 
			</c:forEach>
		</tbody>
		</table>
	</form> 
			 
	<p align="center">
		<c:if test="${param.editFlag != GlobalConstant.FLAG_N}">
		<input type="button" value="保&#12288;存" onclick="saveAppraisalAndAuthor()" class="search"/>
      	<input type="button" value="关&#12288;闭" onclick="jboxClose();" class="search"/>
      	</c:if>
   		
	</p>
	         
	<%-- 克隆作者模板 --%>
	<table class="basic" id="addAuthorTable" style="display: none" style="width: 100%">
		<tr>
			<td>
				<input class="xltext" style="width: 85%;"  type="text" name="typeName"/>
			</td>
			<td>
				<input class="validate[required] xltext" style="width: 85%;" name="authorName" type="text"/>
			</td>
			<td style="text-align: center;">
				<select class="xlselect" style="width: 85%;" name="sexId">
					<option value="">请选择</option>
					<c:forEach var="dict" items="${userSexEnumList }">
						<c:if test="${dict.id != userSexEnumUnknown.id}">
						<option value="${dict.id}">${dict.name}</option>
						</c:if>	 
					</c:forEach>
				</select>
			</td>
			<td>
				<select class="xlselect" name="educationId" style="width: 85%;" >
					<option value="">请选择</option>
					<c:forEach var="dict" items="${dictTypeEnumUserEducationList}">
					<option value="${dict.dictId}">${dict.dictName}</option>
					</c:forEach>
				</select>
			</td>
			<td>
           		<select name="degreeId" class="xlselect"  style="width: 85%;" >
              		<option value="">请选择</option>
              		<c:forEach var="dict" items="${dictTypeEnumUserDegreeList }">
           			<option value="${dict.dictId }" <c:if test="${author.degreeId eq dict.dictId }">selected="selected"</c:if>>${dict.dictName }</option> 
           			</c:forEach>
           		</select> 
           	</td>
			<td>
				<select name="titleId" class="xlselect"  style="width: 85%">
					<option value="">请选择</option>
					<c:forEach var="dict" items="${dictTypeEnumUserTitleList}">
						<option value="${dict.dictId}">${dict.dictName}</option>
					</c:forEach>
				</select>
			</td>
			<td style="text-align: center;">
				 [<a onclick="delAuthorTr(this)" style="cursor: pointer;">删除</a>]
			</td>
		</tr>
	   </table>
	</div>
	</div>
	</div> 	
</div>
</body>
</html>