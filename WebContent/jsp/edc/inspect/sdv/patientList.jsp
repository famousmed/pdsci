<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="jquery_fixedtable" value="true"/>
</jsp:include>
<style>
.divPicNosdv{background-image: url('<s:url value='/css/skin/${skinPath}/images/unchecked.png' />');background-repeat: no-repeat;background-position: 10px center;}
.divPicSdving{background-image: url('<s:url value='/css/skin/${skinPath}/images/checking.png' />');background-repeat: no-repeat;background-position: 10px center;}
.divPicSdved{background-image: url('<s:url value='/css/skin/${skinPath}/images/gou.gif' />');background-repeat: no-repeat;background-position: 10px center;}
.viewTd img {border: 0;position: relative;vertical-align: middle;}
</style>
<script type="text/javascript">
	function doSdv(recordFlow){
		<c:if test="${projParam.inspectLock ==  GlobalConstant.FLAG_Y  || projParam.projLock ==  GlobalConstant.FLAG_Y}">
		jboxTip("当前项目已锁定核查!");
		return;
		</c:if>
		if($("#sdvModel").attr("checked")=="checked"){
			var width = $(top.window.document).width();
			jboxOpen("<s:url value='/edc/inspect/sdvMain?recordFlow='/>"+recordFlow, "数据核查", width-200, 600);
		}else {
			window.location.href="<s:url value='/edc/inspect/sdvMain?recordFlow='/>"+recordFlow+"&groupFlow=${groupFlow}";
		}
	}
	$(document).ready(function(){
		init();
	});
	function init(){
		$(".viewTd").hover(function() {
			$(this).find("span").stop().animate({left: "210", opacity:1}, "slow").css("display","block");
		},function(){
			$(this).find("span").stop().animate({left: "0", opacity: 0}, "slow");
		});
	}
	function viewInputOper(recordFlow){
		jboxOpen("<s:url value='/edc/inspect/inputOperInfo'/>?recordFlow="+recordFlow,"录入信息",500,300);
	}
	
	<c:if test="${fn:length(patientList)>0}">
	$(document).ready(function() {
        var Id = "tableDiv";
        var maintbheight = $('.mainright').height()-100;
        var maintbwidth = $('.mainright').width()-50;
        
        $("#" + Id + " .FixedTables").fixedTable({
            width: maintbwidth,
            height: maintbheight,
            fixedColumns: 2,
            classHeader: "fixedHead",
            classFooter: "fixedFoot",
            classColumn: "fixedColumn",
            fixedColumnWidth: 150,
            outerId: Id
            //Contentbackcolor: "#187BAF",
           	//Contenthovercolor: "#fbf8e9",
            //fixedColumnbackcolor:"#187BAF",
            //fixedColumnhovercolor:"#fbf8e9"
        });
    });
	</c:if>
</script>
<style>
.wechatApp-contact {
border: 1px solid #b8b8b8;
border-radius: 10px;
height: 130px;
margin: 18px 10px 0 10px;
background: #f8f8f8;
position: relative;
padding: 15px 124px 0 10px;
-webkit-box-shadow: 1px 0 2px rgba(255,255,255,.6) inset;
box-shadow: 1px 0 2px rgba(255,255,255,.6) inset;
}
.wechat-noresult {
margin-top: 25px;
font-size: 18px;
color: #b7b7b7;
}
</style>
</head>
	<body>
		<div id="tableDiv">
			<c:if test="${!empty visitList && !empty patientList}">
		<table id="patientFixedTable" class="xllist FixedTables">
			<thead>
				<tr>
					<th style="width:50px;" title="序号">序号</th>
					<th style="width:100px;" title="受试者编码">受试者编码</th>
					<c:forEach items="${visitList }" var="visit">
						<th title="${visit.visitName }">${pdfn:cutString(visit.visitName,14,true,1)}</th>
					</c:forEach>				
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${patientList}" var="patient">
				<tr style="height: 20px">
					<td style="width:50px;">${patient.patientSeq}</td>
					<td style="width:100px;">${patient.patientCode}</td>
					<c:forEach items="${visitList }" var="visit">
					<c:set var="edcPatientVisit" value="${patientVisitMap[patient.patientFlow][visit.visitFlow].edcPatientVisit }"/>
					<td class="viewTd <c:if test='${edcPatientVisit.sdvOperStatusId == edcSdvStatusEnumSdving.id}'>divPicSdving</c:if> 
						<c:if test='${(edcPatientVisit.sdvOperStatusId == edcSdvStatusEnumSdved.id) }'>divPicSdved</c:if>
						<c:if test='${(edcPatientVisit.inputOperStatusId == edcInputStatusEnumChecked.id) and !(edcPatientVisit.sdvOperStatusId eq edcSdvStatusEnumSdved.id)and !(edcPatientVisit.sdvOperStatusId eq edcSdvStatusEnumSdving.id)}'>divPicNosdv</c:if>"
					>
						<div style="width:220px;">
							<c:choose>
								<c:when test='${edcPatientVisit.inputOperStatusId != edcInputStatusEnumChecked.id and !empty edcPatientVisit.inputOper1StatusId }'>
										<a href="javascript:viewInputOper('${edcPatientVisit.recordFlow }');">录入中</a>
								</c:when>
								<c:when test='${edcPatientVisit.inputOperStatusId == edcInputStatusEnumChecked.id }'>
									<span style="display: none;float: right">
											监查员：[<a href="javascript:doSdv('${edcPatientVisit.recordFlow }');">${ !empty edcPatientVisit.sdvOperName ?edcPatientVisit.sdvOperName:"未核查" }</a>]&#12288;
									</span>
								</c:when>
								<c:when test='${empty edcPatientVisit.inputOper1StatusId }'>
											-
								</c:when>
							</c:choose>
							</div>
							</td>
					</c:forEach>
				</tr>
			</c:forEach>
			<c:if test="${patientList == null || patientList.size()==0 }"> 
				<tr> 
					<c:set var="visitNum" value="${visitList == null?0:visitList.size() }"></c:set>
					<td align="center" colspan="${visitNum+2}">无记录</td>
				</tr>
			</c:if>
			</tbody>
		</table>
		</c:if>
		<c:if test="${empty patientList }">
			<div class="wechatApp-contact">
				<h3 class="wechatAPP-mod-hd">提示:</h3>
				<div class="wechat-noresult">${param.orgFlow==''?'请先选择机构!':'该机构暂无入组受试者!' }</div>
			</div>
		</c:if>
		<c:if test="${empty visitList }">
			<div>
			该项目暂未维护访视，请联系项目管理员!
			</div>
		</c:if>
		</div>
</body>
</html>