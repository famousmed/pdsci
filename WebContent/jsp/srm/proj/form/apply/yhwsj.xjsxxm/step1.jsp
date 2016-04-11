<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ztree" value="true"/>
</jsp:include>

<c:if test="${param.view != GlobalConstant.FLAG_Y}">
<script type="text/javascript">
	function nextOpt(step){
		if(false==$("#projForm").validationEngine("validate")){
			return false;
		}
		var form = $('#projForm');
		var action = form.attr('action');
		action+="?nextPageName="+step;
		form.attr("action" , action);
		form.submit();
	}
	
	function add(tb){
	 	$("#"+tb+"Tb").append($("#"+tb+"Template tr:eq(0)").clone());
	 	
	 	var length = $("#"+tb+"Tb").children().length;
	 	//序号
		$("#"+tb+"Tb").children("tr").last().children("td").eq(1).text(length);
	}
	
	function delTr(tb){
		//alert("input[name="+tb+"Ids]:checked");
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
			//删除后序号
			var serial = 0;
			$("."+tb+"Serial").each(function(){
				serial += 1;
				$(this).text(serial);
			});
		});
	}
	
	function selectSingle(obj) {
		var value = $(obj).val();
		var name = $(obj).attr("name");
		$("input[name="+name+"][value!="+value+"]:checked").attr("checked",false);
	}	
	
</script>
</c:if>

	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" style="position: relative;"
		id="projForm">
		<input type="hidden" id="pageName" name="pageName" value="step1" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
		
		<font style="font-size: 14px; font-weight:bold;color: #333;">一、评选申报表</font><br/>
		
		<table class="basic" style="width: 100%; margin-top: 10px;" >
			<tr>
				<td style="text-align: right;">新技术项目名称：</td>
				<td><input type="text" name="projName" value="${empty resultMap.projName?proj.projName:resultMap.projName}" class="inputText" style="width: 90%"/></td>
           		<td style="text-align: right;">开展时间：</td>
				<td>
					<input type="text" name="projStartTime" value="${empty resultMap.projStartTime?proj.projStartTime:resultMap.projStartTime}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputText ctime" style="width: 120px; margin-right: 0px;" readonly="readonly"/>
					至&nbsp;<input type="text" name="projEndTime" value="${empty resultMap.projEndTime?proj.projEndTime:resultMap.projEndTime}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputText ctime" style="width: 120px; margin-right: 0px;" readonly="readonly"/>
				</td>
			</tr>
			<tr>
				<td style="text-align: right;">技术水平：</td>
				<td colspan="3">
					国内&nbsp;<input type="checkbox" name="technologyLevel" <c:if test="${resultMap.technologyLevel eq '国内'}">checked="checked"</c:if> value="国内" onchange="selectSingle(this)"/>
					&#12288;省内&nbsp;<input type="checkbox" name="technologyLevel" <c:if test="${resultMap.technologyLevel eq '省内'}">checked="checked"</c:if> value="省内" onchange="selectSingle(this)"/>
					&#12288;市内&nbsp;<input type="checkbox" name="technologyLevel" <c:if test="${resultMap.technologyLevel eq '市内'}">checked="checked"</c:if> value="市内" onchange="selectSingle(this)"/>
					&#12288;区内&nbsp;<input type="checkbox" name="technologyLevel" <c:if test="${resultMap.technologyLevel eq '区内'}">checked="checked"</c:if> value="区内" onchange="selectSingle(this)"/>
					&#12288;院内&nbsp;<input type="checkbox" name="technologyLevel" <c:if test="${resultMap.technologyLevel eq '院内'}">checked="checked"</c:if> value="院内" onchange="selectSingle(this)"/>
				</td>
			</tr>
			<tr>
				<td style="text-align: right;">项目负责人：</td>
				<td><input type="text" name="applyUserName" value="${empty resultMap.applyUserName?proj.applyUserName:resultMap.applyUserName}" class="inputText" style="width: 90%"/></td>
				<td style="text-align: right;">科室名称：</td>
				<td><input type="text" name="applyDeptName" value="${empty resultMap.applyDeptName?proj.applyDeptName:resultMap.applyDeptName}" class="inputText" style="width: 90%"/></td>
			</tr>
			<tr>
				<td style="text-align: right;">协作科室 或单位：</td>
				<td colspan="3">
					无&nbsp;<input type="checkbox" name="ishaveDept" <c:if test="${resultMap.ishaveDept eq '无'}">checked="checked"</c:if> value="无" onchange="selectSingle(this)"/>
					&#12288;有&nbsp;<input type="checkbox" name="ishaveDept" <c:if test="${resultMap.ishaveDept eq '有'}">checked="checked"</c:if> value="有" onchange="selectSingle(this)"/>&nbsp;(选择“有”时填写下列内容)
				</td>
			</tr>
			<tr>
				<td style="text-align: right;">单位或科室名称：</td>
				<td colspan="3"><input type="text" name="cooperationDeptName" value="${resultMap.cooperationDeptName}" class="inputText" style="width: 90%"/></td>
			</tr>
			<tr>
				<td style="text-align: right;">协作职责：</td>
				<td colspan="3"><input type="text" name="cooperationDuty" value="${resultMap.cooperationDuty}" class="inputText" style="width: 90%"/></td>
			</tr>
		</table>
		
		
		
		<!-- 负责人 -->
		<!-- <font style="font-size: 14px; font-weight:bold;color: #333; margin-top: 20px;">项目组情况</font> -->
		<table width="100%" class="bs_tb" style="margin-top: 20px;">
			<tr>
				<th colspan="12" class="theader">负责人
					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
						<span style="float: right;padding-right: 10px">
						<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('fzr')"></img>&#12288;
						<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('fzr');"></img></span>
					</c:if>
				</th>
			</tr> 
		    <tr>
		       <td width="20px"></td>
		       <td width="40px">序号</td>
		       <td width="10%">姓名</td>
		       <td width="8%">性别</td>
		       <td width="7%">年龄</td>
		       <td width="10%">学历</td>
		       <td width="20%">职务</td>
		       <td width="20%">职称</td>
		       <td width="20%">专业</td>
		    </tr>
		    <tbody id="fzrTb">
		    <c:forEach items="${resultMap.fzr}" var="fzr" varStatus="status">
		    <tr>
				<td width="20px" style="text-align: center;"><input name="fzrIds" type="checkbox"/></td>
				<td width="40px" style="text-align: center;" class="fzrSerial">${status.count}</td>
				<td><input type="text" name="fzr_name" value="${fzr.objMap.fzr_name}" class="inputText" style="width: 90%"/></td>
				<td>
	                <select name="fzr_gender" class="inputText" style="width: 90%;">
	                   <option value="">请选择</option>
	                   <c:forEach var="dict" items="${userSexEnumList}">
	                   		<c:if test="${dict.id != userSexEnumUnknown.id}">
	                   			<option value="${dict.name}" <c:if test="${fzr.objMap.fzr_gender eq dict.name}">selected="selected"</c:if>>${dict.name}</option>
	                   		</c:if>	 
	                   </c:forEach>
	                </select>
	            </td>
				<td><input type="text" name="fzr_age" value="${fzr.objMap.fzr_age}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td>
	                <select name="fzr_education" class="inputText" style="width: 90%;">
	                   <option value="">请选择</option>
	                   <c:forEach var="dict" items="${dictTypeEnumUserEducationList }">
	                   <option value="${dict.dictName}" <c:if test="${fzr.objMap.fzr_education eq dict.dictName}">selected="selected"</c:if>>${dict.dictName }</option> 
	                   </c:forEach>
	                </select>
	            </td>
				<td><input type="text" name="fzr_duty" value="${fzr.objMap.fzr_duty}" class="inputText" style="width: 90%"/></td>
				<td>
					<select name="fzr_title" class="inputText" style="width: 90%;">
						<option value="">请选择</option>
						<c:forEach var="dict" items="${dictTypeEnumUserTitleList}">
						<option value="${dict.dictName}" <c:if test="${fzr.objMap.fzr_title eq dict.dictName}">selected="selected"</c:if>>${dict.dictName }</option> 
						</c:forEach>
					</select> 
             	</td>
				<td><input type="text" name="fzr_major" value="${fzr.objMap.fzr_major}" class="inputText" style="width: 90%"/></td>
			</tr>
		    </c:forEach>  
		    </tbody>
		 </table>
		 
		 
		<!-- 项目组人员 -->
		<table width="100%" class="bs_tb" style="margin-top: 10px;">
			<tr>
				<th colspan="12" class="theader">项目组人员
					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
						<span style="float: right;padding-right: 10px">
						<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('xmzry')"></img>&#12288;
						<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('xmzry');"></img></span>
					</c:if>
				</th>
			</tr> 
		    <tr>
		       <td width="20px"></td>
		       <td width="40px">序号</td>
		       <td width="10%">姓名</td>
		       <td width="8%">性别</td>
		       <td width="7%">年龄</td>
		       <td width="10%">学历</td>
		       <td width="20%">职务</td>
		       <td width="20%">职称</td>
		       <td width="20%">专业</td>
		    </tr>
		    <tbody id="xmzryTb">
		    <c:forEach items="${resultMap.xmzry}" var="xmzry" varStatus="status">
		    <tr>
				<td width="20px" style="text-align: center;"><input name="xmzryIds" type="checkbox"/></td>
				<td width="40px" style="text-align: center;" class="xmzrySerial">${status.count}</td>
				<td><input type="text" name="xmzry_name" value="${xmzry.objMap.xmzry_name}" class="inputText" style="width: 90%"/></td>
				<td>
	                <select name="xmzry_gender" class="inputText" style="width: 90%;">
	                   <option value="">请选择</option>
	                   <c:forEach var="dict" items="${userSexEnumList}">
	                   		<c:if test="${dict.id != userSexEnumUnknown.id}">
	                   			<option value="${dict.name}" <c:if test="${xmzry.objMap.xmzry_gender eq dict.name}">selected="selected"</c:if>>${dict.name}</option>
	                   		</c:if>	 
	                   </c:forEach>
	                </select>
	            </td>
				<td><input type="text" name="xmzry_age" value="${xmzry.objMap.xmzry_age}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td>
	                <select name="xmzry_education" class="inputText" style="width: 90%;">
	                   <option value="">请选择</option>
	                   <c:forEach var="dict" items="${dictTypeEnumUserEducationList }">
	                   <option value="${dict.dictName}" <c:if test="${xmzry.objMap.xmzry_education eq dict.dictName}">selected="selected"</c:if>>${dict.dictName }</option> 
	                   </c:forEach>
	                </select>
	            </td>
				<td><input type="text" name="xmzry_duty" value="${xmzry.objMap.xmzry_duty}" class="inputText" style="width: 90%"/></td>
				<td>
					<select name="xmzry_title" class="inputText" style="width: 90%;">
						<option value="">请选择</option>
						<c:forEach var="dict" items="${dictTypeEnumUserTitleList}">
						<option value="${dict.dictName}" <c:if test="${xmzry.objMap.xmzry_title eq dict.dictName}">selected="selected"</c:if>>${dict.dictName }</option> 
						</c:forEach>
					</select> 
             	</td>
				<td><input type="text" name="xmzry_major" value="${xmzry.objMap.xmzry_major}" class="inputText" style="width: 90%"/></td>
			</tr>
		    </c:forEach>  
		    </tbody>
		 </table>
		 
		 <table class="basic" style="width: 100%; margin-top: 20px;" >
			<tr>
				<td rowspan="4" width="17%" style="text-align: center;">项目安排</td>
				<td style="text-align: center;">项目完成情况</td>
				<td style="text-align: center;">完成例数</td>
			</tr>
			<tr>
				<td style="text-align: center;">外请专家完成，项目组人员协助例数</td>
				<td><input type="text" name="exampleCount1" value="${resultMap.exampleCount1}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
			</tr>
			<tr>
				<td style="text-align: center;">专家现场指导，项目组独立完成例数</td>
				<td><input type="text" name="exampleCount2" value="${resultMap.exampleCount2}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
			</tr>
			<tr>
				<td style="text-align: center;">项目组独立完成技术成熟例数</td>
				<td><input type="text" name="exampleCount3" value="${resultMap.exampleCount3}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
			</tr>
		 </table>
			
		 
	</form>
	
	
    <c:if test="${param.view!=GlobalConstant.FLAG_Y}">
		<div align="center" style="margin-top: 10px">
		    <input id="nxt" type="button" onclick="nextOpt('step2')" class="search" value="下一步"/>
       	</div>
    </c:if>
	
	<div style="display: none;">
   		<!--二、负责人  模板 -->
   		<table id="fzrTemplate" width="100%" class="bs_tb" style="margin-top: 20px;">
	   		<tr>
				<td width="20px" style="text-align: center;"><input name="fzrIds" type="checkbox"/></td>
				<td width="40px" style="text-align: center;" class="fzrSerial"></td>
				<td><input type="text" name="fzr_name" class="inputText" style="width: 90%"/></td>
				<td>
	                <select name="fzr_gender" class="inputText" style="width: 90%;">
	                   <option value="">请选择</option>
	                   <c:forEach var="dict" items="${userSexEnumList}">
	                   		<c:if test="${dict.id != userSexEnumUnknown.id}">
	                   			<option value="${dict.name}">${dict.name}</option>
	                   		</c:if>	 
	                   </c:forEach>
	                </select>
	            </td>
				<td><input type="text" name="fzr_age" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td>
	                <select name="fzr_education" class="inputText" style="width: 85%;">
	                   <option value="">请选择</option>
	                   <c:forEach var="dict" items="${dictTypeEnumUserEducationList }">
	                   <option value="${dict.dictName}">${dict.dictName }</option> 
	                   </c:forEach>
	                </select>
	            </td>
				<td><input type="text" name="fzr_duty" class="inputText" style="width: 90%"/></td>
				<td>
					<select name="fzr_title" class="inputText" style="width: 90%;">
						<option value="">请选择</option>
						<c:forEach var="dict" items="${dictTypeEnumUserTitleList}">
						<option value="${dict.dictName}">${dict.dictName }</option> 
						</c:forEach>
					</select> 
	            	</td>
				<td><input type="text" name="fzr_major" class="inputText" style="width: 90%"/></td>
			</tr>
   		</table>
   		
   		
   		<table id="xmzryTemplate" width="100%" class="bs_tb" style="margin-top: 20px;">
   		<tr>
				<td width="20px" style="text-align: center;"><input name="xmzryIds" type="checkbox"/></td>
				<td width="40px" style="text-align: center;" class="xmzrySerial">${status.count}</td>
				<td><input type="text" name="xmzry_name" value="${xmzry.objMap.xmzry_name}" class="inputText" style="width: 90%"/></td>
				<td>
	                <select name="xmzry_gender" class="inputText" style="width: 90%;">
	                   <option value="">请选择</option>
	                   <c:forEach var="dict" items="${userSexEnumList}">
	                   		<c:if test="${dict.id != userSexEnumUnknown.id}">
	                   			<option value="${dict.name}">${dict.name}</option>
	                   		</c:if>	 
	                   </c:forEach>
	                </select>
	            </td>
				<td><input type="text" name="xmzry_age" value="${xmzry.objMap.xmzry_age}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td>
	                <select name="xmzry_education" class="inputText" style="width: 90%;">
	                   <option value="">请选择</option>
	                   <c:forEach var="dict" items="${dictTypeEnumUserEducationList}">
	                   <option value="${dict.dictName}">${dict.dictName}</option> 
	                   </c:forEach>
	                </select>
	            </td>
				<td><input type="text" name="xmzry_duty" class="inputText" style="width: 90%"/></td>
				<td>
					<select name="xmzry_title" class="inputText" style="width: 90%;">
						<option value="">请选择</option>
						<c:forEach var="dict" items="${dictTypeEnumUserTitleList}">
						<option value="${dict.dictName}">${dict.dictName}</option> 
						</c:forEach>
					</select> 
             	</td>
				<td><input type="text" name="xmzry_major" class="inputText" style="width: 90%"/></td>
			</tr>
   		</table>
 	</div>
		