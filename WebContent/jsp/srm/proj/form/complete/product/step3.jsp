<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
<script type="text/javascript">
function nextOpt(step){
	if(false==$("#projForm").validationEngine("validate")){
		return false;
	}
	var form = $('#projForm');
	form.append('<input type="hidden" name="nextPageName" value="'+step+'"/>');
	$('#nxt').attr({"disabled":"disabled"});
	$('#prev').attr({"disabled":"disabled"});
	jboxStartLoading();
	form.submit();
}
function addApplyUser(tb){
	var html = '<tr>'+
	'<td><input type="checkbox"/></td>'+
	'<td><input class="inputText" name="'+tb+'_name" type="text"/></td>'+
	'<td>'+
	 '<select class="inputText" name="'+tb+'_sex">'+
	 '<option value="">请选择</option>'+ 
	    <c:forEach items="${userSexEnumList }" var="sex">
	    	<c:choose>
		    	<c:when test="${userSexEnumUnknown.id!=sex.id }">
		    	'<option value="${sex.id }">${sex.name }</option>'+ 
		    	</c:when>
	        </c:choose>   
        </c:forEach>
	 '</select></td>'+
	'<td><input  name="'+tb+'_birthday" type="text" class="inputText ctime" onClick="WdatePicker({dateFmt:'+"'yyyy-MM-dd'"+'})" readonly="readonly"/></td>'+
	'<td>'+
	'<select class="inputText" name="'+tb+'_degree">'+
	 '<option value="">请选择</option>'+ 
		<c:forEach items="${dictTypeEnumUserDegreeList}" var="degree">
			'<option value="${degree.dictId}">${degree.dictName}</option>'+
		</c:forEach>
	'</select></td>'+
	'<td>'+
		'<select class="inputText" name="'+tb+'_professional">'+
		 '<option value="">请选择</option>'+ 
			<c:forEach items="${dictTypeEnumUserTitleList}" var="title">
				'<option value="${title.dictId}">${title.dictName}</option>'+
			</c:forEach>
		'</select></td>'+
	'<td>'+
	'<select class="inputText" name="'+tb+'_post">'+
	 '<option value="">请选择</option>'+ 
	    <c:forEach items="${dictTypeEnumUserPostList}" var="post">
	   '<option value="${post.dictId}">${post.dictName}</option>'+
        </c:forEach>
	 '</select>'+ 
	'</td>'+
	'<td><input name="'+tb+'_workTime" type="text" class="inputText"/></td>'+
	'<td><input name="'+tb+'_workOrg" type="text" class="inputText"/></td>'+
'</tr>'; 
	$('#projMainPeopTb').append(html);
	
}

function addProjPeop(tb){
	var html = '<tr>'+
	'<td><input type="checkbox"/></td>'+
	'<td><input class="inputText" name="'+tb+'_name" type="text"/></td>'+
	'<td>'+
	 '<select class="inputText" name="'+tb+'_sex">'+
	 '<option value="">请选择</option>'+ 
	    <c:forEach items="${userSexEnumList }" var="sex">
	    <c:choose>
	    	<c:when test="${userSexEnumUnknown.id!=sex.id }">
	    	'<option value="${sex.id }">${sex.name }</option>'+ 
	    	</c:when>
	    </c:choose>     
        </c:forEach>
	 '</select></td>'+
	'<td><input  name="'+tb+'_birthday" type="text" class="inputText ctime" onClick="WdatePicker({dateFmt:'+"'yyyy-MM-dd'"+'})" readonly="readonly"/></td>'+
	'<td>'+
	'<select class="inputText" name="'+tb+'_degree">'+
	 '<option value="">请选择</option>'+ 
		<c:forEach items="${dictTypeEnumUserDegreeList}" var="degree">
			'<option value="${degree.dictId}">${degree.dictName}</option>'+
		</c:forEach>
	'</select></td>'+
	'<td>'+
		'<select class="inputText" name="'+tb+'_professional">'+
		 '<option value="">请选择</option>'+ 
			<c:forEach items="${dictTypeEnumUserTitleList}" var="title">
				'<option value="${title.dictId}">${title.dictName}</option>'+
			</c:forEach>
		'</select></td>'+
	'<td>'+
	'<select class="inputText" name="'+tb+'_post">'+ 
	 '<option value="">请选择</option>'+ 
	    <c:forEach items="${dictTypeEnumUserPostList}" var="post">
	   '<option value="${post.dictId}">${post.dictName}</option>'+
        </c:forEach>
	 '</select>'+ 
	'</td>'+
	'<td><input name="'+tb+'_workTime" type="text" class="inputText"/></td>'+
	'<td><input name="'+tb+'_workOrg" type="text" class="inputText"/></td>'+
'</tr>'; 
	$('#projPeopTb').append(html);
}

function delTr(tb){
	var trs = $('#'+tb).find(':checkbox:checked');
	$.each(trs , function(i , n){
		$(n).parent('td').parent("tr").remove();
		
	});
	
}
</script>
</c:if>
<style type="text/css">
	.bs_tb input.inputText{width:80%;}
	.ctime{margin-right: 0px;}
	
</style>

<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" style="position: relative;">
    <input type="hidden" id="pageName" name="pageName" value="step3"/>
	<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
    <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
	<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
	<table width="100%" cellspacing="0" cellpadding="0" class="bs_tb">
	    <thead>
		    <tr>
			  <th colspan="9" class="theader">三、人员情况<c:if test="${param.view!=GlobalConstant.FLAG_Y }"><span style="float: right;padding-right: 10px"><a href="javascript:void(0)"><img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addApplyUser('projMainPeop');"></img></a>&nbsp;<a href="javascript:void(0)"><img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('projMainPeopTb');"></img></a></span> </c:if></th>
		    </tr>
	         <tr align="center">
	           	<td width="5%">序号</td>
			    <td width="10%">姓名</td>
                <td width="7%">性别</td>
				<td width="13%">出生日期</td>
				<td width="10%">学位</td>
	            <td width="10%">职称</td>
				<td width="10%">职务</td>
			    <td width="15%">工作时间（单位：月/年）</td>
	            <td width="20%">所在单位</td>
	         </tr>
	    </thead>
	    <tbody id="projMainPeopTb">
	         <c:if test="${! empty resultMap.projMainPeop}">
	           <c:forEach var="mainPeop" items="${resultMap.projMainPeop}" varStatus="num">
			     <tr>
					<!-- 复选框 -->
					<td><input type="checkbox"/></td>
		            <!-- 姓名 -->    
					<td><input name="projMainPeop_name" value="${mainPeop.objMap.projMainPeop_name}" class="inputText" /></td>
				    <!-- 性别 -->   
					<td>
					  <select name="projMainPeop_sex"  class="inputText" >
					    <option value="">请选择</option>
				        <c:forEach items="${userSexEnumList }" var="sex">
				        <c:if test="${userSexEnumUnknown.id!=sex.id }">
						<option value="${sex.id }" <c:if test='${mainPeop.objMap.projMainPeop_sex eq sex.id}'>selected="selected"</c:if>>${sex.name }</option>     
						</c:if>
						</c:forEach>
			          </select>		
					</td>
					   <!-- 出生日期 --> 
					<td><input name="projMainPeop_birthday" value="${mainPeop.objMap.projMainPeop_birthday}"  class="inputText ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/></td>
					<!-- 学位 --> 
				    <td>
					   <select name="projMainPeop_degree" class="inputText">
					   <option value="">请选择</option>
					   <c:forEach items="${dictTypeEnumUserDegreeList}" var="degree">
		        	   <option value="${degree.dictId}" <c:if test='${mainPeop.objMap.projMainPeop_degree==degree.dictId}'>selected="selected"</c:if>>${degree.dictName}</option>
		        	   </c:forEach>
			           </select>
					</td>
					<!-- 职称 -->
					<td>
					   <select name="projMainPeop_professional" class="inputText">
					   <option value="">请选择</option>
					   <c:forEach items="${dictTypeEnumUserTitleList}" var="title">
		        	   <option value="${title.dictId}" <c:if test='${mainPeop.objMap.projMainPeop_professional==title.dictId}'>selected="selected"</c:if>>${title.dictName}</option>
		        	   </c:forEach>
					   </select>
					</td>
					<!-- 职务 -->
				    <td>
					   <select name="projMainPeop_post" class="inputText">
					   <option value="">请选择</option>
					   <c:forEach items="${dictTypeEnumUserPostList}" var="post">
		        	   <option value="${post.dictId}" <c:if test='${mainPeop.objMap.projMainPeop_post==post.dictId}'>selected="selected"</c:if>>${post.dictName}</option>
		        	   </c:forEach>
					   </select>
				    </td>
					<!-- 工作时间 -->
					<td>
					   <input name="projMainPeop_workTime" value="${mainPeop.objMap.projMainPeop_workTime}" class="inputText"  />
					</td>
					<!-- 所在单位 -->  
					<td><input name="projMainPeop_workOrg" value="${mainPeop.objMap.projMainPeop_workOrg}" class="inputText"  /></td>
		        </tr>
              </c:forEach>
	       </c:if>
	       <c:if test="${empty resultMap.projMainPeop}">
				<c:forEach var="mainPeop" items="${contractMap.projMainPeop}">
	               <tr>
				   <!-- 复选框 -->
					<td><input type="checkbox"/></td>
				   <!-- 姓名 -->  
				    <td><input name="projMainPeop_name" value="${mainPeop.objMap.projMainPeop_name}" class="inputText"/></td>
				   <!-- 性别 -->   
				   <td>
				      <select name="projMainPeop_sex" class="inputText" >
				      <option value="">请选择</option>
				      <c:forEach items="${userSexEnumList }" var="sex">
				       <c:if test="${userSexEnumUnknown.id!=sex.id }">
				      <option value="${sex.id }" <c:if test='${mainPeop.objMap.projMainPeop_sex eq sex.id}'>selected="selected"</c:if>>${sex.name }</option>     
				      </c:if>
				      </c:forEach>
				   </select>			
				   </td>
				   <!-- 出生日期 -->
				   <td><input name="projMainPeop_birthday" value="${mainPeop.objMap.projMainPeop_birthday}"  class="inputText ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/></td>
				   <!-- 学位 -->
				   <td>
					   <select name="projMainPeop_degree" class="inputText">
					   <option value="">请选择</option>
					   <c:forEach items="${dictTypeEnumUserDegreeList}" var="degree">
		        	   <option value="${degree.dictId}" <c:if test='${mainPeop.objMap.projMainPeop_degree==degree.dictId}'>selected="selected"</c:if>>${degree.dictName}</option>
		        	   </c:forEach>
					   </select>
				   </td>
					   <!-- 职称 -->
				   <td>
					   <select name="projMainPeop_professional" class="inputText">
					   <option value="">请选择</option>
					   <c:forEach items="${dictTypeEnumUserTitleList}" var="title">
		        	   <option value="${title.dictId}" <c:if test='${mainPeop.objMap.projMainPeop_professional==title.dictId}'>selected="selected"</c:if>>${title.dictName}</option>
		        	   </c:forEach>
					   </select>
				   </td>
					   <!-- 职务 -->
				   <td>
					   <select name="projMainPeop_post" class="inputText">
					   <option value="">请选择</option>
					   <c:forEach items="${dictTypeEnumUserPostList}" var="post">
		        	   <option value="${post.dictId}" <c:if test='${mainPeop.objMap.projMainPeop_post==post.dictId}'>selected="selected"</c:if>>${post.dictName}</option>
		        	   </c:forEach>
					   </select>
					</td>
					  <!-- 工作时间 -->
					<td><input name="projMainPeop_workTime" value="${mainPeop.objMap.projMainPeop_workTime}" class="inputText"  /></td>
					  <!-- 所在单位 -->  
					<td><input name="projMainPeop_workOrg" value="${mainPeop.objMap.projMainPeop_workOrg}" class="inputText" /></td>
					</tr>
					</c:forEach>
			</c:if>
	     </tbody>
	</table>
	<table width="100%" cellspacing="0" cellpadding="0" class="bs_tb">
        <tr>
            <th colspan="9" class="theader">项目参与人<c:if test="${param.view!=GlobalConstant.FLAG_Y }"><span style="float: right;padding-right: 10px"><a href="javascript:void(0)"><img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addProjPeop('projPeop');"></img></a>&nbsp;<a href="javascript:void(0)"><img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('projPeopTb');"></img></a></span> </c:if></th>
        </tr>
        <tr align="center">
            <td width="5%">序号</td>
			<td width="10%">姓名</td>
			<td width="7%">性别</td>
			<td width="13%">出生日期</td>
			<td width="10%">学位</td>
			<td width="10%">职称</td>
			<td width="10%">职务</td>
			<td width="15%">工作时间（单位：月/年）</td>
			<td width="20%">所在单位</td>
		</tr>
	    <tbody id="projPeopTb">
		    <c:if test="${! empty resultMap.projPeop}">
			    <c:forEach var="mainPeop" items="${resultMap.projPeop}" varStatus="num">
				    <tr>
					    <!-- 复选框 -->
						<td><input type="checkbox"/></td>
						<!-- 姓名 -->    
						<td><input name="projPeop_name" value="${mainPeop.objMap.projPeop_name}" class="inputText"/></td>
						<!-- 性别 -->   
						<td>
						    <select name="projPeop_sex" class="inputText">
						        <option value="">请选择</option>
								<c:forEach items="${userSexEnumList }" var="sex">
								    <c:if test="${userSexEnumUnknown.id!=sex.id }">
									    <option value="${sex.id }" <c:if test='${mainPeop.objMap.projPeop_sex eq sex.id}'>selected="selected"</c:if>>${sex.name }</option>     
									</c:if>
								</c:forEach>
							</select>		
						</td>
						<!-- 出生日期 --> 
						<td><input name="projPeop_birthday" value="${mainPeop.objMap.projPeop_birthday}"  class="inputText ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/></td>
						<!-- 学位 --> 
						<td>
						    <select name="projPeop_degree" class="inputText">
							    <option value="">请选择</option>
								<c:forEach items="${dictTypeEnumUserDegreeList}" var="degree">
		        				    <option value="${degree.dictId}" <c:if test='${mainPeop.objMap.projPeop_degree==degree.dictId}'>selected="selected"</c:if>>${degree.dictName}</option>
		        				</c:forEach>
							</select>
						</td>
						<!-- 职称 -->
						<td>
						    <select name="projPeop_professional" class="inputText">
						        <option value="">请选择</option>
								<c:forEach items="${dictTypeEnumUserTitleList}" var="title">
		        				    <option value="${title.dictId}" <c:if test='${mainPeop.objMap.projPeop_professional==title.dictId}'>selected="selected"</c:if>>${title.dictName}</option>
		        				</c:forEach>
							</select>
						</td>
						<!-- 职务 -->
						<td>
						    <select name="projPeop_post" class="inputText">
						        <option value="">请选择</option>
								<c:forEach items="${dictTypeEnumUserPostList}" var="post">
		        				    <option value="${post.dictId}" <c:if test='${mainPeop.objMap.projPeop_post==post.dictId}'>selected="selected"</c:if>>${post.dictName}</option>
		        				</c:forEach>
							</select>
						</td>
						<!-- 工作时间 -->
						<td>
						    <input name="projPeop_workTime" value="${mainPeop.objMap.projPeop_workTime}" class="inputText"  />
						</td>
						<!-- 所在单位 -->  
						<td><input name="projPeop_workOrg" value="${mainPeop.objMap.projPeop_workOrg}" class="inputText" /></td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty resultMap.projPeop}">
                <c:forEach var="mainPeop" items="${contractMap.projPeop}">
			        <tr>
					    <!-- 复选框 -->
						<td><input type="checkbox"/></td>
						<!-- 姓名 -->  
						<td><input name="projPeop_name" value="${mainPeop.objMap.projPeop_name}" class="inputText"/></td>
						<!-- 性别 -->   
						<td>
						    <select name="projPeop_sex" class="inputText">
							    <option value="">请选择</option>
								<c:forEach items="${userSexEnumList }" var="sex">
								    <c:if test="${userSexEnumUnknown.id!=sex.id }">
									    <option value="${sex.id }" <c:if test='${mainPeop.objMap.projPeop_sex eq sex.id}'>selected="selected"</c:if>>${sex.name }</option>     
									</c:if>
								</c:forEach>
							</select>			
						</td>
						<!-- 出生日期 -->
						<td><input name="projPeop_birthday" value="${mainPeop.objMap.projPeop_birthday}"  class="inputText ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/></td>
						<!-- 学位 -->
						<td>
						    <select name="projPeop_degree" class="inputText">
						        <option value="">请选择</option>
								<c:forEach items="${dictTypeEnumUserDegreeList}" var="degree">
		        				    <option value="${degree.dictId}" <c:if test='${mainPeop.objMap.projPeop_degree==degree.dictId}'>selected="selected"</c:if>>${degree.dictName}</option>
		        				</c:forEach>
							</select>
						</td>
						<!-- 职称 -->
						<td>
						    <select name="projPeop_professional" class="inputText">
							    <option value="">请选择</option>
								<c:forEach items="${dictTypeEnumUserTitleList}" var="title">
		        				    <option value="${title.dictId}" <c:if test='${mainPeop.objMap.projPeop_professional==title.dictId}'>selected="selected"</c:if>>${title.dictName}</option>
		        				</c:forEach>
							</select>
						</td>
						<!-- 职务 -->
						<td>
						    <select name="projPeop_post" class="inputText">
							    <option value="">请选择</option>
								<c:forEach items="${dictTypeEnumUserPostList}" var="post">
		        				    <option value="${post.dictId}" <c:if test='${mainPeop.objMap.projPeop_post==post.dictId}'>selected="selected"</c:if>>${post.dictName}</option>
		        				</c:forEach>
							</select>
						</td>
						<!-- 工作时间 -->
						<td><input name="projPeop_workTime" value="${mainPeop.objMap.projPeop_workTime}" class="inputText"  /></td>
						<!-- 所在单位 -->  
						<td><input name="projPeop_workOrg" value="${mainPeop.objMap.projPeop_workOrg}" class="inputText" /></td>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
    </table> 
	<table width="100%" cellspacing="0" cellpadding="0" class="bs_tb">
	    <tr>
	        <th colspan="9" class="theader">项目研发总人数</th>
	    </tr>
	    <tr>
	        <td>其中博士：</td>
	        <td><input class="inputText"  type="text" id="memberBS" name="memberBS" value="${resultMap.memberBS }"/></td>
	        <td>硕士：</td>
	        <td><input class="inputText"  type="text" id="memberSS" name="memberSS" value="${resultMap.memberSS }"/></td>
	        <td>其中高级职称：</td>
	        <td><input class="inputText"  type="text" id="highTitle" name="highTitle" value="${resultMap.highTitle }"/></td>
	        <td>中级职称：</td>
	        <td><input class="inputText"  type="text" id="middleTitle" name="middleTitle" value="${resultMap.middleTitle }"/></td>
	    </tr>
	</table>
</form>
<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
  <div class="button" style="width: 100%;">
     <input onclick="nextOpt('step2')" id="prev" class="search" type="button" value="上一步"/>
     <input onclick="nextOpt('step5')" id="nxt" class="search" type="button" value="下一步"/>
  </div>  
</c:if> 
