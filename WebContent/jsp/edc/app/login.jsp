<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <?xml version="1.0" encoding="UTF-8"?>
<response>
	<resultId>${responseMap['resultId'] }</resultId>
	<resultType>${reqCode}</resultType>
	<resultName>${responseMap['resultName'] }</resultName>
	<data>
		<userInfo>
			<userFlow>${user.userFlow}</userFlow>
			<userName>${user.userName}</userName>
		</userInfo>
	</data>
</response>
