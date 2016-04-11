<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<script type="text/javascript">
	$(document).ready(function(){
		<c:if test="${!empty doctor}">
			<c:if test="${doctor.selDeptFlag eq GlobalConstant.FLAG_Y}">
				$("#selDeptTab").hide();
			</c:if>
			<c:if test="${!(doctor.selDeptFlag eq GlobalConstant.FLAG_Y)}">
				loadSelDept("${doctor.doctorFlow}");
				$("#selDeptTab").show();
			</c:if> 
		</c:if>
		$(".dateInput").attr({
			readonly:true,
		});
		
		if(${empty resultMap}){
			for(var key in rosteringDateTemp['${doctor.doctorFlow}']){
				for(var id in rosteringDateTemp['${doctor.doctorFlow}'][key]){
					$("#"+id).val(rosteringDateTemp['${doctor.doctorFlow}'][key][id]);
				}
			}
		}
	});
	
	
	function loadSelDept(doctorFlow){
		jboxLoad("selDept","<s:url value='/sch/doc/seldept_item'/>?doctorFlow="+doctorFlow+"&flag=rosteringHandDept",false);
	}
	
	function saveResult(){
		if(!$("#schArrangeResult").validationEngine("validate")){
			return ;
		} 
		var url = "<s:url value='/sch/arrange/saveArrangeResult'/>";
		var resultList = [];
		var arrDocDeptList = [];
		$(".arrangeDocDept").each(function(){
			var arrDocDept = eval("("+$(this).val()+")");
			arrDocDeptList.push(arrDocDept);
		});
		$(".resultData").each(function(){
			var result = eval("("+$(this).attr("resultData")+")");
			$(this).find(".resultRecord").each(function(){
				var schYear = $(this).attr("schYear");
				var schMonth = $(this).attr("schMonth");
				if(parseFloat(schMonth)){
					var newResult = result;
					var startDate = $(this).find(":text.startFlag").val();
					var endDate = $(this).find(":text.endFlag").val();
					newResult.schYear = schYear;
					newResult.schMonth = schMonth;
					newResult.schStartDate = startDate;
					newResult.schEndDate = endDate;
					resultList.push(newResult);
				}
			});
		});
		var requestData = {
				"arrDoc":{
					"doctorFlow":"${doctor.doctorFlow}",
					"doctorName":"${doctor.doctorName}",
					"rotationFlow":"${doctor.rotationFlow}",
					"rotationName":"${doctor.rotationName}",
				},
				"arrDocDeptList":arrDocDeptList,
				"resultList":resultList,
		};
		jboxPostJson(url,JSON.stringify(requestData),function(resp){
			if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
				window.parent.frames["mainIframe"].window.loadDeptList("${doctor.doctorFlow}");
			}
		},null,true);
	}
	
	function delResult(){
		jboxConfirm("确认删除?",function () {
			if(${empty resultMap}){
				rosteringDateTemp = {};
				$(".dateInput").val("");
			}else{
				jboxPost("<s:url value='/sch/arrange/delArrangeResult'/>","doctorFlow=${doctor.doctorFlow}",function(resp){
					if(resp=='${GlobalConstant.DELETE_SUCCESSED}'){
						loadDeptList("${doctor.doctorFlow}");//window.parent.frames["mainIframe"].window.
					}
				},null,true);
			}
		});
	}
	
	function calculateDate(date){
		dateStr = date.value;
		if(dateStr != null && $.trim(date.value) != ''){
			var ymd = dateStr.split("-");
			var dd = parseInt(ymd[2]);
			if(dd != 1 && dd != 16){
				if(dd < 16){
					date.value = ymd[0]+"-"+ymd[1]+"-"+1;
				}
				if(dd > 16){
					date.value = ymd[0]+"-"+ymd[1]+"-"+16;
				}
				calculateDate(date);
				jboxTip("日期只能为 1号 或者 16号 ");
				return ;
			}
			jboxGet("<s:url value='/sch/arrange/calculateDate'/>","date="+dateStr+"&step="+$("#"+date.id.replace("schStartDate","dateStep")).text(),function(resp){
				if(!("${doctor.doctorFlow}" in rosteringDateTemp)){
					rosteringDateTemp['${doctor.doctorFlow}'] = {};
				}else{
					for(var key in rosteringDateTemp['${doctor.doctorFlow}']){
						var result = true;
						if(key == date.id.replace("Start","")){
							continue;
						}
						for(var id in rosteringDateTemp['${doctor.doctorFlow}'][key]){
							var currDate = rosteringDateTemp['${doctor.doctorFlow}'][key][id];
							var isStart = id.indexOf("Start")!=-1;
							result = (isStart?currDate:(date.value))>(isStart?(date.value):currDate) && (isStart?currDate:resp)>(isStart?resp:currDate);
							if(result){
								break;
							}
						}
						if(!result){
							jboxTip("对不起,该日期区间与其他日期产生重叠!");
							date.value="";
							$("#"+date.id.replace("Start","End")).val("");
							return;
						}
					}
				}
				if(!(date.id.replace("Start","") in rosteringDateTemp['${doctor.doctorFlow}'])){
					rosteringDateTemp['${doctor.doctorFlow}'][date.id.replace("Start","")] = {};
				}
				$("#"+date.id.replace("Start","End")).val(resp);
				rosteringDateTemp['${doctor.doctorFlow}'][date.id.replace("Start","")][date.id] = date.value;
				rosteringDateTemp['${doctor.doctorFlow}'][date.id.replace("Start","")][$("#"+date.id.replace("Start","End")).attr("id")] = resp;
				
			},null,false);
		}
	}
</script>
</head>

<body>
	<form id="schArrangeResult" style="margin-bottom: 10px">
				<table  class="xllist" style="font-size: 14px">
					<tr>
						<th style="text-align: left;width: 100px;" colspan="5">
							<c:if test="${!empty doctor}">
								&#12288;
								医师姓名：${doctor.doctorName}
								&#12288;&#12288;&#12288;&#12288;
								轮转方案：${doctor.rotationName}
								&#12288;&#12288;&#12288;&#12288;
								轮转年限：${rotationYear}年
							</c:if>
							<c:if test="${empty doctor}">
								&#12288;请选择医师
							</c:if>
						</th>
					</tr>
					<tr>
						<th style="text-align: center;">轮转科室</th>
						<th style="text-align: center; ">轮转时间</th>
						<th style="text-align: center; width: 200px;">第一年</th>
						<th style="text-align: center; width: 200px;">第二年</th>
						<th style="text-align: center; width: 200px;">第三年</th>
					</tr>
					<c:forEach items="${rotationDeptList}" var="rotationDept">
						<input type="hidden" class="arrangeDocDept" value="
							{
								doctorFlow:'${doctor.doctorFlow}',
								doctorName:'${doctor.doctorName}',
								deptFlow:'${rotationDept.deptFlow}',
								deptName:'${rotationDept.deptName}',
								groupFlow:'${rotationDept.groupFlow}',
								schDeptFlow:'${rotationDept.schDeptFlow}',
								schDeptName:'${rotationDept.schDeptName}',
								firstYear:'${rotationDept.firstYear}',
								secondYear:'${rotationDept.secondYear}',
								thirdYear:'${rotationDept.thirdYear}',
							}
						"/>
						<tr 
						class="resultData"
						resultData="
							{
								doctorFlow:'${doctor.doctorFlow}',
								doctorName:'${doctor.doctorName}',
								sessionNumber:'${doctor.sessionNumber}',
								rotationFlow:'${doctor.rotationFlow}',
								rotationName:'${doctor.rotationName}',
								deptFlow:'${rotationDept.deptFlow}',
								deptName:'${rotationDept.deptName}',
								schDeptFlow:'${rotationDept.schDeptFlow}',
								schDeptName:'${rotationDept.schDeptName}',
								isRequired:'${rotationDept.isRequired}',
								standardDeptId:'${rotationDept.standardDeptId}',
								standardDeptName:'${rotationDept.standardDeptName}',
								groupFlow:'${rotationDept.groupFlow}',
							}
						"
						>
							<td>${rotationDept.schDeptName}</td>
							<td><font id="dateStep_${doctor.sessionNumber}__${rotationDept.schDeptFlow}">${rotationDept.firstYear}</font>个月${empty rotationDept.secondYear?'':'+'}<font id="dateStep_${doctor.sessionNumber+1}__${rotationDept.schDeptFlow}">${rotationDept.secondYear}</font>${empty rotationDept.thirdYear?'':'个月+'}<font id="dateStep_${doctor.sessionNumber+2}__${rotationDept.schDeptFlow}">${rotationDept.thirdYear}</font>${!empty rotationDept.thirdYear?'个月':''}</td>
							<td class="resultRecord" schYear="${doctor.sessionNumber}" schMonth="${rotationDept.firstYear}">
								<c:if test="${!empty rotationDept.firstYear && !(rotationDept.firstYear eq '0')}">
									<c:set value="${rotationDept.schDeptFlow}${doctor.sessionNumber}" var="resultMapKey"></c:set>
									<input type="hidden" class="${rotationDept.schDeptFlow}" value="${doctor.sessionNumber}"/>
									<input 
									title="日期: 1号 或 16号" 
									class="dateInput startFlag validate[required]" 
									type="text" 
									id="schStartDate_${doctor.sessionNumber}__${rotationDept.schDeptFlow}" 
									style="width: 80px;" 
									value="${resultMap[resultMapKey].schStartDate}"
									onblur="calculateDate(this);"
									onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"
									/>
									-
									<input 
									class="dateInput endFlag validate[required]" 
									type="text" 
									id="schEndDate_${doctor.sessionNumber}__${rotationDept.schDeptFlow}" 
									style="width: 80px;" 
									value="${resultMap[resultMapKey].schEndDate}"
									/>
								</c:if>
							</td>
							<td class="resultRecord" schYear="${doctor.sessionNumber+1}" schMonth="${rotationDept.secondYear}">
								<c:if test="${!empty rotationDept.secondYear && !(rotationDept.secondYear eq '0')}">
									<c:set value="${rotationDept.schDeptFlow}${doctor.sessionNumber+1}" var="resultMapKey"></c:set>
									<input type="hidden" class="${rotationDept.schDeptFlow}" value="${doctor.sessionNumber+1}"/>
									<input 
									title="日期: 1号 或 16号" 
									class="dateInput startFlag validate[required]" 
									type="text" 
									id="schStartDate_${doctor.sessionNumber+1}__${rotationDept.schDeptFlow}" 
									style="width: 80px;" 
									value="${resultMap[resultMapKey].schStartDate}"
									onblur="calculateDate(this);"
									onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"
									/>
									-
									<input 
									class="dateInput endFlag validate[required]" 
									type="text" 
									id="schEndDate_${doctor.sessionNumber+1}__${rotationDept.schDeptFlow}" 
									style="width: 80px;" 
									value="${resultMap[resultMapKey].schEndDate}"
									/>
								</c:if>
							</td>
							<td class="resultRecord" schYear="${doctor.sessionNumber+2}" schMonth="${rotationDept.thirdYear}">
								<c:if test="${!empty rotationDept.thirdYear && !(rotationDept.thirdYear eq '0')}">
									<c:set value="${rotationDept.schDeptFlow}${doctor.sessionNumber+2}" var="resultMapKey"></c:set>
									<input type="hidden" class="${rotationDept.schDeptFlow}" value="${doctor.sessionNumber+2}"/>
									<input 
									title="日期: 1号 或 16号" 
									class="dateInput startFlag validate[required]" 
									type="text" 
									id="schStartDate_${doctor.sessionNumber+2}__${rotationDept.schDeptFlow}" 
									style="width: 80px;" 
									value="${resultMap[resultMapKey].schStartDate}"
									onblur="calculateDate(this);"
									onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"
									/>
									-
									<input 
									class="dateInput endFlag validate[required]" 
									type="text" 
									id="schEndDate_${doctor.sessionNumber+2}__${rotationDept.schDeptFlow}" 
									style="width: 80px;" 
									value="${resultMap[resultMapKey].schEndDate}"
									/>
								</c:if>
							</td>
						</tr>
					</c:forEach>
					
					<c:if test="${doctor.selDeptFlag eq GlobalConstant.FLAG_Y}">
						<c:forEach items="${doctorDeptList}" var="doctorDept">
							<c:set value="${doctorDept.groupFlow}${doctorDept.schDeptFlow}" var="rotationDeptMapKey"></c:set>
							<input type="hidden" class="arrangeDocDept" value="
							{
								doctorFlow:'${doctor.doctorFlow}',
								doctorName:'${doctor.doctorName}',
								deptFlow:'${rotationDeptMap[rotationDeptMapKey].deptFlow}',
								deptName:'${rotationDeptMap[rotationDeptMapKey].deptName}',
								groupFlow:'${rotationDeptMap[rotationDeptMapKey].groupFlow}',
								schDeptFlow:'${rotationDeptMap[rotationDeptMapKey].schDeptFlow}',
								schDeptName:'${rotationDeptMap[rotationDeptMapKey].schDeptName}',
								firstYear:'${rotationDeptMap[rotationDeptMapKey].firstYear}',
								secondYear:'${rotationDeptMap[rotationDeptMapKey].secondYear}',
								thirdYear:'${rotationDeptMap[rotationDeptMapKey].thirdYear}',
							}
						"/>
							<tr
							class="resultData"
							resultData="
								{
									doctorFlow:'${doctor.doctorFlow}',
									doctorName:'${doctor.doctorName}',
									sessionNumber:'${doctor.sessionNumber}',
									rotationFlow:'${doctor.rotationFlow}',
									rotationName:'${doctor.rotationName}',
									deptFlow:'${rotationDeptMap[rotationDeptMapKey].deptFlow}',
									deptName:'${rotationDeptMap[rotationDeptMapKey].deptName}',
									schDeptFlow:'${rotationDeptMap[rotationDeptMapKey].schDeptFlow}',
									schDeptName:'${rotationDeptMap[rotationDeptMapKey].schDeptName}',
									isRequired:'${rotationDeptMap[rotationDeptMapKey].isRequired}',
									standardDeptId:'${rotationDeptMap[rotationDeptMapKey].standardDeptId}',
									standardDeptName:'${rotationDeptMap[rotationDeptMapKey].standardDeptName}',
									groupFlow:'${rotationDeptMap[rotationDeptMapKey].groupFlow}',
								}
							"
							>
								<td>*${doctorDept.schDeptName}</td>
								<td><font id="dateStep_${doctor.sessionNumber}_${rotationDeptMap[rotationDeptMapKey].groupFlow}_${rotationDeptMap[rotationDeptMapKey].schDeptFlow}">${rotationDeptMap[rotationDeptMapKey].firstYear}</font>个月${empty rotationDeptMap[rotationDeptMapKey].secondYear?'':'+'}<font id="dateStep_${doctor.sessionNumber+1}_${rotationDeptMap[rotationDeptMapKey].groupFlow}_${rotationDeptMap[rotationDeptMapKey].schDeptFlow}">${rotationDeptMap[rotationDeptMapKey].secondYear}</font>${empty rotationDeptMap[rotationDeptMapKey].thirdYear?'':'个月+'}<font id="dateStep_${doctor.sessionNumber+2}_${rotationDeptMap[rotationDeptMapKey].groupFlow}_${rotationDeptMap[rotationDeptMapKey].schDeptFlow}">${rotationDeptMap[rotationDeptMapKey].thirdYear}</font>${!empty rotationDeptMap[rotationDeptMapKey].thirdYear?'个月':''}</td>
								<td class="resultRecord" schYear="${doctor.sessionNumber}" schMonth="${rotationDeptMap[rotationDeptMapKey].firstYear}">
									<c:if test="${!empty rotationDeptMap[rotationDeptMapKey].firstYear && !(rotationDeptMap[rotationDeptMapKey].firstYear eq '0')}">
										<c:set value="${rotationDeptMap[rotationDeptMapKey].schDeptFlow}${doctor.sessionNumber}" var="resultMapKey"></c:set>
										<input type="hidden" class="${rotationDeptMap[rotationDeptMapKey].groupFlow}${rotationDeptMap[rotationDeptMapKey].schDeptFlow}" value="${doctor.sessionNumber}"/>
										<input 
										title="日期: 1号 或 16号" 
										class="dateInput startFlag validate[required]" 
										type="text" 
										id="schStartDate_${doctor.sessionNumber}_${rotationDeptMap[rotationDeptMapKey].groupFlow}_${rotationDeptMap[rotationDeptMapKey].schDeptFlow}" 
										style="width: 80px;" 
										value="${resultMap[resultMapKey].schStartDate}"
										onblur="calculateDate(this);"
										onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"
										/>
										-
										<input 
										class="dateInput endFlag validate[required]" 
										type="text" 
										id="schEndDate_${doctor.sessionNumber}_${rotationDeptMap[rotationDeptMapKey].groupFlow}_${rotationDeptMap[rotationDeptMapKey].schDeptFlow}" 
										style="width: 80px;" 
										value="${resultMap[resultMapKey].schEndDate}"
										/>
									</c:if>
								</td>
								<td class="resultRecord" schYear="${doctor.sessionNumber+2}" schMonth="${rotationDeptMap[rotationDeptMapKey].secondYear}">
									<c:if test="${!empty rotationDeptMap[rotationDeptMapKey].secondYear && !(rotationDeptMap[rotationDeptMapKey].secondYear eq '0')}">
										<c:set value="${rotationDeptMap[rotationDeptMapKey].schDeptFlow}${doctor.sessionNumber+1}" var="resultMapKey"></c:set>
										<input type="hidden" class="${rotationDeptMap[rotationDeptMapKey].groupFlow}${rotationDeptMap[rotationDeptMapKey].schDeptFlow}" value="${doctor.sessionNumber+1}"/>
										<input 
										title="日期: 1号 或 16号" 
										class="dateInput startFlag validate[required]" 
										type="text" 
										id="schStartDate_${doctor.sessionNumber+1}_${rotationDeptMap[rotationDeptMapKey].groupFlow}_${rotationDeptMap[rotationDeptMapKey].schDeptFlow}" 
										style="width: 80px;" 
										value="${resultMap[resultMapKey].schStartDate}"
										onblur="calculateDate(this);"
										onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"
										/>
										-
										<input 
										class="dateInput endFlag validate[required]" 
										type="text" 
										id="schEndDate_${doctor.sessionNumber+1}_${rotationDeptMap[rotationDeptMapKey].groupFlow}_${rotationDeptMap[rotationDeptMapKey].schDeptFlow}" 
										style="width: 80px;" 
										value="${resultMap[resultMapKey].schEndDate}"
										/>
									</c:if>
								</td>
								<td class="resultRecord" schYear="${doctor.sessionNumber+2}" schMonth="${rotationDeptMap[rotationDeptMapKey].thirdYear}">
									<c:if test="${!empty rotationDeptMap[rotationDeptMapKey].thirdYear && !(rotationDeptMap[rotationDeptMapKey].thirdYear eq '0')}">
										<c:set value="${rotationDeptMap[rotationDeptMapKey].schDeptFlow}${doctor.sessionNumber+2}" var="resultMapKey"></c:set>
										<input type="hidden" class="${rotationDeptMap[rotationDeptMapKey].groupFlow}${rotationDeptMap[rotationDeptMapKey].schDeptFlow}" value="${doctor.sessionNumber+2}"/>
										<input 
										title="日期: 1号 或 16号" 
										class="dateInput startFlag validate[required]" 
										type="text" 
										id="schStartDate_${doctor.sessionNumber+2}_${rotationDeptMap[rotationDeptMapKey].groupFlow}_${rotationDeptMap[rotationDeptMapKey].schDeptFlow}" 
										style="width: 80px;" 
										value="${resultMap[resultMapKey].schStartDate}"
										onblur="calculateDate(this);"
										onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"
										/>
										-
										<input 
										class="dateInput endFlag validate[required]" 
										type="text" 
										id="schEndDate_${doctor.sessionNumber+2}_${rotationDeptMap[rotationDeptMapKey].groupFlow}_${rotationDeptMap[rotationDeptMapKey].schDeptFlow}" 
										style="width: 80px;" 
										value="${resultMap[resultMapKey].schEndDate}"
										/>
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</c:if>
					
					<c:if test="${empty rotationDeptList && empty doctorDeptList}">
						<tr><td align="center" colspan="5">无记录</td></tr>
					</c:if>
				</table>
				<c:if test="${doctor.selDeptFlag eq GlobalConstant.FLAG_Y}">
					<div style="padding-top: 5px;text-align: center;">
						<input type="button" value="保&#12288;存" class="search" onclick="saveResult();"/>
						<input type="button" value="删除排班" class="search" onclick="delResult();"/>
					</div>
				</c:if>
			</form>
</body>
</html>