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
			magazineStatistics();
			cmEduStatistics();
			academicComStatistics();
		});
	}
	
	function magazineStatistics(){
		$("#magazineStatistics input").each(function(){
			$(this).val("");
		});
		$("#magazineTb select[name=magazine_type]").each(function (){
			var type = this.value;
			var post = $(this).parent().next().children().val();
			var num = parseFloat($("input[name="+type + post+"]").val());
			if(isNaN(num)){
				num = 0;
			}
			$("input[name="+type + post+"]").val(num+1);
		});
	}
	
	function cmEduStatistics(){
		$("#cmEduStatistics input").each(function(){
			$(this).val("");
		});
		$("#cmEduTb select[name=cmEdu_projType]").each(function (){
			var projType = this.value;
			var workType = $(this).parent().next().children().val();
			var num = parseFloat($("input[name="+projType + workType+"]").val());
			if(isNaN(num)){
				num = 0;
			}
			$("input[name="+projType + workType+"]").val(num+1);
		});
	}
	
	function academicComStatistics(){
		$("#academicComStatistics input").each(function(){
			$(this).val("");
		});
		$("#academicComTb select[name=academicCom_meetingType]").each(function (){
			var meetingType = this.value;
			var way = $(this).parent().next().next().next().children().val();
			var num = parseFloat($("input[name="+meetingType + way+"]").val());
			if(isNaN(num)){
				num = 0;
			}
			$("input[name="+meetingType + way+"]").val(num+1);
		});
	}
</script>
</c:if>

<style type="text/css">
 .bs_tb tbody td input{text-align: left;margin-left: 10px;}
</style>

	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" style="position: relative;"
		id="projForm">
		<input type="hidden" id="pageName" name="pageName" value="step6" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
		<div>
			<font style="font-size: 18px; font-weight:bold; ">六、其他指标</font>
		</div>
		<table class="bs_tb" style="width: 100%; margin-top: 10px; position: relative;" >
			<tr>
				<th colspan="6" class="theader">1.中心所具有杂志编委情况
					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
					<span style="float: right;padding-right: 10px">
					<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('magazine')"></img>&#12288;
					<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('magazine');"></img></span>
					</c:if>
				</th>
			</tr>
			<tr>
				<td width="50px"></td>
				<td width="50px">序号</td>
				<td width="30%">杂志名称</td>
				<td width="20%">杂志类型</td>
				<td width="20%">担任职务</td>
				<td width="20%">编委姓名</td>
			</tr>
			<tbody id="magazineTb">
			<c:if test="${not empty resultMap.magazine}">
				<c:forEach var="magazine" items="${resultMap.magazine}" varStatus="status">
				<tr>
		             <td width="50px" style="text-align: center;"><input name="magazineIds" type="checkbox"/></td>
		             <td width="50px" style="text-align: center;" class="magazineSerial">${status.count}</td>
		             <td><input type="text" name="magazine_name" value="${magazine.objMap.magazine_name}" class="inputText" style="width: 90%"/></td>
		             <td>
		             	<select name="magazine_type"  class="inputText" style="width: 90%" onchange="magazineStatistics()">
		             		<option value="">请选择</option>
		             		<option value="SCI" <c:if test="${magazine.objMap.magazine_type eq 'SCI'}">selected="selected"</c:if>>SCI收录期刊</option>
		             		<option value="EI" <c:if test="${magazine.objMap.magazine_type eq 'EI'}">selected="selected"</c:if>>EI收录期刊</option>
		             		<option value="ISTP" <c:if test="${magazine.objMap.magazine_type eq 'ISTP'}">selected="selected"</c:if>>ISTP收录期刊</option>
		             		<option value="GW" <c:if test="${magazine.objMap.magazine_type eq 'GW'}">selected="selected"</c:if>>国外期刊</option>
		             		<option value="GJJ" <c:if test="${magazine.objMap.magazine_type eq 'GGJ'}">selected="selected"</c:if>>国家级学报</option>
		             		<option value="ZHYX" <c:if test="${magazine.objMap.magazine_type eq 'ZHYX'}">selected="selected"</c:if>>中华医学系列杂志</option>
		             	</select>
		             </td>
		             <td>
		             	<select name="magazine_post"  class="inputText" style="width: 90%" onchange="magazineStatistics()">
		             		<option value="">请选择</option>
		             		<option value="zb" <c:if test="${magazine.objMap.magazine_post eq 'zb'}">selected="selected"</c:if>>主编</option>
		             		<option value="fzb" <c:if test="${magazine.objMap.magazine_post eq 'fzb'}">selected="selected"</c:if>>副主编</option>
		             		<option value="cwbj" <c:if test="${magazine.objMap.magazine_post eq 'cwbj'}">selected="selected"</c:if>>常务编辑</option>
		             		<option value="bw" <c:if test="${magazine.objMap.magazine_post eq 'bw'}">selected="selected"</c:if>>编委</option>
		             		<option value="tysg" <c:if test="${magazine.objMap.magazine_post eq 'tysg'}">selected="selected"</c:if>>特约审稿</option>
		             	</select>
		             </td>
		             <td><input type="text" name="magazine_editorialBoardName" value="${magazine.objMap.magazine_editorialBoardName}"  class="inputText" style="width: 90%"/></td>
				</tr>
			    </c:forEach>
	    	</c:if>
			</tbody>
		</table>
		
		<font style="font-size: 14px; font-weight:bold; ">&#12288;担任杂志编委情况统计</font>
		<table id="magazineStatistics" class="bs_tb" style="width: 100%; position: relative;" >
			<tr>
				<td></td>
				<td>主编</td>
				<td>副主编</td>
				<td>常务编辑</td>
				<td>编委</td>
				<td>特约审稿</td>
			</tr>
			<tr>
				<td>SCI收录期刊</td>
				<td><input type="text" name="SCIzb" value="${resultMap.SCIzb}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="SCIfzb" value="${resultMap.SCIfzb}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="SCIcwbj" value="${resultMap.SCIcwbj}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="SCIbw" value="${resultMap.SCIbw}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="SCItysg" value="${resultMap.SCItysg}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
			</tr>
			<tr>
				<td>EI收录期刊</td>
				<td><input type="text" name="EIzb" value="${resultMap.EIzb}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="EIfzb" value="${resultMap.EIfzb}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="EIcwbj" value="${resultMap.EIcwbj}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="EIbw" value="${resultMap.EIbw}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="EItysg" value="${resultMap.EItysg}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
			</tr>
			<tr>
				<td>ISTP收录期刊</td>
				<td><input type="text" name="ISTPzb" value="${resultMap.ISTPzb}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="ISTPfzb" value="${resultMap.ISTPfzb}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="ISTPcwbj" value="${resultMap.ISTPcwbj}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="ISTPbw" value="${resultMap.ISTPbw}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="ISTPtysg" value="${resultMap.ISTPtysg}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
			</tr>
			<tr>
				<td>国外期刊</td>
				<td><input type="text" name="GWzb" value="${resultMap.GWzb}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="GWfzb" value="${resultMap.GWfzb}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="GWcwbj" value="${resultMap.GWcwbj}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="GWbw" value="${resultMap.GWbw}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="GWtysg" value="${resultMap.GWtysg}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
			</tr>
			<tr>
				<td>国家级学报</td>
				<td><input type="text" name="GJJzb" value="${resultMap.GJJzb}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="GJJfzb" value="${resultMap.GJJfzb}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="GJJcwbj" value="${resultMap.GJJcwbj}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="GJJbw" value="${resultMap.GJJbw}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="GJJtysg" value="${resultMap.GJJtysg}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
			</tr>
			<tr>
				<td>中华医学系列杂志</td>
				<td><input type="text" name="ZHYXzb" value="${resultMap.ZHYXzb}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="ZHYXfzb" value="${resultMap.ZHYXfzb}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="ZHYXcwbj" value="${resultMap.ZHYXcwbj}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="ZHYXbw" value="${resultMap.ZHYXbw}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="ZHYXtysg" value="${resultMap.ZHYXtysg}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
			</tr>
		</table>
		
		
		<!-- 2.继续医学教育情况 -->
		<table class="bs_tb" style="width: 100%; margin-top: 40px; position: relative;">
			<tr>
				<th colspan="7" class="theader">2.继续医学教育情况
					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
					<span style="float: right;padding-right: 10px">
					<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('cmEdu')"></img>&#12288;
					<img title="删除" style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('cmEdu');"></img></span>
					</c:if>
				</th>
			</tr>
			<tr>
				<td width="50px"></td>
				<td width="50px">序号</td>
				<td width="20%">项目名称</td>
				<td width="17%">项目类型</td>
				<td width="15%">承担工作类型</td>
				<td width="10%">承担人</td>
				<td width="26%">起止时间</td>
			</tr>
			<tbody id="cmEduTb">
			<c:if test="${not empty resultMap.cmEdu}">
				<c:forEach var="cmEdu" items="${resultMap.cmEdu}" varStatus="status">
				<tr>
		             <td width="50px" style="text-align: center;"><input name="cmEduIds" type="checkbox"/></td>
		             <td width="50px" style="text-align: center;" class="cmEduSerial">${status.count}</td>
		             <td><input type="text" name="cmEdu_projName" value="${cmEdu.objMap.cmEdu_projName}" class="inputText" style="width: 90%"/></td>
		             <td>
		             	<select name="cmEdu_projType" class="inputText" style="width: 99%" onchange="cmEduStatistics()">
		             		<option value="">请选择</option>
		             		<option value="GJJ" <c:if test="${cmEdu.objMap.cmEdu_projType eq 'GJJ'}">selected="selected"</c:if>>国家级继续医学教育项目</option>
		             		<option value="SJ" <c:if test="${cmEdu.objMap.cmEdu_projType eq 'SJ'}">selected="selected"</c:if>>省级继续医学教育项目</option>
		             	</select>
		             </td>
		             <td>
		             	<select name="cmEdu_workType" class="inputText" style="width: 90%" onchange="cmEduStatistics()">
		             		<option value="">请选择</option>
		             		<option value="projApplyUser" <c:if test="${cmEdu.objMap.cmEdu_workType eq 'projApplyUser'}">selected="selected"</c:if>>项目负责人</option>
		             		<option value="teacher" <c:if test="${cmEdu.objMap.cmEdu_workType eq 'teacher'}">selected="selected"</c:if>>授课教师</option>
		             	</select>
		             </td>
		             <td><input type="text" name="cmEdu_applyUser" value="${cmEdu.objMap.cmEdu_applyUser}"  class="inputText" style="width: 90%"/></td>
		             <td>
		             	<input class="inputText ctime" type="text" name="cmEdu_startTime" value="${cmEdu.objMap.cmEdu_startTime}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width: 40%;margin-right: 0px;"/>
		             	~<input class="inputText ctime" type="text" name="cmEdu_endTime" value="${cmEdu.objMap.cmEdu_endTime}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width: 40%;margin-right: 0px;"/>
		             </td>
				</tr>
			    </c:forEach>
	    	</c:if>
			</tbody>
		</table>
		
		<!-- 继续医学教育统计 -->
		<font style="font-size: 14px; font-weight:bold; ">&#12288;继续医学教育统计</font>
		<table id="cmEduStatistics" class="bs_tb" style="width: 100%; position: relative;">
			<tr>
				<td></td>
				<td>项目负责人</td>
				<td>授课教师</td>
			</tr>
			<tr>
				<td>国家级继续医学教育项目</td>
				<td><input type="text" name="GJJprojApplyUser" value="${resultMap.GJJprojApplyUser}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="GJJteacher" value="${resultMap.GJJteacher}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
			</tr>
			<tr>
				<td>省级继续医学教育项目</td>
				<td><input type="text" name="SJprojApplyUser" value="${resultMap.SJprojApplyUser}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="SJteacher" value="${resultMap.SJteacher}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
			</tr>
		</table>
		
		
		
		<!-- 3.国外进修-->
		<table class="bs_tb" style="width: 100%; margin-top: 40px; position: relative;">
			<tr>
				<th colspan="5" class="theader">3.国外进修
					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
					<span style="float: right;padding-right: 10px">
					<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('training')"></img>&#12288;
					<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('training');"></img></span>
					</c:if>
				</th>
			</tr>
			<tr>
				<td width="50px"></td>
				<td width="50px">序号</td>
				<td width="30%">国家</td>
				<td width="20%">进修人</td>
				<td width="40%">起止时间</td>
			</tr>
			<tbody id="trainingTb">
			<c:if test="${not empty resultMap.training}">
				<c:forEach var="training" items="${resultMap.training}" varStatus="status">
				<tr>
		             <td width="50px" style="text-align: center;"><input name="trainingIds" type="checkbox"/></td>
		             <td width="50px" style="text-align: center;" class="trainingSerial">${status.count}</td>
		             <td><input type="text" name="training_country" value="${training.objMap.training_country}" class="inputText" style="width: 90%"/></td>
		             <td><input type="text" name="training_user" value="${training.objMap.training_user}"  class="inputText" style="width: 90%"/></td>
		             <td>
		             	<input class="inputText ctime" type="text" name="training_startTime" value="${training.objMap.training_startTime}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width: 40%;margin-right: 0px;"/>
		             	~ <input class="inputText ctime" type="text" name="training_endTime" value="${training.objMap.training_endTime}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width: 40%;margin-right: 0px;"/>
		             </td>
				</tr>
			    </c:forEach>
	    	</c:if>
			</tbody>
		</table>
		
		<!-- 4.学术交流-->
		<table class="bs_tb" style="width: 100%; margin-top: 40px; position: relative;">
			<tr>
				<th colspan="8" class="theader">4.学术交流
					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
					<span style="float: right;padding-right: 10px">
					<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('academicCom')"></img>&#12288;
					<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('academicCom');"></img></span>
					</c:if>
				</th>
			</tr>
			<tr>
				<td width="50px"></td>
				<td width="50px">序号</td>
				<td width="20%">会议名称</td>
				<td width="10%">会议性质</td>
				<td width="20%">地点</td>
				<td width="20%">时间</td>
				<td width="10%">参会方式</td>
				<td width="10%">参会人</td>
			</tr>
			<tbody id="academicComTb">
			<c:if test="${not empty resultMap.academicCom}">
				<c:forEach var="academicCom" items="${resultMap.academicCom}" varStatus="status">
				<tr>
		             <td width="50px" style="text-align: center;"><input name="academicComIds" type="checkbox"/></td>
		             <td width="50px" style="text-align: center;" class="academicComSerial">${status.count}</td>
		             <td><input type="text" name="academicCom_meetingName" value="${academicCom.objMap.academicCom_meetingName}" class="inputText" style="width: 90%"/></td>
		             <td>
		             	<select name="academicCom_meetingType" class="inputText" style="width: 90%" onchange="academicComStatistics()">
		             		<option value="">请选择</option>
		             		<option value="gjhy" <c:if test="${academicCom.objMap.academicCom_meetingType eq 'gjhy'}">selected="selected"</c:if>>国际会议</option>
		             		<option value="qgxhy" <c:if test="${academicCom.objMap.academicCom_meetingType eq 'qgxhy'}">selected="selected"</c:if>>全国性会议</option>
		             		<option value="xsjz" <c:if test="${academicCom.objMap.academicCom_meetingType eq 'xsjz'}">selected="selected"</c:if>>学术讲座</option>
		             	</select>
		             </td>
		             <td><input type="text" name="academicCom_address" value="${academicCom.objMap.academicCom_address}"  class="inputText" style="width: 90%"/></td>
		             <td>
		             	<input class="inputText ctime" type="text" name="academicCom_time" value="${academicCom.objMap.academicCom_time}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width: 90%;"/>
		             </td>
		             <td>
		             	<select name="academicCom_way" class="inputText" style="width: 90%" onchange="academicComStatistics()">
		             		<option value="">请选择</option>
		             		<option value="DHZX" <c:if test="${academicCom.objMap.academicCom_way eq 'DHZX'}">selected="selected"</c:if>>大会主席</option>
		             		<option value="FHZX" <c:if test="${academicCom.objMap.academicCom_way eq 'FHZX'}">selected="selected"</c:if>>分会主席</option>
		             		<option value="DHFY" <c:if test="${academicCom.objMap.academicCom_way eq 'DHFY'}">selected="selected"</c:if>>大会发言</option>
		             		<option value="BB" <c:if test="${academicCom.objMap.academicCom_way eq 'BB'}">selected="selected"</c:if>>壁报</option>
		             		<option value="CH" <c:if test="${academicCom.objMap.academicCom_way eq 'CH'}">selected="selected"</c:if>>参会</option>
		             	</select>
		             </td>
		             <td><input type="text" name="academicCom_person" value="${academicCom.objMap.academicCom_person}"  class="inputText" style="width: 90%"/></td>
				</tr>
			    </c:forEach>
	    	</c:if>
			</tbody>
		</table>
		<!-- 学术交流统计 -->
		<font style="font-size: 14px; font-weight:bold; ">&#12288;学术交流统计</font>
		<table id="academicComStatistics" class="bs_tb" style="width: 100%; position: relative;">
			<tr>
				<td></td>
				<td>大会主席</td>
				<td>分会主席</td>
				<td>大会发言</td>
				<td>壁报</td>
				<td>参会</td>
			</tr>
			<tr>
				<td>国际会议</td>
				<td><input type="text" name="gjhyDHZX" value="${resultMap.gjhyDHZX}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="gjhyFHZX" value="${resultMap.gjhyFHZX}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="gjhyDHFY" value="${resultMap.gjhyDHFY}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="gjhyBB" value="${resultMap.gjhyBB}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="gjhyCH" value="${resultMap.gjhyCH}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
			</tr>
			<tr>
				<td>全国性会议</td>
				<td><input type="text" name="qgxhyDHZX" value="${resultMap.qgxhyDHZX}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="qgxhyFHZX" value="${resultMap.qgxhyFHZX}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="qgxhyDHFY" value="${resultMap.qgxhyDHFY}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="qgxhyBB" value="${resultMap.qgxhyBB}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="qgxhyCH" value="${resultMap.qgxhyCH}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
			</tr>
			<tr>
				<td>学术讲座</td>
				<td><input type="text" name="xsjzDHZX" value="${resultMap.xsjzDHZX}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="xsjzFHZX" value="${resultMap.xsjzFHZX}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="xsjzDHFY" value="${resultMap.xsjzDHFY}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="xsjzBB" value="${resultMap.xsjzBB}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="xsjzCH" value="${resultMap.xsjzCH}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
			</tr>
		</table>
		
		<!-- 5.经费信息 -->
		<table class="basic" style="width: 100%;margin-top: 40px; position: relative;">
			<tr>
				<th colspan="4" style="text-align: left;padding-left: 15px;">5.经费信息</th>
			</tr>
			<tr>
				<td style="text-align: right;">上级主管部门配套经费（万元）：</td>
				<td><input type="text" name="competentDeptFund" value="${resultMap.competentDeptFund}" class="validate[custom[number]] inputText" style="width: 90%"/></td>
				<td style="text-align: right;">本单位配套经费（万元）：</td>
				<td><input type="text" name="matingFund" value="${resultMap.matingFund}" class="validate[custom[number]] inputText" style="width: 90%"/></td>
			</tr>
		</table>
		
		<!-- 6.毕业的研究生人数 -->
		<table class="basic" style="width: 100%;margin-top: 40px; position: relative;">
			<tr>
				<th colspan="6" style="text-align: left;padding-left: 15px;">6.毕业的研究生人数</th>
			</tr>
			<tr>
				<td style="text-align: right;">博士后出站人数：</td>
				<td><input type="text" name="postDoctoralNum" value="${resultMap.postDoctoralNum}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td style="text-align: right;">博士生：</td>
				<td><input type="text" name="doctoralNum" value="${resultMap.doctoralNum}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td style="text-align: right;">硕士生：</td>
				<td><input type="text" name="postgraduateNum" value="${resultMap.postgraduateNum}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
			</tr>
		</table>
		
		</form>
		
	<!-- -----------------------------------模板------------------------------------------------------------ -->	
	<div style="display: none">
		<!-- 1.杂志编委模板 -->
		<table class="bs_tb" id="magazineTemplate" style="width: 100%">
        <tr>
             <td width="50px" style="text-align: center;"><input name="magazineIds" type="checkbox"/></td>
             <td width="50px" style="text-align: center;" class="magazineSerial"></td>
             <td><input type="text" name="magazine_name" class="inputText" style="width: 90%"/></td>
             <td>
             	<select name="magazine_type"  class="inputText" style="width: 90%" onchange="magazineStatistics()">
             		<option value="">请选择</option>
             		<option value="SCI">SCI收录期刊</option>
             		<option value="EI">EI收录期刊</option>
             		<option value="ISTP">ISTP收录期刊</option>
             		<option value="GW">国外期刊</option>
             		<option value="GJJ">国家级学报</option>
             		<option value="ZHYX">中华医学系列杂志</option>
             	</select>
             </td>
             <td>
             	<select name="magazine_post"  class="inputText" style="width: 90%" onchange="magazineStatistics()">
             		<option value="">请选择</option>
             		<option value="zb" >主编</option>
             		<option value="fzb">副主编</option>
             		<option value="cwbj">常务编辑</option>
             		<option value="bw">编委</option>
             		<option value="tysg">特约审稿</option>
             	</select>
             </td>
             <td><input type="text" name="magazine_editorialBoardName" class="inputText" style="width: 90%"/></td>
		</tr>
		</table>
		
		
		<!-- 2.继续医学教育模板 -->
		<table class="bs_tb" id="cmEduTemplate" style="width: 100%">
        <tr>
             <td width="50px" style="text-align: center;"><input name="cmEduIds" type="checkbox"/></td>
             <td width="50px" style="text-align: center;" class="cmEduSerial"></td>
             <td><input type="text" name="cmEdu_projName"  class="inputText" style="width: 90%"/></td>
             <td>
             	<select name="cmEdu_projType"  class="inputText" style="width: 99%" onchange="cmEduStatistics()">
             		<option value="">请选择</option>
             		<option value="GJJ">国家级继续医学教育项目</option>
             		<option value="SJ">省级继续医学教育项目</option>
             	</select>
             </td>
             <td>
             	<select name="cmEdu_workType"  class="inputText" style="width: 90%" onchange="cmEduStatistics()">
             		<option value="">请选择</option>
             		<option value="projApplyUser">项目负责人</option>
             		<option value="teacher">授课教师</option>
             	</select>
             </td>
             <td><input type="text" name="cmEdu_applyUser"  class="inputText" style="width: 90%"/></td>
             <td>
             	<input class="inputText ctime" type="text" name="cmEdu_startTime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width: 40%;margin-right: 0px;"/>
             	~<input class="inputText ctime" type="text" name="cmEdu_endTime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width: 40%;margin-right: 0px;"/>
             </td>
		</tr>
		</table>
		
		<!-- 3.国外进修模板 -->
		<table class="bs_tb" id="trainingTemplate" style="width: 100%">
        <tr>
            <td width="50px" style="text-align: center;"><input name="trainingIds" type="checkbox"/></td>
            <td width="50px" style="text-align: center;" class="trainingSerial"></td>
            <td><input type="text" name="training_country" class="inputText" style="width: 90%"/></td>
            <td><input type="text" name="training_user" class="inputText" style="width: 90%"/></td>
            <td>
            	<input class="inputText ctime" type="text" name="training_startTime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width: 40%;margin-right: 0px;"/>
            	~<input class="inputText ctime" type="text" name="training_endTime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width: 40%;margin-right: 0px;"/>
            </td>
		</tr>
		</table>
		
		<!-- 4.学术交流模板 -->
		<table class="bs_tb" id="academicComTemplate" style="width: 100%">
        <tr>
             <td width="50px" style="text-align: center;"><input name="academicComIds" type="checkbox"/></td>
             <td width="50px" style="text-align: center;" class="academicComSerial"></td>
             <td><input type="text" name="academicCom_meetingName" class="inputText" style="width: 90%"/></td>
             <td>
             	<select name="academicCom_meetingType" class="inputText" style="width: 90%" onchange="academicComStatistics()">
             		<option value="">请选择</option>
             		<option value="gjhy">国际会议</option>
             		<option value="qgxhy">全国性会议</option>
             		<option value="xsjz">学术讲座</option>
             	</select>
             </td>
             <td><input type="text" name="academicCom_address" class="inputText" style="width: 90%"/></td>
             <td>
             	<input class="inputText ctime" type="text" name="academicCom_time" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width: 90%;"/>
             </td>
             <td>
             	<select name="academicCom_way" class="inputText" style="width: 90%" onchange="academicComStatistics()">
             		<option value="">请选择</option>
             		<option value="DHZX" >大会主席</option>
             		<option value="FHZX" >分会主席</option>
             		<option value="DHFY" >大会发言</option>
             		<option value="BB">壁报</option>
             		<option value="CH">参会</option>
             	</select>
             </td>
             <td><input type="text" name="academicCom_person" value="${academicCom.objMap.academicCom_person}"  class="inputText" style="width: 90%"/></td>
		</tr>
		</table>
	</div>
    <div class="button" style="width: 100%; <c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none</c:if>">
	   <a href="javascript:void(0)" target="_self" class="search" onclick="nextOpt('step5')">上一步</a>
	   <a href="javascript:void(0)" target="_self" class="search" onclick="nextOpt('finish')">完成</a>
    </div>

		