<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<c:if test="${param.view != GlobalConstant.FLAG_Y}">
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="ueditor" value="true"/>
</jsp:include>
<script type="text/javascript">
function addApplyUser(tb){
	$('#'+tb).append($('#'+tb+"_model").html());
}
function delTr(tb){
	var trs = $('#'+tb).find(':checkbox:checked');
	if(trs.length==0){
		jboxTip("请勾选要删除的！");
		return false;
	}
	jboxConfirm("确认删除？" , function(){
		$.each(trs , function(i , n){
			$(n).parent('td').parent("tr").remove();
			
		});
		
	});
}
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
</script>
</c:if>
<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" style="position: relative;">
    <input type="hidden" id="pageName" name="pageName" value="step5"/>
	<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
	<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
	<input type="hidden" name="recTypeId" value="${param.recTypeId}"/>
	<div class="title_sp">五、人员情况</div>
	    <!-- 项目负责人开始 -->
		<table width="100%" cellspacing="0" cellpadding="0" class="bs_tb">
		    <tr>
			    <th colspan="8" style="text-align: left;padding-left: 15px;" class="theader">项目负责人<span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span><c:if test="${param.view != GlobalConstant.FLAG_Y}"><span style="float: right;padding-right: 10px"><img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addApplyUser('projMainPeopTb');"></img>&nbsp;<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('projMainPeopTb');"></img></span></c:if></th>
            </tr>
			<tr>
			    <td width="5%">序号</td>
				<td width="12%">姓名</td>
				<td width="7%">性别</td>
				<td width="7%">年龄</td>
				<td width="15%">职务/职称</td>
				<td width="17%">从事专业</td>
				<td width="15%">为本项目工作时间（单位：月/年）</td>
				<td>所在单位</td>
			</tr>
			<tbody id="projMainPeopTb">
			    <c:if test="${! empty resultMap.projMainPeop}">
			        <c:choose>
   			            <c:when test="${param.view == GlobalConstant.FLAG_Y}">
   			                <c:forEach var="mainPeop" items="${resultMap.projMainPeop}" varStatus="num">
							    <tr>
								    <!-- 复选框 -->
								    <td>${num.count }</td>
								    <!-- 姓名 -->    
								    <td>${mainPeop.objMap.projMainPeop_name}</td>
								    <!-- 性别 -->   
								    <td>
									    <c:forEach items="${userSexEnumList }" var="sex">
										    <c:if test="${sex.id != userSexEnumUnknown.id}">
											    <c:if test='${mainPeop.objMap.projMainPeop_sex eq sex.id}'>${sex.name }</c:if>
											</c:if>
									    </c:forEach>
								    </td>
								    <!-- 年龄 --> 
								    <td>${mainPeop.objMap.projMainPeop_age}</td>
								    <!-- 职务/职称 --> 
								    <td>${mainPeop.objMap.projMainPeop_postAndTitle}</td>
								    <!-- 从事专业 --> 
								    <td>
								        ${mainPeop.objMap.projMainPeop_major}
								    </td>
								    <!-- 工作时间 -->
								    <td>
								        ${mainPeop.objMap.projMainPeop_workTime}
								    </td>
								    <!-- 所在单位 -->  
								    <td>${mainPeop.objMap.projMainPeop_workOrg}</td>
								</tr>
                            </c:forEach>
   			            </c:when>
   			            <c:otherwise>
					        <c:forEach var="mainPeop" items="${resultMap.projMainPeop}" varStatus="num">
					            <tr>
								    <!-- 复选框 -->
								    <td><input type="checkbox"/></td>
								    <!-- 姓名 -->    
								    <td><input name="projMainPeop_name" value="${mainPeop.objMap.projMainPeop_name}" class='validate[required] inputText' style="width:80%;"/></td>
								    <!-- 性别 -->   
								    <td>
								        <select name="projMainPeop_sex" class="validate[required] inputText">
								            <option value="">请选择</option>
											<c:forEach items="${userSexEnumList }" var="sex">
											    <c:if test="${sex.id != userSexEnumUnknown.id}">
											        <option value="${sex.id }" <c:if test='${mainPeop.objMap.projMainPeop_sex eq sex.id}'>selected="selected"</c:if>>${sex.name }</option>     
											    </c:if>
											</c:forEach>
									    </select>		
								    </td>
								    <!-- 年龄 --> 
								    <td><input name="projMainPeop_age" value="${mainPeop.objMap.projMainPeop_age}" class='validate[custom[integer]] inputText' style="width:80%;" /></td>
								    <!-- 职务/职称 --> 
								    <td><input name="projMainPeop_postAndTitle" value="${mainPeop.objMap.projMainPeop_postAndTitle}" class='validate[required] inputText' style="width:80%;" /></td>
								    <!-- 从事专业 --> 
								    <td>
								        <input name="projMainPeop_major" value="${mainPeop.objMap.projMainPeop_major}" class='validate[required] inputText' style="width:80%;"  />	
								    </td>
								    <!-- 工作时间 -->
								    <td>
								        <input name="projMainPeop_workTime" value="${mainPeop.objMap.projMainPeop_workTime}" class='validate[required] inputText' style="width:80%;"  />
								    </td>
								    <!-- 所在单位 -->  
								    <td><input name="projMainPeop_workOrg" value="${mainPeop.objMap.projMainPeop_workOrg}" class='validate[required] inputText' style='width:84%;'/></td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</c:if>
				<!-- 从申报书中带出或是默认一条 -->
				<c:if test="${empty resultMap.projMainPeop and param.view != GlobalConstant.FLAG_Y}">
				    <c:choose>
   			            <c:when test="${not empty applyMap.projMainPeop}">
   			            <c:forEach var="projMainPeop" items="${applyMap.projMainPeop}" varStatus="status">
					        <tr>
					        	<td><input type="checkbox"/></td>
								<td><input type="text" name="projMainPeop_name" value="${projMainPeop.objMap.projMainPeop_name}" class="inputText validate[required]" style="width: 80%;"/></td>
								<td>
					                <select name="projMainPeop_sex" class="inputText validate[required]">
					                   <option value="">请选择</option>
					                   <c:forEach var="sex" items="${userSexEnumList}">
					                   		<c:if test="${sex.id != userSexEnumUnknown.id}">
					                   			<option value="${sex.id}" <c:if test="${projMainPeop.objMap.projMainPeop_sex eq sex.id}">selected="selected"</c:if>>${sex.name}</option>
					                   		</c:if>	 
					                   </c:forEach>
					                </select>
				           		</td>
								<td><input type="text" name="projMainPeop_age" value="${projMainPeop.objMap.projMainPeop_age}" class="validate[custom[integer]] inputText" style="width: 80%;"/></td>
								<td><input type="text" name="projMainPeop_postAndTitle" value="${projMainPeop.objMap.projMainPeop_jobTitle}" class="inputText validate[required]" style="width: 80%;"/></td>
								<td><input type="text" name="projMainPeop_major" value="${projMainPeop.objMap.projMainPeop_major}" class="validate[required] inputText" style="width: 80%;"/></td>
								<td><input type="text" name="projMainPeop_workTime" value="${projMainPeop.objMap.projMainPeop_workTime}" class="inputText validate[required]" style="width: 80%;"/></td>
								<td><input type="text" name="projMainPeop_workOrg" value="${projMainPeop.objMap.projMainPeop_workOrg}" class="inputText validate[required]" style="width: 80%;"/></td>
					        </tr>
					    </c:forEach>
   			            </c:when>
   			            <c:otherwise>
	   			            <tr>
						    <!-- 复选框 -->
						    <td><input type="checkbox"/></td>
						    <!-- 姓名 -->    
							<td><input name="projMainPeop_name" class='validate[required] inputText' style="width:80%;"/></td>
							<!-- 性别 -->   
							<td>
							    <select name="projMainPeop_sex" class="validate[required] inputText">
								    <option value="">请选择</option>
									<c:forEach items="${userSexEnumList }" var="sex">
									    <c:if test="${ sex.id != userSexEnumUnknown.id}">
										    <option value="${sex.id }">${sex.name }</option> 
										</c:if>    
									</c:forEach>
								</select>		
							</td>
							<!-- 年龄 --> 
							<td><input name="projMainPeop_age" value="${mainPeop.objMap.projMainPeop_age}" class='validate[custom[integer]] inputText' style="width:80%;" /></td>
							<!-- 职务/职称 --> 
							<td><input name="projMainPeop_postAndTitle" value="${mainPeop.objMap.projMainPeop_postAndTitle}" class='validate[required] inputText' style="width:80%;" /></td>
							<!-- 业务专业 --> 
							<td>
							    <input name="projMainPeop_major" class='validate[required] inputText' style="width:80%;"/>	
							</td>
							<!-- 工作时间 -->
							<td>
							    <input name="projMainPeop_workTime" class='validate[required] inputText' style="width:80%;"/>
							</td>
							<!-- 所在单位 -->  
							<td><input name="projMainPeop_workOrg" class='validate[required] inputText' style="width:84%;"/></td>
						    </tr>
   			            </c:otherwise>
   			        </c:choose>
				</c:if>
			</tbody>
      	</table> 
      	<!-- 项目负责人结束 -->
      	<!-- 主要参加人员开始 -->
      	<table width="100%" cellspacing="0" cellpadding="0" class="bs_tb" style="margin-top: 10px;" id="table6">
      	    <tr>
			    <th colspan="8" style="text-align: left;padding-left: 15px;" class="theader">主要参加人员<span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span><c:if test="${param.view != GlobalConstant.FLAG_Y}"><span style="float: right;padding-right: 10px"><img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addApplyUser('projPeopTb');"></img>&nbsp;<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('projPeopTb');"></img></span></c:if></th>
			</tr>
			<tr>
			    <td width="5%">序号</td>
				<td width="12%">姓名</td>
				<td width="7%">性别</td>
				<td width="7%">年龄</td>
				<td width="15%">职务/职称</td>
				<td width="17%">从事专业</td>
				<td width="15%">为本项目工作时间（单位：月/年）</td>
				<td>所在单位</td>
			</tr>
			<tbody id="projPeopTb">
			    <c:if test="${! empty resultMap.projPeop}">
			        <c:choose>
   			            <c:when test="${param.view == GlobalConstant.FLAG_Y}">
   			                <c:forEach var="mainPeop" items="${resultMap.projPeop}" varStatus="num">
							    <tr>
								    <!-- 复选框 -->
								    <td>${num.count }</td>
								    <!-- 姓名 -->    
								    <td>${mainPeop.objMap.projPeop_name}</td>
								    <!-- 性别 -->   
								    <td>
									    <c:forEach items="${userSexEnumList }" var="sex">
										    <c:if test="${ sex.id != userSexEnumUnknown.id}">
											    <c:if test='${mainPeop.objMap.projPeop_sex eq sex.id}'>${sex.name}</c:if>
											</c:if>     
										</c:forEach>
								    </td>
								    <!-- 年龄 --> 
								    <td>${mainPeop.objMap.projPeop_age}</td>
								    <!-- 职务/职称 --> 
								    <td>${mainPeop.objMap.projPeop_postAndTitle}</td>
								    <!-- 业务专业 --> 
								    <td>${mainPeop.objMap.projPeop_major}</td>
								    <!-- 工作时间 -->
								    <td>${mainPeop.objMap.projPeop_workTime}</td>
								    <!-- 所在单位 -->  
								    <td>${mainPeop.objMap.projPeop_workOrg}</td>
								</tr>
							</c:forEach>
   			            </c:when>
   			            <c:otherwise>
						    <c:forEach var="mainPeop" items="${resultMap.projPeop}" varStatus="num">
							    <tr>
								    <!-- 复选框 -->
								    <td><input type="checkbox"/></td>
								    <!-- 姓名 -->    
								    <td><input name="projPeop_name" value="${mainPeop.objMap.projPeop_name}" class='validate[required] inputText' style="width:80%;"/></td>
								    <!-- 性别 -->   
								    <td>
								        <select name="projPeop_sex" class="validate[required] inputText">
								            <option value="">请选择</option>
											<c:forEach items="${userSexEnumList }" var="sex">
											    <c:if test="${ sex.id != userSexEnumUnknown.id}">
											        <option value="${sex.id }" <c:if test='${mainPeop.objMap.projPeop_sex eq sex.id}'>selected="selected"</c:if>>${sex.name }</option>
											    </c:if>     
											</c:forEach>
										</select>		
								    </td>
								    <!-- 年龄 --> 
								    <td><input name="projPeop_age" value="${mainPeop.objMap.projPeop_age}" class='validate[custom[integer]] inputText' style="width:80%;" /></td>
								    <!-- 职务/职称 --> 
								    <td><input name="projPeop_postAndTitle" value="${mainPeop.objMap.projPeop_postAndTitle}" class='validate[required] inputText' style="width:80%;" /></td>
								    <!-- 业务专业 --> 
								    <td>
								        <input name="projPeop_major" value="${mainPeop.objMap.projPeop_major}" class='validate[required] inputText' style="width:80%;" />	
								    </td>
								    <!-- 工作时间 -->
								    <td>
								        <input name="projPeop_workTime" value="${mainPeop.objMap.projPeop_workTime}" class='validate[required] inputText' style="width:80%;"  />
								    </td>
								    <!-- 所在单位 -->  
								    <td><input name="projPeop_workOrg" value="${mainPeop.objMap.projPeop_workOrg}" class='validate[required] inputText' style='width:84%;'/></td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</c:if>
				<!-- 从申报书中带出或是默认一条 -->
				<c:if test="${empty resultMap.projPeop and param.view != GlobalConstant.FLAG_Y}">
				    <c:choose>
				        <c:when test="${not empty applyMap.projPeop}">
				            <c:forEach var="projPeop" items="${applyMap.projPeop}" varStatus="status">
						        <tr>
						        	<td><input type="checkbox"/></td>
									<td><input type="text" name="projPeop_name" value="${projPeop.objMap.projPeop_name}" class="inputText validate[required]" style="width: 80%;"/></td>
									<td>
						                <select name="projPeop_sex" class="inputText validate[required]">
						                   <option value="">请选择</option>
						                   <c:forEach var="sex" items="${userSexEnumList}">
						                   		<c:if test="${sex.id != userSexEnumUnknown.id}">
						                   			<option value="${sex.id}" <c:if test="${projPeop.objMap.projPeop_sex eq sex.id}">selected="selected"</c:if>>${sex.name}</option>
						                   		</c:if>	 
						                   </c:forEach>
						                </select>
					           		</td>
									<td><input type="text" name="projPeop_age" value="${projPeop.objMap.projPeop_age}" class="validate[custom[integer]] inputText" style="width: 80%;"/></td>
									<td><input type="text" name="projPeop_postAndTitle" value="${projPeop.objMap.projPeop_jobTitle}" class="inputText validate[required]" style="width: 80%;"/></td>
									<td><input type="text" name="projPeop_major" value="${projPeop.objMap.projPeop_major}" class="validate[required] inputText" style="width: 80%;"/></td>
									<td><input type="text" name="projPeop_workTime" value="${projPeop.objMap.projPeop_workTime}" class="validate[required] inputText" style="width: 80%;"/></td>
									<td><input type="text" name="projPeop_workOrg" value="${projPeop.objMap.projPeop_workOrg}" class="inputText validate[required]" style="width: 80%;"/></td>
						        </tr>
						    </c:forEach>
				        </c:when>
				        <c:otherwise>
				        <tr>
					    <!-- 复选框 -->
						<td><input type="checkbox"/></td>
						<!-- 姓名 -->    
						<td><input name="projPeop_name" class='inputText validate[required]' style="width:80%;"/></td>
						<!-- 性别 -->   
						<td>
						    <select name="projPeop_sex" class="inputText validate[required]">
							    <option value="">请选择</option>
								<c:forEach items="${userSexEnumList }" var="sex">
								    <c:if test="${ sex.id != userSexEnumUnknown.id}">
									    <option value="${sex.id }">${sex.name }</option> 
									</c:if>    
								</c:forEach>
							</select>		
						</td>
						<!-- 年龄 --> 
						<td><input name="projPeop_age" class='validate[custom[integer]] inputText' style="width:80%;" /></td>
						<!-- 职务/职称 --> 
						<td><input name="projPeop_postAndTitle" class='inputText validate[required]' style="width:80%;" /></td>
						<!-- 业务专业 --> 
						<td>
						    <input name="projPeop_major" class='inputText validate[required]' style="width:80%;"/>	
						</td>
						<!-- 工作时间 -->
						<td>
						    <input name="projPeop_workTime" class='inputText validate[required]' style="width:80%;"/>
						</td>
						<!-- 所在单位 -->  
						<td><input name="projPeop_workOrg" class='inputText validate[required]' style="width:84%;"/></td>
					    </tr>
				        </c:otherwise>
				    </c:choose>
				</c:if>
			</tbody>
      	</table>
      	<!-- 主要参加人员结束 -->
      	<c:if test="${param.view != GlobalConstant.FLAG_Y}">
      	    <div align="center" style="margin-top: 10px">
      		    <input id="prev" type="button" onclick="nextOpt('step4')" class="search" value="上一步"/>
        	    <input id="nxt" type="button" onclick="nextOpt('step6')" class="search" value="下一步"/>
			</div>
		</c:if>
</form>
	<c:if test="${param.view != GlobalConstant.FLAG_Y}">
	    <div style="display: none;">
		    <table>
			    <tbody id="projMainPeopTb_model">
				    <tr>
					    <!-- 复选框 -->
						<td><input type="checkbox"/></td>
						<!-- 姓名 -->    
						<td><input name="projMainPeop_name" class='inputText validate[required]' style="width:80%;"/></td>
						<!-- 性别 -->   
						<td>
						    <select name="projMainPeop_sex" class="inputText validate[required]">
						        <option value="">请选择</option>
								<c:forEach items="${userSexEnumList }" var="sex">
								    <c:if test="${ sex.id != userSexEnumUnknown.id}">
									    <option value="${sex.id }">${sex.name }</option> 
									</c:if>    
								</c:forEach>
							</select>		
						</td>
						<!-- 年龄 --> 
						<td><input name="projMainPeop_age" value="${mainPeop.objMap.projMainPeop_age}" class='inputText validate[required]' style="width:80%;" /></td>
						<!-- 职务/职称 --> 
						<td><input name="projMainPeop_postAndTitle" value="${mainPeop.objMap.projMainPeop_postAndTitle}" class='inputText validate[required]' style="width:80%;" /></td>
						<!-- 业务专业 --> 
						<td>
						    <input name="projMainPeop_major" class='inputText validate[required]' style="width:80%;"/>	
						</td>
						<!-- 工作时间 -->
						<td>
						    <input name="projMainPeop_workTime" class='inputText validate[required]' style="width:80%;"/>
						</td>
						<!-- 所在单位 -->  
						<td><input name="projMainPeop_workOrg" class='inputText validate[required]' style="width:84%;"/></td>
					</tr>
				</tbody>
			</table>
			<table>
			    <tbody id="projPeopTb_model">
				    <tr>
					    <!-- 复选框 -->
						<td><input type="checkbox"/></td>
						<!-- 姓名 -->    
						<td><input name="projPeop_name" class='inputText validate[required]' style="width:80%;"/></td>
						<!-- 性别 -->   
						<td>
						    <select name="projPeop_sex" class="inputText validate[required]">
						        <option value="">请选择</option>
								<c:forEach items="${userSexEnumList }" var="sex">
								    <c:if test="${ sex.id != userSexEnumUnknown.id}">
									    <option value="${sex.id }">${sex.name }</option>  
									</c:if>   
								</c:forEach>
							</select>		
						</td>
						<!-- 年龄 --> 
						<td><input name="projPeop_age" class='inputText validate[required]' style="width:80%;" /></td>
						<!-- 职务/职称 --> 
						<td><input name="projPeop_postAndTitle" class='inputText validate[required]' style="width:80%;" /></td>
						<!-- 业务专业 --> 
						<td>
						    <input name="projPeop_major" class='inputText validate[required]' style="width:80%;"/>	
						</td>
						<!-- 工作时间 -->
						<td>
						    <input name="projPeop_workTime" class='inputText validate[required]' style="width:80%;"/>
						</td>
						<!-- 所在单位 -->  
						<td><input name="projPeop_workOrg" class='inputText validate[required]' style="width:84%;"/></td>
					</tr>
				</tbody>
			</table>
		</div>
	</c:if>
