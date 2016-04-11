<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <?xml version="1.0" encoding="UTF-8"?>
<response>
	<resultId>${responseMap['resultId'] }</resultId>
	<resultType>${reqCode}</resultType>
	<resultName>${responseMap['resultName'] }</resultName>
	<data>
		<params>
			<applyForFollow>${isVisit}</applyForFollow>
		</params>
		<patientInfo name="基本信息"  order="1">
	               <item id="namePy" name="受试者姓名" order="1" type="text" >
					</item>
					<item id="sex" name="性别" order="2" type="radio"> 
						<option id="Man">男</option>
						<option id="Woman">女</option>		
					</item>
					<item id="birthday" name="出生年月日" order="3" type="number" placeholder="例如：19670987" >
					</item>
	    </patientInfo>
	    <c:if test="${!empty factors }"> 
		<factor name="分层因素"  order="2">
			<c:forEach items="${factors}" var="factor" varStatus="vs">
					<item id="${factor.index}" order="${vs.count }" name="分层${vs.count}" type="radio">
						<c:forEach items="${factor.itemMap }" var="item">
								<option id="${item.key}">${item.value}</option>
						</c:forEach>
					</item >
			</c:forEach>
        </factor>
        </c:if>
		<include name="纳入标准"  order="3">
			<c:forEach items="${inList}" var="in" >
			<item id="${in.ieVarName}" order="${in.ordinal}" type="${in.inputTypeId}" maxValue="${in.maxValue}" minValue="${in.minValue}" passedValue="${in.passedValue}" >${in.ieName}</item>
			</c:forEach>
		</include>
		<exclude name="排除标准"  order="4">
			<c:forEach items="${exList}" var="ex" >
				<item id="${ex.ieVarName}" order="${ex.ordinal}" type="${ex.inputTypeId}" maxValue="${ex.maxValue}" minValue="${ex.minValue}" passedValue="${ex.passedValue}" >${ex.ieName}</item>
			</c:forEach>
		</exclude>
	</data>
</response>
