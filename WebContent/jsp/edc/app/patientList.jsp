<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <?xml version="1.0" encoding="UTF-8"?>
<response>
	<resultId>${responseMap['resultId'] }</resultId>
	<resultType>${reqCode}</resultType>
	<resultName>${responseMap['resultName'] }</resultName>
	<data>
		<c:forEach items="${patientList }" var="patient">
			<patientInfo>
				<patientFlow>${patient.patientFlow }</patientFlow>
			    <order>${patient.patientSeq }</order>
			    <name>${patient.patientName}</name>
				<namePy>${patient.patientNamePy }</namePy>
				<birthday>${patient.patientBirthday}</birthday>
				<sex>${patient.sexName }</sex>
				<pack>${drugMap[patient.patientFlow] }</pack>
				<group>${recMap[patient.patientFlow].drugGroup }</group>
				<assignTime>${pdfn:transDateTime(recMap[patient.patientFlow].assignTime)}</assignTime>
				<assigner>${recMap[patient.patientFlow].assignUserName}</assigner>
			</patientInfo>
		</c:forEach>
	</data>
</response>
