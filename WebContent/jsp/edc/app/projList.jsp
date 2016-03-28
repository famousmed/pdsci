<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <?xml version="1.0" encoding="UTF-8"?>
<response>
	<resultId>${responseMap['resultId'] }</resultId>
	<resultType>${reqCode}</resultType>
	<resultName>${responseMap['resultName'] }</resultName>
	<data>
		<c:forEach items="${projList }" var="proj">
			<proj> 
				<projFlow>${proj.projFlow }</projFlow>
				<projName>${proj.projName }</projName>	
			</proj>
		</c:forEach>
	</data>
</response>
