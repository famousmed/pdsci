<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<script type="text/javascript">
function refresh(pickType,checked){
	if(checked==false){
		pickType = "";
	}
	jboxLoad("overview","<s:url value='/irb/secretary/overview'/>?pickType="+pickType);
}
</script>
</head>
<body>

<table width="100%" class="xllist">
        <thead>
        <tr>
          <th  colspan="5"  style="text-align: left;">&#12288;审查概况&#12288;
         <input type="checkbox" id="${quickDatePickEnumMonth.id }" name="pickType" <c:if test="${param.pickType == quickDatePickEnumMonth.id }">checked</c:if>  onchange="refresh('${quickDatePickEnumMonth.id }',this.checked);"/><label for="${quickDatePickEnumMonth.id }">${quickDatePickEnumMonth.name }</label>&#12288;
         <input type="checkbox" id="${quickDatePickEnumSeason.id }" name="pickType" <c:if test="${param.pickType == quickDatePickEnumSeason.id }">checked</c:if> onchange="refresh('${quickDatePickEnumSeason.id }',this.checked);"/><label for="${quickDatePickEnumSeason.id }">${quickDatePickEnumSeason.name }</label>&#12288;
         <input type="checkbox" id="${quickDatePickEnumYear.id }"  name="pickType" <c:if test="${param.pickType == quickDatePickEnumYear.id }">checked</c:if> onchange="refresh('${quickDatePickEnumYear.id }',this.checked);"/><label for="${quickDatePickEnumYear.id }">${quickDatePickEnumYear.name }</label>
         <a href="#" style="float: right;padding-right: 10px;" class="quickFlipCta">详细>></a></th>
       </tr>
       </thead>
       <tbody>
       	<tr>
       		<td width="100px">审查/项目类型</td><td><b>药物</b></td><td><b>科研</b></td><td><b>器械</b></td>
       	</tr>
    	 			<tr>
             <td style="text-align: center;">
              	初始审查
             </td>
             <td style="text-align:center">
             	<c:set var="key" value="${projCategroyEnumYw.id }_${GlobalConstant.FLAG_Y }"/>
             	${applyCountMap[key] }
             </td>
             <td style="text-align:center">
             	<c:set var="key" value="${projCategroyEnumKy.id }_${GlobalConstant.FLAG_Y }"/>
             	${applyCountMap[key] }
             </td>
             <td style="text-align:center">
             	<c:set var="key" value="${projCategroyEnumQx.id }_${GlobalConstant.FLAG_Y }"/>
             	${applyCountMap[key] }
             </td>
        </tr>
        <tr>
             <td style="text-align: center;">
              	跟踪审查
             </td>
             <td style="text-align: center">
             	<c:set var="key" value="${projCategroyEnumYw.id }_${GlobalConstant.FLAG_N }"/>
             	${applyCountMap[key] }
             </td>
              <td style="text-align: center">
             	<c:set var="key" value="${projCategroyEnumKy.id }_${GlobalConstant.FLAG_N }"/>
             	${applyCountMap[key] }
             </td>
              <td style="text-align: center">
             <c:set var="key" value="${projCategroyEnumQx.id }_${GlobalConstant.FLAG_N }"/>
             	${applyCountMap[key] }
             </td>
        </tr>
       </tbody>
 </table>
							 