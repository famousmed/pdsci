<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

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
		<input type="hidden" id="pageName" name="pageName" value="step5"/>
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
        <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" name="recTypeId" value="${param.recTypeId}"/>
		
       	<table class="bs_tb" style="width: 100%">
			<tr>
		   		<th colspan="4" style="text-align: left;padding-left: 15px;" class="theader">六、计划进度安排与考核指标
		   			<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
		   			<span style="float: right;padding-right: 10px">
		   				<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('work');"></img>
	   					<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('work');"></img>
		   			</span> 
		   			</c:if>
		   		</th>
	   		</tr>
			<tr>	
				<td style="text-align: center;" width="5%"></td>
				<td style="text-align: center;" width="5%">序号</td>
				<td style="text-align: center;" width="30%">工作进度（按半年度分）</td>
				<td style="text-align: center;">主要工作内容</td>
			</tr>
   			<tbody id="workTb">
   			    <c:choose>
   			        <c:when test="${param.view == GlobalConstant.FLAG_Y}">
   			            <c:forEach var="work" items="${resultMap.work}" varStatus="status">
			            <tr>
                            <td width="5%" style="text-align: center;"><!-- <input name="workIds" type="checkbox"/> --></td>
			                <td width="5%" class="workSerial" style="text-align: center;">${status.count}</td>
			                <td width="30%" style="text-align: center;">
			           		    ${work.objMap.work_stratDate}
			           		    ~${work.objMap.work_endDate}
			                </td>
			                <td style="text-align: center;">
			           		    ${work.objMap.work_content}
			                </td>
			            </tr>
			            </c:forEach>
   			        </c:when>
   			        <c:otherwise>
   			            <c:if test="${empty resultMap.work}">
		   			      <tr>
					        <td width="5%" style="text-align: center;"><input name="workIds" type="checkbox"/></td>
					        <td width="5%" style="text-align: center;" class="workSerial">1</td>
					        <td width="30%">
						       <input type="text" name="work_stratDate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  class="inputText" readonly="readonly" style="margin-right: 0px;width:40%;"/>
						       ~<input type="text" name="work_endDate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  class="inputText" readonly="readonly" style="width:40%;"/>
					        </td>
					        <td>
						         <input type="text" class="inputText"  name="work_content" style="width:80%;"/>
					        </td>
		                  </tr>
   			    	    </c:if>
   			    	    <c:if test="${! empty resultMap.work}">
						<c:forEach var="work" items="${resultMap.work}" varStatus="status">
					        <tr>
					           <td width="5%"><input name="workIds" type="checkbox"/></td>
					           <td width="5%" class="workSerial">${status.count}</td>
					           <td width="30%">
					           		<input type="text" name="work_stratDate" value="${work.objMap.work_stratDate}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  class="inputText" readonly="readonly" style="margin-right: 0px; width:40%;"/>
					           		~<input type="text" name="work_endDate" value="${work.objMap.work_endDate}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  class="inputText" readonly="readonly" style="width:40%;"/>
					           </td>
					           <td>
					           		<input type="text" class="inputText"  name="work_content" value="${work.objMap.work_content}" style="width:80%;"/>
					           </td>
					        </tr>
					    </c:forEach>
				        </c:if>
   			        </c:otherwise>
   			    </c:choose>
   			</tbody>
		</table>
		<table class="basic" style="width: 100%;margin-top: 10px;">
	        <tr>
		     	<td style="text-align:left;padding-left: 10px;padding-top: 10px;padding-bottom: 10px;">
		     	  <c:choose>
                             <c:when test="${param.view==GlobalConstant.FLAG_Y}">
                                ${pdfn:toHTML(resultMap.indicator)}
                             </c:when>
                             <c:otherwise>
		     		<textarea placeholder="&#12288;项目完成后主要考核指标：[包括1. 项目技术考核指标；2. 项目的成果（知识产权、小试、样品、论文等）；3. 项目的社会效益；4. 其他考核指标]。" class="xltxtarea" name="indicator" style="height: 300px;">${resultMap.indicator}</textarea>
		     	</c:otherwise>
		     	</c:choose>
		     	</td>
		    </tr>
	 	</table>
     	
       	<c:if test="${param.view != GlobalConstant.FLAG_Y}">
       	<div align="center" style="margin-top: 10px">
       	    <input id="prev" type="button" onclick="nextOpt('step4')" class="search" value="上一步"/>
       	    <input id="nxt" type="button" onclick="nextOpt('step6')" class="search" value="下一步"/>
       	</div>
       	</c:if>	          
	</form>
	
	<div style="display: none">
		<!-- 计划进度安排模板 -->
		<table class="basic" id="workTemplate" style="width: 100%">
        <tr>
			<td width="50px" style="text-align: center;"><input name="workIds" type="checkbox"/></td>
			<td width="50px" style="text-align: center;" class="workSerial"></td>
			<td width="30%">
				<input type="text" name="work_stratDate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  class="inputText" readonly="readonly" style="margin-right: 0px;width:40%;"/>
				~<input type="text" name="work_endDate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  class="inputText" readonly="readonly" style="width:40%;"/>
			</td>
			<td>
				<input type="text" class="inputText"  name="work_content" style="width:80%;"/>
			</td>
        </tr>
		</table>
	</div>
