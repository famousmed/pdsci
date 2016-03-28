<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:if test="${param.view!=GlobalConstant.FLAG_Y}">
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
	
</script>
</c:if>

	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post"
		id="projForm" style="position: relative;">
		<input type="hidden" id="pageName" name="pageName" value="step2" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
		
		<font style="font-size: 14px; font-weight:bold;color: #333;">二、主要工作简历</font>
		
		<!-- 二、主要工作简历 -->
		<table width="100%" class="bs_tb" style="margin-top: 20px;">
			<tr>
				<th colspan="12" class="theader">二、主要工作简历
					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
						<span style="float: right;padding-right: 10px">
						<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('work')"></img>&#12288;
						<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('work');"></img></span>
					</c:if>
				</th>
			</tr> 
		    <tr>
		       <td width="20px"></td>
		       <td width="40px">序号</td>
		       <td width="10%">起始年月</td>
		       <td width="10%">终止年月</td>
		       <td width="35%">工作单位</td>
		       <td width="25%">从事何工作</td>
		       <td width="15%">备  注</td>
		    </tr>
		    <tbody id="workTb">
		    <c:forEach items="${resultMap.workResume}" var="work" varStatus="status">
		    <tr>
				<td width="20px" style="text-align: center;"><input name="workIds" type="checkbox"/></td>
				<td width="40px" style="text-align: center;" class="workSerial">${status.count}</td>
				<td><input type="text" name="workResume_startDate" value="${work.objMap.workResume_startDate}" onclick="WdatePicker({dateFmt:'yyyy-MM'})" class="inputText ctime" style="width: 90%;" readonly="readonly"/></td>
				<td><input type="text" name="workResume_endDate" value="${work.objMap.workResume_endDate}" onclick="WdatePicker({dateFmt:'yyyy-MM'})" class="inputText ctime" style="width: 90%;" readonly="readonly"/></td>
				<td><input type="text" name="workResume_orgName" value="${work.objMap.workResume_orgName}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="workResume_work" value="${work.objMap.workResume_work}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="workResume_remark" value="${work.objMap.workResume_remark}" class="inputText" style="width: 90%"/></td>
			</tr>
		    </c:forEach>  
		    </tbody>
		 </table>
		 
        
        <!-- 三、学术组织任职情况 -->
        <table width="100%" class="bs_tb" style="margin-top: 20px;">
			<tr>
				<th colspan="12" class="theader">三、学术组织任职情况
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
		       <td width="35%">学术组织名称</td>
		       <td width="30%">所任职务</td>
		       <td width="30%">备  注</td>
		    </tr>
		    <tbody id="acadTb">
		    <c:forEach items="${resultMap.academic}" var="acad" varStatus="status">
		    <tr>
				<td width="20px" style="text-align: center;"><input name="acadIds" type="checkbox"/></td>
				<td width="40px" style="text-align: center;" class="acadSerial">${status.count}</td>
				<td><input type="text" name="academic_name" value="${acad.objMap.academic_name}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="academic_post" value="${acad.objMap.academic_post}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="academic_remark" value="${acad.objMap.academic_remark}" class="inputText" style="width: 90%"/></td>
			</tr>
		    </c:forEach>  
		    </tbody>
		 </table>
		 
		 
		<!--  四、获奖情况（2009年—2013年） -->
		 <table width="100%" class="bs_tb" style="margin-top: 20px;">
			<tr>
				<th colspan="12" class="theader">
					四、获奖情况（
					<input type="text" name="prizeYear1" value="${resultMap.prizeYear1}" onclick="WdatePicker({dateFmt:'yyyy'})" class="inputText" style="width: 40px;margin-right: 0px;" readonly="readonly"/>年
					—<input type="text" name="prizeYear2" value="${resultMap.prizeYear2}" onclick="WdatePicker({dateFmt:'yyyy'})" class="inputText" style="width: 40px;margin-right: 0px;" readonly="readonly"/>年）
					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
						<span style="float: right;padding-right: 10px">
						<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('priz')"></img>&#12288;
						<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('priz');"></img></span>
					</c:if>
				</th>
			</tr> 
		    <tr>
		       <td width="20px"></td>
		       <td width="40px">序号</td>
		       <td width="25%">奖励名称</td>
		       <td width="20%">获奖项目名称</td>
		       <td width="23%">颁奖部门</td>
		       <td width="10%">奖励级别</td>
		       <td width="5%">排名</td>
		       <td width="12%">获奖时间</td>
		    </tr>
		    <tbody id="prizTb">
		    <c:forEach items="${resultMap.prize}" var="priz" varStatus="status">
		    <tr>
				<td width="20px" style="text-align: center;"><input name="prizIds" type="checkbox"/></td>
				<td width="40px" style="text-align: center;" class="prizSerial">${status.count}</td>
				<td><input type="text" name="prize_name" value="${priz.objMap.prize_name}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="prize_itemName" value="${priz.objMap.prize_itemName}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="prize_presentation" value="${priz.objMap.prize_presentation}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="prize_level" value="${priz.objMap.prize_level}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="prize_rank" value="${priz.objMap.prize_rank}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="prize_time" value="${priz.objMap.prize_time}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputText ctime" style="width: 90%" readonly="readonly"/></td>
			</tr>
		    </c:forEach>  
		    </tbody>
		 </table>
		 
		 
		 <!--  五、科研情况 -->
		 <table width="100%" class="bs_tb" style="margin-top: 20px;">
			<tr>
				<th colspan="12" class="theader">五、科研情况
					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
						<span style="float: right;padding-right: 10px">
						<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('rese')"></img>&#12288;
						<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('rese');"></img></span>
					</c:if>
				</th>
			</tr> 
		    <tr>
		       <td width="20px"></td>
		       <td width="40px">序号</td>
		       <td width="26%">项目名称</td>
		       <td width="20%">项目来源</td>
		       <td width="10%">项目编号</td>
		       <td width="10%">金额（万元）</td>
		       <td width="12%">起始时间</td>
		       <td width="12%">验收时间</td>
		       <td width="5%">排名</td>
		    </tr>
		    <tbody id="reseTb">
		    <c:forEach items="${resultMap.research}" var="rese" varStatus="status">
		    <tr>
				<td width="20px" style="text-align: center;"><input name="reseIds" type="checkbox"/></td>
				<td width="40px" style="text-align: center;" class="reseSerial">${status.count}</td>
				<td><input type="text" name="research_name" value="${rese.objMap.research_name}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="research_source" value="${rese.objMap.research_source}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="research_number" value="${rese.objMap.research_number}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="research_money" value="${rese.objMap.research_money}" class="validate[custom[number]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="research_startTime" value="${rese.objMap.research_startTime}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputText ctime" style="width: 90%"/></td>
				<td><input type="text" name="research_checkTime" value="${rese.objMap.research_checkTime}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputText ctime" style="width: 90%"/></td>
				<td><input type="text" name="research_rank" value="${rese.objMap.research_rank}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
			</tr>
		    </c:forEach>  
		    </tbody>
		 </table>
		 
		 
		 
		 <!--  六、发表论文 -->
		 <table width="100%" class="bs_tb" style="margin-top: 20px;">
			<tr>
				<th colspan="12" class="theader">六、发表论文
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
		       <td width="33%">论文题目</td>
		       <td width="20%">刊物名称</td>
		       <td width="15%">期刊号</td>
		       <td width="12%">发表时间</td>
		       <td width="15%">论文类别</td>
		    </tr>
		    <tbody id="thesTb">
		    <c:forEach items="${resultMap.thesis}" var="thes" varStatus="status">
		    <tr>
				<td width="20px" style="text-align: center;"><input name="thesIds" type="checkbox"/></td>
				<td width="40px" style="text-align: center;" class="thesSerial">${status.count}</td>
				<td><input type="text" name="thesis_topic" value="${thes.objMap.thesis_topic}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="thesis_periodicalName" value="${thes.objMap.thesis_periodicalName}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="thesis_periodicalNo" value="${thes.objMap.thesis_periodicalNo}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="thesis_publishTime" value="${thes.objMap.thesis_publishTime}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputText ctime" style="width: 90%"/></td>
				<td><input type="text" name="thesis_category" value="${thes.objMap.thesis_category}" class="inputText" style="width: 90%"/></td>
			</tr>
		    </c:forEach>  
		    </tbody>
		 </table>
		 
		 
		 <!--  七、代表著作、译著 -->
		 <table width="100%" class="bs_tb" style="margin-top: 20px;">
			<tr>
				<th colspan="12" class="theader">六、发表论文
					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
						<span style="float: right;padding-right: 10px">
						<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('book')"></img>&#12288;
						<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('book');"></img></span>
					</c:if>
				</th>
			</tr> 
		    <tr>
		       <td width="20px"></td>
		       <td width="40px">序号</td>
		       <td width="33%">论文题目著作、译著题目</td>
		       <td width="20%">出版社</td>
		       <td width="12%">出版时间</td>
		       <td width="15%">书号</td>
		       <td width="10%">类别</td>
		       <td width="5%">排名</td>
		    </tr>
		    <tbody id="bookTb">
		    <c:forEach items="${resultMap.book}" var="book" varStatus="status">
		    <tr>
				<td width="20px" style="text-align: center;"><input name="bookIds" type="checkbox"/></td>
				<td width="40px" style="text-align: center;" class="bookSerial">${status.count}</td>
				<td><input type="text" name="book_topic" value="${book.objMap.book_topic}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="book_press" value="${book.objMap.book_press}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="book_publishTime" value="${book.objMap.book_publishTime}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputText ctime" style="width: 90%"/></td>
				<td><input type="text" name="book_bookNo" value="${book.objMap.book_bookNo}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="book_category" value="${book.objMap.book_category}" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="book_mark" value="${book.objMap.book_mark}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
			</tr>
		    </c:forEach>  
		    </tbody>
		 </table>
		 
	</form>

   	<c:if test="${param.view!=GlobalConstant.FLAG_Y}">
     	<div align="center" style="margin-top: 10px">
     	    <input id="prev" type="button" onclick="nextOpt('step1')" class="search" value="上一步"/>
     	    <input id="nxt" type="button" onclick="nextOpt('step3')" class="search" value="下一步"/>
     	</div>
   	</c:if>
   	
   	
   	<div style="display: none;">
   		<!--二、主要工作简历  模板 -->
   		<table id="workTemplate" width="100%" class="bs_tb" style="margin-top: 20px;">
   			<tr>
				<td width="20px" style="text-align: center;"><input name="workIds" type="checkbox"/></td>
				<td width="40px" style="text-align: center;" class="workSerial"></td>
				<td><input type="text" name="workResume_startDate" onclick="WdatePicker({dateFmt:'yyyy-MM'})" class="inputText ctime" style="width: 90%;" readonly="readonly"/></td>
				<td><input type="text" name="workResume_endDate" onclick="WdatePicker({dateFmt:'yyyy-MM'})" class="inputText ctime" style="width: 90%;" readonly="readonly"/></td>
				<td><input type="text" name="workResume_orgName" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="workResume_work" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="workResume_remark" class="inputText" style="width: 90%"/></td>
			</tr>
   		</table>
   		
   		
   		<!-- 三、学术组织任职情况 模板 -->
   		<table id="acadTemplate" width="100%" class="bs_tb" style="margin-top: 20px;">
   			<tr>
				<td width="20px" style="text-align: center;"><input name="acadIds" type="checkbox"/></td>
				<td width="40px" style="text-align: center;" class="acadSerial"></td>
				<td><input type="text" name="academic_name" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="academic_post" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="academic_remark" class="inputText" style="width: 90%"/></td>
			</tr>
   		</table>
   		
   		<!-- 四、获奖情况   模板 -->
   		<table id="prizTemplate" width="100%" class="bs_tb" style="margin-top: 20px;">
   			<tr>
				<td width="20px" style="text-align: center;"><input name="prizIds" type="checkbox"/></td>
				<td width="40px" style="text-align: center;" class="prizSerial">${status.count}</td>
				<td><input type="text" name="prize_name" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="prize_itemName" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="prize_presentation" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="prize_level" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="prize_rank" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="prize_time" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputText ctime" style="width: 90%" readonly="readonly"/></td>
			</tr>
   		</table>
   		
   		
   		<!-- 五、科研情况 -->
   		<table id="reseTemplate" width="100%" class="bs_tb" style="margin-top: 20px;">
   			<tr>
				<td width="20px" style="text-align: center;"><input name="reseIds" type="checkbox"/></td>
				<td width="40px" style="text-align: center;" class="reseSerial"></td>
				<td><input type="text" name="research_name" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="research_source" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="research_number" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="research_money" class="validate[custom[number]] inputText" style="width: 90%"/></td>
				<td><input type="text" name="research_startTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputText ctime" style="width: 90%"/></td>
				<td><input type="text" name="research_checkTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputText ctime" style="width: 90%"/></td>
				<td><input type="text" name="research_rank" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
			</tr>
   		</table>
   		
   		<!-- 六、发表论文 -->
   		<table id="thesTemplate" width="100%" class="bs_tb" style="margin-top: 20px;">
   			<tr>
				<td width="20px" style="text-align: center;"><input name="thesIds" type="checkbox"/></td>
				<td width="40px" style="text-align: center;" class="thesSerial"></td>
				<td><input type="text" name="thesis_topic" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="thesis_periodicalName" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="thesis_periodicalNo" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="thesis_publishTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputText ctime" style="width: 90%"/></td>
				<td><input type="text" name="thesis_category" class="inputText" style="width: 90%"/></td>
			</tr>
   		</table>
   		
   		<!-- 七、代表著作、译著 -->
   		<table id="bookTemplate" width="100%" class="bs_tb" style="margin-top: 20px;">
   			<tr>
				<td width="20px" style="text-align: center;"><input name="bookIds" type="checkbox"/></td>
				<td width="40px" style="text-align: center;" class="bookSerial">${status.count}</td>
				<td><input type="text" name="book_topic" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="book_press" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="book_publishTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="inputText ctime" style="width: 90%"/></td>
				<td><input type="text" name="book_bookNo" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="book_category" class="inputText" style="width: 90%"/></td>
				<td><input type="text" name="book_mark" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
			</tr>
   		</table>
 	</div>
