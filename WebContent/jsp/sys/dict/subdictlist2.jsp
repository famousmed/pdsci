<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<a href="javascript:void(0);" onclick="subDictAdd('${parentDict.dictFlow}' , '${param.level-1}');">${param.level}级新增</a>
<table class="xllist"> 
	<tr>
		<th width="10%">字典代码</th>
		<th width="30%">字典名称</th>
		<th width="30%">描述</th>
		<th width="20%" >操作</th>
	</tr>
	<tbody>
		<c:forEach items="${dictList}" var="dict">
			<tr id="${dict.dictFlow}">
				<td>${dict.dictId}</td>
				<td>
				    <c:if test="${dict.recordStatus == GlobalConstant.RECORD_STATUS_Y }">
				        <a href="javascript:void(0);" onclick="viewChildNode('${dict.dictFlow}' , '${param.level}');">${dict.dictName}</a>
				    </c:if>
				    <c:if test="${dict.recordStatus == GlobalConstant.RECORD_STATUS_N }">
				        <a href="javascript:void(0);" title="请启用后才可以编辑子字典">${dict.dictName}</a>
				    </c:if>
				</td>
				<td>${dict.dictDesc}</td>
				<td>
					<c:if test="${dict.recordStatus == GlobalConstant.RECORD_STATUS_Y }">
					[<a href="javascript:subDictEdit('${dict.dictFlow}' , '${parentDict.dictFlow}' , '${param.level-1}');" >编辑</a>] | [<a href="javascript:delDict('${dict.dictFlow}','${GlobalConstant.RECORD_STATUS_N}' , '${parentDict.dictFlow}' , '${param.level-1}');" >停用</a>]
					</c:if>				
					<c:if test="${dict.recordStatus == GlobalConstant.RECORD_STATUS_N }">
					[<a href="javascript:delDict('${dict.dictFlow}','${GlobalConstant.RECORD_STATUS_Y}' , '${parentDict.dictFlow}' , '${param.level-1}');" >启用</a>]
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


