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
	
	function selectSingle2(obj) {
		var value = $(obj).val();
		var name = $(obj).attr("name");
		$("input[class='inputText isOtherOrg'][value!="+value+"]:checked").attr("checked",false);
	}
	
	function personnelCount(obj){
		var total = 0;
		//支出预算合计
		$("#rysxj td:not(:first,:last,:eq(5))").each(function(){
			var val = $(this).children("input").val();
			if (val == null || val == undefined || val == '' || isNaN(val)){
				val = 0;
			}
			total  +=  parseFloat(val);
		});
		$("#subjectPersonnelSubtotal").val(parseFloat(total));
	}
	
	function percent(){
		var total = 0;
		var num = $("input[name='businessIncome']").val();
		if (num == null || num == undefined || num == '' || isNaN(num)){
			num = 0;
		}
		var total = $("input[name='hospitalBusinessTotalIncome']").val();
		if (total == null || total == undefined || total == '' || isNaN(total)){
			return false;
		}
		var val = Math.round(num / total * 10000) / 100.00
		$("#ratio").val(parseFloat(val));
	}
	
	
</script>
</c:if>

	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" style="position: relative;"
		id="projForm">
		<input type="hidden" id="pageName" name="pageName" value="step1" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
		
		<font style="font-size: 14px; font-weight:bold;color: #333;">一、基本信息</font><br/>
		<table class="basic" style="width: 100%; margin-top: 10px;">
			<tr>
				<td width="14%" style="text-align: right;">是否原区级重点学科：</td>
				<td>
					是 <input type="checkbox" name="isOriginal" value="是" onchange="selectSingle(this)" <c:if test="${resultMap.isOriginal eq '是'}">checked="checked"</c:if> class="inputText" style="margin: 0px;padding: 0px;"/>
					&#12288;否 <input type="checkbox" name="isOriginal" value="否" onchange="selectSingle(this)" <c:if test="${resultMap.isOriginal eq '否'}">checked="checked"</c:if> class="inputText" style="margin: 0px;padding: 0px;"/>
				</td>
           		<td width="17%" style="text-align: right;">原医学重点学科名称：</td>
				<td colspan="6"><input type="text" name="originalSubjectName" value="${resultMap.originalSubjectName}" class="inputText" style="width: 90%"/></td>
			</tr>
			<tr>
           		<td style="text-align: right;">学科名称：</td>
				<td colspan="8"><input type="text" name="subjectName" value="${empty resultMap.subjectName?proj.projName:resultMap.subjectName}" class="inputText" style="width: 90%"/></td>
			</tr>
			<tr>
           		<td rowspan="5" style="text-align: right;">学科主攻方向：</td>
				<td colspan="8">1.<input type="text" name="attackDirection1" value="${resultMap.attackDirection1}" class="inputText" style="width: 90%"/></td>
			</tr>
			<tr>
				<td colspan="8">2.<input type="text" name="attackDirection2" value="${resultMap.attackDirection2}" class="inputText" style="width: 90%"/></td>
			</tr>
			<tr>
				<td colspan="8">3.<input type="text" name="attackDirection3" value="${resultMap.attackDirection3}" class="inputText" style="width: 90%"/></td>
			</tr>
			<tr>
				<td colspan="8">4.<input type="text" name="attackDirection4" value="${resultMap.attackDirection4}" class="inputText" style="width: 90%"/></td>
			</tr>
			<tr>
				<td colspan="8">5.<input type="text" name="attackDirection5" value="${resultMap.attackDirection5}" class="inputText" style="width: 90%"/></td>
			</tr>
			<tr>
           		<td colspan="2" style="text-align: right;">上一年学科业务收入（单位：万元）：</td>
				<td><input type="text" name="businessIncome" value="${resultMap.businessIncome}" onchange="percent()" class="validate[custom[number]] inputText" style="width: 90%"/></td>
           		<td style="text-align: right;">医院业务总收入（单位：万元）：</td>
				<td><input type="text" name="hospitalBusinessTotalIncome" value="${resultMap.hospitalBusinessTotalIncome}" onchange="percent()" class="validate[custom[number]] inputText" style="width: 90%"/></td>
           		<td style="text-align: right;">占比%：</td>
				<td><input type="text" id="ratio" name="ratio" value="${resultMap.ratio}" class="validate[custom[number]] inputText" style="width: 90%;border-bottom-style: none;" readonly="readonly"/></td>
			</tr>
		</table>
			
		<table width="100%" class="basic" style="border-top-style: none;">
			<tr>
           		<td rowspan="2" style="text-align: right;">与其他单位协作机制：</td>
           		<td>是 <input type="checkbox" name="isOtherOrgCoordination" value="是" onchange="selectSingle2(this)" <c:if test="${resultMap.isOtherOrgCoordination eq '是'}">checked="checked"</c:if> class="inputText isOtherOrg" style="margin: 0px;padding: 0px;"/></td>
           		<td style="text-align: right;">已开展学科协作的单位：</td>
				<td colspan="2" ><input type="text" name="coordinationOrg1" value="${resultMap.coordinationOrg1}" class="inputText" style="width: 90%"/></td>
           		<td style="text-align: right;">协作的学科：</td>
				<td><input type="text" name="coordinationSubject1" value="${resultMap.coordinationSubject1}" class="inputText" style="width: 90%"/></td>
           		<td style="text-align: right;">协作专家：</td>
				<td><input type="text" name="coordinationSpecialist1" value="${resultMap.coordinationSpecialist1}" class="inputText" style="width: 90%"/></td>
			</tr>
			<tr>
           		<td>否 <input type="checkbox" name="isOtherOrgCoordinationMechanism" value="否" onchange="selectSingle2(this)" <c:if test="${resultMap.isOtherOrgCoordinationMechanism eq '否'}">checked="checked"</c:if> class="inputText isOtherOrg" style="margin: 0px;padding: 0px;"/></td>
           		<td style="text-align: right;margin: 0px;padding: 0px;">希望开展学科协作的单位：</td>
				<td colspan="2"><input type="text" name="coordinationOrg2" value="${resultMap.coordinationOrg2}" class="inputText" style="width: 90%"/></td>
           		<td style="text-align: right;">协作的学科：</td>
				<td><input type="text" name="coordinationSubject2" value="${resultMap.coordinationSubject2}" class="inputText" style="width: 90%"/></td>
           		<td style="text-align: right;">协作专家：</td>
				<td><input type="text" name="coordinationSpecialist2" value="${resultMap.coordinationSpecialist2}" class="inputText" style="width: 90%"/></td>
			</tr>
		</table>
			
		<table width="100%" class="basic" style="border-top-style: none;">
			<tr>
           		<td rowspan="6" style="text-align: right;">学科带头人：</td>
           		<td style="text-align: right;">姓名：</td>
				<td><input type="text" name="academicLeaderName" value="${resultMap.academicLeaderName}" class="inputText" style="width: 90%"/></td>
           		<td rowspan="6" style="text-align: center;">单位管理部门<br/>联系人</td>
           		<td style="text-align: right;">姓名：</td>
				<td width="40%"><input type="text" name="manageDeptLinkmanName" value="${resultMap.manageDeptLinkmanName}" class="inputText" style="width: 90%"/></td>
			</tr>
			<tr>
           		<td style="text-align: right;">职称：</td>
				<td>
					<select name="academicLeaderTitle" class="inputText" style="width: 90%;">
						<option value="">请选择</option>
						<c:forEach var="dict" items="${dictTypeEnumUserTitleList }">
						<option value="${dict.dictName}" <c:if test="${resultMap.academicLeaderTitle eq dict.dictName}">selected="selected"</c:if>>${dict.dictName}</option> 
						</c:forEach>
					</select>
				</td>
           		<td style="text-align: right;">电话：</td>
				<td colspan="4"><input type="text" name="manageDeptLinkmanPhone" value="${resultMap.manageDeptLinkmanPhone}" class="validate[custom[phone2]] inputText" style="width: 90%"/></td>
			</tr>
			<tr>
           		<td style="text-align: right;">职务：</td>
				<td>
					<select name="academicLeaderPost" class="inputText" style="width: 90%;">
	                   <option value="">请选择</option>
	                   <c:forEach var="dict" items="${dictTypeEnumUserPostList }">
	                   <option value="${dict.dictName}" <c:if test="${resultMap.academicLeaderPost eq dict.dictName}">selected="selected"</c:if>>${dict.dictName }</option> 
	                   </c:forEach>
	                </select>
				</td>
           		<td style="text-align: right;">手机：</td>
				<td colspan="4"><input type="text" name="manageDeptLinkmanMobilePhone" value="${resultMap.manageDeptLinkmanMobilePhone}" class="validate[custom[mobile]] inputText" style="width: 90%"/></td>
			</tr>
			<tr>
           		<td style="text-align: right;">出生年月：</td>
				<td><input type="text" name="academicLeaderBirthday" value="${resultMap.academicLeaderBirthday}" onclick="WdatePicker({dateFmt:'yyyy-MM'})" class="inputText ctime" style="width: 90%" readonly="readonly"/></td>
           		<td style="text-align: right;">E-mail：</td>
				<td colspan="4"><input type="text" name="manageDeptLinkmanEmail" value="${resultMap.manageDeptLinkmanEmail}" class="validate[custom[email]] inputText" style="width: 90%"/></td>
			</tr>
			<tr>
           		<td style="text-align: right;">联系手机：</td>
				<td><input type="text" name="academicLeaderMobilePhone" value="${resultMap.academicLeaderMobilePhone}" class="validate[custom[mobile]] inputText" style="width: 90%"/></td>
           		<td rowspan="2" style="text-align: right;">单位地址：</td>
				<td colspan="4" rowspan="2"><input type="text" name="manageDeptLinkmanOrgAdress" value="${resultMap.manageDeptLinkmanOrgAdress}" class="inputText" style="width: 90%"/></td>
			</tr>
			<tr>
           		<td style="text-align: right;">身份证号码：</td>
				<td><input type="text" name="academicLeaderIdNo" value="${resultMap.academicLeaderIdNo}" class="validate[custom[chinaIdLoose]] inputText" style="width: 90%"/></td>
			</tr>
		</table>
			
		<table width="100%" class="basic" style="border-top-style: none;">
			<tr>
           		<td width="14%" rowspan="2" style="text-align: right;">学科人员队伍：</td>
           		<td style="text-align:center;">人员数小计</td>
           		<td style="text-align:center;">正高职称</td>
           		<td style="text-align:center;">副高职称</td>
           		<td style="text-align:center;">中级职称</td>
           		<td style="text-align:center;">初级职称</td>
           		<td width="5%" rowspan="2" style="text-align:center;">其中</td>
           		<td style="text-align:center;">博士</td>
           		<td style="text-align:center;">硕士</td>
			</tr>
			<tr id="rysxj">
				<td><input type="text" id="subjectPersonnelSubtotal" name="subjectPersonnelSubtotal" value="${resultMap.subjectPersonnelSubtotal}" class="validate[custom[integer]] inputText" style="width: 90%;border-bottom-style: none;"/></td>
				<td><input type="text" name="subjectPersonnelZgzc" value="${resultMap.subjectPersonnelZgzc}" onchange="personnelCount(this)" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="subjectPersonnelFgzc" value="${resultMap.subjectPersonnelFgzc}" onchange="personnelCount(this)" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="subjectPersonnelZjzc" value="${resultMap.subjectPersonnelZjzc}" onchange="personnelCount(this)" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="subjectPersonnelCjzc" value="${resultMap.subjectPersonnelCjzc}" onchange="personnelCount(this)" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="subjectPersonnelDoctor" value="${resultMap.subjectPersonnelDoctor}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="subjectPersonnelMaster" value="${resultMap.subjectPersonnelMaster}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
			</tr>
		</table>
		
		<table width="100%" class="bs_tb" style="border-top-style: none;">
		    <tr>
		      <th colspan="11" class="theader" style="border-top-style: none;">学科团队
		            <c:if test="${param.view!=GlobalConstant.FLAG_Y }">
					  <span style="float: right;padding-right: 10px">
					  <img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('team')"></img>&#12288;
					<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('team');"></img></span>
					</c:if>
		      </th>
		   </tr> 
		    <tr>
		       <td width="20px"></td>
		       <td width="20px">序号</td>
		       <td width="6%">姓名</td>
		       <td width="5%">年龄</td>
		       <td width="16%">身份证号码</td>
		       <td width="8%">学历</td>
		       <td width="10%">所学专业</td>
		       <td width="7%">专业技<br/>术职务</td>
		       <td width="6%">是否博<br/>（硕）<br/>士导</td>
		       <td width="15%">在学科建设中的主要任务</td>
		       <td width="20%">所在单位</td>
		    </tr>
		    <tbody id="teamTb">
		    <c:forEach items="${resultMap.subjectTeam}" var="team" varStatus="status">
		    <tr>
		      <td width="20px" style="text-align: center;"><input name="teamIds" type="checkbox"/></td>
      		  <td width="20px" style="text-align: center;" class="teamSerial">${status.count}</td>
		      <td><input type="text" name="subjectTeam_name" value="${team.objMap.subjectTeam_name}" class="inputText" style="width: 90%"/></td>
		      <td><input type="text" name="subjectTeam_age" value="${team.objMap.subjectTeam_age}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
		      <td><input type="text" name="subjectTeam_idNo" value="${team.objMap.subjectTeam_idNo}" class="validate[custom[chinaIdLoose]] inputText" style="width: 90%"/></td>
		      <td>
		      	<select name="subjectTeam_education" class="inputText" style="width: 90%;">
                   <option value="">请选择</option>
                   <c:forEach var="dict" items="${dictTypeEnumUserEducationList}">
                   <option value="${dict.dictName}" <c:if test="${dict.dictName eq team.objMap.subjectTeam_education}">selected="selected"</c:if>>${dict.dictName}</option>
                   </c:forEach>
                </select>
		      </td>
		      <td><input type="text" name="subjectTeam_major" value="${team.objMap.subjectTeam_major}" class="inputText" style="width: 90%"/></td>
		      <td>
		      	<select name="subjectTeam_post" class="inputText" style="width: 90%;">
                   <option value="">请选择</option>
                   <option value="正高" <c:if test="${team.objMap.subjectTeam_post eq '正高'}">selected="selected"</c:if>>正高</option>
                   <option value="副高" <c:if test="${team.objMap.subjectTeam_post eq '副高'}">selected="selected"</c:if>>副高</option>
                   <option value="中级" <c:if test="${team.objMap.subjectTeam_post eq '中级'}">selected="selected"</c:if>>中级</option>
                   <option value="初级" <c:if test="${team.objMap.subjectTeam_post eq '初级'}">selected="selected"</c:if>>初级</option>
                   <option value="其他" <c:if test="${team.objMap.subjectTeam_post eq '其他'}">selected="selected"</c:if>>其他</option>
                </select>
		      </td>
		      <td>
		      	<select name="subjectTeam_isMentor" class="inputText" style="width: 90%;">
                   <option value="是" <c:if test="${'是' eq team.objMap.subjectTeam_isMentor}">selected="selected"</c:if>>是</option>
                   <option value="否" <c:if test="${'否' eq team.objMap.subjectTeam_isMentor}">selected="selected"</c:if>>否</option>
                </select>
		      </td>
		      <td>
		      	<select name="subjectTeam_task" class="inputText" style="width: 90%;">
                   <option value="">请选择</option>
                   <option value="学科带头人(后备)" <c:if test="${team.objMap.subjectTeam_task eq '学科带头人(后备)'}">selected="selected"</c:if>>学科带头人(后备)</option>
                   <option value="学科技术骨干" <c:if test="${team.objMap.subjectTeam_task eq '学科技术骨干'}">selected="selected"</c:if>>学科技术骨干</option>
                   <option value="辅助人员" <c:if test="${team.objMap.subjectTeam_task eq '辅助人员'}">selected="selected"</c:if>>辅助人员</option>
                </select>
		      </td>
		      <td><input type="text" name="subjectTeam_org" value="${team.objMap.subjectTeam_org}" class="inputText" style="width: 90%"/></td>
		    </tr>
		    </c:forEach>  
		    </tbody>
		 </table>
	</form>
	
	
    <c:if test="${param.view!=GlobalConstant.FLAG_Y}">
		<div align="center" style="margin-top: 10px">
		    <input id="nxt" type="button" onclick="nextOpt('step2')" class="search" value="下一步"/>
       	</div>
    </c:if>
   
    <div style="display: none;">
   		<!-- 学科团队模板 -->
   		<table id="teamTemplate" width="100%" class="bs_tb" style="margin-top: 20px;">
   		<tr>
		      <td width="20px" style="text-align: center;"><input name="teamIds" type="checkbox"/></td>
      		  <td width="20px" style="text-align: center;" class="teamSerial"></td>
		      <td><input type="text" name="subjectTeam_name" class="inputText" style="width: 90%"/></td>
		      <td><input type="text" name="subjectTeam_age" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
		      <td><input type="text" name="subjectTeam_idNo" class="validate[custom[chinaIdLoose]] inputText" style="width: 90%"/></td>
		      <td>
		      	  <select name="subjectTeam_education" class="inputText" style="width: 90%;">
                   <option value="">请选择</option>
                   <c:forEach var="dict" items="${dictTypeEnumUserEducationList}">
                   <option value="${dict.dictName}">${dict.dictName}</option>
                   </c:forEach>
               	  </select>
		      </td>
		      <td><input type="text" name="subjectTeam_major" class="inputText" style="width: 90%"/></td>
		      <td>
		      	<select name="subjectTeam_post" class="inputText" style="width: 90%;">
                   <option value="">请选择</option>
                   <option value="正高">正高</option>
                   <option value="副高">副高</option>
                   <option value="中级">中级</option>
                   <option value="初级">初级</option>
                   <option value="其他">其他</option>
                </select>
		      </td>
		      <td>
		      	<select name="subjectTeam_isMentor" class="inputText" style="width: 90%;">
                   <option value="是">是</option>
                   <option value="否">否</option>
                </select>
		      </td>
		      <td>
		      	<select name="subjectTeam_task" class="inputText" style="width: 90%;">
                   <option value="">请选择</option>
                   <option value="学科带头人(后备)">学科带头人(后备)</option>
                   <option value="学科技术骨干">学科技术骨干</option>
                   <option value="辅助人员">辅助人员</option>
                </select>
		      </td>
		      <td><input type="text" name="subjectTeam_org" class="inputText" style="width: 90%"/></td>
	    </tr>
   		</table>
    </div>

		