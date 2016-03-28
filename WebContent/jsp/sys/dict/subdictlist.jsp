<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<table class="xllist"> 
	<tr>
		<th width="10%">字典代码</th>
		<th width="30%">字典名称</th>
		<c:if test='${level>2}'>
		<th width="30%">详细项</th>
		</c:if>
		<c:if test='${level<=2}'>
		<th width="30%">描述</th>
		</c:if>
		<th width="20%" >操作</th>
	</tr>
	<tbody>
		<c:forEach items="${dictList}" var="dict">
			<tr id="${dict.dictFlow}">
				<td>${dict.dictId}</td>
				<td>
				    <c:if test="${dict.recordStatus == GlobalConstant.RECORD_STATUS_Y }">
				        ${dict.dictName}
				    </c:if>
				    <c:if test="${dict.recordStatus == GlobalConstant.RECORD_STATUS_N }">
				        <a href="javascript:void(0);" title="请启用后才可以编辑子字典">${dict.dictName}</a>
				    </c:if>
				</td>
				<c:if test='${level>2}'>
				<td style="text-align: left;">
				    <c:forEach items="${subDicts[dict.dictFlow]}" var="subDict">
				       &nbsp;&nbsp;${subDict.dictId}:${subDict.dictName}<br/>
				    </c:forEach>
				</td>
				</c:if>
				<c:if test='${level<=2}'>
				<td>${dict.dictDesc}</td>
				</c:if>
				<td>
					<c:if test="${dict.recordStatus == GlobalConstant.RECORD_STATUS_Y }">
					[<a href="javascript:subDictEdit('${dict.dictFlow}' , '${parentDict.dictFlow}');" >编辑</a>] | [<a href="javascript:delDict('${dict.dictFlow}','${GlobalConstant.RECORD_STATUS_N}' , '${parentDict.dictFlow}');" >停用</a>]
					</c:if>				
					<c:if test="${dict.recordStatus == GlobalConstant.RECORD_STATUS_N }">
					[<a href="javascript:delDict('${dict.dictFlow}','${GlobalConstant.RECORD_STATUS_Y}' , '${parentDict.dictFlow}');" >启用</a>]
					</c:if>
				</td>
			</tr>
	    </c:forEach>
	</tbody>
	<c:if test="${dictList == null || dictList.size()==0 }"> 
        <tr> 
	        <td align="center" colspan="4">无记录</td>
	    </tr>
    </c:if>
</table>


