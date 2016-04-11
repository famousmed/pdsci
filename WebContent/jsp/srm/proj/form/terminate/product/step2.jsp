<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:if test="${param.view != GlobalConstant.FLAG_Y}">
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
function add(itemGroupName){
	var url = "?pageName="+$('#pageName').val()+
	"&itemGroupName="+itemGroupName+
	"&recFlow="+$('#recFlow').val()+
	"&projFlow="+$('#projFlow').val();
	jboxOpen("<s:url value='/srm/proj/mine/showPageGroupStep'/>"+url, "添加信息", 700,500);
}

function edit(flow,itemGroupName){
	var url = "?pageName="+$('#pageName').val()+
	"&itemGroupName="+itemGroupName+
	"&recFlow="+$('#recFlow').val()+
	"&projFlow="+$('#projFlow').val()+
	"&itemGroupFlow="+flow;
	jboxOpen("<s:url value='/srm/proj/mine/showPageGroupStep'/>"+url, "编辑信息", 700,500);
}

function del(flow,itemGroupName){
	var datas = {
			"pageName":$('#pageName').val(),
			"&itemGroupName=":itemGroupName,
			"recFlow":$('#recFlow').val(),
			"projFlow":$('#projFlow').val(),
			"itemGroupFlow":flow,
	};
	var url = "<s:url value='/srm/proj/mine/delPageGroupStep'/>";
	jboxPost(url , datas , function(){
		window.parent.frames['mainIframe'].location.reload(true);
		jboxClose();
	} , null , true);
}

function addApplyUser(tb){
	var html = '<tr>'+
	'<td><input type="checkbox"/></td>'+
	'<td><input style="width:80px;" class="inputText validate[required]" name="'+tb+'_name" type="text"/></td>'+
	'<td>'+
	 '<select name="'+tb+'_sex" class="inputText validate[required]">'+
	 '<option value="">请选择</option>'+ 
	    <c:forEach items="${userSexEnumList }" var="sex">
	    	<c:choose>
		    	<c:when test="${userSexEnumUnknown.id!=sex.id }">
		    	'<option value="${sex.id }">${sex.name }</option>'+ 
		    	</c:when>
	        </c:choose>   
     </c:forEach>
	 '</select></td>'+
	'<td><input style="width:100px;" name="'+tb+'_birthday" type="text" class="inputText validate[required]" onClick="WdatePicker({dateFmt:'+"'yyyy-MM-dd'"+'})" readonly="readonly"/></td>'+
	'<td>'+
	'<select name="'+tb+'_degree" class="inputText validate[required]">'+
	'<option value="">请选择</option>'+ 
		<c:forEach items="${dictTypeEnumUserDegreeList}" var="degree">
			'<option value="${degree.dictId}">${degree.dictName}</option>'+
		</c:forEach>
	'</select></td>'+
	'<td>'+
		'<select name="'+tb+'_professional" class="inputText validate[required]">'+
		'<option value="">请选择</option>'+ 
			<c:forEach items="${dictTypeEnumUserTitleList}" var="title">
				'<option value="${title.dictId}">${title.dictName}</option>'+
			</c:forEach>
		'</select></td>'+
	'<td>'+
	'<select name="'+tb+'_post" class="inputText validate[required]">'+  
	'<option value="">请选择</option>'+ 
	    <c:forEach items="${dictTypeEnumUserPostList}" var="post">
	   '<option value="${post.dictId}">${post.dictName}</option>'+
        </c:forEach>
	 '</select>'+ 
	'</td>'+
	'<td><input name="'+tb+'_workTime" class="inputText validate[required]" type="text"/></td>'+
	'<td><input name="'+tb+'_workOrg" class="inputText validate[required]" type="text" style="width: 80%"/></td>'+
'</tr>'; 
	$('#projMainPeopTb').append(html);
	
}

function addProjPeop(tb){
	var html = '<tr>'+
	'<td><input type="checkbox"/></td>'+
	'<td><input style="width:80px;" class="inputText validate[required]" name="'+tb+'_name" type="text"/></td>'+
	'<td>'+
	 '<select name="'+tb+'_sex" class="inputText validate[required]">'+
	 '<option value="">请选择</option>'+ 
	    <c:forEach items="${userSexEnumList }" var="sex">
	    	<c:choose>
		    	<c:when test="${userSexEnumUnknown.id!=sex.id }">
		    	'<option value="${sex.id }">${sex.name }</option>'+ 
		    	</c:when>
	        </c:choose>   
  </c:forEach>
	 '</select></td>'+
	'<td><input style="width:100px;" name="'+tb+'_birthday" type="text" class="inputText validate[required]" onClick="WdatePicker({dateFmt:'+"'yyyy-MM-dd'"+'})" readonly="readonly"/></td>'+
	'<td>'+
	'<select name="'+tb+'_degree" class="inputText validate[required]">'+
	'<option value="">请选择</option>'+ 
		<c:forEach items="${dictTypeEnumUserDegreeList}" var="degree">
		'<option value="${degree.dictId}">${degree.dictName}</option>'+
		</c:forEach>
	'</select></td>'+
	'<td>'+
		'<select name="'+tb+'_professional" class="inputText validate[required]">'+
		'<option value="">请选择</option>'+ 
			<c:forEach items="${dictTypeEnumUserTitleList}" var="title">
				'<option value="${title.dictId}">${title.dictName}</option>'+
			</c:forEach>
		'</select></td>'+
	'<td>'+
	'<select name="'+tb+'_post" class="inputText validate[required]">'+
	'<option value="">请选择</option>'+ 
	    <c:forEach items="${dictTypeEnumUserPostList}" var="post">
	   '<option value="${post.dictId}">${post.dictName}</option>'+
        </c:forEach>
	 '</select>'+ 
	'</td>'+
	'<td><input name="'+tb+'_workTime" class="inputText validate[required]" type="text"/></td>'+
	'<td><input name="'+tb+'_workOrg" class="inputText validate[required]" type="text" style="width: 80%"/></td>'+
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
<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" style="position: relative;">
    <input type="hidden" id="pageName" name="pageName" value="step2"/>
	<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
    <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
	<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
    <div>
        <font style="font-size: 14px; font-weight:bold; padding-left: 10px;margin-top: 10px;color: #333; ">二、人员情况</font>
    </div>		 
    <table width="100%"  cellspacing="0" cellpadding="0" class="bs_tb" style="margin-top: 10px;">
        <tr>
            <th colspan="11" class="theader">项目负责人
                <c:if test="${param.view!=GlobalConstant.FLAG_Y }"><span style="float: right;padding-right: 10px"><img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addApplyUser('projMainPeop');"></img>&nbsp;<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('projMainPeopTb');"></img></span> </c:if>
            </th>
        </tr>
        <tr>
		    <td width="50" style="font-weight:bold;">序号</td>
			<td width="12%" style="font-weight:bold;">姓名</td>
			<td width="60" style="font-weight:bold;">性别</td>
			<td width="13%" style="font-weight:bold;">出生日期</td>
			<td width="10%" style="font-weight:bold;">学位</td>
			<td width="10%" style="font-weight:bold;">职称</td>
			<td style="font-weight:bold;" width="10%">职务</td>
			<td width="15%" style="font-weight:bold;">工作时间（单位：月/年）</td>
			<td  style="font-weight:bold;">所在单位</td>
		</tr>
		<tbody id="projMainPeopTb">
		    <c:if test="${! empty resultMap.projMainPeop}">
	            <c:forEach var="mainPeop" items="${resultMap.projMainPeop}" varStatus="num">
			        <tr>
					    <!-- 复选框 -->
					    <td><input type="checkbox"/></td>
		                <!-- 姓名 -->    
					    <td><input name="projMainPeop_name" value="${mainPeop.objMap.projMainPeop_name}" style="width:80px;" class="inputText validate[required]"/></td>
				        <!-- 性别 -->   
					    <td>
					        <select name="projMainPeop_sex" class="inputText validate[required]">
					            <option value="">请选择</option>
				                <c:forEach items="${userSexEnumList }" var="sex">
						            <c:if test="${sex.id != 'Unknown' }"><option value="${sex.id }" <c:if test='${mainPeop.objMap.projMainPeop_sex eq sex.id}'>selected="selected"</c:if>>${sex.name }</option></c:if>     
						        </c:forEach>
			                </select>		
					    </td>
					    <!-- 出生日期 --> 
					    <td><input name="projMainPeop_birthday" value="${mainPeop.objMap.projMainPeop_birthday}" style="width:100px" class="inputText validate[required]" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/></td>
					    <!-- 学位 --> 
				        <td>
					        <select name="projMainPeop_degree" class="inputText validate[required]">
					            <option value="">请选择</option>
					            <c:forEach items="${dictTypeEnumUserDegreeList}" var="degree">
		        	                <option value="${degree.dictId}" <c:if test='${mainPeop.objMap.projMainPeop_degree==degree.dictId}'>selected="selected"</c:if>>${degree.dictName}</option>
		        	            </c:forEach>
			               </select>
					   </td>
					   <!-- 职称 -->
					   <td>
					       <select name="projMainPeop_professional" class="inputText validate[required]">
					           <option value="">请选择</option>
					           <c:forEach items="${dictTypeEnumUserTitleList}" var="title">
		        	               <option value="${title.dictId}" <c:if test='${mainPeop.objMap.projMainPeop_professional==title.dictId}'>selected="selected"</c:if>>${title.dictName}</option>
		        	           </c:forEach>
					       </select>
					   </td>
					   <!-- 职务 -->
				       <td>
					       <select name="projMainPeop_post" class="inputText validate[required]">
					           <option value="">请选择</option>
					           <c:forEach items="${dictTypeEnumUserPostList}" var="post">
		        	               <option value="${post.dictId}" <c:if test='${mainPeop.objMap.projMainPeop_post==post.dictId}'>selected="selected"</c:if>>${post.dictName}</option>
		        	           </c:forEach>
					       </select>
				       </td>
					   <!-- 工作时间 -->
					   <td>
					       <input name="projMainPeop_workTime" class="inputText validate[required]" value="${mainPeop.objMap.projMainPeop_workTime}"    />
					   </td>
					   <!-- 所在单位 -->  
					   <td><input name="projMainPeop_workOrg" class="inputText validate[required]" value="${mainPeop.objMap.projMainPeop_workOrg}" style="width: 80%"/></td>
		           </tr>
               </c:forEach>
	       </c:if>
	       <c:if test="${empty resultMap.projMainPeop}">
		       <c:forEach var="mainPeop" items="${contractMap.projMainPeop}">
	               <tr>
				   <!-- 复选框 -->
				   <td><input type="checkbox"/></td>
				   <!-- 姓名 -->  
				   <td><input name="projMainPeop_name" class="inputText validate[required]" value="${mainPeop.objMap.projMainPeop_name}" style="width:80px;"/></td>
				   <!-- 性别 -->   
				   <td>
				       <select name="projMainPeop_sex" class="inputText validate[required]">
				           <option value="">请选择</option>
				           <c:forEach items="${userSexEnumList }" var="sex">
				               <c:if test="${sex.id != 'Unknown' }"><option value="${sex.id }" <c:if test='${mainPeop.objMap.projMainPeop_sex eq sex.id}'>selected="selected"</c:if>>${sex.name }</option></c:if>     
				           </c:forEach>
				       </select>			
				   </td>
				   <!-- 出生日期 -->
				   <td><input name="projMainPeop_birthday" class="inputText validate[required]" value="${mainPeop.objMap.projMainPeop_birthday}" style="width:100px" class="ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/></td>
				   <!-- 学位 -->
				   <td>
					   <select name="projMainPeop_degree" class="inputText validate[required]" >
					   <option value="">请选择</option>
					   <c:forEach items="${dictTypeEnumUserDegreeList}" var="degree">
		        	   <option value="${degree.dictId}" <c:if test='${mainPeop.objMap.projMainPeop_degree==degree.dictId}'>selected="selected"</c:if>>${degree.dictName}</option>
		        	   </c:forEach>
					   </select>
				   </td>
					   <!-- 职称 -->
				   <td>
					   <select name="projMainPeop_professional" class="inputText validate[required]">
					   <option value="">请选择</option>
					   <c:forEach items="${dictTypeEnumUserTitleList}" var="title">
		        	   <option value="${title.dictId}" <c:if test='${mainPeop.objMap.projMainPeop_professional==title.dictId}'>selected="selected"</c:if>>${title.dictName}</option>
		        	   </c:forEach>
					   </select>
				   </td>
					   <!-- 职务 -->
				   <td>
					   <select name="projMainPeop_post" class="inputText validate[required]" >
					   <option value="">请选择</option>
					   <c:forEach items="${dictTypeEnumUserPostList}" var="post">
		        	   <option value="${post.dictId}" <c:if test='${mainPeop.objMap.projMainPeop_post==post.dictId}'>selected="selected"</c:if>>${post.dictName}</option>
		        	   </c:forEach>
					   </select>
					</td>
					  <!-- 工作时间 -->
					<td><input name="projMainPeop_workTime" class="inputText validate[required]" value="${mainPeop.objMap.projMainPeop_workTime}"    /></td>
					  <!-- 所在单位 -->  
					<td><input name="projMainPeop_workOrg" class="inputText validate[required]" value="${mainPeop.objMap.projMainPeop_workOrg}" style="width: 80%"/></td>
					</tr>
				</c:forEach>
			</c:if>
        </tbody>
    </table>  
	<table width="100%" cellspacing="0" cellpadding="0" class="bs_tb" style="margin-top: 10px;">
        <tr>
            <th colspan="11" class="theader">项目参与人
                <c:if test="${param.view!=GlobalConstant.FLAG_Y }"><span style="float: right;padding-right: 10px"><img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addProjPeop('projPeop');"></img>&nbsp;<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('projPeopTb');"></img></span> </c:if>
            </th>
        </tr>
		<tr>
		    <td width="50" style="font-weight:bold;">序号</td>
			<td width="12%" style="font-weight:bold;">姓名</td>
			<td width="60" style="font-weight:bold;">性别</td>
			<td width="13%" style="font-weight:bold;">出生日期</td>
			<td width="10%" style="font-weight:bold;">学位</td>
			<td width="10%" style="font-weight:bold;">职称</td>
			<td style="font-weight:bold;" width="10%">职务</td>
			<td width="15%" style="font-weight:bold;">工作时间（单位：月/年）</td>
			<td  style="font-weight:bold;">所在单位</td>
        </tr>
		<tbody id="projPeopTb">
		    <c:if test="${! empty resultMap.projPeop}">
			    <c:forEach var="mainPeop" items="${resultMap.projPeop}" varStatus="num">
				    <tr>
					    <!-- 复选框 -->
						<td><input type="checkbox"/></td>
						<!-- 姓名 -->    
						<td><input name="projPeop_name" class="inputText validate[required]" value="${mainPeop.objMap.projPeop_name}" style="width:80px;"/></td>
						<!-- 性别 -->   
						<td>
						    <select name="projPeop_sex" class="inputText validate[required]">
							    <option value="">请选择</option>
								    <c:forEach items="${userSexEnumList }" var="sex">
									    <c:if test="${sex.id != 'Unknown' }"><option value="${sex.id }" <c:if test='${mainPeop.objMap.projPeop_sex eq sex.id}'>selected="selected"</c:if>>${sex.name }</option></c:if>     
									</c:forEach>
							</select>		
						</td>
						<!-- 出生日期 --> 
						<td><input name="projPeop_birthday" class="inputText validate[required]" value="${mainPeop.objMap.projPeop_birthday}" style="width:100px"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/></td>
						<!-- 学位 --> 
						<td>
						    <select name="projPeop_degree" class="inputText validate[required]">
						        <option value="">请选择</option>
								<c:forEach items="${dictTypeEnumUserDegreeList}" var="degree">
		        				    <option value="${degree.dictId}" <c:if test='${mainPeop.objMap.projPeop_degree==degree.dictId}'>selected="selected"</c:if>>${degree.dictName}</option>
		        				</c:forEach>
							</select>
						</td>
						<!-- 职称 -->
						<td>
						    <select name="projPeop_professional" class="inputText validate[required]">
							    <option value="">请选择</option>
								<c:forEach items="${dictTypeEnumUserTitleList}" var="title">
		        				    <option value="${title.dictId}" <c:if test='${mainPeop.objMap.projPeop_professional==title.dictId}'>selected="selected"</c:if>>${title.dictName}</option>
		        				</c:forEach>
							</select>
						</td>
						<!-- 职务 -->
						<td>
						    <select name="projPeop_post" class="inputText validate[required]">
							    <option value="">请选择</option>
								<c:forEach items="${dictTypeEnumUserPostList}" var="post">
		        				    <option value="${post.dictId}" <c:if test='${mainPeop.objMap.projPeop_post==post.dictId}'>selected="selected"</c:if>>${post.dictName}</option>
		        				</c:forEach>
							</select>
						</td>
						<!-- 工作时间 -->
						<td>
						    <input name="projPeop_workTime" class="inputText validate[required]" value="${mainPeop.objMap.projPeop_workTime}"   />
						</td>
						<!-- 所在单位 -->  
						<td><input name="projPeop_workOrg" class="inputText validate[required]" value="${mainPeop.objMap.projPeop_workOrg}" style="width: 80%"/></td>
                    </tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty resultMap.projPeop}">
			    <c:forEach var="mainPeop" items="${contractMap.projPeop}">
				    <tr>
					    <!-- 复选框 -->
						<td><input type="checkbox"/></td>
						<!-- 姓名 -->  
						<td><input name="projPeop_name" class="inputText validate[required]"  value="${mainPeop.objMap.projPeop_name}" style="width:80px;"/></td>
						<!-- 性别 -->   
						<td>
						    <select name="projPeop_sex" class="inputText validate[required]" >
							    <option value="">请选择</option>
								    <c:forEach items="${userSexEnumList }" var="sex">
									    <c:if test="${sex.id != 'Unknown' }"><option value="${sex.id }" <c:if test='${mainPeop.objMap.projPeop_sex eq sex.id}'>selected="selected"</c:if>>${sex.name }</option></c:if>     
									</c:forEach>
							</select>			
						</td>
						<!-- 出生日期 -->
						<td><input name="projPeop_birthday" class="inputText validate[required]" value="${mainPeop.objMap.projPeop_birthday}" style="width:100px"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/></td>
						<!-- 学位 -->
						<td>
						    <select name="projPeop_degree" class="inputText validate[required]">
							    <option value="">请选择</option>
								<c:forEach items="${dictTypeEnumUserDegreeList}" var="degree">
		        				    <option value="${degree.dictId}" <c:if test='${mainPeop.objMap.projPeop_degree==degree.dictId}'>selected="selected"</c:if>>${degree.dictName}</option>
		        				</c:forEach>
							</select>
						</td>
						<!-- 职称 -->
						<td>
						    <select name="projPeop_professional" class="inputText validate[required]">
							    <option value="">请选择</option>
								<c:forEach items="${dictTypeEnumUserTitleList}" var="title">
		        				    <option value="${title.dictId}" <c:if test='${mainPeop.objMap.projPeop_professional==title.dictId}'>selected="selected"</c:if>>${title.dictName}</option>
		        				</c:forEach>
							</select>
						</td>
						<!-- 职务 -->
						<td>
						    <select name="projPeop_post" class="inputText validate[required]">
							    <option value="">请选择</option>
								<c:forEach items="${dictTypeEnumUserPostList}" var="post">
		        				    <option value="${post.dictId}" <c:if test='${mainPeop.objMap.projPeop_post==post.dictId}'>selected="selected"</c:if>>${post.dictName}</option>
		        				</c:forEach>
							</select>
						</td>
						<!-- 工作时间 -->
						<td><input name="projPeop_workTime" class="inputText validate[required]" value="${mainPeop.objMap.projPeop_workTime}"   /></td>
						<!-- 所在单位 -->  
						<td><input name="projPeop_workOrg" class="inputText validate[required]" value="${mainPeop.objMap.projPeop_workOrg}" style="width: 80%"/></td>
				    </tr>
				</c:forEach>
			</c:if>
		</tbody>
    </table> 
    <table width="100%" class="basic" style="margin-top: 10px;">
        <tr>
 		    <th colspan="4" style="padding-left:15px;text-align:left;">基本信息</th>
 		</tr>
        <tbody>
            <tr>
                <td width="20%" style="text-align: right;">博士个数：</td>
                <td width="30%">
                    <input name="boShiCount" class="inputText validate[required]" value="${resultMap.boShiCount}"/>      
                <td width="20%" style="text-align: right;">硕士个数：</td>
                <td width="30%">
                    <input name="shuoShiCount" class="inputText validate[required]" value="${resultMap.shuoShiCount}"/>
                </td>
            </tr>
            <tr>
                <td width="20%" style="text-align: right;">高级职称个数：</td>
                <td width="30%">
	                <input name="hightDutyCount" class="inputText validate[required]" value="${resultMap.hightDutyCount}"/>
                </td>
                <td width="20%" style="text-align: right;">中级职称个数：</td>
                <td width="30%">
	                <input name="midDutyCount" class="inputText validate[required]" value="${resultMap.midDutyCount}"/>
                </td>
            </tr>
        </tbody>
    </table>
</form>
<div class="button" style="width:100%;<c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none;</c:if>">
    <input onclick="nextOpt('step1')" id="prev" class="search" type="button" value="上一步"/>
    <input onclick="nextOpt('step3')" id="nxt" class="search" type="button" value="下一步"/>
</div>
      			   
