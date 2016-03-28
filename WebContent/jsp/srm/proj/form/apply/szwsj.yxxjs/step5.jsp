<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:if test="${param.view != GlobalConstant.FLAG_Y}">
<script type="text/javascript">
	function nextOpt(step){
		var files = $('#projFileTb input[name="file"]');
		if(files.length==1&&!$(files[0]).val()){
			$(files[0]).parents("tr").remove();
		}
		if(false==$("#projForm").validationEngine("validate")){
			return false;
		}
	    var form = $("#projForm");
		form.append('<input type="hidden" name="nextPageName" value="'+step+'"/>');
		$('#nxt').attr({"disabled":"disabled"});
		$('#prev').attr({"disabled":"disabled"});
		jboxStartLoading();
		form.submit();
	}
	function addFile(tb){
		var html = '<tr>'+
			'<td style="text-align: center"><input type="checkbox"/></td>'+
			'<td style="text-align: left;">&#12288;<input type="file" name="file" class="validate[required]"/></td>'+
		'</tr>';
		$('#'+tb).append(html);
	}
	function delTr(tb){
		var trs = $('#'+tb).find(':checkbox:checked');
		if(trs.length==0){
			jboxTip("请勾选要删除的！");
			return false;
		}
		jboxConfirm("确认删除？" , function(){
			$.each(trs , function(i , n){
				$(n).parent('td').parent("tr").remove();
				
			});
			
		});
	}
</script>
</c:if>
<style type="text/css">
 .bs_tb tbody td input{text-align: left;margin-left: 10px;}
</style>
	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post"
		id="projForm" enctype="multipart/form-data" style="position: relative;">
		<input type="hidden" id="pageName" name="pageName" value="step5" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
		
		<table width="100%" cellspacing="0" cellpadding="0" class="basic">
			<tr>
				<th colspan="2" style="text-align: left;padding-left: 20px;font-size: 14px;">五、附件信息
					<c:if test="${param.view!=GlobalConstant.FLAG_Y}">
					<span style="float: right;padding-right: 10px">
					<a href="javascript:void(0)"><img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addFile('projFileTb')"></img></a>
					<a href="javascript:void(0)"><img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('projFileTb')"></img></a>
					</span>
					</c:if>
				</th>
			</tr>
			<tr>
				<td width="5%" style="text-align: center;">序号</td>
				<td style="text-align: left; padding-left: 10px;">附件名称</td>
			</tr>
			<tbody id="projFileTb">
				 <c:choose>
				    <c:when test="${param.view==GlobalConstant.FLAG_Y}">
				        <c:forEach var="file" items="${fileFlows}" varStatus="sta">
				          <c:if test="${not empty file}">
				            <tr>
						    <td style="text-align: center;">${sta.count}</td>
							<td><input name="file" value="${file}" type="hidden"/><a href='<s:url value="/pub/file/down?fileFlow=${file}"/>'>${pageFileMap[file].fileName}</a></td>
						</tr>
						</c:if>
				        </c:forEach>
				    </c:when>
				    <c:otherwise>
				        <c:if test="${empty fileFlows}">
	                        <tr>
				                <td style="text-align: center;"><input type="checkbox"/></td>
					            <td style="text-align: left;">&#12288;<input name="file" type="file" class="validate[required]"/></td>
				            </tr>
	                    </c:if>
				        <c:forEach var="file" items="${fileFlows}" varStatus="sta">
				            <c:if test="${not empty file}">
				            <tr>
				                <td style="text-align: center;"><input type="checkbox"/></td>
					            <td style="text-align: left;">&#12288;<input name="file" value="${file}" type="hidden"/><a href='<s:url value="/pub/file/down?fileFlow=${file}"/>'>${pageFileMap[file].fileName}</a></td>
				            </tr>
				            </c:if>
				        </c:forEach>
			        </c:otherwise>
		    </c:choose>
			</tbody>
		</table>
		<c:if test="${param.view!=GlobalConstant.FLAG_Y}">
		<div align="center" style="margin-top: 10px">
			<input id="prev" type="button" onclick="nextOpt('step4')" class="search" value="上一步"/>
			<input id="nxt" type="button" onclick="nextOpt('finish')" class="search" value="完成"/>
       	</div>
       	</c:if>

	</form>
