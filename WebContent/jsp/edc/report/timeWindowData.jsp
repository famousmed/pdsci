<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<style>
.viewTd img {border: 0;position: relative;vertical-align: middle;}
</style>
<script type="text/javascript" defer="defer">
	$(document).ready(function(){
		init();
		$(".outs").each(function(){
			$("#"+$(this).val()).attr("color","red");
		});
		
		for(var key in orgCenterNo){
			$("."+key).text(orgCenterNo[key]);
		}
	});
	
	function init(){
		$(".viewTd").hover(function() {
			$(this).find("span").stop().animate({left: "210", opacity:1}, "slow").css("display","block");
		},function(){
			$(this).find("span").stop().animate({left: "0", opacity: 0}, "slow");
		});
	}
	<c:if test="${fn:length(patientList)>0}">
	$(document).ready(function() {
        var Id = "tableDiv";
        var maintbheight = $('.mainright').height()-100;
        var maintbwidth = $('.mainright').width()-50;
        
        $("#" + Id + " .FixedTables").fixedTable({
            width: maintbwidth,
            height: maintbheight,
            fixedColumns: 3,
            classHeader: "fixedHead",
            classFooter: "fixedFoot",
            classColumn: "fixedColumn",
            fixedColumnWidth: 200,
            outerId: Id
        });
        
    });
	</c:if>
</script>
</head>
	<body>
		<div id="tableDiv">
		<table id="patientFixedTable" class="xllist FixedTables">
			<thead>
			<tr>
				<th style="width:50px;" title="中心号">中心号</th>
				<th style="width:50px;" title="序号">序号</th>
				<th style="width:100px;" title="受试者编码">受试者编码</th>
				<th title="入组日期">入组日期</th>
				<c:forEach items="${visitList }" var="visit">
					<th title="${visit.visitName }">${pdfn:cutString(visit.visitName,14,true,1)}</th>
				</c:forEach>				
			</tr>
			</thead>
			<tbody id="dataBody">
			<c:forEach items="${patientList}" var="patient">
				<tr style="height: 20px">
					<td class="${patient.orgFlow}" style="width:50px;"></td>
					<td style="width:50px;">${patient.patientSeq}</td>
					<td style="width:100px;">
						<font id="${patient.patientFlow}">${patient.patientCode}</font>
					</td>
					<td class="viewTd" style="text-align: center;"><div style="width:120px;">${pdfn:transDate(patient.inDate)}</div></td>
					<c:set value="${false}" var="isOut" />
					<c:forEach items="${visitList}" var="visit" varStatus="visitStatus">
						<c:set var="visitDateKey" value="${patient.patientFlow}${visit.visitFlow}"/>
						<c:if test="${!empty windowMap[visitDateKey].outWindowTypeId}">
							<c:set value="${true}" var="isOut" />
						</c:if>
						<td 
							<c:if test="${!empty windowMap[visitDateKey].windowVisitLeft}">
							title="${windowMap[visitDateKey].windowVisitLeft} ~ ${windowMap[visitDateKey].windowVisitRight}"
							</c:if>
						 class="viewTd ${!empty windowMap[visitDateKey].outWindowTypeId?'outTd':''}" style="text-align: center;">
							<div style="width:120px;">
								<font color="${!empty windowMap[visitDateKey].outWindowTypeId?'red':''}">
									${empty windowMap[visitDateKey].visitDate?'-':windowMap[visitDateKey].visitDate}
								</font>
								<c:if test="${!empty windowMap[visitDateKey].outWindowDays}">
								<font color="blue">
									(${windowMap[visitDateKey].outWindowDays})
									</font>
								</c:if>
							</div>
						</td>
					</c:forEach>
					<c:if test="${isOut}">
						<input type="hidden" class="outs" value="${patient.patientFlow}"/>
					</c:if>
				</tr>
			</c:forEach>
			</tbody>
			<c:if test="${empty patientList}"> 
				<tr> 
					<c:set var="visitNum" value="${visitList == null?0:visitList.size()}"></c:set>
					<td align="center" colspan="${visitNum+4}">无记录</td>
				</tr>
			</c:if>
		</table>
	</div>
</body>
</html>