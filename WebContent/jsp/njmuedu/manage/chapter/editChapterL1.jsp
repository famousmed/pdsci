<script type="text/javascript">
function save(){
	var form=$("#editForm");
	if(false == $("#editForm").validationEngine("validate")){
		return false;
	}
	var data=$('#editForm').serialize();
	var url = "<s:url value='/njmuedu/manage/course/saveChapter'/>";
	jboxPost(url,data, function(resp){
		    var resps=resp.split(":");
		       if(resps[0]=="1"){
					$("#currExpandChapterFlow").val(resps[1]);
					jboxTip("${GlobalConstant.SAVE_SUCCESSED}");
					getAllDataJson();
		       }else{
		    	   jboxTip("${GlobalConstant.SAVE_FAIL}");
		       }
		 },null,false);
}
</script>
<c:if test="${empty sysCfgMap['upload_base_url'] or empty sysCfgMap['upload_stream_url']}">请联系系统管理员先在系统配置中配置文件上传的路径</c:if>
<c:if test="${not empty sysCfgMap['upload_base_url'] and not empty sysCfgMap['upload_stream_url']}">
<table width="100%" cellspacing="0" cellpadding="0" class="bs_tb">
				<tr>
					<th colspan="4" class="bs_name">相关操作<span id="operation"></span></th>
				</tr>
				<tr>
					<td>
						<form id="editForm" style="position: relative;" method="post">
						<input type="hidden" id="courseFlow" name="courseFlow" value="${param.courseFlow }"/>
						<input type="hidden" id="chapterFlow" name="chapterFlow" value="${chapter.chapterFlow }"/>
						<input type="hidden" id="parentChapterFlow" name="parentChapterFlow" value="${chapter.parentChapterFlow }"/>
						<input type="hidden" id="chapterOrder" name="chapterOrder" value="${chapter.chapterOrder }"/>
						<table class="basic" style="border-style: hidden;" id="editChapterL2" width="100%"> 
							<tr>
								<th width="14%" id="chapterType"><span style="color: red">*</span>&nbsp;名&#12288;&#12288;称：</th>
								<td style="text-align: left;"><input type="text" id="chapterName" name="chapterName" class="validate[required] inputText" value="${chapter.chapterName }" style="width:80%;text-align: left;"/></td>
								<th width="14%"><span style="color: red">*</span>&nbsp;序&#12288;&#12288;号：</th>
								<td style="text-align: left;"><input type="text" id="chapterNo" name="chapterNo" class="validate[required] inputText" value="${chapter.chapterNo }" style="text-align: left;"/></td>
							</tr>
							<tr>
								<td colspan="4">
									<input type="button" value="保&#12288;存" class="search" onclick="save()">
								</td>
							</tr>
						</table>
						</form>
					</td>
				</tr>
			</table>
</c:if>