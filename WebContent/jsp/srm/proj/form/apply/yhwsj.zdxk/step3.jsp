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
		<input type="hidden" id="pageName" name="pageName" value="step3" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
		
		<font style="font-size: 14px; font-weight:bold;color: #333;">三、科研业绩</font>
		<table width="100%" class="bs_tb" style="margin-top: 20px;">
			<tr>
				<th colspan="12" class="theader">近三年围绕主攻方向承担项目
					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
						<span style="float: right;padding-right: 10px">
						<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('proj')"></img>&#12288;
						<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('proj');"></img></span>
					</c:if>
				</th>
			</tr> 
		    <tr>
		       <td width="20px"></td>
		       <td width="40px">序号</td>
		       <td width="20%">项目名称</td>
		       <td width="10%">主攻方向</td>
		       <td width="10%">课题来源</td>
		       <td width="7%">完成人</td>
		       <td width="4%">排名</td>
		       <td width="6%">财政拨款<br/>（万元）</td>
		       <td width="10%">立项时间</td>
		       <td width="10%">最具代表性</td>
		       <td width="14%">所在单位</td>
		       <td width="4%">单位<br/>排名</td>
		    </tr>
		    <tbody id="projTb">
		    <c:forEach items="${resultMap.assumeProj}" var="proj" varStatus="status">
		    <tr>
				<td width="20px" style="text-align: center;"><input name="projIds" type="checkbox"/></td>
				<td width="40px" style="text-align: center;" class="projSerial">${status.count}</td>
				<td><input type="text" name="assumeProj_projName" value="${proj.objMap.assumeProj_projName}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="assumeProj_attackDirection" value="${proj.objMap.assumeProj_attackDirection}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="assumeProj_subjectSource" value="${proj.objMap.assumeProj_subjectSource}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="assumeProj_accomplishMan" value="${proj.objMap.assumeProj_accomplishMan}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="assumeProj_ranking" value="${proj.objMap.assumeProj_ranking}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="assumeProj_appropriation" value="${proj.objMap.assumeProj_appropriation}" class="validate[custom[number]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="assumeProj_approvalTime" value="${proj.objMap.assumeProj_approvalTime}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputText ctime" style="width: 90%;text-align: left;" readonly="readonly"/></td>
				<td><input type="text" name="assumeProj_representative" value="${proj.objMap.assumeProj_representative}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="assumeProj_org" value="${proj.objMap.assumeProj_org}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="assumeProj_orgRanking" value="${proj.objMap.assumeProj_orgRanking}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
			</tr>
		    </c:forEach>  
		    </tbody>
		 </table>
		 
		 
		<!--  近三年围绕主攻方向获得科技成果奖励 -->
		 <table width="100%" class="bs_tb" style="margin-top: 20px;">
			<tr>
				<th colspan="12" class="theader">近三年围绕主攻方向获得科技成果奖励
					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
						<span style="float: right;padding-right: 10px">
						<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('achi')"></img>&#12288;
						<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('achi');"></img></span>
					</c:if>
				</th>
			</tr> 
		    <tr>
		       <td width="20px"></td>
		       <td width="40px">序号</td>
		       <td width="20%">成果名称</td>
		       <td width="11%">主攻方向</td>
		       <td width="12%">授奖单位</td>
		       <td width="7%">奖励等级</td>
		       <td width="7%">完成人</td>
		       <td width="4%">排名</td>
		       <td width="6%">获奖年份</td>
		       <td width="10%">最具代表性</td>
		       <td width="14%">所在单位</td>
		       <td width="4%">单位<br/>排名</td>
		    </tr>
		    <tbody id="achiTb">
		    <c:forEach items="${resultMap.achievement}" var="achi" varStatus="status">
		    <tr>
				<td width="20px" style="text-align: center;"><input name="achiIds" type="checkbox"/></td>
				<td width="40px" style="text-align: center;" class="achiSerial">${status.count}</td>
				<td><input type="text" name="achievement_name" value="${achi.objMap.achievement_name}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="achievement_attackDirection" value="${achi.objMap.achievement_attackDirection}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="achievement_awardOrg" value="${achi.objMap.achievement_awardOrg}" class="inputText" style="width: 90%"/></td>
				<td>
					<select name="achievement_grade" class="inputText" style="width: 90%;"  >
						<option value="">请选择</option>
						<c:forEach var="dict" items="${dictTypeEnumPrizedLevelList}">
						<option value="${dict.dictName}" <c:if test="${achi.objMap.achievement_grade==dict.dictName}">selected="selected"</c:if>>${dict.dictName}</option>
						</c:forEach>
				    </select>
				</td>
				<td><input type="text" name="achievement_accomplishMan" value="${achi.objMap.achievement_accomplishMan}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="achievement_ranking" value="${achi.objMap.achievement_ranking}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="achievement_awardsYear" value="${achi.objMap.achievement_awardsYear}" onclick="WdatePicker({dateFmt:'yyyy'})" class="inputText ctime" style="width: 90%;text-align: left;" readonly="readonly"/></td>
				<td><input type="text" name="achievement_representative" value="${achi.objMap.achievement_representative}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="achievement_org" value="${achi.objMap.achievement_org}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="achievement_orgRanking" value="${achi.objMap.achievement_orgRanking}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
			</tr>
		    </c:forEach>  
		    </tbody>
		 </table>
		 
		 <!--  近三年围绕主攻方向发表学术论文 -->
		 <table width="100%" class="bs_tb" style="margin-top: 20px;">
			<tr>
				<th colspan="12" class="theader">近三年围绕主攻方向发表学术论文
					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
						<span style="float: right;padding-right: 10px">
						<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('thes')"></img>&#12288;
						<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('thes');"></img></span>
					</c:if>
				</th>
			</tr> 
		    <tr>
		       <td width="20px"></td>
		       <td width="40px">序号</td>
		       <td width="20%">论文名称</td>
		       <td width="11%">主攻方向</td>
		       <td width="12%">期刊名称</td>
		       <td width="7%">期刊级别</td>
		       <td width="7%">完成人</td>
		       <td width="4%">排名</td>
		       <td width="10%">发表日期</td>
		       <td width="10%">最具代表性</td>
		       <td width="14%">所在单位</td>
		    </tr>
		    <tbody id="thesTb">
		    <c:forEach items="${resultMap.thesis}" var="thes" varStatus="status">
		    <tr>
				<td width="20px" style="text-align: center;"><input name="thesIds" type="checkbox"/></td>
				<td width="40px" style="text-align: center;" class="thesSerial">${status.count}</td>
				<td><input type="text" name="thesis_name" value="${thes.objMap.thesis_name}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="thesis_attackDirection" value="${thes.objMap.thesis_attackDirection}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="thesis_periodicalName" value="${thes.objMap.thesis_periodicalName}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="thesis_periodicalGrade" value="${thes.objMap.thesis_periodicalGrade}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="thesis_accomplishMan" value="${thes.objMap.thesis_accomplishMan}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="thesis_ranking" value="${thes.objMap.thesis_ranking}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="thesis_publishDate" value="${thes.objMap.thesis_publishDate}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputText ctime" style="width: 90%;text-align: left;" readonly="readonly"/></td>
				<td><input type="text" name="thesis_representative" value="${thes.objMap.thesis_representative}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="thesis_org" value="${thes.objMap.thesis_org}" class="inputText" style="width: 90%"/></td>
			</tr>
		    </c:forEach>  
		    </tbody>
		 </table>
		 
		 <!-- 三年以来围绕主攻方向发明专利 -->
		 <table width="100%" class="bs_tb" style="margin-top: 20px;">
			<tr>
				<th colspan="12" class="theader">近三年围绕主攻方向发明专利
					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
						<span style="float: right;padding-right: 10px">
						<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('pate')"></img>&#12288;
						<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('pate');"></img></span>
					</c:if>
				</th>
			</tr> 
		    <tr>
		       <td width="20px"></td>
		       <td width="40px">序号</td>
		       <td width="30%">专利名称</td>
		       <td width="25%">授权或申请号</td>
		       <td width="10%">专利类型</td>
		       <td width="10%">专利范围</td>
		       <td width="20%">所在单位</td>
		    </tr>
		    <tbody id="pateTb">
		    <c:forEach items="${resultMap.patent}" var="pate" varStatus="status">
		    <tr>
				<td width="20px" style="text-align: center;"><input name="pateIds" type="checkbox"/></td>
				<td width="40px" style="text-align: center;" class="pateSerial">${status.count}</td>
				<td><input type="text" name="patent_name" value="${pate.objMap.patent_name}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="patent_applyNo" value="${pate.objMap.patent_applyNo}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="patent_type" value="${pate.objMap.patent_type}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="patent_scope" value="${pate.objMap.patent_scope}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="patent_org" value="${pate.objMap.patent_org}" class="inputText" style="width: 90%"/></td>
			</tr>
		    </c:forEach>  
		    </tbody>
		 </table>
		 
		<!--  三年以来围绕主攻方向发表专著 -->	
		<table width="100%" class="bs_tb" style="margin-top: 20px;">
			<tr>
				<th colspan="12" class="theader">三年以来围绕主攻方向发表专著
					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
						<span style="float: right;padding-right: 10px">
						<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('mono')"></img>&#12288;
						<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('mono');"></img></span>
					</c:if>
				</th>
			</tr> 
		    <tr>
		       <td width="20px"></td>
		       <td width="40px">序号</td>
		       <td width="25%">专著名称</td>
		       <td width="10%">排位</td>
		       <td width="20%">出版社名称</td>
		       <td width="10%">出版社级别</td>
		       <td width="10%">出版日期</td>
		       <td width="20%">所在单位</td>
		    </tr>
		    <tbody id="monoTb">
		    <c:forEach items="${resultMap.monograph}" var="mono" varStatus="status">
		    <tr>
				<td width="20px" style="text-align: center;"><input name="monoIds" type="checkbox"/></td>
				<td width="40px" style="text-align: center;" class="monoSerial">${status.count}</td>
				<td><input type="text" name="monograph_name" value="${mono.objMap.monograph_name}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="monograph_ranking" value="${mono.objMap.monograph_ranking}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="monograph_pressName" value="${mono.objMap.monograph_pressName}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="monograph_pressGrade" value="${mono.objMap.monograph_pressGrade}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="monograph_pressDate" value="${mono.objMap.monograph_pressDate}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputText ctime" style="width: 90%;text-align: left;" readonly="readonly"/></td>
				<td><input type="text" name="monograph_org" value="${mono.objMap.monograph_org}" class="inputText" style="width: 90%"/></td>
			</tr>
		    </c:forEach>  
		    </tbody>
		 </table>
		 
		 <!-- 近三年来学术交流情况	主办会议名称	时间	范围	所在单位 -->
		 <table width="100%" class="bs_tb" style="margin-top: 20px; border-bottom-style: none;">
			<tr>
				<th colspan="12" class="theader">近三年来学术交流情况
					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
						<span style="float: right;padding-right: 10px">
						<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('comm')"></img>&#12288;
						<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('comm');"></img></span>
					</c:if>
				</th>
			</tr> 
		    <tr>
		       <td width="20px"></td>
		       <td width="40px">序号</td>
		       <td width="40%">主办会议名称</td>
		       <td width="10%">时间</td>
		       <td width="10%">范围</td>
		       <td width="35%">所在单位</td>
		    </tr>
		    <tbody id="commTb">
		    <c:forEach items="${resultMap.communicate}" var="comm" varStatus="status">
		    <tr>
				<td width="20px" style="text-align: center;"><input name="commIds" type="checkbox"/></td>
				<td width="40px" style="text-align: center;" class="commSerial">${status.count}</td>
				<td><input type="text" name="communicate_name" value="${comm.objMap.communicate_name}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="communicate_date" value="${comm.objMap.communicate_date}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputText ctime" style="width: 90%;text-align: left;" readonly="readonly"/></td>
				<td><input type="text" name="communicate_scope" value="${comm.objMap.communicate_scope}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="communicate_org" value="${comm.objMap.communicate_org}" class="inputText" style="width: 90%"/></td>
			</tr>
		    </c:forEach>  
		    </tbody>
		 </table>
		 
		 <table width="100%" class="bs_tb" style="margin-top: 20px;">
		 	<tr>
           		<td style="text-align: right;">参加省级以上会议：</td>
				<td style="text-align: left;padding-left: 2%;"><input type="text" name="cjsjyshy" value="${resultMap.cjsjyshy}" class="inputText" style="width: 100px"/>人</td>
           		<td style="text-align: right;">三甲医院进修：</td>
				<td style="text-align: left;padding-left: 2%;"><input type="text" name="sjyyjx" value="${resultMap.sjyyjx}" class="inputText" style="width: 100px"/>人</td>
			</tr>
		    <tr>
           		<td style="text-align: right;">接受省外进修：</td>
				<td style="text-align: left;padding-left: 2%;"><input type="text" name="jsswjx" value="${resultMap.jsswjx}" class="inputText" style="width: 100px"/>人</td>
           		<td style="text-align: right;">接受省内进修：</td>
				<td style="text-align: left;padding-left: 2%;"><input type="text" name="jssnjx" value="${resultMap.jssnjx}" class="inputText" style="width: 100px"/>人</td>
			</tr>
		</table>
		
		<table width="100%" class="bs_tb" style="margin-top: 20px;">
			<tr>
				<th colspan="12" class="theader">三年来研究生培养情况</th>
			</tr> 
		    <tr>
           		<td style="text-align: right;">毕业硕士生：</td>
				<td style="text-align: left;padding-left: 2%;"><input type="text" name="graduatePostgraduate" value="${resultMap.graduatePostgraduate}" class="validate[custom[integer]] inputText" style="width: 100px"/>人</td>
           		<td style="text-align: right;">在读硕士生：</td>
				<td style="text-align: left;padding-left: 2%;"><input type="text" name="studyingPostgraduate" value="${resultMap.studyingPostgraduate}" class="validate[custom[integer]] inputText" style="width: 100px"/>人</td>
			</tr>
			<tr>
           		<td style="text-align: right;">毕业博士生：</td>
				<td style="text-align: left;padding-left: 2%;"><input type="text" name="graduateDoctor" value="${resultMap.graduateDoctor}" class="validate[custom[integer]] inputText" style="width: 100px"/>人</td>
           		<td style="text-align: right;">在读博士生：</td>
				<td style="text-align: left;padding-left: 2%;"><input type="text" name="studyingDoctor" value="${resultMap.studyingDoctor}" class="validate[custom[integer]] inputText" style="width: 100px"/>人</td>
			</tr>
		 </table>
		 
		 <!--  学术组织现任职情况 -->	
		<table width="100%" class="bs_tb" style="margin-top: 20px;">
			<tr>
				<th colspan="12" class="theader">学术组织现任职情况
					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
						<span style="float: right;padding-right: 10px">
						<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('acad')"></img>&#12288;
						<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('acad');"></img></span>
					</c:if>
				</th>
			</tr> 
		    <tr>
		       <td width="20px"></td>
		       <td width="40px">序号</td>
		       <td width="10%">姓名</td>
		       <td width="25%">学术组织名称</td>
		       <td width="10%">学术组织类别</td>
		       <td width="20%">现任职务</td>
		       <td width="10%">最具代表性</td>
		       <td width="20%">所在单位</td>
		    </tr>
		    <tbody id="acadTb">
		    <c:forEach items="${resultMap.academicBeInOffice}" var="acad" varStatus="status">
		    <tr>
				<td width="20px" style="text-align: center;"><input name="acadIds" type="checkbox"/></td>
				<td width="40px" style="text-align: center;" class="acadSerial">${status.count}</td>
				<td><input type="text" name="academicBeInOffice_name" value="${acad.objMap.academicBeInOffice_name}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="academicBeInOffice_orgName" value="${acad.objMap.academicBeInOffice_orgName}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="academicBeInOffice_orgType" value="${acad.objMap.academicBeInOffice_orgType}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="academicBeInOffice_post" value="${acad.objMap.academicBeInOffice_post}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="academicBeInOffice_representative" value="${acad.objMap.academicBeInOffice_representative}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="academicBeInOffice_org" value="${acad.objMap.academicBeInOffice_org}" class="inputText" style="width: 90%"/></td>
			</tr>
		    </c:forEach>  
		    </tbody>
		 </table>
		 
		<!-- 期刊杂志现任职情况 -->
		<table width="100%" class="bs_tb" style="margin-top: 20px;">
			<tr>
				<th colspan="12" class="theader">期刊杂志现任职情况
					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
						<span style="float: right;padding-right: 10px">
						<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('peri')"></img>&#12288;
						<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('peri');"></img></span>
					</c:if>
				</th>
			</tr> 
		    <tr>
		       <td width="20px"></td>
		       <td width="40px">序号</td>
		       <td width="10%">姓名</td>
		       <td width="25%">期刊名称</td>
		       <td width="10%">期刊级别</td>
		       <td width="20%">现任职务</td>
		       <td width="10%">最具代表性</td>
		       <td width="20%">所在单位</td>
		    </tr>
		    <tbody id="periTb">
		    <c:forEach items="${resultMap.periodicalBeInOffice}" var="peri" varStatus="status">
		    <tr>
				<td width="20px" style="text-align: center;"><input name="periIds" type="checkbox"/></td>
				<td width="40px" style="text-align: center;" class="periSerial">${status.count}</td>
				<td><input type="text" name="periodicalBeInOffice_name" value="${peri.objMap.periodicalBeInOffice_name}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="periodicalBeInOffice_periodicalName" value="${peri.objMap.periodicalBeInOffice_periodicalName}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="periodicalBeInOffice_periodicalGrade" value="${peri.objMap.periodicalBeInOffice_periodicalGrade}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="periodicalBeInOffice_post" value="${peri.objMap.periodicalBeInOffice_post}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="periodicalBeInOffice_representative" value="${peri.objMap.periodicalBeInOffice_representative}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="periodicalBeInOffice_org" value="${peri.objMap.periodicalBeInOffice_org}" class="inputText" style="width: 90%"/></td>
			</tr>
		    </c:forEach>  
		    </tbody>
		 </table>
		 
 		<!-- 代表性新技术 -->
		<table width="100%" class="bs_tb" style="margin-top: 20px;">
			<tr>
				<th colspan="12" class="theader">代表性新技术
					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
						<span style="float: right;padding-right: 10px">
						<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('tech')"></img>&#12288;
						<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('tech');"></img></span>
					</c:if>
				</th>
			</tr> 
		    <tr>
		       <td width="20px"></td>
		       <td width="40px">序号</td>
		       <td width="20%">技术名称</td>
		       <td width="35%">技术简要内容（300字以内）</td>
		       <td width="20%">应用范围</td>
		       <td width="20%">所在单位</td>
		    </tr>
		    <tbody id="techTb">
		    <c:forEach items="${resultMap.newTechnique}" var="tech" varStatus="status">
		    <tr>
				<td width="20px" style="text-align: center;"><input name="techIds" type="checkbox"/></td>
				<td width="40px" style="text-align: center;" class="techSerial">${status.count}</td>
				<td><input type="text" name="newTechnique_techniqueName" value="${tech.objMap.newTechnique_techniqueName}" class="inputText" style="width: 90%"/></td>
				<td style="text-align:left;">
		     		 <textarea placeholder="" class="validate[maxSize[300]] xltxtarea"  name="newTechnique_content">${tech.objMap.newTechnique_content}</textarea>
				</td>
				<td><input type="text" name="newTechnique_appliedRange" value="${tech.objMap.newTechnique_appliedRange}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="newTechnique_org" value="${tech.objMap.newTechnique_org}" class="inputText" style="width: 90%"/></td>
			</tr>
		    </c:forEach>  
		    </tbody>
		 </table>
		 
		 
		 <table width="100%" class="bs_tb" style="margin-top: 20px;">
			<tr>
           		<td width="15%" style="text-align: right;">近十年内标志性成果简述（500字以内）：</td>
		     	<td style="text-align:left;">
		     		<textarea placeholder="近十年内标志性成果简述（500字以内）"  class="validate[maxSize[1000]] xltxtarea" name="landmarkAchievement">${resultMap.landmarkAchievement}</textarea>
		     	</td>
		    </tr>
		 </table>
		 
	</form>
	
	
    <c:if test="${param.view!=GlobalConstant.FLAG_Y}">
		<div align="center" style="margin-top: 10px">
		    <input id="prev" type="button" onclick="nextOpt('step2')" class="search" value="上一步"/>
     	    <input id="nxt" type="button" onclick="nextOpt('step4')" class="search" value="下一步"/>
       	</div>
    </c:if>
   
    <div style="display: none;">
   		<!-- 承担项目 模板 -->
   		<table id="projTemplate" width="100%" class="bs_tb" style="margin-top: 20px;">
   			<tr>
				<td width="20px" style="text-align: center;"><input name="projIds" type="checkbox"/></td>
				<td width="40px" style="text-align: center;" class="projSerial"></td>
				<td><input type="text" name="assumeProj_projName" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="assumeProj_attackDirection" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="assumeProj_subjectSource" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="assumeProj_accomplishMan" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="assumeProj_ranking" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="assumeProj_appropriation" class="validate[custom[number]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="assumeProj_approvalTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputText ctime" style="width: 90%;text-align: left;" readonly="readonly"/></td>
				<td><input type="text" name="assumeProj_representative" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="assumeProj_org" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="assumeProj_orgRanking" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
		    </tr>
   		</table>
   		
   		<!-- 科技成果奖励 模板 -->
   		<table id="achiTemplate" width="100%" class="bs_tb" style="margin-top: 20px;">
   			<tr>
				<td width="20px" style="text-align: center;"><input name="achiIds" type="checkbox"/></td>
				<td width="40px" style="text-align: center;" class="achiSerial"></td>
				<td><input type="text" name="achievement_name" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="achievement_attackDirection" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="achievement_awardOrg" class="inputText" style="width: 90%"/></td>
				<td>
					<select name="achievement_grade" class="inputText" style="width: 90%;"  >
						<option value="">请选择</option>
						<c:forEach var="dict" items="${dictTypeEnumPrizedLevelList}">
						<option value="${dict.dictName}">${dict.dictName}</option>
						</c:forEach>
				    </select>
				</td>
				<td><input type="text" name="achievement_accomplishMan" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="achievement_ranking" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="achievement_awardsYear" onclick="WdatePicker({dateFmt:'yyyy'})" class="inputText ctime" style="width: 90%;text-align: left;" readonly="readonly"/></td>
				<td><input type="text" name="achievement_representative" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="achievement_org" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="achievement_orgRanking" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
			</tr>
   		</table>
   		
   		<!-- 发表学术论文 模板 -->
   		<table id="thesTemplate" width="100%" class="bs_tb" style="margin-top: 20px;">
   			<tr>
				<td width="20px" style="text-align: center;"><input name="thesIds" type="checkbox"/></td>
				<td width="40px" style="text-align: center;" class="thesSerial"></td>
				<td><input type="text" name="thesis_name" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="thesis_attackDirection" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="thesis_periodicalName" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="thesis_periodicalGrade" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="thesis_accomplishMan" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="thesis_ranking" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="thesis_publishDate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputText ctime" style="width: 90%;text-align: left;" readonly="readonly"/></td>
				<td><input type="text" name="thesis_representative" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="thesis_org" class="inputText" style="width: 90%"/></td>
			</tr>
   		</table>
   		
   		<!-- 发明专利 模板 -->
   		<table id="pateTemplate" width="100%" class="bs_tb" style="margin-top: 20px;">
 			<tr>
				<td width="20px" style="text-align: center;"><input name="pateIds" type="checkbox"/></td>
				<td width="40px" style="text-align: center;" class="pateSerial"></td>
				<td><input type="text" name="patent_name" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="patent_applyNo" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="patent_type" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="patent_scope" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="patent_org" class="inputText" style="width: 90%"/></td>
			</tr>
   		</table>
   		
   		<!-- 发表专著 模板 -->
   		<table id="monoTemplate" width="100%" class="bs_tb" style="margin-top: 20px;">
 			<tr>
				<td width="20px" style="text-align: center;"><input name="monoIds" type="checkbox"/></td>
				<td width="40px" style="text-align: center;" class="monoSerial"></td>
				<td><input type="text" name="monograph_name" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="monograph_ranking" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="monograph_pressName" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="monograph_pressGrade" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="monograph_pressDate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputText ctime" style="width: 90%;text-align: left;" readonly="readonly"/></td>
				<td><input type="text" name="monograph_org" class="inputText" style="width: 90%"/></td>
			</tr>
   		</table>
   		
   		<!-- 学术交流  模板 -->
   		<table id="commTemplate" width="100%" class="bs_tb" style="margin-top: 20px;">
 			<tr>
				<td width="20px" style="text-align: center;"><input name="commIds" type="checkbox"/></td>
				<td width="40px" style="text-align: center;" class="commSerial"></td>
				<td><input type="text" name="communicate_name" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="communicate_date" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputText ctime" style="width: 90%;text-align: left;" readonly="readonly"/></td>
				<td><input type="text" name="communicate_scope" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="communicate_org" class="inputText" style="width: 90%"/></td>
			</tr>
		</table>	
		
   		<!-- 学术组织现任职  模板 -->
   		<table id="acadTemplate" width="100%" class="bs_tb" style="margin-top: 20px;">
 			<tr>
				<td width="20px" style="text-align: center;"><input name="acadIds" type="checkbox"/></td>
				<td width="40px" style="text-align: center;" class="acadSerial"></td>
				<td><input type="text" name="academicBeInOffice_name" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="academicBeInOffice_orgName" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="academicBeInOffice_orgType" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="academicBeInOffice_post" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="academicBeInOffice_representative" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="academicBeInOffice_org" class="inputText" style="width: 90%"/></td>
			</tr>
   		</table>
   		
   		<!-- 期刊杂志现任职  模板 -->
   		<table id="periTemplate" width="100%" class="bs_tb" style="margin-top: 20px;">
 			<tr>
				<td width="20px" style="text-align: center;"><input name="periIds" type="checkbox"/></td>
				<td width="40px" style="text-align: center;" class="periSerial"></td>
				<td><input type="text" name="periodicalBeInOffice_name" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="periodicalBeInOffice_periodicalName" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="periodicalBeInOffice_periodicalGrade" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="periodicalBeInOffice_post" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="periodicalBeInOffice_representative" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="periodicalBeInOffice_org" class="inputText" style="width: 90%"/></td>
			</tr>
   		</table>
   		
   		
   		<!-- 代表性新技术 -->
   		<table id="techTemplate" width="100%" class="bs_tb" style="margin-top: 20px;">
 			<tr>
				<td width="20px" style="text-align: center;"><input name="techIds" type="checkbox"/></td>
				<td width="40px" style="text-align: center;" class="techSerial"></td>
				<td><input type="text" name="newTechnique_techniqueName" class="inputText" style="width: 90%"/></td>
				<td style="text-align:left;">
		     		 <textarea placeholder="" class="validate[maxSize[300]] xltxtarea"  name="newTechnique_content"></textarea>
				</td>
				<td><input type="text" name="newTechnique_appliedRange" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="newTechnique_org" class="inputText" style="width: 90%"/></td>
			</tr>
   		</table>
    </div>

		