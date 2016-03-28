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
function save(){
  	if(false==$("#srmReseachrep").validationEngine("validate")){
		return false;
	}
	if(false==$("#authorList").validationEngine("validate")){
		return false;
	}
   	var reseachrep = $("#srmReseachrep").serializeJson();
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
		var contributionPercent= $(n).find("input[name='contributionPercent']").val();
		var data = {
				"authorFlow":authorFlow,
				"typeName":typeName,
				"authorName":authorName,
				"sexId":sexId,
				"educationId":educationId,
				"titleId":titleId,
				"degreeId":degreeId,
				"contributionPercent":contributionPercent
		};
		datas.push(data);
	});
	var t = {'authorList':datas,'reseachrep':reseachrep,"srmAchFile":achFile};
	$("#jsondata").val(JSON.stringify(t));
	var url = "<s:url value='/srm/ach/reseachrep/save'/>";
	jboxStartLoading();
	jboxSubmit($('#srmReseachrep'),url,function(resp){
    	window.parent.frames['mainIframe'].window.search();
    	jboxClose();	
	},function(resp){
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
	var url = '<s:url value="/srm/ach/reseachrep/deleteAuthor?authorFlow="/>' + authorFlow;
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
	<form id="srmReseachrep" style="position: relative;" enctype="multipart/form-data" method="post">
    <input type="hidden" name="statusId" value="${dictTypeEnumStatusType }"/>
    <input id="jsondata" type="hidden" name="jsondata" value=""/>
	      
	<table class="basic" style="width: 100%">
		<tr class="bs_name" style="height: 26px">
			<td style="text-align:left" colspan="4">基本信息</td>
		</tr>
      	<tr>
        	<th width="16%">报告题目：</th>
         	<td colspan="3">
        		<input class="validate[required] name xltext" type="text" name="repTitle" value="${reseachrep.repTitle}" style="width: 97%;"/>
         	</td>
       	</tr>
       	<tr>
         	<th>所属单位：</th>
         	<td>
	      	  	<c:forEach var="dict" items="${dictTypeEnumOrgBelongList }">
	         	<input type="radio" name="belongOrgId" id="belongOrgId_${dict.dictId }" value="${dict.dictId }"  <c:if test="${reseachrep.belongOrgId eq dict.dictId }">checked="checked"</c:if>/><label for="belongOrgId_${dict.dictId }">&nbsp;${dict.dictName }</label>&nbsp;
	      		</c:forEach>
			<th>提交单位：</th>
   			<td>
            	<input class="xltext" type="text" name="submitOrg" value="${reseachrep.submitOrg }">
       		</td>
       </tr>
       <tr>
         	<th>提交时间：</th>
         	<td>
             	<input class="xltext ctime" type="text" style="width: 160px;" name="submitDate" value="${reseachrep.submitDate }" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
         	</td>
        	<th>是否被采纳：</th>
        	<td>
         		<input type="radio" name="acceptFlag" id="acceptFlag_Y" value="Y" <c:if test="${reseachrep.acceptFlag==GlobalConstant.FLAG_Y}" >checked="checked"</c:if> ><label for="acceptFlag_Y">&nbsp;是</label>&nbsp;
         		<input type="radio" name="acceptFlag" id="acceptFlag_N" value="N" <c:if test="${reseachrep.acceptFlag==GlobalConstant.FLAG_N}" >checked="checked"</c:if> ><label for="acceptFlag_N">&nbsp;否</label>&nbsp;
         	</td>
       </tr>
       <tr>
         	<th>学科门类：</th>
         	<td>
	           	<c:forEach items="${dictTypeEnumSubjectTypeList }" var="dict">
	            	<input type="radio" name="subjectTypeId" id="subjectType_${dict.dictId }" value="${dict.dictId }" <c:if test="${reseachrep.subjectTypeId eq dict.dictId }">checked="checked"</c:if>/><label for="subjectType_${dict.dictId }">&nbsp;${dict.dictName}</label>&nbsp;
				</c:forEach>
        	</td>
         	<th>采纳对象：</th>
			<td>
				<c:forEach var="dict" items="${dictTypeEnumAcceptOrgList}">
				<input type="radio"  name="acceptObjectId" id="AcceptOrg_${dict.dictId}" value="${dict.dictId }" <c:if test="${reseachrep.acceptObjectId==dict.dictId}">checked="checked"</c:if>/><label for="AcceptOrg_${dict.dictId }">&nbsp;${dict.dictName}</label>&nbsp; 
				</c:forEach>
			</td>
       </tr>
       <tr>
         	<th>项目来源：</th>
			<td>
				<select name="projSourceId" class="xlselect">
					<option value="0">请选择</option>
					<c:forEach items="${dictTypeEnumProjSourceList }" var="dict">
					<option value="${dict.dictId }" <c:if test="${reseachrep.projSourceId eq dict.dictId }">selected="selected"</c:if>>${dict.dictName }</option>
					</c:forEach>
				</select>
			</td>
         	<th>字数：</th>
	        <td>
	           <input class="validate[custom[number]] validate[maxSize[3]] xltext" type="text" style="margin-right: 0px;" name="repWordCount" value="${reseachrep.repWordCount }">万字
	        </td>
       </tr>
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
						<input type="file" id="file" name="file" />     
					</c:otherwise>
				</c:choose>
					<input type="hidden" name="reseachrepFlow" value="${reseachrep.reseachrepFlow }"/>
				</td>
			</tr>
		</tbody>
	</table>
      
	<table class="basic" style="width: 100%">
		<thead><tr><th colspan="4" class="bs_name">备注信息</th></tr></thead>
			<tbody>
				<tr>
					<th width="16%">备注信息：</th>
					<td><textarea class="validate[maxSize[100]] xltxtarea" style="margin-left: 0px;" name="remark" >${reseachrep.remark }</textarea></td>
				</tr>
			</tbody>
	</table>
	</form>
      
	<form id="authorList">
	<table class="basic" id="mubiao" style="width: 100%">
		<tr>
			<th colspan="8" class="bs_name">研究报告作者<c:if test="${param.editFlag != GlobalConstant.FLAG_N}"><a href="javascript:void(0)"><img src="${ctxPath}/css/skin/${skinPath}/images/add.png" onclick="addAuthor();" title="添加"></img></a></c:if></th>
		</tr>
		<tr>
			<th style="text-align: center; width: 10%;">署名顺序</th>
			<th style="text-align: center; width: 15%;">作者姓名</th>
			<th style="text-align: center; width: 10%;">性别</th>
			<th style="text-align: center; width: 10%;">学历</th>
			<th style="text-align: center; width: 10%;">学位</th>
			<th style="text-align: center; width: 10%;">职称</th>
			<th style="text-align: center; width: 10%;">贡献率</th>
			<c:if test="${param.editFlag != GlobalConstant.FLAG_N}">
			<th style="text-align: center; width: 5%;">操作</th>
			</c:if>
		</tr>
      	<tbody id="test">
   		<%-- 默认作者 --%>
        <c:if test="${empty param.reseachrepFlow}">
     	<tr>
	        <td>
	        	<input class="xltext" style="width: 85%;"  type="text" name="typeName"/>
	        </td>
            <td>
               <input class="validate[required] xltext" style="width: 85%;"  type="text" name="authorName" value="${sessionScope.currUser.userName }"/>
            </td>
            <td>
               <select name="sexId" class="validate[required] xlselect" style="width: 85%;">
                  <option value="">请选择</option>
                  <c:forEach var="sex" items="${userSexEnumList}">
                  		<c:if test="${sex.id != userSexEnumUnknown.id}">
                  			<option value="${sex.id}" <c:if test="${sessionScope.currUser.sexId eq sex.id }">selected="selected"</c:if>>${sex.name}</option> 
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
            <td>
            	<input class="xltext validate[custom[number]] validate[max[100]]" style="width: 70%; margin-right: 0px;"  type="text" name="contributionPercent"/>%
            </td>
            
            <c:if test="${param.editFlag != GlobalConstant.FLAG_N}">
            <td>
           	   [<a onclick="delAuthorTr(this)" style="cursor: pointer;">删除</a>] 
            </td>
            </c:if>
      	</tr> 
		</c:if>
      
      
		<c:forEach var="author" items="${reseachrepAuthorList}">
		<tr>
        	<td>
          		<input type="hidden" name="authorFlow" value="${author.authorFlow }"/>
             	<input class="xltext" style="width: 85%;"  type="text" name="typeName" value="${author.typeName}"/>
             </td>
             <td>
                <input class="validate[required] xltext" style="width: 85%;"  type="text" name="authorName" value="${author.authorName }"/>
             </td>
             <td>
                <select name="sexId" class="validate[required] xlselect" style="width: 85%;">
                   <option value="">请选择</option>
                   <c:forEach var="sex" items="${userSexEnumList}">
                   		<c:if test="${sex.id != userSexEnumUnknown.id}">
                  			<option value="${sex.id}" <c:if test="${author.sexId eq sex.id}">selected="selected"</c:if>>${sex.name}</option>
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
             <td>
	             <input class="xltext validate[custom[number]] validate[max[100]]" style="width: 70%; margin-right: 0px;"  type="text" name="contributionPercent" value="${author.contributionPercent}"/>%
	         </td>
             <c:if test="${param.editFlag != GlobalConstant.FLAG_N}">
             <td>
           	   [<a onclick="delAuthor('${author.authorFlow}',this)" style="cursor: pointer;">删除</a>]
              </td>
              </c:if>
           </tr> 
           </c:forEach>
           </tbody>
         </table>
         </form>
         
        <form id="srmAchFile">
         	<input type="hidden" name="fileFlow" value="${file.fileFlow }"/>
        </form>
         
		<p class="button" >
			<c:if test="${param.editFlag != GlobalConstant.FLAG_N}">
			<input type="button" value="保&#12288;存" onclick="save();" class="search"/>
			<input type="button" value="关&#12288;闭" onclick="jboxClose();" class="search"/>
			</c:if>
			
		</p>


		<table class="basic" id="moban" style="display: none" style="width: 100%">
        <tr>
	        <td>
        		<input class="xltext" style="width: 85%;"  type="text" name="typeName"/>
	        </td>
            <td>
               	<input class="validate[required] xltext" style="width: 85%;" type="text" name="authorName"/>
            </td>
            <td>
               	<select name="sexId" class="validate[required] xlselect" style="width: 85%;">
					<option value="">请选择</option>
					<c:forEach var="sex" items="${userSexEnumList}">
					<c:if test="${sex.id != userSexEnumUnknown.id}">
					<option value="${sex.id}" >${sex.name}</option>
					</c:if> 
					</c:forEach>
               </select>
            </td>
            <td>
                <select name="educationId" class="xlselect" style="width: 85%;">
					<option value="">请选择</option>
					<c:forEach var="dict" items="${dictTypeEnumUserEducationList }">
					<option value="${dict.dictId }">${dict.dictName }</option> 
					</c:forEach>
               </select>
            </td>
            <td>
				<select name="degreeId" class="xlselect" style="width: 85%;">
					<option value="">请选择</option>
					<c:forEach var="dict" items="${dictTypeEnumUserDegreeList }">
					<option value="${dict.dictId }" >${dict.dictName }</option> 
					</c:forEach>
				</select> 
            </td>
            <td>
				<select name="titleId" class="xlselect" style="width: 85%;">
					<option value="">请选择</option>
					<c:forEach var="dict" items="${dictTypeEnumUserTitleList }">
					<option value="${dict.dictId }">${dict.dictName }</option> 
					</c:forEach>
				</select> 
            </td>
            <td>
	             <input class="xltext validate[custom[number]] validate[max[100]]" style="width: 70%; margin-right: 0px;"  type="text" name="contributionPercent"/>%
	        </td>
            <td> 
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