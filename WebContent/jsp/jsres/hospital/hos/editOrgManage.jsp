<jsp:include page="/jsp/jsres/htmlhead-jsres.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="font" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
</jsp:include>
<script type="text/javascript">
$(document).ready(function(){
	if($("#personTb tr").length<=0){
		add('person');
	}
 });

String.prototype.htmlFormartById = function(data){
	var html = this;
	for(var key in data){
		var reg = new RegExp('\\{'+key+'\\}','g');
		html = html.replace(reg,data[key]);
	}
	return html;
};

function add(tb){
	var cloneTr = $("#"+tb+"Template tr:eq(0)").clone();
	var index = $("#"+tb+"Tb tr").length;
	cloneTr.html(cloneTr.html().htmlFormartById({"index":index}));
	$("#"+tb+"Tb").append(cloneTr);
}
function saveOrganizationInfo(){
	 if(!$("#BaseInfoForm").validationEngine("validate")){
			return false;
		} 
	jboxPost("<s:url value='/jsres/base/saveBase'/>" , $("#BaseInfoForm").serialize() , function(resp){
		if("${GlobalConstant.SAVE_SUCCESSED}" == resp){
			setTimeout(function(){
				$("#submitBtn").show();
				loadInfo('${GlobalConstant.ORG_MANAGE}','${sessionScope.currUser.orgFlow}');
			},1000);
		}
	} , null , true);
}
function del(tb){
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
		
		var reg = new RegExp('\\[\\d+\\]','g');
		$("#"+tb+"Tb tr").each(function(i){
			$("[name]",this).each(function(){
				this.name = this.name.replace(reg,"["+i+"]");
			});
		});
	});
}

function checkTeltphone(obj){
	var r, reg; 
	var s = obj.value;
	reg =/^[1][34578]\w*$/; //正则表达式模式。
	r = reg.test(s); 
	if(r){
		$(obj).addClass("validate[custom[mobile]]");
		$(obj).removeClass("validate[custom[phone2]]");
	}else{
		$(obj).addClass("validate[custom[phone2]]");
		$(obj).removeClass("validate[custom[mobile]]");
	}       
}
</script>
   <form id='BaseInfoForm' style="position:relative;">
   <input type="hidden" name="sysOrg.orgFlow" value="${empty sysOrg.orgFlow?sessionScope.currUser.orgFlow:sysOrg.orgFlow}"/>
	<input type="hidden" name="flag" value="${GlobalConstant.ORG_MANAGE}"/>
	<div class="main_bd">
		<div class="div_table" id="work">
		  <h4>组织管理（住院医师培训组织管理机构成员及职责）</h4>
		  <table border="0" cellpadding="0" cellspacing="0" class="grid">
		    <colgroup>
		      <col width="5%"/>
		      <col width="14%"/>
		      <col width="6%"/>
		      <col width="10%"/>
		      <col width="15%"/>
		      <col width="10%"/>
		      <col width="10%"/>
		      <col width="10%"/>
		      <col width="10%"/>
		      <col width="10%"/>
		     <!--   <col width="16%"/>-->
		    </colgroup>
		    	<tr>
					<th colspan="10" style="text-align: left;">
						<span style="float: right;padding-right: 20px">
							<img class="opBtn" title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="javascript:add('person')"></img>&#12288;
							<img class="opBtn" title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="javascript:del('person')"></img>
						</span>
					</th>
			  </tr>
		      <tr>
		         <th></th> 
		        <th>姓名</th>
		        <th>性别</th>
		        <th>年龄</th>
		        <th>专业</th>
		        <th>最高学历</th>
		        <th>科室</th>
		        <th>职务</th>
		        <th>联系电话</th>
		        <th>专职/兼职</th>
		        <!-- <th>删除</th> -->
		      </tr>
		      <tbody id="personTb">
					<c:forEach var="person" items="${organizationManage.organizationPersonList}" varStatus="status">
				     	<tr>
				     		  <td><input type="checkbox" name="personIds"/>	</td>
							  <td><input type="text" class="input validate[required]" style="width:80px;"name="organizationManage.organizationPersonList[${status.index}].name" value="${person.name }"/><span class="red">*</span></td>
					          <td>
					          	<select name="organizationManage.organizationPersonList[${status.index}].sex" class="select" style="width:80px;">
				                   <option value="">请选择</option>
				                   <c:forEach var="dict" items="${userSexEnumList }">
				                   		<c:if test="${dict.id != userSexEnumUnknown.id}">
				                   			<option value="${dict.name}" <c:if test="${person.sex eq dict.name}">selected="selected"</c:if>>${dict.name}</option>
				                   		</c:if>	 
				                   </c:forEach>
				                </select>
					          </td>
					          <td><input type="text" class="input1 validate[custom[integer],max[150]]" style="width:50px;" name="organizationManage.organizationPersonList[${status.index}].age"value="${person.age }"/></td>
					          <td><input type="text" class="input1" style="width:120px;" name="organizationManage.organizationPersonList[${status.index}].profession"value="${person.profession }"/></td>
					          <td>
					          		<select class="select" name="organizationManage.organizationPersonList[${status.index}].tallStudy" >
								      	<option value="">请选择</option>
								      	<c:forEach items="${dictTypeEnumUserEducationList }" var="dict">
									        			<option value="${dict.dictName}" <c:if test="${person.tallStudy==dict.dictName }">selected="selected"</c:if>>${dict.dictName}</option>
								        </c:forEach>
								</select>    
					          </td>
					          <td><input type="text" class="input1" style="width:80px;" name="organizationManage.organizationPersonList[${status.index}].dept"  value="${person.dept }"/></td>
					         <td>
					         	<select class="select" name="organizationManage.organizationPersonList[${status.index}].job" >
							      	<option value="">请选择</option>
							      	<c:forEach items="${dictTypeEnumUserPostList }" var="dict">
								        			<option value="${dict.dictName}"<c:if test="${person.job==dict.dictName }">selected="selected"</c:if>>${dict.dictName}</option>
							        </c:forEach>
								</select>      			
					         </td>
					         <td><input type="text" class="input1" style="width:80px;" name="organizationManage.organizationPersonList[${status.index}].telephone"  value="${person.telephone }" onchange="checkTeltphone(this);"/></td>
		             		 <td><input type="text" class="input1" style="width:80px;"name="organizationManage.organizationPersonList[${status.index}].partOrAllJob"   value="${person.partOrAllJob }"/></td>
		             </tr>
	        	</c:forEach>
			</tbody>
		         </table>
		         </div>
				<div class="div_table">
				  <table border="0" cellpadding="0" cellspacing="0" class="grid">
		      <tr>
		        <td colspan="10" style="text-align:left; padding-left:5px;">现有住院医师培训相关规章制度、培训实施计划、考试考核等（请列出具体名称）：</td>
		      </tr>
		      <tr>
		        <td colspan="10" ><textarea name="organizationManage.info" >${organizationManage.info}</textarea></td>
		      </tr>
		      </table>
			</div>
		<c:if test="${resBase.baseStatusId eq baseStatusEnumNotSubmit.id  or resBase.baseStatusId eq baseStatusEnumNotPassed.id or empty resBase.baseStatusId  }">
		     <div class="btn_info">
				  <input class="btn_blue"  onclick="saveOrganizationInfo();" type="button" value="保存"/>
			  </div>
		  </c:if>
	</div>
	
	</form>
	<div style="display: none">
		<table id="personTemplate">
       		<tr>
       		    <td><input type="checkbox" name="personIds"/></td>
			  	<td><input type="text" class="input validate[required]" style="width:80px;"name="organizationManage.organizationPersonList[{index}].name" /><span class="red">*</span></td>
				<td>
						<select name="organizationManage.organizationPersonList[{index}].sex" class="select" style="width:80px;">
		                   <option value="">请选择</option>
		                   <c:forEach var="dict" items="${userSexEnumList }">
		                   		<c:if test="${dict.id != userSexEnumUnknown.id}">
		                   			<option value="${dict.name}" >${dict.name}</option>
		                   		</c:if>	 
		                   </c:forEach>
		                </select>
				</td>
				<td><input type="text" class="input1 validate[custom[integer],max[150]] " style="width:50px;" name="organizationManage.organizationPersonList[{index}].age" /></td>
				<td><input type="text" class="input1" style="width:120px;" name="organizationManage.organizationPersonList[{index}].profession"/></td>
				<td>
							<select class="select" name="organizationManage.organizationPersonList[{index}].tallStudy" >
						      	<option value="">请选择</option>
						      	<c:forEach items="${dictTypeEnumUserEducationList }" var="dict">
							        			<option value="${dict.dictName}" >${dict.dictName}</option>
						        </c:forEach>
							</select>    
				</td>
				<td><input type="text" class="input1" style="width:80px;" name="organizationManage.organizationPersonList[{index}].dept"  /></td>
				<td>
						<select class="select" name="organizationManage.organizationPersonList[{index}].job" >
					      	<option value="">请选择</option>
					      	<c:forEach items="${dictTypeEnumUserPostList }" var="dict">
						        			<option value="${dict.dictName}">${dict.dictName}</option>
					        </c:forEach>
						</select>      			
				</td>
				<td><input type="text" class="input1" style="width:80px;" name="organizationManage.organizationPersonList[{index}].telephone"  onchange="checkTeltphone(this);"/></td>
				<td><input type="text" class="input1" style="width:80px;"name="organizationManage.organizationPersonList[{index}].partOrAllJob"  /></td>
			</tr>
		</table>
		</div>
