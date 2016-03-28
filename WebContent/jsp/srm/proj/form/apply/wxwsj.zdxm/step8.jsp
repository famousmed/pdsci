<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/jsp/edu/htmlhead-edu.jsp">
	<jsp:param name="jquery_form" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
</jsp:include>
<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
<script type="text/javascript">
function nextOpt(step){
	if(false==$("#projForm").validationEngine("validate")){
		return false;
	}
	var form = $('#projForm');
	form.append('<input type="hidden" name="nextPageName" value="'+step+'"/>');
	$('#nxt').attr({"disabled":"disabled"});
	$('#prev').attr({"disabled":"disabled"});
	jboxStartLoading();
	form.submit();
}

function addFile(tb){
	$("#"+tb+"Tb").append($("#"+tb+"Template tr:eq(0)").clone());
 	
 	var length = $("#"+tb+"Tb").children().length;
 	//序号
	$("#"+tb+"Tb").children("tr").last().children("td").eq(1).text(length);
}

function delTr(tb){
	//alert("input[name="+tb+"Ids]:checked");
	var checkboxs = $("input[name='"+tb+"Ids']:checked");
	if(checkboxs.length==0){
		jboxTip("请勾选要删除的！");
		return false;
	}
	jboxConfirm("确认删除?",function () {
		var trs = $('#'+tb+'Tb').find(':checkbox:checked');
		$.each(trs , function(i , n){
			$(n).parent('td').parent("tr").remove();
		});
		//删除后序号
		var serial = 9;
		$("."+tb+"Serial").each(function(){
			serial ++;
			$(this).text(serial);
		});
	});
}

function delFile(flow){
	jboxConfirm("确认删除附件?" ,  function(){
		var datas = {
				"pageName":$('#pageName').val(),
				"itemGroupName":$('#itemGroupName').val(),
				"recFlow":$('#recFlow').val(),
				"projFlow":$('#projFlow').val(),
				"itemGroupFlow":flow,
				"delFileFlag":"${GlobalConstant.FLAG_Y}",
		};
		//var url = "<s:url value='/srm/proj/mine/delPageGroupStep'/>";
		var url = "<s:url value='/srm/proj/mine/delFileItemGroup'/>";
		jboxPost(url , datas , function(){
			window.parent.frames['mainIframe'].location.reload(true);
			jboxClose();
		} , null , true);
	});
}

function checkFile(file){
	var filePath = file.value;
	var suffix = filePath.substring(filePath.lastIndexOf(".")+1);
	if("doc" == suffix || "docx" == suffix || "xls" == suffix || "xlsx" == suffix || "pdf" == suffix || "jpg" == suffix || "rar" == suffix || "zip" == suffix){
		$("#checkFileFlag").val("${GlobalConstant.FLAG_Y}");
	}else{
		$(file).val(null);
		jboxInfo("上传附件的格式只能为word，excel，pdf，jpg");
	}
}
</script>
</c:if>

<c:set var="file1"/>
<c:set var="file2"/>
<c:set var="file3"/>
<c:set var="file4"/>
<c:set var="file5"/>
<c:set var="file6"/>
<c:set var="file7"/>
<c:set var="file8"/>
<c:set var="file9"/>

<c:forEach items="${resultMap.fileEdit}" var="fe">
	<%-- ${fe.objMap.fileEdit_file}---${fe.objMap.fileEdit_fileName}<br/> --%>
	<c:if test="${fe.objMap.fileEdit_fileRemark eq '1'}">
		<c:set var="file1" value="${fe.objMap.fileEdit_file}"/>
	</c:if>
	<c:if test="${fe.objMap.fileEdit_fileRemark eq '2'}">
		<c:set var="file2" value="${fe.objMap.fileEdit_file}"/>
	</c:if>
	<c:if test="${fe.objMap.fileEdit_fileRemark eq '3'}">
		<c:set var="file3" value="${fe.objMap.fileEdit_file}"/>
	</c:if>
	<c:if test="${fe.objMap.fileEdit_fileRemark eq '4'}">
		<c:set var="file4" value="${fe.objMap.fileEdit_file}"/>
	</c:if>
	<c:if test="${fe.objMap.fileEdit_fileRemark eq '5'}">
		<c:set var="file5" value="${fe.objMap.fileEdit_file}"/>
	</c:if>
	<c:if test="${fe.objMap.fileEdit_fileRemark eq '6'}">
		<c:set var="file6" value="${fe.objMap.fileEdit_file}"/>
	</c:if>
	<c:if test="${fe.objMap.fileEdit_fileRemark eq '7'}">
		<c:set var="file7" value="${fe.objMap.fileEdit_file}"/>
	</c:if>
	<c:if test="${fe.objMap.fileEdit_fileRemark eq '8'}">
		<c:set var="file8" value="${fe.objMap.fileEdit_file}"/>
	</c:if>
	<c:if test="${fe.objMap.fileEdit_fileRemark eq '9'}">
		<c:set var="file9" value="${fe.objMap.fileEdit_file}"/>
	</c:if>
<%-- 	${fe.objMap.fileEdit_fileName}--
    ${fe.objMap.fileEdit_file}--
    ${fe.objMap.fileEdit_fileRemark}--
    ${fe.flow}--<br/> --%>
</c:forEach>
		
   		<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" enctype="multipart/form-data" style="position: relative;">
			<input type="hidden" id="pageName" name="pageName" value="step8"/>
			<input type="hidden" name="itemGroupName" value="${param.itemGroupName}"/>
			<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
            <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
			<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
			
			<input type="hidden" id="checkFileFlag" name="checkFileFlag"/>
			
			<font style="font-size: 14px; font-weight:bold;color: #333; ">八、附件信息</font>
			<table width="100%" cellspacing="0" cellpadding="0" class="bs_tb" style="margin-top: 10px;">
    			<tr>
   					<th colspan="11" class="theader">附件信息（上传附件总大小不大于5M，格式只能为word，excel，pdf，jpg）
   						<c:if test="${param.view!=GlobalConstant.FLAG_Y}"><span style="float: right;padding-right: 10px"><a href="javascript:void(0)"><img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addFile('fileList')"></img></a>&#12288;<a href="javascript:void(0)"><img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('fileList')"></img></a></span></c:if>
   					</th>
				</tr>
	            <tr>
	           		<td width="3%"></td>
	           		<td width="5%" style="font-weight:bold;padding: 0px;">序号</td>
	                <td width="50%" style="font-weight:bold;padding: 0px;">文件名</td>
	                <td width="15%">有（√）</td>
	                <c:if test="${param.view!=GlobalConstant.FLAG_Y }">
	                	<td width="30%">操作</td>
	                </c:if>
	            </tr>
	            <tbody id="fileListTb">
    			<tr>
    				 <td width="3%"></td>
		             <td style="text-align: center;" class="docFileSerial">1</td>
		             <td>
		             	<c:if test="${not empty file1}">
							<a href='<s:url value="/pub/file/down?fileFlow=${file1}"/>'>合作各方合作协议</a>
							<input type="hidden" name="fileEdit_fileRemark" value="1"/>
							<input type="hidden" name="fileEdit_fileName" value="合作各方合作协议"/>
							<input type="hidden" name="fileEdit_file" value="${file1}"/>
						</c:if>
		             	<c:if test="${empty file1}">合作各方合作协议</c:if>
		             </td>
		             <td>
						<c:if test="${not empty file1}">
							<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/>
						</c:if>
		             </td>
					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
						<td style="padding-left: 20px;">
							<c:if test="${not empty file1}">
								[<a href="javascript:delFile('${file1}');">删除</a>]
							</c:if>
							<c:if test="${empty file1}">
							   <input type="file" name="fileEdit_file" onchange="checkFile(this);" />
							   <input type="hidden" name="fileEdit_fileRemark" value="1"/>
							   <input type="hidden" name="fileEdit_fileName" value="合作各方合作协议"/>
							</c:if>
						</td>
					</c:if>
				</tr>
				<tr>
					 <td></td>
		             <td width="5%" style="text-align: center;" class="docFileSerial">2</td>
		             <td>
			             	<c:if test="${not empty file2}">
								<a href='<s:url value="/pub/file/down?fileFlow=${file2}"/>'>已发表相关论文</a>
								<input type="hidden" name="fileEdit_fileRemark" value="2"/>
								<input type="hidden" name="fileEdit_fileName" value="已发表相关论文"/>
								<input type="hidden" name="fileEdit_file" value="${file2}"/>
							</c:if>
			             	<c:if test="${empty file2}">已发表相关论文</c:if>
		             </td>
		             <td>
						<c:if test="${not empty file2}">
							<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/>
						</c:if>
		             </td>
		             <c:if test="${param.view!=GlobalConstant.FLAG_Y }">
						<td style="padding-left: 20px;">
							<c:if test="${not empty file2}">
								[<a href="javascript:delFile('${file2}');">删除</a>]
							</c:if>
							<c:if test="${empty file2}">
							    <input type="file" name="fileEdit_file" onchange="checkFile(this);" />
							    <input type="hidden" name="fileEdit_fileRemark" value="2"/>
								<input type="hidden" name="fileEdit_fileName" value="已发表相关论文"/>
							</c:if>
						</td>
					</c:if>
				</tr>
				<tr>
					 <td></td>
		             <td width="5%" style="text-align: center;" class="docFileSerial">3</td>
		             <td>
			             	<c:if test="${not empty file3}">
								<a href='<s:url value="/pub/file/down?fileFlow=${file3}"/>'>科技成果鉴定证书</a>
								<input type="hidden" name="fileEdit_fileRemark" value="3"/>
								<input type="hidden" name="fileEdit_fileName" value="科技成果鉴定证书"/>
								<input type="hidden" name="fileEdit_file" value="${file3}"/>
							</c:if>
			             	<c:if test="${empty file3}">科技成果鉴定证书</c:if>
		             </td>
		             <td>
						<c:if test="${not empty file3}">
							<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/>
						</c:if>
		             </td>
		             <c:if test="${param.view!=GlobalConstant.FLAG_Y }">
						<td style="padding-left: 20px;">
							<c:if test="${not empty file3}">
								[<a href="javascript:delFile('${file3}');">删除</a>]
							</c:if>
							<c:if test="${empty file3}">
							    <input type="file" name="fileEdit_file" onchange="checkFile(this);" />
							    <input type="hidden" name="fileEdit_fileRemark" value="3"/>
								<input type="hidden" name="fileEdit_fileName" value="科技成果鉴定证书"/>
							</c:if>
						</td>
					</c:if>
				</tr>
				<tr>
					 <td></td>
		             <td width="5%" style="text-align: center;" class="docFileSerial">4</td>
		             <td>
			             	<c:if test="${not empty file4}">
								<a href='<s:url value="/pub/file/down?fileFlow=${file4}"/>'>专利证书</a>
								<input type="hidden" name="fileEdit_fileRemark" value="4"/>
								<input type="hidden" name="fileEdit_fileName" value="专利证书"/>
								<input type="hidden" name="fileEdit_file" value="${file4}"/>
							</c:if>
			             	<c:if test="${empty file4}">专利证书</c:if>
		             </td>
		             <td>
						<c:if test="${not empty file4}">
							<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/>
						</c:if>
		             </td>
		             <c:if test="${param.view!=GlobalConstant.FLAG_Y}">
						<td style="padding-left: 20px;">
							<c:if test="${not empty file4}">
								[<a href="javascript:delFile('${file4}');">删除</a>]
							</c:if>
							<c:if test="${empty file4}">
							    <input type="file" name="fileEdit_file" onchange="checkFile(this);" />
							    <input type="hidden" name="fileEdit_fileRemark" value="4"/>
								<input type="hidden" name="fileEdit_fileName" value="专利证书"/>
							</c:if>
						</td>
					</c:if>
				</tr>
				<tr>
					 <td></td>
		             <td width="5%" style="text-align: center;" class="docFileSerial">5</td>
		             <td>
			             	<c:if test="${not empty file5}">
								<a href='<s:url value="/pub/file/down?fileFlow=${file5}"/>'>查新证明</a>
								<input type="hidden" name="fileEdit_fileRemark" value="5"/>
								<input type="hidden" name="fileEdit_fileName" value="查新证明"/>
								<input type="hidden" name="fileEdit_file" value="${file5}"/>
							</c:if>
			             	<c:if test="${empty file5}">查新证明</c:if>
		             </td>
		             <td>
						<c:if test="${not empty file5}">
							<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/>
						</c:if>
		             </td>
		             <c:if test="${param.view!=GlobalConstant.FLAG_Y }">
						<td style="padding-left: 20px;">
							<c:if test="${not empty file5}">
								[<a href="javascript:delFile('${file5}');">删除</a>]
							</c:if>
							<c:if test="${empty file5}">
							    <input type="file" name="fileEdit_file" onchange="checkFile(this);" />
							    <input type="hidden" name="fileEdit_fileRemark" value="5"/>
								<input type="hidden" name="fileEdit_fileName" value="查新证明"/>
							</c:if>
						</td>
					</c:if>
				</tr>
				<tr>
				     <td></td>
		             <td width="5%" style="text-align: center;" class="docFileSerial">6</td>
		             <td>
			             	<c:if test="${not empty file6}">
								<a href='<s:url value="/pub/file/down?fileFlow=${file6}"/>'>检测报告</a>
								<input type="hidden" name="fileEdit_fileRemark" value="6"/>
								<input type="hidden" name="fileEdit_fileName" value="检测报告"/>
								<input type="hidden" name="fileEdit_file" value="${file6}"/>
							</c:if>
			             	<c:if test="${empty file6}">检测报告</c:if>
		             </td>
		             <td>
						<c:if test="${not empty file6}">
							<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/>
						</c:if>
		             </td>
		             <c:if test="${param.view!=GlobalConstant.FLAG_Y }">
						<td style="padding-left: 20px;">
							<c:if test="${not empty file6}">
								[<a href="javascript:delFile('${file6}');">删除</a>]
							</c:if>
							<c:if test="${empty file6}">
							    <input type="file" name="fileEdit_file" onchange="checkFile(this);" />
							    <input type="hidden" name="fileEdit_fileRemark" value="6"/>
								<input type="hidden" name="fileEdit_fileName" value="检测报告"/>
							</c:if>
						</td>
					</c:if>
				</tr>
				<tr>
				     <td></td>
		             <td width="5%" style="text-align: center;" class="docFileSerial">7</td>
		             <td>
			             	<c:if test="${not empty file7}">
								<a href='<s:url value="/pub/file/down?fileFlow=${file7}"/>'>生物新种登记证</a>
								<input type="hidden" name="fileEdit_fileRemark" value="7"/>
								<input type="hidden" name="fileEdit_fileName" value="生物新种登记证"/>
								<input type="hidden" name="fileEdit_file" value="${file7}"/>
							</c:if>
			             	<c:if test="${empty file7}">生物新种登记证</c:if>
		             </td>
		             <td>
						<c:if test="${not empty file7}">
							<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/>
						</c:if>
		             </td>
		             <c:if test="${param.view!=GlobalConstant.FLAG_Y }">
						<td style="padding-left: 20px;">
							<c:if test="${not empty file7}">
								[<a href="javascript:delFile('${file7}');">删除</a>]
							</c:if>
							<c:if test="${empty file7}">
							    <input type="file" name="fileEdit_file" onchange="checkFile(this);" />
							    <input type="hidden" name="fileEdit_fileRemark" value="7"/>
								<input type="hidden" name="fileEdit_fileName" value="生物新种登记证"/>
							</c:if>
						</td>
					</c:if>
				</tr>
				<tr>
					 <td></td>
		             <td width="5%" style="text-align: center;" class="docFileSerial">8</td>
		             <td>
			             	<c:if test="${not empty file8}">
								<a href='<s:url value="/pub/file/down?fileFlow=${file8}"/>'>已有科研项目文件或证明材料</a>
								<input type="hidden" name="fileEdit_fileRemark" value="8"/>
								<input type="hidden" name="fileEdit_fileName" value="已有科研项目文件或证明材料"/>
								<input type="hidden" name="fileEdit_file" value="${file8}"/>
							</c:if>
			             	<c:if test="${empty file8}">已有科研项目文件或证明材料</c:if>
		             </td>
		             <td>
						<c:if test="${not empty file8}">
							<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/>
						</c:if>
		             </td>
		             <c:if test="${param.view!=GlobalConstant.FLAG_Y }">
						<td style="padding-left: 20px;">
							<c:if test="${not empty file8}">
								[<a href="javascript:delFile('${file8}');">删除</a>]
							</c:if>
							<c:if test="${empty file8}">
							    <input type="file" name="fileEdit_file" onchange="checkFile(this);" />
							    <input type="hidden" name="fileEdit_fileRemark" value="8"/>
								<input type="hidden" name="fileEdit_fileName" value="已有科研项目文件或证明材料"/>
							</c:if>
						</td>
					</c:if>
				</tr>
				<tr>
					 <td></td>
		             <td width="5%" style="text-align: center;" class="docFileSerial">9</td>
		             <td>
			             	<c:if test="${not empty file9}">
								<a href='<s:url value="/pub/file/down?fileFlow=${file9}"/>'>伦理委员会意见</a>
								<input type="hidden" name="fileEdit_fileRemark" value="9"/>
								<input type="hidden" name="fileEdit_fileName" value="伦理委员会意见"/>
								<input type="hidden" name="fileEdit_file" value="${file9}"/>
							</c:if>
			             	<c:if test="${empty file9}">伦理委员会意见</c:if>
		             </td>
		             <td>
						<c:if test="${not empty file9}">
							<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/>
						</c:if>
		             </td>
		             <c:if test="${param.view!=GlobalConstant.FLAG_Y }">
						<td style="padding-left: 20px;">
							<c:if test="${not empty file9}">
								[<a href="javascript:delFile('${file9}');">删除</a>]
							</c:if>
							<c:if test="${empty file9}">
							    <input type="file" name="fileEdit_file" onchange="checkFile(this);" />
							    <input type="hidden" name="fileEdit_fileRemark" value="9"/>
								<input type="hidden" name="fileEdit_fileName" value="伦理委员会意见"/>
							</c:if>
						</td>
					</c:if>
				</tr>
				
		       <c:set var="count" value="9"/>
		       <c:forEach items="${resultMap.fileEdit}" var="fe">
		       <c:if test="${fe.objMap.fileEdit_fileRemark =='other'}">
					<tr>
						<td></td>
						<td class="fileListSerial">${count+1}<c:set var="count" value="${count+1}"/></td>
						<td>
							<a href='<s:url value="/pub/file/down?fileFlow=${fe.objMap.fileEdit_file}"/>'>${fe.objMap.fileEdit_fileName}</a>
							<input type="hidden" name="fileEdit_fileRemark" value="${fe.objMap.fileEdit_fileRemark}"/>
							<input type="hidden" name="fileEdit_fileName" value="${fe.objMap.fileEdit_fileName}"/>
							<input type="hidden" name="fileEdit_file" value="${fe.objMap.fileEdit_file}"/>
						</td>
						<td><img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/></td>
						<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
							<td  style="padding-left: 20px;">
								[<a href="javascript:delFile('${fe.objMap.fileEdit_file}');">删除</a>]
							</td>
						</c:if>
					</tr>
				</c:if>
				</c:forEach>
			</tbody>
		</table>
	</form>
	
	<!-------------------------------------------------------------------------------------------------------->
		
	<div style="display: none">
		<!-- 模板 -->
		<table class="basic" id="fileListTemplate" style="width: 100%">
        <tr>
             <td width="3%" style="text-align: center;"><input name="fileListIds" type="checkbox"/></td>
             <td width="5%" style="text-align: center;" class="fileListSerial"></td>
             <td>
             	<input type="text" name="fileEdit_fileName" class="inputText" style="width: 80%"/>
             	<input type="hidden" name="fileEdit_fileRemark" class="validate[required]" value="other"/>
             </td>
             <td></td>
             <td style="padding-left: 20px;">
             	<input type="file" name="fileEdit_file" class="validate[required]" onchange="checkFile(this);" />
             </td>
		</tr>
		</table>
	</div>
	
	 <c:if test="${param.view!=GlobalConstant.FLAG_Y }">
       	 <div class="button" style="width:100%;">
			<input id="prev" type="button" onclick="nextOpt('step7')" class="search" value="上一步"/>
            <input id="nxt" type="button" onclick="nextOpt('finish')" class="search" value="完&#12288;成"/>
     	</div>
     </c:if>
