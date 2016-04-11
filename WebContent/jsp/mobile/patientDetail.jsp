<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <?xml version="1.0" encoding="UTF-8"?>
<response>
	<resultId>${responseMap['resultId'] }</resultId>
	<resultType>${reqCode}</resultType>
	<resultName>${responseMap['resultName'] }</resultName>
	<data>
		<patientInfo>
			<centerNo name="中心号" order="1">${centerNo }</centerNo>
			<randomCode name="随即号" order="2">${randomInfo.randomRec.randomCode }</randomCode>
			<birthday name="出生日期" order="3">${pdfn:transDateTime(randomInfo.patient.patientBirthday) }</birthday>
			<factor name="预后因素" order="4">${randomInfo.randomRec.drugFactorName }</factor>
			<assignLabel name="申请类别" order="5">${randomInfo.randomRec.assignLabelName}</assignLabel>
			<assigner name="申请人" order="6">${randomInfo.randomRec.assignUserName}</assigner>
			<assignTime name="申请时间" order="7">${pdfn:transDateTime(randomInfo.randomRec.assignTime)}</assignTime>
			<prompterStatus name="破盲状态" order="8">${empty (randomInfo.randomRec.promptStatusName)?'未破盲':randomInfo.randomRec.promptStatusName}</prompterStatus>
			<prompter name="破盲人" order="9">${randomInfo.randomRec.promptUserName }</prompter>
			<promptTime name="破盲时间" order="10">${randomInfo.randomRec.promptTime }</promptTime>
			<drugPack name="药物编码" order="11">${randomInfo.randomRec.drugPack}</drugPack>
			<drugGroup name="药物组别" order="12">${randomInfo.randomRec.drugGroup}</drugGroup>
		</patientInfo>
		<c:forEach items="${randomInfo.drugRecList }" var="apply">
			<applyRecord>
				<assignTime name="申请时间"   order="1">${pdfn:transDateTime(apply.assignTime)}</assignTime>
				<assigner name="申请人"  order="2">${apply.assignUserName}</assigner>
				<pack name="药物编码"  order="3">${apply.drugPack }</pack>
				<assignLabel name="申请类别"  order="4">${apply.assignLabelName }</assignLabel>
			</applyRecord>
		</c:forEach>
	</data>
</response>
