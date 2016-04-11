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
			satStatistics();
			thesisStatistics();
			patentStatistics();
			certificateTypeStatistics();
		});
	}
	
	
	function satStatistics(){
		$("#satStatistics input").each(function(){
			$(this).val("");
		});
		$("#satTb select[name=sat_awardName]").each(function (){
			var awardName = this.value;
			var grade = $(this).parent().next().children().val();
			//alert(awardName +"," +grade);
			var num = parseFloat($("input[name="+awardName + grade+"]").val());
			if(isNaN(num)){
				num = 0;
			}
			$("input[name="+awardName + grade+"]").val(num+1);
		});
	}
	
	function thesisStatistics(){
		$("#thesisStatistics input").each(function(){
			$(this).val("");
		});
		$("#thesisTb select[name=thesis_periodicalList]").each(function (){
			var periodicalList = this.value;
			var authorIdentity = $(this).parent().next().next().children().val();
			//alert(periodicalList +"," +authorIdentity);
			var num = parseFloat($("input[name="+periodicalList + authorIdentity+"]").val());
			if(isNaN(num)){
				num = 0;
			}
			$("input[name="+periodicalList + authorIdentity+"]").val(num+1);
		});
	}
	
	function patentStatistics(){
		$("#patentStatistics input").each(function(){
			$(this).val("");
		});
		$("#patentTb select[name=patent_typeName]").each(function (){
			var typeName = this.value;
			var country = $(this).parent().next().children().val();
			//alert(typeName +"," +country);
			var num = parseFloat($("input[name="+typeName + country+"]").val());
			if(isNaN(num)){
				num = 0;
			}
			$("input[name="+typeName + country+"]").val(num+1);
		});
	}
	
	
	function certificateTypeStatistics(){
		$("#certificateTypeStatistics input").each(function(){
			$(this).val("");
		});
		$("#patentTb select[name=patent_certificateType]").each(function (){
			var type = this.value;
			//alert(type);
			var num = parseFloat($("input[name=certificate"+type+"]").val());
			if(isNaN(num)){
				num = 0;
			}
			$("input[name=certificate"+type+"]").val(num+1);
		});
	}
	
	
</script>
</c:if>

<style type="text/css">
 .bs_tb tbody td input{text-align: left;margin-left: 10px;}
</style>

	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" style="position: relative;"
		id="projForm">
		<input type="hidden" id="pageName" name="pageName" value="step4" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
		   
		<div>
			<font style="font-size: 18px; font-weight:bold; ">四、中心成果</font>
		</div>
		<table class="bs_tb" style="width: 100%;margin-top: 10px;">
			<tr>
				<th colspan="11" class="theader">1.主要科研成果获奖情况
					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
					<span style="float: right;padding-right: 10px">
					<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('sat')"></img>&#12288;
					<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('sat');"></img></span>
					</c:if>
				</th>
			</tr>
			<tr>
				<td style="text-align: center;" width="50px"></td>
				<td style="text-align: center;" width="50px">序号</td>
				<td style="text-align: center;" width="15%">项目名称</td>
				<td style="text-align: center;" width="12%">时间</td>
				<td style="text-align: center;" width="20%">奖励名称</td>
				<td style="text-align: center;" width="7%">等级</td>
				<td style="text-align: center;" width="10%">授奖部门</td>
				<td style="text-align: center;" width="9%">第一完成单位</td>
				<td style="text-align: center;" width="5%">本单位排名</td>
				<td style="text-align: center;" width="10%">完成人</td>
				<td style="text-align: center;" width="5%">完成人顺序</td>
			</tr>
			<tbody id="satTb">
			<c:if test="${not empty resultMap.sat}">
				<c:forEach var="sat" items="${resultMap.sat}" varStatus="status">
				<tr>
		             <td width="50px" style="text-align: center;"><input name="satIds" type="checkbox"/></td>
		             <td width="50px" style="text-align: center;" class="satSerial">${status.count}</td>
		             <td><input type="text" name="sat_projName" value="${sat.objMap.sat_projName}" class="inputText" style="width: 80%"/></td>
		             <td>
		             	 <input class="inputText ctime" type="text" name="sat_time" value="${sat.objMap.sat_time}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width: 80%;"/>
		             </td>
		             <td>
					 	<select name="sat_awardName"  class="inputText" onchange="satStatistics()">
					 		<option value="">请选择</option>
					 		<option value="gjkjjbj" <c:if test="${sat.objMap.sat_awardName eq 'gjkjjbj'}">selected="selected"</c:if>>国家科技进步奖</option>
					 		<option value="gjzrkxj" <c:if test="${sat.objMap.sat_awardName eq 'gjzrkxj'}">selected="selected"</c:if>>国家自然科学奖</option>
					 		<option value="gjfmj" <c:if test="${sat.objMap.sat_awardName eq 'gjfmj'}">selected="selected"</c:if>>国家发明奖</option>
					 		<option value="zhyxkjj" <c:if test="${sat.objMap.sat_awardName eq 'zhyxkjj'}">selected="selected"</c:if>>中华医学科技奖</option>
					 		<option value="jsskjjbj" <c:if test="${sat.objMap.sat_awardName eq 'jsskjjbj'}">selected="selected"</c:if>>江苏省科技进步奖</option>
					 		<option value="qtsbjkjjbj" <c:if test="${sat.objMap.sat_awardName eq 'qtsbjkjjbj'}">selected="selected"</c:if>>其他省部级科技进步奖</option>
					 		<option value="sqttjjkjjbj" <c:if test="${sat.objMap.sat_awardName eq 'sqttjjkjjbj'}">selected="selected"</c:if>>省其他厅局级科技进步奖</option>
					 		<option value="sjkjjbj" <c:if test="${sat.objMap.sat_awardName eq 'sjkjjbj'}">selected="selected"</c:if>>市级科技进步奖</option>
					 		<option value="jsswstyxxjsyjj" <c:if test="${sat.objMap.sat_awardName eq 'jsswstyxxjsyjj'}">selected="selected"</c:if>>江苏省卫生厅医学新技术引进奖</option>
					 		<option value="qt" <c:if test="${sat.objMap.sat_awardName eq 'qt'}">selected="selected"</c:if>>其他</option>
					 	</select>	
		             </td>
		             <td>
					 	<select name="sat_grade"  class="inputText">
					 		<option value="">请选择</option>
					 		<option value="Grade0" <c:if test="${sat.objMap.sat_grade eq 'Grade0'}">selected="selected"</c:if>>特等奖</option>
					 		<option value="Grade1" <c:if test="${sat.objMap.sat_grade eq 'Grade1'}">selected="selected"</c:if>>一等奖</option>
					 		<option value="Grade2" <c:if test="${sat.objMap.sat_grade eq 'Grade2'}">selected="selected"</c:if>>二等奖</option>
					 		<option value="Grade3" <c:if test="${sat.objMap.sat_grade eq 'Grade3'}">selected="selected"</c:if>>三等奖</option>
					 		<option value="Grade4" <c:if test="${sat.objMap.sat_grade eq 'Grade4'}">selected="selected"</c:if>>四等奖</option>
					 	</select>	
		             </td>
		             <td><input type="text" name="sat_awardDepartment" value="${sat.objMap.sat_awardDepartment}"  class="inputText" style="width: 80%"/></td>
		             <td><input type="text" name="sat_firstFinishOrg" value="${sat.objMap.sat_firstFinishOrg}"  class="inputText" style="width: 80%"/></td>
		             <td><input type="text" name="sat_orgRanking" value="${sat.objMap.sat_orgRanking}"  class="inputText" style="width: 80%"/></td>
		             <td><input type="text" name="sat_author" value="${sat.objMap.sat_author}"  class="inputText" style="width: 80%"/></td>
		             <td><input type="text" name="sat_authorOrder" value="${sat.objMap.sat_authorOrder}"  class="inputText" style="width: 80%"/></td>
				</tr>
			    </c:forEach>
	    	</c:if>
			</tbody>
		</table>
		
		<font style="font-size: 14px; font-weight:bold; ">&#12288;按获奖等级统计：</font>
		<table class="bs_tb" style="width: 100%;">
			<tr>
				<td></td>
				<td>国家科技进步奖</td>
				<td>国家自然科学奖</td>
				<td>国家发明奖</td>
				<td>中华医学科技奖</td>
				<td>江苏省科技进步奖</td>
				<td>其他省部级科技进步奖</td>
				<td>省其他厅局级科技进步奖</td>
				<td>市级科技进步奖</td>
				<td>江苏省卫生厅医学新技术引进奖</td>
				<td>其他</td>
			</tr>
		
		<tbody id="satStatistics">
			<tr>
				<td width="50px;">特等奖</td>
				<td><input type="text" name="gjkjjbjGrade0" value="${resultMap.gjkjjbjGrade0}"  class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="gjzrkxjGrade0" value="${resultMap.gjzrkxjGrade0}"  class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="gjfmjGrade0" value="${resultMap.gjfmjGrade0}"  class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="zhyxkjjGrade0" value="${resultMap.zhyxkjjGrade0}"  class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="jsskjjbjGrade0" value="${resultMap.jsskjjbjGrade0}"  class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="qtsbjkjjbjGrade0" value="${resultMap.qtsbjkjjbjGrade0}"  class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="sqttjjkjjbjGrade0" value="${resultMap.sqttjjkjjbjGrade0}"  class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="sjkjjbjGrade0" value="${resultMap.sjkjjbjGrade0}"  class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="jsswstyxxjsyjjGrade0" value="${resultMap.jsswstyxxjsyjjGrade0}"  class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="qtGrade0" value="${resultMap.qtGrade0}"  class="validate[custom[integer]] inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td>一等奖</td>
				<td><input type="text" name="gjkjjbjGrade1" value="${resultMap.gjkjjbjGrade1}"  class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="gjzrkxjGrade1" value="${resultMap.gjzrkxjGrade1}"  class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="gjfmjGrade1" value="${resultMap.gjfmjGrade1}"  class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="zhyxkjjGrade1" value="${resultMap.zhyxkjjGrade1}"  class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="jsskjjbjGrade1" value="${resultMap.jsskjjbjGrade1}"  class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="qtsbjkjjbjGrade1" value="${resultMap.qtsbjkjjbjGrade1}"  class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="sqttjjkjjbjGrade1" value="${resultMap.sqttjjkjjbjGrade1}"  class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="sjkjjbjGrade1" value="${resultMap.sjkjjbjGrade1}"  class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="jsswstyxxjsyjjGrade1" value="${resultMap.jsswstyxxjsyjjGrade1}"  class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="qtGrade1" value="${resultMap.qtGrade1}"  class="validate[custom[integer]] inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td>二等奖</td>
				<td><input type="text" name="gjkjjbjGrade2" value="${resultMap.gjkjjbjGrade2}"  class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="gjzrkxjGrade2" value="${resultMap.gjzrkxjGrade2}"  class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="gjfmjGrade2" value="${resultMap.gjfmjGrade2}"  class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="zhyxkjjGrade2" value="${resultMap.zhyxkjjGrade2}"  class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="jsskjjbjGrade2" value="${resultMap.jsskjjbjGrade2}"  class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="qtsbjkjjbjGrade2" value="${resultMap.qtsbjkjjbjGrade2}"  class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="sqttjjkjjbjGrade2" value="${resultMap.sqttjjkjjbjGrade2}"  class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="sjkjjbjGrade2" value="${resultMap.sjkjjbjGrade2}"  class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="jsswstyxxjsyjjGrade2" value="${resultMap.jsswstyxxjsyjjGrade2}"  class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="qtGrade2" value="${resultMap.qtGrade2}"  class="validate[custom[integer]] inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td>三等奖</td>
				<td><input type="text" name="gjkjjbjGrade3" value="${resultMap.gjkjjbjGrade3}"  class="inputText" style="width: 80%"/></td>
				<td><input type="text" name="gjzrkxjGrade3" value="${resultMap.gjzrkxjGrade3}"  class="inputText" style="width: 80%"/></td>
				<td><input type="text" name="gjfmjGrade3" value="${resultMap.gjfmjGrade3}"  class="inputText" style="width: 80%"/></td>
				<td><input type="text" name="zhyxkjjGrade3" value="${resultMap.zhyxkjjGrade3}"  class="inputText" style="width: 80%"/></td>
				<td><input type="text" name="jsskjjbjGrade3" value="${resultMap.jsskjjbjGrade3}"  class="inputText" style="width: 80%"/></td>
				<td><input type="text" name="qtsbjkjjbjGrade3" value="${resultMap.qtsbjkjjbjGrade3}"  class="inputText" style="width: 80%"/></td>
				<td><input type="text" name="sqttjjkjjbjGrade3" value="${resultMap.sqttjjkjjbjGrade3}"  class="inputText" style="width: 80%"/></td>
				<td><input type="text" name="sjkjjbjGrade3" value="${resultMap.sjkjjbjGrade3}"  class="inputText" style="width: 80%"/></td>
				<td><input type="text" name="jsswstyxxjsyjjGrade3" value="${resultMap.jsswstyxxjsyjjGrade3}"  class="inputText" style="width: 80%"/></td>
				<td><input type="text" name="qtGrade3" value="${resultMap.qtGrade3}"  class="inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td>四等奖</td>
				<td><input type="text" name="gjkjjbjGrade4" value="${resultMap.gjkjjbjGrade4}"  class="inputText" style="width: 80%"/></td>
				<td><input type="text" name="gjzrkxjGrade4" value="${resultMap.gjzrkxjGrade4}"  class="inputText" style="width: 80%"/></td>
				<td><input type="text" name="gjfmjGrade4" value="${resultMap.gjfmjGrade4}"  class="inputText" style="width: 80%"/></td>
				<td><input type="text" name="zhyxkjjGrade4" value="${resultMap.zhyxkjjGrade4}"  class="inputText" style="width: 80%"/></td>
				<td><input type="text" name="jsskjjbjGrade4" value="${resultMap.jsskjjbjGrade4}"  class="inputText" style="width: 80%"/></td>
				<td><input type="text" name="qtsbjkjjbjGrade4" value="${resultMap.qtsbjkjjbjGrade4}"  class="inputText" style="width: 80%"/></td>
				<td><input type="text" name="sqttjjkjjbjGrade4" value="${resultMap.sqttjjkjjbjGrade4}"  class="inputText" style="width: 80%"/></td>
				<td><input type="text" name="sjkjjbjGrade4" value="${resultMap.sjkjjbjGrade4}"  class="inputText" style="width: 80%"/></td>
				<td><input type="text" name="jsswstyxxjsyjjGrade4" value="${resultMap.jsswstyxxjsyjjGrade4}"  class="inputText" style="width: 80%"/></td>
				<td><input type="text" name="qtGrade4" value="${resultMap.qtGrade4}"  class="inputText" style="width: 80%"/></td>
			</tr>
		</tbody>
		</table>
		
		
		<!-- 3.发表论文 -->
		<table class="bs_tb" style="width: 100%;margin-top: 40px;">
			<tr>
				<th colspan="11" class="theader">2.发表论文
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
				<td width="20%">论文名称</td>
				<td width="15%">发表刊物</td>
				<td width="10%">完成人</td>
				<td width="15%">刊物列表</td>
				<td width="10%">影响因子</td>
				<td width="10%">作者身份</td>
			</tr>
			<tbody id="thesisTb">
			<c:if test="${! empty resultMap.thesis}">
				<c:forEach var="thesis" items="${resultMap.thesis}" varStatus="status">
				<tr>
		             <td width="50px" style="text-align: center;"><input name="thesisIds" type="checkbox"/></td>
		             <td width="50px" style="text-align: center;" class="thesisSerial">${status.count}</td>
		             <td>
						 <input class="inputText ctime" type="text" name="thesis_time" value="${thesis.objMap.thesis_time}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width: 80%;"/>
		             </td>
		             <td><input type="text" name="thesis_name" value="${thesis.objMap.thesis_name}"  class="inputText" style="width: 80%"/></td>
		             <td><input type="text" name="thesis_periodical" value="${thesis.objMap.thesis_periodical}"  class="inputText" style="width: 80%"/></td>
		             <td><input type="text" name="thesis_author" value="${thesis.objMap.thesis_author}"  class="inputText" style="width: 80%"/></td>
		             <td>
		             	<select name="thesis_periodicalList" class="inputText" style="width: 80%" onchange="thesisStatistics();">
		             		<option value="">请选择</option>
		             		<option value="SCI" <c:if test="${thesis.objMap.thesis_periodicalList eq 'SCI'}">selected="selected"</c:if>>SCI收录期刊</option>
		             		<option value="EI" <c:if test="${thesis.objMap.thesis_periodicalList eq 'EI'}">selected="selected"</c:if>>EI收录期刊</option>
		             		<option value="ISTP" <c:if test="${thesis.objMap.thesis_periodicalList eq 'ISTP'}">selected="selected"</c:if>>ISTP收录期刊</option>
		             		<option value="GW" <c:if test="${thesis.objMap.thesis_periodicalList eq 'GW'}">selected="selected"</c:if>>国外期刊</option>
		             		<option value="GJJ" <c:if test="${thesis.objMap.thesis_periodicalList eq 'GJJ'}">selected="selected"</c:if>>国家级学报</option>
		             		<option value="ZHYX" <c:if test="${thesis.objMap.thesis_periodicalList eq 'ZHYX'}">selected="selected"</c:if>>中华医学系列杂志</option>
		             		<option value="QT" <c:if test="${thesis.objMap.thesis_periodicalList eq 'QT'}">selected="selected"</c:if>>其他</option>
		             	</select>
		             </td>
		             <td><input type="text" name="thesis_ImpactFactor" value="${thesis.objMap.thesis_ImpactFactor}"  class="inputText" style="width: 80%"/></td>
		             <td>
		             	<select name="thesis_authorIdentity" class="inputText" style="width: 80%" onchange="thesisStatistics();">
		             		<option value="">请选择</option>
		             		<option value="dyzz" <c:if test="${thesis.objMap.thesis_authorIdentity eq 'dyzz'}">selected="selected"</c:if>>第一作者</option>
		             		<option value="txzz" <c:if test="${thesis.objMap.thesis_authorIdentity eq 'txzz'}">selected="selected"</c:if>>通讯作者</option>
		             	</select>
		             </td>
				</tr>
			    </c:forEach>
	    	</c:if>
			</tbody>
		</table>
		<!--.论文统计 -->
		<font style="font-size: 14px; font-weight:bold; ">&#12288;论文统计：</font>
		<table id="thesisStatistics" class="bs_tb" style="width: 100%;">
			<tr>
				<td width="90px;"></td>
				<td>SCI收录期刊</td>
				<td>EI收录期刊</td>
				<td>ISTP收录期刊</td>
				<td>国外期刊</td>
				<td>国家级学报</td>
				<td style="tfont-weight:bold;">中华医学系列杂志</td>
				<td>其他</td>
			</tr>
			<tr>
				<td>第一作者</td>
				<td><input type="text" name="SCIdyzz" value="${resultMap.SCIdyzz}" class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="EIdyzz" value="${resultMap.EIdyzz}" class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="ISTPdyzz" value="${resultMap.ISTPdyzz}" class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="GWdyzz" value="${resultMap.GWdyzz}" class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="GJJdyzz" value="${resultMap.GJJdyzz}" class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="ZHYXdyzz" value="${resultMap.ZHYXdyzz}" class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="QTdyzz" value="${resultMap.QTdyzz}" class="validate[custom[integer]] inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td>通讯作者</td>
				<td><input type="text" name="SCItxzz" value="${resultMap.SCItxzz}" class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="EItxzz" value="${resultMap.EItxzz}" class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="ISTPtxzz" value="${resultMap.ISTPtxzz}" class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="GWtxzz" value="${resultMap.GWtxzz}" class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="GJJtxzz" value="${resultMap.GJJtxzz}" class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="ZHYXtxzz" value="${resultMap.ZHYXtxzz}" class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td><input type="text" name="QTtxzz" value="${resultMap.QTtxzz}" class="inputText" style="width: 80%"/></td>
			</tr>
		</table>
		
		
		<!-- 3.出版的学术专著 -->
		<table class="bs_tb" style="width: 100%;margin-top: 40px;position: relative;">
			<tr>
				<th colspan="10" class="theader">3.出版的学术专著
					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
					<span style="float: right;padding-right: 10px">
					<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('book')"></img>&#12288;
					<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('book');"></img></span>
					</c:if>
				</th>
			</tr>
			<tr>
				<td width="50px"></td>
				<td width="50px">序号</td>
				<td >时间</td>
				<td >专著及教材</td>
				<td >字数（万字）</td>
				<td >完成人</td>
				<td >本人完成字数（万字）</td>
				<td >编辑身份</td>
				<td >出版社</td>
			</tr>
			<tbody id="bookTb">
			<c:if test="${! empty resultMap.book}">
				<c:forEach var="book" items="${resultMap.book}" varStatus="status">
				<tr>
		             <td width="50px" style="text-align: center;"><input name="bookIds" type="checkbox"/></td>
		             <td width="50px" style="text-align: center;" class="bookSerial">${status.count}</td>
		             <td>
		             	 <input class="inputText ctime" type="text" name="book_time" value="${book.objMap.book_time}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width: 80%;"/>
		             </td>
		             <td><input type="text" name="book_name" value="${book.objMap.book_name}"  class="inputText" style="width: 80%"/></td>
		             <td><input type="text" name="book_wordCount" value="${book.objMap.book_wordCount}"  class="validate[custom[number]] inputText" style="width: 80%"/></td>
		             <td><input type="text" name="book_author" value="${book.objMap.book_author}"  class="inputText" style="width: 80%"/></td>
		             <td><input type="text" name="book_selfWordCount" value="${book.objMap.book_selfWordCount}"  class="validate[custom[number]] inputText" style="width: 80%"/></td>
		             <td><input type="text" name="book_authorIdentity" value="${book.objMap.book_authorIdentity}"  class="inputText" style="width: 80%"/></td>
		             <td><input type="text" name="book_publisher" value="${book.objMap.book_publisher}"  class="inputText" style="width: 80%"/></td>
				</tr>
			    </c:forEach>
	    	</c:if>
			</tbody>
		</table>
		
		
		<!-- 4．专利情况-->
		<table class="bs_tb" style="width: 100%;margin-top: 40px;">
			<tr>
				<th colspan="10" class="theader">4.专利情况
					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
					<span style="float: right;padding-right: 10px">
					<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('patent')"></img>&#12288;
					<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('patent');"></img></span>
					</c:if>
				</th>
			</tr>
			<tr>
				<td style="text-align: center;"  width="50px"></td>
				<td  width="50px">序号</td>
				<td >专利名称</td>
				<td >专利类型</td>
				<td >国家</td>
				<td >时间</td>
				<td >证书类型</td>
				<td >完成人</td>
			</tr>
			<tbody id="patentTb">
			<c:if test="${! empty resultMap.patent}">
				<c:forEach var="patent" items="${resultMap.patent}" varStatus="status">
				<tr>
		             <td width="50px" style="text-align: center;"><input name="patentIds" type="checkbox"/></td>
		             <td width="50px" style="text-align: center;" class="patentSerial">${status.count}</td>
		             <td><input type="text" name="patent_name" value="${patent.objMap.patent_name}"  class="inputText" style="width: 80%"/></td>
		             <td>
		             	<select name="patent_typeName" class="inputText" style="width: 80%" onchange="patentStatistics();">
		             		<option value="">请选择</option>
		             		<option value="FM" <c:if test="${patent.objMap.patent_typeName eq 'FM'}">selected="selected"</c:if>>发明（项）</option>
		             		<option value="SYXX" <c:if test="${patent.objMap.patent_typeName eq 'SYXX'}">selected="selected"</c:if>>实用新型（项）</option>
		             		<option value="WGSJ" <c:if test="${patent.objMap.patent_typeName eq 'WGSJ'}">selected="selected"</c:if>>外观设计（项）</option>
		             	</select>
					 </td>
		             <td>
			             <select  name="patent_country" class="inputText" style="width: 80%" onchange="patentStatistics();">
			             	<option value="">请选择</option>
			             	<option value="gn" <c:if test="${patent.objMap.patent_country eq 'gn'}">selected="selected"</c:if>>国内</option>
			             	<option value="gw" <c:if test="${patent.objMap.patent_country eq 'gw'}">selected="selected"</c:if>>国外</option>
			             </select>
		             </td>
		             <td>
	             		<input class="inputText ctime" type="text" name="patent_time" value="${patent.objMap.patent_time}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width: 80%;"/>
		             </td>
		             <td>
	             		<select name="patent_certificateType" class="inputText" style="width: 80%" onchange="certificateTypeStatistics()">
	             			<option value="">请选择</option>
	             			<option value="1" <c:if test="${patent.objMap.patent_certificateType eq '1'}">selected="selected"</c:if>>1类（项）</option>
	             			<option value="2" <c:if test="${patent.objMap.patent_certificateType eq '2'}">selected="selected"</c:if>>2类（项）</option>
	             			<option value="3" <c:if test="${patent.objMap.patent_certificateType eq '3'}">selected="selected"</c:if>>3类（项）</option>
	             			<option value="4" <c:if test="${patent.objMap.patent_certificateType eq '4'}">selected="selected"</c:if>>4类（项）</option>
	             			<option value="5" <c:if test="${patent.objMap.patent_certificateType eq '5'}">selected="selected"</c:if>>5类（项）</option>
	             		</select>
		             </td>
		             <td><input type="text" name="patent_author" value="${patent.objMap.patent_author}"  class="inputText" style="width: 80%"/></td>
				</tr>
			    </c:forEach>
	    	</c:if>
			</tbody>
		</table>

		<!-- 专利统计：-->
		<font style="font-size: 14px; font-weight:bold; ">&#12288;专利统计：</font>
		<table id="patentStatistics" class="basic" style="width: 100%;position: relative;">
			<tr>
				<th width="100px;" style="text-align: right;">国内：</th>
				<td style="text-align: right;">发明（项）：</td>
				<td><input type="text" name="FMgn" value="${resultMap.FMgn}" class="validate[custom[integer]] inputText"/></td>
				<td style="text-align: right;">实用新型（项）：</td>
				<td><input type="text" name="SYXXgn" value="${resultMap.SYXXgn}" class="validate[custom[integer]] inputText"/></td>
				<td style="text-align: right;">外观设计（项）：</td>
				<td><input type="text" name="WGSJgn" value="${resultMap.WGSJgn}" class="validate[custom[integer]] inputText"/></td>
			</tr>
			<tr>
				<th width="100px;" style="text-align: right;">国外：</th>
				<td style="text-align: right;">发明（项）：</td>
				<td><input type="text" name="FMgw" value="${resultMap.FMgw}" class="validate[custom[integer]] inputText"/></td>
				<td style="text-align: right;">实用新型（项）：</td>
				<td><input type="text" name="SYXXgw" value="${resultMap.SYXXgw}" class="validate[custom[integer]] inputText"/></td>
				<td style="text-align: right;">外观设计（项）：</td>
				<td><input type="text" name="WGSJgw" value="${resultMap.WGSJgw}" class="validate[custom[integer]] inputText"/></td>
			</tr>
		</table>
		
		<table id="certificateTypeStatistics" class="basic" style="width: 100%; border-top: none;">
			<tr>
				<th width="100px;" style="text-align: right;">新药证书：</th>
				<td style="text-align: right; width: 80px;">1类（项）：</td>
				<td><input type="text" name="certificate1" value="${resultMap.certificate1}" class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td style="text-align: right;width: 80px;">2类（项）：</td>
				<td><input type="text" name="certificate2" value="${resultMap.certificate2}" class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td style="text-align: right;width: 80px;">3类（项）：</td>
				<td><input type="text" name="certificate3" value="${resultMap.certificate3}" class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td style="text-align: right;width: 80px;">4类（项）： </td>
				<td><input type="text" name="certificate4" value="${resultMap.certificate4}" class="validate[custom[integer]] inputText" style="width: 80%"/></td>
				<td style="text-align: right;width: 80px;">5类（项）： </td>
				<td><input type="text" name="certificate5" value="${resultMap.certificate5}" class="validate[custom[integer]] inputText" style="width: 80%"/></td>
			</tr>
		</table>
		
		</form>
	<!-- -----------------------------------模板------------------------------------------------------------ -->	
	<div style="display: none">
		<!-- 4.专利模板 -->
		<table class="bs_tb" id="patentTemplate" style="width: 100%">
        <tr>
             <td width="50px" style="text-align: center;"><input name="patentIds" type="checkbox"/></td>
             <td width="50px" style="text-align: center;" class="patentSerial"></td>
             <td><input type="text" name="patent_name" class="inputText" style="width: 80%"/></td>
             <td>
             	<select name="patent_typeName" class="inputText" style="width: 80%" onchange="patentStatistics();">
             		<option value="">请选择</option>
             		<option value="FM">发明（项）</option>
             		<option value="SYXX">实用新型（项）</option>
             		<option value="WGSJ">外观设计（项）</option>
             	</select>
			 </td>
             <td>
	             <select  name="patent_country" class="inputText" style="width: 80%" onchange="patentStatistics();">
	             	<option value="">请选择</option>
	             	<option value="gn">国内</option>
	             	<option value="gw">国外</option>
	             </select>
             </td>
             <td><input type="text" name="patent_time" class="inputText" style="width: 80%"/></td>
             <td>
           		<select name="patent_certificateType" class="inputText" style="width: 80%" onchange="certificateTypeStatistics()">
           			<option value="">请选择</option>
           			<option value="1">1类（项）</option>
           			<option value="2">2类（项）</option>
           			<option value="3">3类（项）</option>
           			<option value="4">4类（项）</option>
           			<option value="5">5类（项）</option>
           		</select>
            </td>
            <td><input type="text" name="patent_author" class="inputText" style="width: 80%"/></td>
		</tr>
		</table>
		
		<!-- 3.出版的学术专著模板 -->
		<table class="bs_tb" id="bookTemplate" style="width: 100%">
        <tr>
            <td width="50px" style="text-align: center;"><input name="bookIds" type="checkbox"/></td>
            <td width="50px" style="text-align: center;" class="bookSerial"></td>
            <td>
            	<input class="inputText ctime" type="text" name="book_time" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width: 80%;"/>
            </td>
            <td><input type="text" name="book_name" class="inputText" style="width: 80%"/></td>
            <td><input type="text" name="book_wordCount" class="validate[custom[number]] inputText" style="width: 80%"/></td>
            <td><input type="text" name="book_author" class="inputText" style="width: 80%"/></td>
            <td><input type="text" name="book_selfWordCount" class="validate[custom[number]] inputText" style="width: 80%"/></td>
            <td><input type="text" name="book_authorIdentity" class="inputText" style="width: 80%"/></td>
            <td><input type="text" name="book_publisher" class="inputText" style="width: 80%"/></td>
		</tr>
		</table>
	
	
	
		<!--2. 论文模板 -->
		<table class="bs_tb" id="thesisTemplate" style="width: 100%">
        <tr>
             <td width="50px" style="text-align: center;"><input name="thesisIds" type="checkbox"/></td>
             <td width="50px" style="text-align: center;" class="thesisSerial"></td>
             <td>
           		 <input class="inputText ctime" type="text" name="thesis_time" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width: 80%;"/>
             </td>
             <td><input type="text" name="thesis_name"  class="inputText" style="width: 80%"/></td>
             <td><input type="text" name="thesis_periodical"  class="inputText" style="width: 80%"/></td>
             <td><input type="text" name="thesis_author" class="inputText" style="width: 80%"/></td>
             <td>
             	<select name="thesis_periodicalList" class="inputText" style="width: 80%" onchange="thesisStatistics();">
             		<option value="">请选择</option>
             		<option value="SCI">SCI收录期刊</option>
             		<option value="EI">EI收录期刊</option>
             		<option value="ISTP" >ISTP收录期刊</option>
             		<option value="GW">国外期刊</option>
             		<option value="GJJ">国家级学报</option>
             		<option value="ZHYX">中华医学系列杂志</option>
             		<option value="QT">其他</option>
             	</select>
             </td>
             <td><input type="text" name="thesis_ImpactFactor"  class="inputText" style="width: 80%"/></td>
             <td>
             	<select name="thesis_authorIdentity" class="inputText" style="width: 80%" onchange="thesisStatistics();">
             		<option value="">请选择</option>
             		<option value="dyzz">第一作者</option>
             		<option value="txzz">通讯作者</option>
             	</select>
             </td>
		</tr>
		</table>
	
	
		<!--1. 获奖模板 -->
		<table class="bs_tb" id="satTemplate" style="width: 100%">
        <tr>
             <td width="50px" style="text-align: center;"><input name="satIds" type="checkbox"/></td>
             <td width="50px" style="text-align: center;" class="satSerial"></td>
             <td><input type="text" name="sat_projName"  class="inputText" style="width: 80%"/></td>
             <td>
             	 <input class="inputText ctime" type="text" name="sat_time" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width: 80%;"/>
             </td>
             <td>
			 	<select name="sat_awardName"  class="inputText" onchange="satStatistics()">
			 		<option value="">请选择</option>
			 		<option value="gjkjjbj">国家科技进步奖</option>
			 		<option value="gjzrkxj">国家自然科学奖</option>
			 		<option value="gjfmj">国家发明奖</option>
			 		<option value="zhyxkjj">中华医学科技奖</option>
			 		<option value="jsskjjbj">江苏省科技进步奖</option>
			 		<option value="qtsbjkjjbj">其他省部级科技进步奖</option>
			 		<option value="sqttjjkjjbj">省其他厅局级科技进步奖</option>
			 		<option value="sjkjjbj" >市级科技进步奖</option>
			 		<option value="jsswstyxxjsyjj">江苏省卫生厅医学新技术引进奖</option>
			 		<option value="qt">其他</option>
			 	</select>	
             </td>
             <td>
			 	<select name="sat_grade"  class="inputText" onchange="satStatistics()">
			 		<option value="">请选择</option>
			 		<option value="Grade0">特等奖</option>
			 		<option value="Grade1">一等奖</option>
			 		<option value="Grade2">二等奖</option>
			 		<option value="Grade3">三等奖</option>
			 		<option value="Grade4">四等奖</option>
			 	</select>	
             </td>
             <td><input type="text" name="sat_awardDepartment"  class="inputText" style="width: 80%"/></td>
             <td><input type="text" name="sat_firstFinishOrg"  class="inputText" style="width: 80%"/></td>
             <td><input type="text" name="sat_orgRanking"  class="inputText" style="width: 80%"/></td>
             <td><input type="text" name="sat_author"  class="inputText" style="width: 80%"/></td>
             <td><input type="text" name="sat_authorOrder"  class="inputText" style="width: 80%"/></td>
		</tr>
		</table>
	</div>
	
	
    <div class="button" style="width: 100%; <c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none</c:if>">
	    <a href="javascript:void(0)" target="_self" class="search" onclick="nextOpt('step3')">上一步</a>
	   	<a href="javascript:void(0)" target="_self" class="search" onclick="nextOpt('step5')">下一步</a>
    </div>

		