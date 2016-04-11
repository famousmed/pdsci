<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
	<jsp:param name="jquery_ui_sortable" value="false"/>
	<jsp:param name="jquery_cxselect" value="false"/>
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
<script type="text/javascript">
	function selectProj(){
		jboxOpen("<s:url value='/gcp/researcher/userProjList'/>", "选择项目", 800, 600,false);
	}
	
	function doSave(){
		if(!$("#visitForm").validationEngine("validate")){
			return ;
		}
		//判断是否选择基线
		if($("[name='isBaseline'][value='${GlobalConstant.FLAG_Y}']").length<1){
			jboxTip("请选择访视基线!");
			return ;
		}
		var visitTab = $('#visitTable');
		var trs = visitTab.children();
		var datas = [];
		$.each(trs , function(i , n){
			var visitFlow = $(n).find("input[name='visitFlow']").val();
			var ordinal = $(n).find("input[name='ordinal']").val();
			var visitTypeId =  $(n).find("select[name='visitTypeId']").val();
			var isVisit =  $(n).find("select[name='isVisit']").val();
			var groupFlow =  $(n).find("select[name='groupFlow']").val();
			var visitName =  $(n).find("input[name='visitName']").val();
			var visitWindow1 =  $(n).find("input[name='visitWindow1']").val();
			var visitWindow2 =  $(n).find("input[name='visitWindow2']").val();
			var visitWindow3 =  $(n).find("input[name='visitWindow3']").val();
			
			var data = {
					"visitFlow":visitFlow,
					"ordinal":ordinal,
					"visitTypeId":visitTypeId,
					"isVisit":isVisit,
					"groupFlow":groupFlow,
					"visitName":visitName,
					"visitWindow":visitWindow1+","+visitWindow2+","+visitWindow3,
					"isBaseline":$(n).find("input[name='isBaseline']").val(),
			};
			datas.push(data);
		});
		
		var t = {'visitList':datas};
		var url = "<s:url value='/edc/visit/saveVisitBatch'/>";
		jboxPostJson(url , JSON.stringify(t) , function(){
			window.location.reload(true);
		} , null , true);
	}
		
		function addTr(){
			$('#visitTable').append($("#template tr:eq(0)").clone());
			$('#noRecordTr').css("display","none");
		}
		function delEmptyTr(obj){
			   //var tr=obj.parentNode.parentNode;
			   var tr = $(obj).closest("tr");
	           tr.remove();
	           var trs =  $('#visitTable').children();
	           if (trs.length == 0) {
	        	   $('#noRecordTr').css("display",""); 
	           }
		}
		   function delVisit(visitFlow,obj){
			   jboxGet("<s:url value='/edc/visit/delVisitConfirm'/>?visitFlow="+visitFlow,null,function(resp){
					if(resp != '${GlobalConstant.OPRE_FAIL}'){
						jboxConfirm("确认删除？" ,function(){
							   jboxGet("<s:url value='/edc/visit/deleteVisit?visitFlow='/>" + visitFlow,null,function(){
								   var tr = $(obj).closest("tr");
					    	        tr.remove();
					    	        window.location.reload(true);
							   },null,true);
						   }); 
					}else{
						jboxTip("该访视已有访视数据，不能删除!");
					}
				},null,false);
		   }
		   
			function changeIsVisit(obj){
				var visitType = obj.value;
				if((visitType=="${GlobalConstant.VISIT_TYPE_CM }") || (visitType=="${GlobalConstant.VISIT_TYPE_AE }") || (visitType=="${GlobalConstant.VISIT_TYPE_OW }")){
					$(obj).closest("tr").find("option[value='${GlobalConstant.FLAG_N}']").attr("selected","selected");
				} else {
					$(obj).closest("tr").find("option[value='${GlobalConstant.FLAG_Y}']").attr("selected","selected");
				}
				changeWindow(obj)
			}
			
			function changeWindow(obj){
				var thisTr = $(obj).closest("tr");
				var windowSpan = $(thisTr).find(".windowSpan");
				var isVisit = $(thisTr).find("[name='isVisit'] :selected").val();
				if(isVisit == "${GlobalConstant.FLAG_N }"){
					$(windowSpan).hide();
				} else {
					$(windowSpan).show();
				}
			}
			
			function copyVisit(target){
				var targetTr = $(target).closest("tr");
				var newTr = $(targetTr).clone(true);
				$(newTr).find(":hidden[name='visitFlow']").val("");
				$(targetTr).after(newTr);
				$(newTr).css("background-color","pink");
				$(newTr).one("mouseover",function (){
					$(this).css("background-color","");
				});
			}
			
			function selBaseLine(baseLineTd){
				var newBaseLineTr = $(baseLineTd).parent();
				if($(newBaseLineTr).find("[name='isVisit']").val()=="${GlobalConstant.FLAG_N}"){
					jboxTip("基线必须是访视!");
					return;
				}
				var group = $(newBaseLineTr).find("[name='groupFlow']").val();
				//操作原基线（若分组别，则操作同组别基线）
				$(".baseLineTr").each(function(){
					if ($(this).find("[name='groupFlow']").val()==group || group == "") {//同组别或者通用基线时其他组别基线取消
						cancleBaseLine(this);
					} else if ($(this).find("[name='groupFlow']").val() == "") {//分组别时,选择组别基线，则通用基线取消
						cancleBaseLine(this);
					}
				});
				//操做新基线
				$(newBaseLineTr).addClass("baseLineTr");
				var baseLineImg = $('<img />');
				$(baseLineImg).attr("src","<s:url value='/css/skin/${skinPath}/images/gou.gif'/>");
				$(baseLineTd).append(baseLineImg);
				$(baseLineTd).find("[name='isBaseline']").val("${GlobalConstant.FLAG_Y}");
				$(newBaseLineTr).find("[name='isVisit']").attr("disabled",true);
				$(newBaseLineTr).find("[name='visitWindow1'],[name='visitWindow2'],[name='visitWindow3']").attr({
					"readonly":true,
					"value":0,
				});
				$(newBaseLineTr).find(".editTag").hide();
			}
			
			function cancleBaseLine(obj){
				$(obj).removeClass("baseLineTr");
				$(obj).find(".isBaseline").html("<input type='hidden' name='isBaseline' value='${GlobalConstant.FLAG_N}'>");
				$(obj).find("[name='isVisit']").attr("disabled",false);
				$(obj).find("[name='visitWindow1'],[name='visitWindow2'],[name='visitWindow3']").attr({
					"readonly":false,
					"value":"",
				});
				$(obj).find(".editTag").show();
			}
			
			function checkBaseLine(obj) {
				var baseLineNum=0;
				$(".baseLineTr").each(function(){
					if ($(this).find("[name='groupFlow']").val()==$(obj).val() || $(obj).val() == "") {
						baseLineNum++;
						if (baseLineNum>1) {
							var baseLineTr = $(obj).closest("tr");
							$(baseLineTr).removeClass("baseLineTr");
							$(baseLineTr).find(".isBaseline").html("<input type='hidden' name='isBaseline' value='${GlobalConstant.FLAG_N}'>");
							$(baseLineTr).find("[name='isVisit']").attr("disabled",false);
							$(baseLineTr).find("[name='visitWindow1'],[name='visitWindow2'],[name='visitWindow3']").attr({
								"readonly":false,
								"value":"",
							});
							$(baseLineTr).find(".editTag").show();
							return;
						}
					}
				});
			}
			
			$(document).ready(function(){
				if (${(sessionScope.currWsId eq GlobalConstant.GCP_WS_ID)?patientFlag:(!(projParam.designLock eq GlobalConstant.FLAG_Y) && !( projParam.projLock eq GlobalConstant.FLAG_Y))}) {
					$("#editForm").show();
					$("#showForm").hide();
				} else {
					$("#editForm").hide();
					$("#showForm").show();
				}
				$(".baseLineTr").each(function(){
					$(this).find("[name='visitWindow1'],[name='visitWindow2'],[name='visitWindow3']").attr("readonly",true);
					$(this).find(".editTag").hide();
					$(this).find("[name='isVisit']").attr("disabled",true);
					var baseLineImg = $('<img />');
					$(baseLineImg).attr("src","<s:url value='/css/skin/${skinPath}/images/gou.gif'/>");
					$(this).find("[name='isBaseline'][value='${GlobalConstant.FLAG_Y}']").after(baseLineImg);
				});
				<c:if test="${sessionScope.currWsId==GlobalConstant.GCP_WS_ID && empty sessionScope.gcpCurrProj}">
					selectProj();
				</c:if>
			});
			
	</script>
</head>
<body>
	<c:set value="${sessionScope.gcpCurrProj}" var="proj"/>
	<div class="mainright">
		<div class="content">
			<div style="margin-top: 10px;margin-bottom: 10px;">
				<c:if test="${sessionScope.currWsId==GlobalConstant.GCP_WS_ID }">
				当前项目：<a title="点击切换项目" href="javascript:selectProj();" style="color:blue">${empty proj.projShortName?pdfn:cutString(proj.projName,10,true,3):proj.projShortName}</a> &#12288;&#12288;
				</c:if>
				Tip：<font color="red">每次访视窗以上次的访视时间为准
				<c:if test="${sessionScope.currWsId eq GlobalConstant.GCP_WS_ID && !patientFlag}">&#12288;当前项目首例受试者已入组，无法修改！</c:if>
				<c:if test="${projParam.designLock ==  GlobalConstant.FLAG_Y || projParam.projLock ==  GlobalConstant.FLAG_Y}"> 
					&#12288;当前项目已锁定设计，无法修改!
				</c:if>
				</font>
			</div>
	<div id="editForm">
		<form id="visitForm" >
			<table class="xllist">
				<thead>
				<tr>
					<th width="60px">访视序号</th>
					<th width="120px">访视类型</th>
					<th width="50px">基线</th>
					<th width="80px">是否访视</th>
					<c:if test="${!empty groupList}">
						<th width="100px">组别</th>
					</c:if>
					<th width="230px">访视名称</th>
					<th width="130px">访视窗</th>
					<c:if test="${(sessionScope.currWsId eq GlobalConstant.GCP_WS_ID)?patientFlag:(!(projParam.designLock eq GlobalConstant.FLAG_Y) && !( projParam.projLock eq GlobalConstant.FLAG_Y))}">
						<th width="100px">操作</th>
					</c:if>
				</tr>
				</thead>
				<tbody  id="visitTable">
					<c:forEach items="${visitList}" var="visit">
						<tr class="${visit.isBaseline eq GlobalConstant.FLAG_Y?'baseLineTr':''}">
							<td><input type="text" style="width: 50px;text-align: center;" class="validate[custom[integer]] text" name="ordinal" value="${visit.ordinal }"/>
							 <input type="hidden" name="visitFlow" value="${visit.visitFlow }"/>
							</td>
							<td>
								<select name="visitTypeId" style="width: 120px;" onChange="changeIsVisit(this);">
									<c:forEach var="dict" items="${dictTypeEnumVisitTypeList}">
										<option value="${dict.dictId}" <c:if test="${visit.visitTypeId==dict.dictId}">selected="selected"</c:if>>${dict.dictName}</option>
									</c:forEach>
								</select>
							</td>
							<td title="点击选择基线" class="isBaseline" onclick="selBaseLine(this);">
								<input type="hidden" name="isBaseline" value="${visit.isBaseline}"/>
							</td>
							<td>
								<select name="isVisit"  class="text" style="width: 60px" onChange="changeWindow(this);">
									<option value="${GlobalConstant.FLAG_Y }"  <c:if test="${visit.isVisit eq  GlobalConstant.FLAG_Y}">selected</c:if>  >是</option>
									<option value="${GlobalConstant.FLAG_N }"  <c:if test="${visit.isVisit eq  GlobalConstant.FLAG_N }">selected</c:if>>否</option>
								</select>
							</td>
							<c:if test="${!empty groupList}">
							<td>
								<select name="groupFlow" class="text" style="width: 100px" onChange="checkBaseLine(this);">
									<option value="" <c:if test="${empty visit.groupFlow}">selected="selected"</c:if>>通用</option>
									<c:forEach var="group" items="${groupList}">
										<option value="${group.groupFlow}" <c:if test="${visit.groupFlow==group.groupFlow}">selected="selected"</c:if>>${group.groupName}</option>
									</c:forEach>
								</select>
							</td>
							</c:if>
							<td><input type="text" style="width: 85%"  class="validate[required] text" name="visitName" value="${visit.visitName }"/></td>
							<td>
								<span class="windowSpan" style="display: ${GlobalConstant.FLAG_Y eq visit.isVisit?'':'none' }">
									<input type="text" class="validate[custom[integer]]" name="visitWindow1" value="${pdfn:split(visit.visitWindow,',')[0] }"
										 style="text-align: center;width: 30px"  />- <input type="text" class="validate[custom[integer]]" name="visitWindow2" value="${pdfn:split(visit.visitWindow,',')[1] }"
										 style="text-align: center;width: 30px"/>+ <input type="text" class="validate[custom[integer]]" name="visitWindow3" value="${pdfn:split(visit.visitWindow,',')[2] }"
										 style="text-align: center;width: 30px"/>
								</span>
							</td>
							<c:if test="${(sessionScope.currWsId eq GlobalConstant.GCP_WS_ID)?patientFlag:(!(projParam.designLock eq GlobalConstant.FLAG_Y) && !( projParam.projLock eq GlobalConstant.FLAG_Y))}">
							<td>
							 <span class="editTag">
							 [<label onclick="copyVisit(this)" style="cursor: pointer;">复制</label>] |
							 [<label onclick="delVisit('${visit.visitFlow}',this)" style="cursor: pointer;">删除</label>]
							 </span>
							 </td>
							  </c:if>
						</tr>
					</c:forEach>
				</tbody>
				<c:if test="${empty visitList}"> 
					<tr id="noRecordTr" style="display: "> 
						<td align="center" colspan="8">无记录</td>
					</tr>
				</c:if>
			</table>
		</form>
        <div align="center" style="margin-top: 10px">
            <c:if test="${(sessionScope.currWsId eq GlobalConstant.GCP_WS_ID)?patientFlag:(!(projParam.designLock eq GlobalConstant.FLAG_Y) && !( projParam.projLock eq GlobalConstant.FLAG_Y))}">
                <input type="button" class="search" value="新&#12288;增" onclick="addTr();" />
				<input type="button" class="search" value="保&#12288;存" onclick="doSave();" />
			</c:if>
		</div>
   </div>
   
   <div id="showForm">
		<table class="xllist">
			<thead>
				<tr>
					<th width="60px">访视序号</th>
					<th width="120px">访视类型</th>
					<th width="50px">基线</th>
					<th width="80px">是否访视</th>
					<th width="230px">访视名称</th>
					<th width="130px">访视窗</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach var="group" items="${groupList}">
					<c:set var="visitNum" value="0"></c:set>
					<tr>
						<th style="text-align: left;padding-left: 10px;" colspan="6">${group.groupName }</th>
					</tr>
					<c:forEach items="${visitMap[group.groupFlow]}" var="visit">
						<c:set var="visitNum" value="${visitNum+1 }"></c:set>
						<tr>
							<td>${visit.ordinal }</td>
							<td>${visit.visitTypeName }</td>
							<td>
							<c:if test="${visit.isBaseline eq GlobalConstant.FLAG_Y}">
								<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>">
							</c:if>
							</td>
							<td>
								<c:if test="${visit.isVisit eq  GlobalConstant.FLAG_Y}">是</c:if>
								<c:if test="${visit.isVisit eq  GlobalConstant.FLAG_N }">否</c:if>
							</td>
							<td>${visit.visitName }</td>
							<td>
								<c:if test="${GlobalConstant.FLAG_Y eq visit.isVisit }">
								${pdfn:split(visit.visitWindow,',')[0] } - ${pdfn:split(visit.visitWindow,',')[1] } + ${pdfn:split(visit.visitWindow,',')[2] }
								</c:if>
							</td>
						</tr>
					</c:forEach>
					<c:if test="${visitNum == 0 }"> 
						<tr id="noRecordTr" style="display: "> 
							<td align="center" colspan="6">无记录</td>
						</tr>
					</c:if>
				</c:forEach>
				<c:if test="${!empty groupList}">
				<tr>
					<th style="text-align: left;padding-left: 10px;" colspan="6">通用</th>
				</tr>
				</c:if>
				<c:set var="visitNum" value="0"></c:set>
				<c:forEach items="${visitMap['common']}" var="visit">
				<c:set var="visitNum" value="${visitNum+1 }"></c:set>
					<tr>
						<td>${visit.ordinal }</td>
						<td>${visit.visitTypeName }</td>
						<td>
							<c:if test="${visit.isBaseline eq GlobalConstant.FLAG_Y}">
								<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>">
							</c:if>
						</td>
						<td>
							<c:if test="${visit.isVisit eq  GlobalConstant.FLAG_Y}">是</c:if>
							<c:if test="${visit.isVisit eq  GlobalConstant.FLAG_N }">否</c:if>
						</td>
						<td>${visit.visitName }</td>
						<td>
							<c:if test="${GlobalConstant.FLAG_Y eq visit.isVisit }">
								${pdfn:split(visit.visitWindow,',')[0] } - ${pdfn:split(visit.visitWindow,',')[1] } + ${pdfn:split(visit.visitWindow,',')[2] }
							</c:if>
						</td>
					</tr>
				</c:forEach>
				</tbody>
				<c:if test="${visitNum == 0 }"> 
					<tr id="noRecordTr" style="display: "> 
						<td align="center" colspan="6">无记录</td>
					</tr>
				</c:if>
			</table>
   </div>
   </div>
</div>
<c:if test="${(sessionScope.currWsId eq GlobalConstant.GCP_WS_ID)?patientFlag:(!(projParam.designLock eq GlobalConstant.FLAG_Y) && !( projParam.projLock eq GlobalConstant.FLAG_Y))}">
   <table style="display: none" id="template" name="template">
 <tr >
	   		<td><input type="text" style="width: 50px;text-align: center;" class="validate[custom[integer]] text" name="ordinal" value=""/></td>	 
	   		<td><select name="visitTypeId" class="validate[required] " style="width: 120px"  onChange="changeIsVisit(this);">
					<c:forEach var="dict" items="${dictTypeEnumVisitTypeList}">
						<option value="${dict.dictId}" >${dict.dictName}</option>
					</c:forEach>
			</select></td> 
			<td title="点击选择基线" class="isBaseline" onclick="selBaseLine(this);">
								<input type="hidden" name="isBaseline" value="${GlobalConstant.FLAG_N}"/>
							</td>
			<td>
				<select name="isVisit"  class="text" style="width: 60px" onChange="changeWindow(this);">
					<option value="${GlobalConstant.FLAG_Y }">是</option>
					<option value="${GlobalConstant.FLAG_N }">否</option>
				</select>
			</td>
			<c:if test="${!empty groupList}">
			<td>
				<select name="groupFlow" class="text" style="width: 100px" onChange="checkBaseLine(this);">
					<option value="">通用</option>
					<c:forEach var="group" items="${groupList}">
						<option value="${group.groupFlow}">${group.groupName}</option>
					</c:forEach>
				</select>
			</td>
			</c:if>
			<td><input type="text" style="width: 85%"  class="validate[required] text" name="visitName" value=""/></td>
			<td>
				<span class="windowSpan">
					<input type="text" class="validate[custom[integer]]" name="visitWindow1" value=""
						style="text-align: center;width: 30px"  />- <input type="text" class="validate[custom[integer]]" name="visitWindow2" value=""
						style="text-align: center;width: 30px"/>+ <input type="text" class="validate[custom[integer]]" name="visitWindow3" value=""
						style="text-align: center;width: 30px"/>
				</span>
			</td>
			<td>	
			<span class="editTag">
				[<label onclick="copyVisit(this)" style="cursor: pointer;" >复制</label>] |
				[<label onclick="delEmptyTr(this)" style="cursor: pointer;" >删除</label>]
			</span>
			</td>
	   </tr>
</table>
</c:if>
</body>
</html>