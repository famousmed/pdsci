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
<body>
<script type="text/javascript">
function saveBookAndAuthor(){
	if(false==$("#book").validationEngine("validate")){
		return false;
	}
	if(false==$("#authorList").validationEngine("validate")){
		return false;
	}
	var book = $("#book").serializeJson();
	var achFile = $("#srmAchFile").serializeJson();
	var trs = $('#appendTbody').children();
	var datas = [];
	$.each(trs , function(i , n){
		var authorFlow = $(n).find("input[name='authorFlow']").val();
		var typeName =  $(n).find("input[name='typeName']").val();
		var authorName= $(n).find("input[name='authorName']").val();
		var writeTypeId = $(n).find("select[name='writeTypeId']").val();
		var sexId =  $(n).find("select[name='sexId']").val();
		var educationId= $(n).find("select[name='educationId']").val();
		var titleId= $(n).find("select[name='titleId']").val();
		var writeWordCount= $(n).find("input[name='writeWordCount']").val();
		var data = {
				"authorFlow":authorFlow,
				"typeName":typeName,
				"authorName":authorName,
				"writeTypeId":writeTypeId,
				"sexId":sexId,
				"educationId":educationId,
				"titleId":titleId,
				"writeWordCount":writeWordCount
		};
		datas.push(data);
	});
	var t = {'authorList':datas,'book':book,'srmAchFile':achFile};
	$("#jsondata").val(JSON.stringify(t));
	var url = "<s:url value='/srm/ach/book/save'/>";
	//$('#book').submit();
	jboxStartLoading();
	jboxSubmit($('#book'),url,function(resp){
		window.parent.frames['mainIframe'].location.reload(true);
		jboxClose();
	},
	function(resp){
		alert("error");
	});
}

/* var callBack = function(result){
	if(result=="1"){
		jboxTip("保存成功");
		window.parent.frames['mainIframe'].location.reload(true);
		jboxClose();
	}else{
		jboxTip("保存失败");
	}
}; */
	
//删除一条著作作者
function delAuthor(authorFlow,obj) {
	var url = '<s:url value="/srm/ach/book/deleteAuthor?authorFlow="/>' + authorFlow;
	jboxConfirm("确认删除？" , function(){
		jboxGet(url , null , function(){
			var tr=$(obj).parent("td").parent("tr");
	      	 tr.remove();
		} , null , true);
	});
}

function addAuthor(){
	$('#appendTbody').append($("#addAuthor tr:eq(0)").clone());
}

function delAuthorTr(obj){
	jboxConfirm("确认删除？" , function(){
	    obj.parentNode.parentNode.remove();
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

<div class="mainright">
  <div class="content">
     <div class="title1 clearfix">
        <div id="look">
		<form id="book" style="position: relative;" enctype="multipart/form-data" method="post" action="<s:url value='/srm/ach/book/save'/>" target="screct_frame">
			<input id="jsondata" type="hidden" name="jsondata" value="" />
			<table class="basic" style="width: 100%">
 		 		<tr class="bs_name" style="height: 26px">
				   <td style="text-align:left" colspan="4">基本信息</td>
				</tr>
				<tr>
                    <th>著作名称：</th>
                    <td colspan="3">
                    	<input type="hidden" name="bookFlow" value="${book.bookFlow}">
                    	<input class="validate[required] name xltext" class="td_blue" style="width: 97%;" name="bookName" type="text" value="${book.bookName}" />
                    </td>
                </tr>
        		<tr>
                    <th>出版单位：</th>
                    <td>
                     <input class="xltext" name="publishOrg" type="text" value="${book.publishOrg}" />
					</td>
                    <th>出版日期：</th>
                    <td>
                       <input onClick="WdatePicker({dateFmt:'yyyy-MM'})" style="width: 160px;" class="ctime" name="publishDate" type="text" value="${book.publishDate}" />
                    </td>                                    
                </tr>
                 <tr>
                    <th>出版地：</th>
                    <td>
                        <c:forEach var="dict" items="${dictTypeEnumPlaceNameTypeList}">
						 <input type="radio" name="pubPlaceId" id="pubPlaceId_${dict.dictId }" value="${dict.dictId }" <c:if test="${book.pubPlaceId==dict.dictId}">checked="checked"</c:if>/><label for="pubPlaceId_${dict.dictId }">&nbsp;${dict.dictName }</label>&nbsp;
						</c:forEach>
					</td>
                    <th>著作类别：</th>
                    <td>
                      	<c:forEach var="dict" items="${dictTypeEnumAchBookTypeList}">
						 <input type="radio" name="typeId" id="typeId_${dict.dictId }" value="${dict.dictId }" <c:if test="${book.typeId==dict.dictId}">checked="checked"</c:if>/><label for="typeId_${dict.dictId }">&nbsp;${dict.dictName }</label>&nbsp;
						</c:forEach>
                    </td>                                    
                </tr>
                <tr>
                    <th>学科门类：</th>
                    <td>
                 		<c:forEach var="dict" items="${dictTypeEnumSubjectTypeList}">
	 					<input type="radio" name="categoryId" id="categoryId_${dict.dictId }" value="${dict.dictId }" <c:if test="${book.categoryId==dict.dictId}">checked="checked"</c:if>/><label for="categoryId_${dict.dictId }">&nbsp;${dict.dictName }</label>&nbsp;
						</c:forEach>
					</td>
                    <th>总字数：</th>
                  	<td>
                        <input style="text-align: left;margin-right: 0px;" name="wordCount" class="validate[custom[number]] xltext" type="text" value="${book.wordCount}"/>万字
                    </td>                                    
                </tr>
                <tr>
                    <th>是否译成外文： </th>
                    <td>
                    <c:choose>
					<c:when test="${not empty book.isTranslated}">
						<c:if test="${book.isTranslated eq 0 }">
							<input type="radio" name="isTranslated" id="isTranslated_0" value="0" checked="checked"/><label for="isTranslated_0">&nbsp;是</label>&nbsp;
							<input type="radio" name="isTranslated" id="isTranslated_1" value="1"/><label for="isTranslated_1">&nbsp;否</label>&nbsp;
			 			</c:if>
						<c:if test="${book.isTranslated eq 1 }">
							<input type="radio" name="isTranslated" id="isTranslated_0" value="0"/><label for="isTranslated_0">&nbsp;是</label>&nbsp;
							<input type="radio" name="isTranslated" id="isTranslated_1" value="1" checked="checked"/><label for="isTranslated_1">&nbsp;否</label>&nbsp;
					 	</c:if>
			 		</c:when>
	  				<c:otherwise>
						<input type="radio" name="isTranslated" id="isTranslated_0" value="0"/><label for="isTranslated_0">&nbsp;是</label>&nbsp;
						<input type="radio" name="isTranslated" id="isTranslated_1" value="1" /><label for="isTranslated_1">&nbsp;否</label>&nbsp;
					</c:otherwise>
	 				</c:choose>
					</td>
                          
                    <th>ISBN号：</th>
                    <td>
                        <input class="validate[custom[onlyLetterNumber]] name xltext" name="isbnCode" type="text" value="${book.isbnCode}" />
                    </td>                                    
                </tr>
                <tr>
                    <th>CIP号：</th>
                    <td>
                        <input name="cptCode" class="xltext" type="text" value="${book.cptCode}" />
					</td>
                          
                    <th>出版社级别：</th>
                    <td>
                       	<c:forEach var="dict" items="${dictTypeEnumPressLevelTypeList}">
					 	<input type="radio" name="pressLevelId" id="pressLeveId=${dict.dictId }" value="${dict.dictId }" <c:if test="${book.pressLevelId==dict.dictId}">checked="checked"</c:if>/><label for="pressLeveId=${dict.dictId }">&nbsp;${dict.dictName }</label>&nbsp;
						</c:forEach>
                    </td>                                    
                </tr>
                <tr>
                    <th>项目来源：</th>              
                    <td>
						<select name="projSourceId" class="xlselect" style="width: 168px;">
							<option value="">请选择</option>
							<c:forEach items="${dictTypeEnumProjSourceList }" var="dict">
							<option value="${dict.dictId }" <c:if test="${book.projSourceId eq dict.dictId }">selected="selected"</c:if>>${dict.dictName }</option>
							</c:forEach>
						</select>
                    </td>
                    <th>语言种类：</th>              
                    <td>
						<select name="languageTypeId" class="xlselect" style="width: 168px;">
							<option value="">请选择</option>
							<c:forEach items="${dictTypeEnumLanguageTypeList }" var="dict">
							<option value="${dict.dictId }" <c:if test="${book.languageTypeId eq dict.dictId }">selected="selected"</c:if>>${dict.dictName }</option>
							</c:forEach>
						</select>
                    </td>
                 </tr>
                 <tr>
               	    <th>所属单位：</th>
                  	<td colspan="3">
						<c:forEach var="dict" items="${dictTypeEnumOrgBelongList}">
						<input type="radio" name="orgBelongId" id="orgBelongId_${dict.dictId }" value="${dict.dictId }" <c:if test="${book.orgBelongId==dict.dictId}">checked="checked"</c:if>/><label for="orgBelongId_${dict.dictId }">&nbsp;${dict.dictName }</label>&nbsp;    
						</c:forEach>
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
					</td>
				</tr>
			</tbody>
			</table>
      
			<table class="basic" style="width: 100%">
			<thead>
			    <tr><th colspan="4" class="bs_name">备注信息</th></tr>
			</thead>
			<tbody>
			    <tr>
					<th width="16%">备注信息：</th>
					<td>
						<textarea class="validate[maxSize[100]] xltxtarea" style="margin-left: 0px;" name="remark" >${book.remark }</textarea>
					 </td>
				</tr>
			 </tbody>
			</table>
		 </form>  
	 
		<form id="srmAchFile">
		    <input type="hidden" name="fileFlow" value="${file.fileFlow }"/>
		</form>
       
		<form id="authorList">   
		<table class="basic" style="width: 100%">
		  <tr class="bs_name" style="height: 26px">
		    <td style="text-align:left" colspan="8">著作作者
		    	<c:if test="${param.editFlag != GlobalConstant.FLAG_N}">
		    	<a href="javascript:void(0)"><img src="${ctxPath}/css/skin/${skinPath}/images/add.png" onclick="addAuthor();" title="添加"></img></a>
		    	</c:if>
		    </td>
		  </tr>
          <tr>
			<th width="10%" style="text-align: center;">署名顺序</th>
			<th width="15%" style="text-align: center;">作者姓名</th>
			<th width="13%" style="text-align: center;">参编类型</th>
			<th width="11%" style="text-align: center;">性别</th>
			<th width="13%" style="text-align: center;">学历</th>
			<th width="10%" style="text-align: center;">参编字数</th>
			<th width="12%" style="text-align: center;">职称</th>
			<c:if test="${param.editFlag != GlobalConstant.FLAG_N}">
				<th width="10%" style="text-align: center;">操作</th>
			</c:if>
		  </tr>
		  
		<tbody id="appendTbody">
			<%-- 默认作者 --%>
            <c:if test="${empty param.bookFlow}">
            	<tr>
 				<td>
 					<input class="xltext" style="width: 85%;"  type="text" name="typeName"/>
   				</td>
   				<td>
   					<input class="validate[required] xltext" style="width: 85%" type="text" name="authorName" value="${sessionScope.currUser.userName}" />
   				</td>
   				<td>
		            <select name="writeTypeId" class="xlselect" style="width: 85%;">
		               <option value="">请选择</option>
		               <c:forEach var="dict" items="${dictTypeEnumWriteNameTypeList}">
		               <option value="${dict.dictId }" <c:if test="${author.writeTypeId eq dict.dictId }">selected="selected"</c:if>>${dict.dictName }</option> 
		               </c:forEach>
		            </select>
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
   					<input type="text" id="writeWordCount" name="writeWordCount" class="validate[custom[number]] xlselect" value="${author.writeWordCount }" style="width: 85%"/>
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
		
			<c:forEach items="${bookAuthorList}" var="author">
		  	<tr>
				<td>
 					<input class="xltext" style="width: 85%;"  type="text" name="typeName" value="${author.typeName}"/>
   				</td>
   				<td>
   					<input class="validate[required] xltext" style="width: 85%" type="text" name="authorName" value="${author.authorName}" />
   				</td>
   				<td>
		            <select name="writeTypeId" class="xlselect" style="width: 85%;">
		               <option value="">请选择</option>
		               <c:forEach var="dict" items="${dictTypeEnumWriteNameTypeList}">
		               <option value="${dict.dictId }" <c:if test="${author.writeTypeId eq dict.dictId }">selected="selected"</c:if>>${dict.dictName }</option> 
		               </c:forEach>
		            </select>
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
   					<input type="text" id="writeWordCount" name="writeWordCount" class="validate[custom[number]] xlselect" value="${author.writeWordCount }" style="width: 85%"/>
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
					[<a onclick="delAuthor('${author.authorFlow}',this)" style="cursor: pointer;">删除</a>]
					<input type="hidden" name="authorFlow" value="${author.authorFlow}">
         		 </td>
         		 </c:if>
        		</tr> 
        	</c:forEach>
       	</tbody>
     </table>
				
	 <p align="center">
	    <c:if test="${param.editFlag != GlobalConstant.FLAG_N}">   
        <input type="button" value="保&#12288;存" onclick="saveBookAndAuthor();" class="search"/>
        <input type="button" value="关&#12288;闭" onclick="jboxClose();" class="search"/>
        </c:if>
        
     </p>
     
	</form>
	
	<table id="addAuthor" class="basic" style="display: none;" style="width: 100%">
 		<tr>
			<td>
				<input class="xltext" style="width: 85%;"  type="text" name="typeName" />
			</td>
			<td>
				<input id="authorName" class="xltext"  class="text" name="authorName"  type="text" style="width: 85%;"/>
			</td>
			<td>
				<select id="writeTypeId" name="writeTypeId" class="xlselect" style="width: 85%;">
	                <option value="">请选择</option>
	                <c:forEach var="dict" items="${dictTypeEnumWriteNameTypeList}">
	           	 	<option value="${dict.dictId }" >${dict.dictName }</option> 
	                </c:forEach>
                </select>
			</td>
			<td>
				<select class="validate[required] xlselect"  id="sexId" name="sexId" style="width: 85%;">
	                <option value="">请选择</option>
	                <c:forEach var="dict" items="${userSexEnumList}">
	              		<c:if test="${dict.id != userSexEnumUnknown.id}">
	           	 		<option value="${dict.id}" >${dict.name}</option> 
	           	 		</c:if>
	                </c:forEach>
                </select>
			</td>
			
			<td>
				<select id="educationId" name="educationId" class="xlselect" style="width: 85%;">
					<option value="">请选择</option>
					<c:forEach var="dict" items="${dictTypeEnumUserEducationList}">
					<option value="${dict.dictId}">${dict.dictName}</option>
					</c:forEach>
				</select>
			</td>
			<td>
     					<input type="text" id="writeWordCount" name="writeWordCount" class="xlselect" style="width: 85%;">
          			</td>
			<td>
				<select id="titleId" name="titleId" class="xlselect" style="width: 85%;">
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
<iframe name="screct_frame" style="display: none"></iframe>
</body>
</html>