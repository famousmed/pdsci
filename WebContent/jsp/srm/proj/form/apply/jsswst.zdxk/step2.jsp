<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
			//统计
			userStatistics();
		});
	}
	
	function userStatistics(){
		$("#userStatistics input").each(function(){
			$(this).val("");
		});
		$("#userTb select[name=user_userTitle]").each(function (){
			var title = this.value;
			var age = $(this).parent().prev().prev().children().val();
			//alert(title +"," +age);
			var num ;
			if(age <= 35){
				num = parseFloat($("input[name="+title +"Less35]").val());
				if(isNaN(num)){
					num = 0;
				}
				$("input[name="+title +"Less35]").val(num+1);
			}else if(age >= 36 && age <= 45){
				num = parseFloat($("input[name="+title +"Between36And45]").val());
				if(isNaN(num)){
					num = 0;
				}
				$("input[name="+title +"Between36And45]").val(num+1);
			}else if(age >= 46 && age <= 55){
				num = parseFloat($("input[name="+title +"Between46And55]").val());
				if(isNaN(num)){
					num = 0;
				}
				$("input[name="+title +"Between46And55]").val(num+1);
			}else if(age >= 56 && age <= 60){
				num = parseFloat($("input[name="+title +"Between56And60]").val());
				if(isNaN(num)){
					num = 0;
				}
				$("input[name="+title +"Between56And60]").val(num+1);
			}else if(age >= 61){
				num = parseFloat($("input[name="+title +"Greater61]").val());
				if(isNaN(num)){
					num = 0;
				}
				$("input[name="+title +"Greater61]").val(num+1);
			}
		});
		

		//总数
		var highSum = 0;
		var highTds = $("#userStatistics").children().eq(0).find("td:not(:last , :first)");
		$.each(highTds , function(i , domEle){
				var val = $(domEle).children("input").val();
				if (val == null || val == undefined || val == '' || isNaN(val)){
					val = 0;
				}
				highSum = parseFloat(highSum)+parseFloat(val);
			
		});
		$("input[name=highAmount]").val(parseFloat(highSum.toFixed(3))); 
		
		var middleSum = 0;
		var middleTds = $("#userStatistics").children().eq(1).find("td:not(:last , :first)");
		$.each(middleTds , function(i , domEle){
				var val = $(domEle).children("input").val();
				if (val == null || val == undefined || val == '' || isNaN(val)){
					val = 0;
				}
				middleSum = parseFloat(middleSum)+parseFloat(val);
			
		});
		$("input[name=middleAmount]").val(parseFloat(middleSum.toFixed(3)));
		
		var primarySum = 0;
		var primaryTds = $("#userStatistics").children().eq(2).find("td:not(:last , :first)");
		$.each(primaryTds , function(i , domEle){
				var val = $(domEle).children("input").val();
				if (val == null || val == undefined || val == '' || isNaN(val)){
					val = 0;
				}
				primarySum = parseFloat(primarySum)+parseFloat(val);
			
		});
		$("input[name=primaryAmount]").val(parseFloat(primarySum.toFixed(3)));
		
		
		var assistantSum = 0;
		var assistantTds = $("#userStatistics").children().eq(3).find("td:not(:last , :first)");
		$.each(assistantTds , function(i , domEle){
				var val = $(domEle).children("input").val();
				if (val == null || val == undefined || val == '' || isNaN(val)){
					val = 0;
				}
				assistantSum = parseFloat(assistantSum)+parseFloat(val);
			
		});
		$("input[name=assistantAmount]").val(parseFloat(assistantSum.toFixed(3)));
		
	}
</script>
</c:if>

<style type="text/css">
 .bs_tb tbody td input{text-align: left;margin-left: 10px;}
</style>

	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" style="position: relative;"
		id="projForm">
		<input type="hidden" id="pageName" name="pageName" value="step2" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
		 <div>
		    <font style="font-size: 18px; font-weight:bold; ">二、人员情况</font>
		 </div>  
		 <table width="100%" class="bs_tb">
		    <tr>
		      <th colspan="11" class="theader">1.人员基本情况
		            <c:if test="${param.view!=GlobalConstant.FLAG_Y }">
					<span style="float: right;padding-right: 10px">
					<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('user')"></img>&#12288;
					<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('user');"></img></span>
					</c:if>
		      </th>
		    </tr>
		    <tr>
		      <td width="50px"></td>
		      <td width="50px" style="text-align: center;">序号</td>
		      <td width="10%" style="text-align: center;">姓名</td>
		      <td width="12%" style="text-align: center;">出生年月</td>
		      <td width="5%" style="text-align: center;">年龄</td>
		      <td width="10%" style="text-align: center;">学位</td>
		      <td width="10%" style="text-align: center;">技术职称</td>
		      <td width="10%" style="text-align: center;">学会任职</td>
		      <td width="10%" style="text-align: center;">荣誉称号</td>
		      <td width="10%" style="text-align: center;">人才培养对象</td>
		      <td width="10%" style="text-align: center;">技术特长</td>
		    </tr>
		    <tbody id="userTb">
	           <c:forEach var="user" items="${resultMap.user}" varStatus="status">
			     <tr>
					<!-- 复选框 -->
					<td width="50px" style="text-align: center;"><input name="userIds" type="checkbox"/></td>
              		<td width="50px" style="text-align: center;" class="userSerial">${status.count}</td>
					<td><input type="text" name="user_name" value="${user.objMap.user_name}" class="inputText" style="width: 80%"/></td>
					<td><input type="text" name="user_birthday" value="${user.objMap.user_birthday}"  class="inputText ctime" style="width: 80%" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/></td>
					<td><input type="text" name="user_age" value="${user.objMap.user_age}" class="validate[custom[integer]] inputText" style="width: 80%" onchange="userStatistics()"/></td>
				    <td>
					   <select name="user_degree" class="inputText" style="width: 80%">
					   <option value="">请选择</option>
					   <c:forEach items="${dictTypeEnumUserDegreeList}" var="dict">
		        	   <option value="${dict.dictId}" <c:if test='${user.objMap.user_degree == dict.dictId}'>selected="selected"</c:if>>${dict.dictName}</option>
		        	   </c:forEach>
			           </select>
					</td>
					<!-- 技术职称 -->
					<td>
						<select name="user_userTitle" class="inputText" style="width: 80%" onchange="userStatistics()">
						<option value="">请选择</option>
						<option value="high" <c:if test="${user.objMap.user_userTitle eq 'high'}">selected="selected"</c:if>>高级</option>
						<option value="middle" <c:if test="${user.objMap.user_userTitle eq 'middle'}">selected="selected"</c:if>>中级</option>
						<option value="primary" <c:if test="${user.objMap.user_userTitle eq 'primary'}">selected="selected"</c:if>>初级</option>
						<option value="assistant" <c:if test="${user.objMap.user_userTitle eq 'assistant'}">selected="selected"</c:if>>副高</option>
						</select>
					</td>
					<!-- 学会任职 -->
				    <td>
					   <input type="text" name="user_learnTitle" value="${user.objMap.user_learnTitle}" class="inputText" style="width: 80%"/>
				    </td>
					<!-- 荣誉称号-->
					<td>
					   <input type="text" name="user_honourTitle" value="${user.objMap.user_honourTitle}" class="inputText" style="width: 80%" />
					</td>
					<!-- 人才培养对象 -->  
					<td><input type="text" name="user_talentsDevelop" value="${user.objMap.user_talentsDevelop}" class="inputText" style="width: 80%" /></td>
					<!-- 技术特长 -->  
					<td><input type="text" name="user_technology" value="${user.objMap.user_technology}" class="inputText"  style="width: 80%"/></td>
		        </tr>
              </c:forEach>
	       </tbody>
		 </table>
		 
		 <font style="font-size: 14px; font-weight:bold; ">&#12288;中心人员统计：</font>
		  <table width="100%" class="basic">
		    <tr>
		      <td width="9%" style="text-align: center;">年龄段/职称</td>
		      <td style="text-align: center;">35岁以下</td>
		      <td style="text-align: center;">36岁~45岁</td>
		      <td style="text-align: center;">46岁~55岁</td>
		      <td style="text-align: center;">56岁~60岁</td>
		      <td style="text-align: center;">61岁以上</td>
		      <td style="text-align: center;">总数</td>
		    </tr>
		    <tbody id="userStatistics">
		    <tr>
		      <td style="text-align: center;">高级</td>
		      <td style="text-align: center;"><input name="highLess35" type="text" value="${resultMap.highLess35}" class="validate[custom[integer]] inputText" style="width: 80%" /></td>
		      <td style="text-align: center;"><input name="highBetween36And45" type="text" value="${resultMap.highBetween36And45}" class="validate[custom[integer]] inputText" style="width: 80%" /></td>
		      <td style="text-align: center;"><input name="highBetween46And55" type="text" value="${resultMap.highBetween46And55}" class="validate[custom[integer]] inputText" style="width: 80%" /></td>
		      <td style="text-align: center;"><input name="highBetween56And60" type="text" value="${resultMap.highBetween56And60}" class="validate[custom[integer]] inputText" style="width: 80%"/></td>
		      <td style="text-align: center;"><input name="highGreater61" type="text" value="${resultMap.highGreater61}" class="validate[custom[integer]] inputText" style="width: 80%" /></td>
		      <td style="text-align: center;"><input name="highAmount" type="text" value="${resultMap.highAmount}" class="validate[custom[integer]] inputText" style="width: 80%" /></td>
		    </tr>
		    <tr>
		      <td style="text-align: center;">中级</td>
		      <td style="text-align: center;"><input name="middleLess35" type="text" value="${resultMap.middleLess35}" class="validate[custom[integer]] inputText" style="width: 80%" /></td>
		      <td style="text-align: center;"><input name="middleBetween36And45" type="text" value="${resultMap.middleBetween36And45}" class="validate[custom[integer]] inputText" style="width: 80%" /></td>
		      <td style="text-align: center;"><input name="middleBetween46And55" type="text" value="${resultMap.middleBetween46And55}" class="validate[custom[integer]] inputText" style="width: 80%" /></td>
		      <td style="text-align: center;"><input name="middleBetween56And60" type="text" value="${resultMap.middleBetween56And60}" class="validate[custom[integer]] inputText" style="width: 80%" /></td>
		      <td style="text-align: center;"><input name="middleGreater61" type="text" value="${resultMap.middleGreater61}" class="validate[custom[integer]] inputText" style="width: 80%" /></td>
		      <td style="text-align: center;"><input name="middleAmount" type="text" value="${resultMap.middleAmount}" class="validate[custom[integer]] inputText" style="width: 80%" /></td>
		    </tr>
		    <tr>
		      <td style="text-align: center;">初级</td>
		      <td style="text-align: center;"><input name="primaryLess35" type="text" value="${resultMap.primaryLess35}" class="validate[custom[integer]] inputText"  style="width: 80%"/></td>
		      <td style="text-align: center;"><input name="primaryBetween36And45" type="text" value="${resultMap.primaryBetween36And45}" class="validate[custom[integer]] inputText" style="width: 80%" /></td>
		      <td style="text-align: center;"><input name="primaryBetween46And55" type="text" value="${resultMap.primaryBetween46And55}" class="validate[custom[integer]] inputText" style="width: 80%" /></td>
		      <td style="text-align: center;"><input name="primaryBetween56And60" type="text" value="${resultMap.primaryBetween56And60}" class="validate[custom[integer]] inputText" style="width: 80%" /></td>
		      <td style="text-align: center;"><input name="primaryGreater61" type="text" value="${resultMap.primaryGreater61}" class="validate[custom[integer]] inputText" style="width: 80%" /></td>
		      <td style="text-align: center;"><input name="primaryAmount" type="text" value="${resultMap.primaryAmount}" class="validate[custom[integer]] inputText" style="width: 80%" /></td>
		    </tr>
		    <tr>
		      <td style="text-align: center;">副高</td>
		      <td style="text-align: center;"><input name="assistantLess35" type="text" value="${resultMap.assistantLess35}" class="validate[custom[integer]] inputText" style="width: 80%" /></td>
		      <td style="text-align: center;"><input name="assistantBetween36And45" type="text" value="${resultMap.assistantBetween36And45}" class="validate[custom[integer]] inputText" style="width: 80%" /></td>
		      <td style="text-align: center;"><input name="assistantBetween46And55" type="text" value="${resultMap.assistantBetween46And55}" class="validate[custom[integer]] inputText" style="width: 80%" /></td>
		      <td style="text-align: center;"><input name="assistantBetween56And60" type="text" value="${resultMap.assistantBetween56And60}" class="validate[custom[integer]] inputText" style="width: 80%" /></td>
		      <td style="text-align: center;"><input name="assistantGreater61" type="text" value="${resultMap.assistantGreater61}" class="validate[custom[integer]] inputText" style="width: 80%" /></td>
		      <td style="text-align: center;"><input name="assistantAmount" type="text" value="${resultMap.assistantAmount}" class="validate[custom[integer]] inputText" style="width: 80%" /></td>
		    </tr>
	    	</tbody>
		 </table>
		 <table width="100%" class="basic" style="margin-top: 40px;">
		    <tr><th colspan="8" style="padding-left:15px;text-align:left;">2.主任和副主任情况</th></tr>
		    <tr>
		       <td style="text-align: right;">姓名：</td>
		       <td style="text-align: center;">
		          <input type="text" name="directorName" value="${resultMap.directorName}" class="inputText" style="width: 80%"/>
		       </td>
		       <td style="text-align: right;">职务：</td>
		       <td style="text-align: center;">
		          <select name="directorTitle" class="inputText" style="width: 80%">
		              <option value="">请选择</option>
		              <option value="zr" <c:if test="${resultMap.directorTitle eq 'zr' }">selected="selected"</c:if>>主任</option>
		              <option value="fzr" <c:if test="${resultMap.directorTitle eq 'fzr' }">selected="selected"</c:if>>副主任</option>
		          </select>
		       </td>
		       <td style="text-align: right;">年龄：</td>
		       <td style="text-align: center;">
		          <input type="text" name="directorAge" value="${resultMap.directorAge}" class="inputText" style="width: 80%"/>
		       </td>
		       <td style="text-align: right;">职称：</td>
		       <td style="text-align: center;">
		         <select name="directorPost" class="inputText" style="width: 80%">
       				   <option value="">请选择</option>
					   <c:forEach items="${dictTypeEnumUserTitleList}" var="dict">
		        	   <option value="${dict.dictId}" <c:if test='${resultMap.directorPost==dict.dictId}'>selected="selected"</c:if>>${dict.dictName}</option>
		               </c:forEach>
			     </select>
		       </td>
		    </tr> 
		    <tr>
		       <td style="text-align: right;">导师类型：</td>
		       <td style="text-align: center;">
		          <select name="directorPostgraduateTeacher" class="inputText" style="width: 80%">
		          	  <option value="">请选择</option>
		              <option value="bd" <c:if test="${resultMap.directorPostgraduateTeacher eq 'bd' }">selected="selected"</c:if>>博导</option>
		              <option value="sd" <c:if test="${resultMap.directorPostgraduateTeacher eq 'sd' }">selected="selected"</c:if>>硕导</option>
		          </select>
		       </td>
		       <td style="text-align: right;">学会任职：</td>
		       <td style="text-align: center;">
		          <input type="text" name="directorLearnPost" value="${resultMap.directorLearnPost}" style="width: 80%" class="inputText"/>
		       </td>
		       <td style="text-align: right;">荣誉称号：</td>
		       <td style="text-align: center;">
		          <input type="text" name="directorHonourTitle" value="${resultMap.directorHonourTitle}" style="width: 80%" class="inputText"/>
		       </td>
		       <td style="text-align: right;">人才培养对象：</td>
		       <td style="text-align: center;">
		          <input type="text" name="directorTalentsDevelop" value="${resultMap.directorTalentsDevelop}" style="width: 80%" class="inputText"/>
		       </td>
		    </tr>
		</table>
		
	  <table width="100%" class="bs_tb" style="margin-top: 40px;">
		    <tr><th colspan="10" class="theader" style="padding-left:15px;text-align:left;">3.工作成绩</th></tr>
		    <tr>
		       <th colspan="10" class="theader">1)五年内获奖成果
		            <c:if test="${param.view!=GlobalConstant.FLAG_Y }">
					<span style="float: right;padding-right: 10px">
					<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('ach')"></img>&#12288;
					<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('ach');"></img></span>
					</c:if>
		       </th>
		    </tr>
		    <tr>
		       <td width="50px"></td>
		       <td width="50px">序号</td>
		       <td width="12%">时间</td>
		       <td width="17%">成果名称</td>
		       <td width="15%">奖励名称</td>
		       <td width="10%">等级</td>
		       <td width="10%">授奖部门</td>
		       <td width="15%">第一完成单位</td>
		       <td width="7%">本单位排名</td>
		       <td width="6%">本人排序</td>
		    </tr>
		    <tbody id="achTb">
		    <c:forEach items="${resultMap.ach }" var="ach" varStatus="status">
		    <tr>
		      <td width="50px" style="text-align: center;"><input name="achIds" type="checkbox"/></td>
       		  <td width="50px" style="text-align: center;" class="achSerial">${status.count}</td>
		      <td>
		         <input type="text" name="ach_time" class="inputText ctime" style="width: 80%" value="${ach.objMap.ach_time}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
		      </td>
		      <td>
		         <input type="text" name="ach_name" class="inputText" style="width: 80%" value="${ach.objMap.ach_name}"/>
		      </td>
		      <td>
		         <input type="text" name="ach_awardName" class="inputText" style="width: 80%" value="${ach.objMap.ach_awardName}"/>
		      </td>
		      <td>
		         <input type="text" name="ach_grade" class="inputText" style="width: 80%" value="${ach.objMap.ach_grade}"/>
		      </td>
		      <td>
		         <input type="text" name="ach_giveOrg" class="inputText" style="width: 80%" value="${ach.objMap.ach_giveOrg}"/>
		      </td>
		      <td>
		         <input type="text" name="ach_firstFinishOrg" class="inputText" style="width: 80%" value="${ach.objMap.ach_firstFinishOrg}"/>
		      </td>
		      <td>
		         <input type="text" name="ach_selfOrgRank" class="inputText" style="width: 80%" value="${ach.objMap.ach_selfOrgRank}"/>
		      </td>
		      <td>
		         <input type="text" name="ach_selfRank" class="inputText" style="width: 80%" value="${ach.objMap.ach_selfRank}"/>
		      </td>
		    </tr>
		    </c:forEach> 
		    </tbody>  
		 </table> 
		 <table width="100%" class="bs_tb" style="margin-top: 20px;">
		    <tr>
		      <th colspan="9" class="theader">2)五年内获奖主要论文
		            <c:if test="${param.view!=GlobalConstant.FLAG_Y }">
					<span style="float: right;padding-right: 10px">
					<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('thesis')"></img>&#12288;
					<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('thesis');"></img></span>
					</c:if>
		      </th>
		    </tr>
		    <tr>
		       <td width="50px"></td>
		       <td width="50px">序号</td>
		       <td width="12%">时间</td>
		       <td width="30%">论文名称</td>
		       <td width="10%">发表刊物</td>
		       <td width="10%">完成人</td>
		       <td width="10%">刊物类别</td>
		       <td width="10%">影响因子</td>
		       <td width="10%">作者身份</td>
		    </tr>
		    <tbody id="thesisTb">
		    <c:forEach items="${resultMap.thesis }" var="thesis" varStatus="status">
		    <tr>
		      <td width="50px" style="text-align: center;"><input name="thesisIds" type="checkbox"/></td>
       		  <td width="50px" style="text-align: center;" class="thesisSerial">${status.count}</td>
		      <td>
		         <input type="text" name="thesis_time" class="inputText ctime" style="width: 80%" value="${thesis.objMap.thesis_time}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
		      </td>
		      <td>
		         <input type="text" name="thesis_name" class="inputText" style="width: 80%" value="${thesis.objMap.thesis_name}"/>
		      </td>
		      <td>
		         <input type="text" name="thesis_publication" class="inputText" style="width: 80%" value="${thesis.objMap.thesis_publication}"/>
		      </td>
		      <td>
		         <input type="text" name="thesis_finishPerson" class="inputText" style="width: 80%" value="${thesis.objMap.thesis_finishPerson}"/>
		      </td>
		      <td>
		         <input type="text" name="thesis_publicationType" class="inputText" style="width: 80%" value="${thesis.objMap.thesis_publicationType}"/>
		      </td>
		      <td>
		         <input type="text" name="thesis_influence" class="inputText" style="width: 80%" value="${thesis.objMap.thesis_influence}"/>
		      </td>
		      <td>
		         <input type="text" name="thesis_authorStatus" class="inputText" style="width: 80%" value="${thesis.objMap.thesis_authorStatus}"/>
		      </td>
		    </tr>
		    </c:forEach>
		    </tbody>  
		 </table>
		 <table width="100%" class="bs_tb" style="margin-top: 20px;">
		    <tr>
		      <th colspan="9" class="theader">3)承担与学科发展方向一致的重大课题名称
		            <c:if test="${param.view!=GlobalConstant.FLAG_Y }">
					  <span style="float: right;padding-right: 10px">
					  <img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('task')"></img>&#12288;
					<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('task');"></img></span>
					</c:if>
		      </th>
		   </tr> 
		    <tr>
		       <td width="50px"></td>
		       <td width="50px">序号</td>
		       <td width="20%">课题编号</td>
		       <td width="30%">课题名称</td>
		       <td width="20%">课题来源</td>
		       <td width="10%">经费</td>
		       <td width="10%">本人排序</td>
		    </tr>
		    <tbody id="taskTb">
		    <c:forEach items="${resultMap.task }" var="task" varStatus="status">
		    <tr>
		      <td width="50px" style="text-align: center;"><input name="taskIds" type="checkbox"/></td>
       		  <td width="50px" style="text-align: center;" class="taskSerial">${status.count}</td>
		      <td>
		         <input type="text" name="task_code" class="inputText" style="width: 80%" value="${task.objMap.task_code}"/>
		      </td>
		      <td>
		         <input type="text" name="task_name" class="inputText" style="width: 80%" value="${task.objMap.task_name}"/>
		      </td>
		      <td>
		         <input type="text" name="task_source" class="inputText" style="width: 80%" value="${task.objMap.task_source}"/>
		      </td>
		      <td>
		         <input type="text" name="task_fund" class="inputText" style="width: 80%" value="${task.objMap.task_fund}"/>
		      </td>
		      <td>
		         <input type="text" name="task_rank" class="inputText" style="width: 80%" value="${task.objMap.task_rank}"/>
		      </td>
		    </tr>
		    </c:forEach>  
		    </tbody>
		 </table>
		    
		</form>
    <div class="button" style="width: 100%; <c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none</c:if>">
	   <a href="javascript:void(0)" target="_self" class="search" onclick="nextOpt('step1')">上一步</a>
	   <a href="javascript:void(0)" target="_self" class="search" onclick="nextOpt('step3')">下一步</a>
    </div>
    
    
    
     <div style="display: none;">
     <!-- 人员模板 -->
       <table  id="userTemplate" width="100%" class="bs_tb" style="margin-top: 40px;">
	    <tr>
			<td width="50px" style="text-align: center;"><input name="userIds" type="checkbox"/></td>
			<td width="50px" style="text-align: center;" class="userSerial"></td>
			<td><input type="text" name="user_name"  class="inputText" style="width: 80%"/></td>
			<td><input type="text" name="user_birthday"  style="width: 80%" class="inputText ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/></td>
			<td><input type="text" name="user_age" style="width: 80%" class="validate[custom[integer]] inputText" onchange="userStatistics()"/></td>
		    <td>
			   <select name="user_degree" class="inputText" style="width: 80%">
			   <option value="">请选择</option>
			   <c:forEach items="${dictTypeEnumUserDegreeList}" var="dict">
        	   <option value="${dict.dictId}" >${dict.dictName}</option>
        	   </c:forEach>
	           </select>
			</td>
			<!-- 技术职称 -->
			<td>
				<select name="user_userTitle" class="inputText" style="width: 80%" onchange="userStatistics()">
				<option value="">请选择</option>
				<option value="high">高级</option>
				<option value="middle">中级</option>
				<option value="primary">初级</option>
				<option value="assistant">副高</option>
				</select>
			</td>
			<!-- 学会任职 -->
		    <td>
			   <input type="text" name="user_learnTitle"  class="inputText" style="width: 80%"/>
		    </td>
			<!-- 荣誉称号-->
			<td>
			   <input type="text" name="user_honourTitle"  class="inputText" style="width: 80%" />
			</td>
			<!-- 人才培养对象 -->  
			<td><input type="text" name="user_talentsDevelop"  class="inputText" style="width: 80%" /></td>
			<!-- 技术特长 -->  
			<td><input type="text" name="user_technology"  class="inputText" style="width: 80%" /></td>
        </tr>
	   </table>
	   <!-- 成果模板 -->
	   <table id="achTemplate" width="100%" class="bs_tb" style="margin-top: 40px;">
	      <tr>
		      <td width="50px" style="text-align: center;"><input name="achIds" type="checkbox"/></td>
       		  <td width="50px" style="text-align: center;" class="achSerial"></td>
		      <td>
		         <input type="text" name="ach_time" class="inputText ctime" style="width: 80%" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
		      </td>
		      <td>
		         <input type="text" name="ach_name" class="inputText" style="width: 80%"/>
		      </td>
		      <td>
		         <input type="text" name="ach_awardName" class="inputText" style="width: 80%"/>
		      </td>
		      <td>
		         <input type="text" name="ach_grade" class="inputText" style="width: 80%"/>
		      </td>
		      <td>
		         <input type="text" name="ach_giveOrg" class="inputText" style="width: 80%"/>
		      </td>
		      <td>
		         <input type="text" name="ach_firstFinishOrg" class="inputText" style="width: 80%"/>
		      </td>
		      <td>
		         <input type="text" name="ach_selfOrgRank" class="inputText" style="width: 80%"/>
		      </td>
		      <td>
		         <input type="text" name="ach_selfRank" class="inputText" style="width: 80%"/>
		      </td>
		    </tr>
	   </table>
	     <!-- 论文模板 -->
	   <table id="thesisTemplate" width="100%" class="bs_tb" style="margin-top: 40px;">
	      <tr>
		      <td width="50px" style="text-align: center;"><input name="thesisIds" type="checkbox"/></td>
       		  <td width="50px" style="text-align: center;" class="thesisSerial"></td>
		      <td>
		         <input type="text" name="thesis_time" class="inputText ctime" style="width: 80%" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
		      </td>
		      <td>
		         <input type="text" name="thesis_name" class="inputText" style="width: 80%"/>
		      </td>
		      <td>
		         <input type="text" name="thesis_publication" class="inputText" style="width: 80%"/>
		      </td>
		      <td>
		         <input type="text" name="thesis_finishPerson" class="inputText" style="width: 80%"/>
		      </td>
		      <td>
		         <input type="text" name="thesis_publicationType" class="inputText" style="width: 80%"/>
		      </td>
		      <td>
		         <input type="text" name="thesis_influence" class="inputText" style="width: 80%"/>
		      </td>
		      <td>
		         <input type="text" name="thesis_authorStatus" class="inputText" style="width: 80%" value="${thesis.thesis_authorStatus}"/>
		      </td>
		    </tr>
	   </table>
	      <!-- 课题模板 -->
	   <table id="taskTemplate" width="100%" class="bs_tb" style="margin-top: 40px;">
	     <tr>
		      <td width="50px" style="text-align: center;"><input name="taskIds" type="checkbox"/></td>
       		  <td width="50px" style="text-align: center;" class="taskSerial"></td>
		      <td>
		         <input type="text" name="task_code" class="inputText" style="width: 80%"/>
		      </td>
		      <td>
		         <input type="text" name="task_name" class="inputText" style="width: 80%"/>
		      </td>
		      <td>
		         <input type="text" name="task_source" class="inputText" style="width: 80%"/>
		      </td>
		      <td>
		         <input type="text" name="task_fund" class="inputText" style="width: 80%"/>
		      </td>
		      <td>
		         <input type="text" name="task_rank" class="inputText" style="width: 80%" value="${task.task_rank}"/>
		      </td>
		    </tr>
	   </table>
     </div>

		