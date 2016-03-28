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
function saveCopyrightAndAuthor() {
	if(false==$("#srmCopyright").validationEngine("validate")){
		return false;
	}
	
	if(false==$("#authorList").validationEngine("validate")){
		return false;
	}
	var copyright = $("#srmCopyright").serializeJson();
	var achFile = $("#srmAchFile").serializeJson();
	var trs = $('#appendTbody').children();
	var datas = [];
	$.each(trs , function(i , n){
		var authorFlow = $(n).find("input[name='authorFlow']").val();
		var typeName =  $(n).find("input[name='typeName']").val();
		var authorName= $(n).find("input[name='authorName']").val();
		var workCode= $(n).find("input[name='workCode']").val();
		var sexId =  $(n).find("select[name='sexId']").val();
		var degreeId= $(n).find("select[name='degreeId']").val();
		var educationId= $(n).find("select[name='educationId']").val();
		var titleId= $(n).find("select[name='titleId']").val();
		var contributionPercent= $(n).find("input[name='contributionPercent']").val();
		var data = {
				"authorFlow":authorFlow,
				"typeName":typeName,
				"authorName":authorName,
				"workCode":workCode,
				"sexId":sexId,
				"degreeId":degreeId,
				"educationId":educationId,
				"titleId":titleId,
				"contributionPercent":contributionPercent
		};
		datas.push(data);
	});
	var t = {'authorList':datas,'copyright':copyright,"srmAchFile":achFile};
	//alert("datas:"+ datas);
	$("#jsondata").val(JSON.stringify(t));
	//alert("jsondata:" + $("#jsondata").val());
	var url = "<s:url value='/srm/ach/copyright/save'/>";
	jboxStartLoading();
	jboxSubmit($('#srmCopyright'),url,function(resp){
		window.parent.frames['mainIframe'].location.reload(true);
		jboxClose();	
	},function(resp){
		jboxTip("error");
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
	
	var url = '<s:url value="/srm/ach/copyright/deleteAuthor?authorFlow="/>' + authorFlow;
	jboxConfirm("确认删除？" , function(){
		jboxStartLoading();
		jboxGet(url , null , function(){
			//window.parent.frames['mainIframe'].location.reload(true);
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
     	<form id="srmCopyright" style="position: relative;" enctype="multipart/form-data" method="post" style="position: relative;">
		<input id="jsondata" type="hidden" name="jsondata" value=""/>
		<table class="basic" style="width: 100%">
		<tr class="bs_name" style="height: 26px">
	   		<td colspan="4">
		   		基本信息
	            <input type="hidden" name="copyrightFlow" value="${copyright.copyrightFlow }"/>
	   		</td>
	    </tr>
		<tr>
			<th width="16%">著作权名称：</th>
            <td colspan="3">
                <input class="validate[required] name xltext" style="width: 97%;" name="copyrightName" type="text" value="${copyright.copyrightName}" />
            </td>
		</tr>
		<tr>
			<th>著作权编号：</th>
            <td>
                <input class="validate[required] name xltext"  name="copyrightCode" type="text" value="${copyright.copyrightCode}" />
            </td>
			<th>所属单位：</th>
            <td>
            	<c:forEach var="dict" items="${dictTypeEnumOrgBelongList}">
					<input type="radio" name="belongOrgId" id="orgBelongId_${dict.dictId }" value="${dict.dictId }" <c:if test="${copyright.belongOrgId==dict.dictId}">checked="checked"</c:if>/><label for="orgBelongId_${dict.dictId }">&nbsp;${dict.dictName}</label>&nbsp;    
				</c:forEach>
               <%--  <input class="xltext" name="belongOrgName"  type="text" value="${copyright.belongOrgName}" /> --%>
            </td>
		</tr>
		<tr>
			<th>登记号：</th>
            <td>
                <input class="xltext" name="registerCode" type="text" value="${copyright.registerCode}" />
            </td>
			<th>著作权类型：</th>
            <td>
                <c:forEach items="${dictTypeEnumCopyrightTypeList }" var="dict">
			         <input type="radio" name="copyrightTypeId" id="copyrightTypeId_${dict.dictId }" value="${dict.dictId }" <c:if test="${copyright.copyrightTypeId eq dict.dictId }">checked="checked"</c:if>/><label for="copyrightTypeId_${dict.dictId}">&nbsp;${dict.dictName}</label>&nbsp;
		       	</c:forEach>
            </td>
		</tr>
		<tr>
			<th>出版日期：</th>
            <td>
            	<input onClick="WdatePicker({dateFmt:'yyyy-MM'})"  class="ctime" style="width: 160px;" name="publishDate" type="text" value="${copyright.publishDate}" />
            </td>
			<th>学科门类：</th>
            <td>
                <c:forEach items="${dictTypeEnumSubjectTypeList }" var="dict">
			         <input type="radio" name="subjectTypeId" id="subjectTypeId_${dict.dictId}" value="${dict.dictId }" <c:if test="${copyright.subjectTypeId eq dict.dictId }">checked="checked"</c:if>/><label for="subjectTypeId_${dict.dictId}">&nbsp;${dict.dictName}</label>&nbsp;
		       	</c:forEach>
            </td>
		</tr>
	</table> 
	
	      <%--附件信息 --%>
     <table class="basic" style="width: 100%">
         <thead>
            <tr>
                <th colspan="4" class="bs_name">附件上传</th>
            </tr>
         </thead>
         <tbody>
              <tr>
                 <th width="16%">附件：</th>
                 <td colspan="3">
                    <c:choose>
                     <c:when test="${not empty file.fileName}">
                      <%-- <input type="text" id="rf" value="${file.fileName }" readonly="readonly"> --%>
	                   <a id="down" href='<s:url value="/pub/file/achDown?fileFlow=${file.fileFlow}"/>'>${file.fileName}</a>
	                   <input type="file" id="file" name="file" style="display: none;"/>
	                   <span style="float: right; padding-right: 10px;">
               				<a id="reCheck" href="javascript:void(0);" onclick="reCheck(this);">[重新选择文件]</a>
               		   </span>
                      </c:when>
                    <c:otherwise>
                      <input type="file" id="file" name="file" />     
                    </c:otherwise>
                    </c:choose>
                 </td>
              </tr>
         </tbody>
     </table>
     
      <%--备注信息 --%>
     <table class="basic" style="width: 100%">
       <thead>
          <tr>
            <th colspan="4" class="bs_name">备注信息</th>
          </tr>
       </thead>
       <tbody>
          <tr>
		    <th width="16%">备注信息：</th>
		    <td><textarea class="validate[maxSize[100]] xltxtarea" style="margin-left: 0px;" name="remark" >${copyright.remark }</textarea></td>
		  </tr>
       </tbody>
      </table>
      
	</form>
	
    <form id="srmAchFile">
       <input type="hidden" name="fileFlow" value="${file.fileFlow }"/>
    </form>
		
		
		
	<%-- 著作权作者 --%>
	<form id="authorList">
		<table class="basic" style="width: 100%">
			<tr style="height: 26px">
		   		 <td class="bs_name" style="text-align:left" colspan="9">作者信息<c:if test="${param.editFlag != GlobalConstant.FLAG_N}"><a href="javascript:void(0)"><img src="${ctxPath}/css/skin/${skinPath}/images/add.png" onclick="addAuthor();" title="添加"></img></a></c:if></td>
		    </tr>
                  <tr>
				<th width="10%" style="text-align: center;">署名顺序</th>
				<th width="10%" style="text-align: center;">作者姓名</th>
				<!-- <th width="10%" style="text-align: center;">职工号</th> -->
				<th width="10%" style="text-align: center;">性别</th>
				<th width="10%" style="text-align: center;">学历</th>
				<th width="10%" style="text-align: center;">学位</th>
				<th width="10%" style="text-align: center;">职称</th>
				<!-- <th width="10%" style="text-align: center;">贡献率</th> -->
				<c:if test="${param.editFlag != GlobalConstant.FLAG_N}">
				<th width="10%" style="text-align: center;">操作</th>
				</c:if>
			</tr>
			
	<tbody id="appendTbody">
			
			<%-- 默认作者 --%>
            <c:if test="${empty param.copyrightFlow}">
            	<tr>
         		<td>
     			<input type="hidden" name="authorFlow" value="${author.authorFlow }"/>
           
	              <input class="xltext" style="width: 85%;"  type="text" name="typeName" />
         		</td>
         		<td>
         			<input class="validate[required] xltext" style="width: 85%;" type="text" name="authorName" value="${sessionScope.currUser.userName}"/>
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
	            <%-- <td>
					<input class="xltext" type="text" name="contributionPercent" value="${author.contributionPercent }" style="width: 70px;"/>
				</td> --%>
				<c:if test="${param.editFlag != GlobalConstant.FLAG_N}">
         		<td style="text-align: center;">
         			 [<a onclick="delAuthorTr(this)" style="cursor: pointer;">删除</a>] 
         		</td>
         		</c:if>
        	</tr> 
            </c:if>
			
			
			
			
			<c:forEach items="${copyrightAuthorList}" var="author">
			  <tr>
         		<td>
     			<input type="hidden" name="authorFlow" value="${author.authorFlow }"/>
           
	              <input class="xltext" style="width: 85%;"  type="text" name="typeName" value="${author.typeName}"/>
         		</td>
         		<td>
         			<input class="validate[required] xltext" style="width: 85%;" type="text" name="authorName" value="${author.authorName}"/>
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
	            <%-- <td>
					<input class="xltext" type="text" name="contributionPercent" value="${author.contributionPercent }" style="width: 70px;"/>
				</td> --%>
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
	 		<input type="button" value="保&#12288;存" onclick="saveCopyrightAndAuthor();" class="search"/>
            <input type="button" value="关&#12288;闭" onclick="jboxClose();" class="search"/>
     </c:if>
     		
	 </p>
     
     <%-- 新增作者信息 --%>
 	<table class="basic" id="addAuthorTable" style="display: none" width="100%">
           <tr>
			<td>
				<input class="xltext" style="width: 85%;"  type="text" name="typeName" />
			</td>
			<td>
				<input class="validate[required] xltext" style="width: 85%;" id="authorName" name="authorName" type="text"/>
			</td>
			<td style="width:90px;">
				<select class="validate[required] xlselect" style="width: 85%;" name="sexId">
                   <option value="">请选择</option>
                   <c:forEach var="dict" items="${userSexEnumList }">
                   		<c:if test="${dict.id != userSexEnumUnknown.id}">
                   			<option value="${dict.id}">${dict.name}</option>
                   		</c:if>	 
                   </c:forEach>
                </select>
			</td>
			<td>
				<select class="xlselect" name="educationId" style="width: 85%">
					<option value="">请选择</option>
					<c:forEach var="dict" items="${dictTypeEnumUserEducationList}">
						<option value="${dict.dictId}">${dict.dictName}</option>
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
				<select class="xlselect" style="width: 85%;margin-right: 0px;" id="titleId" name="titleId">
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