<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="ueditor" value="true"/>
</jsp:include>
<script type="text/javascript">
function save(){
	var videoFile=$("#videoFile");
	var videoStatusVal=$("#videoStatus").val();
	var imgStatusVal=$("#imgStatus").val();
	if(videoStatusVal=="uping" || imgStatusVal=="uping"){
		jboxTip("文件正在上传中，请稍等！");
		return false;
	}else if(videoStatusVal=="fail"){
		jboxTip("文件上传失败，请重试！");
		return false;
	}else if(videoFile.val()==""){
		jboxTip("您还没有上传课程视频！");
		return false;
	}
	if(false == $("#editForm").validationEngine("validate")){
		return false;
	}
	if(checkCredit()){
	var data=$('#editForm').serialize();
	var url = "<s:url value='/resedu/manage/course/saveChapter'/>";
	jboxPost(url,data, function(resp){
		var resps=resp.split(":");
		if(resps[0]=="1"){
			$("#currExpandChapterFlow").val(resps[1]);
			$("#allChapterCredit").val(resps[2]);
			getAllDataJson();
			jboxTip("${GlobalConstant.SAVE_SUCCESSED}");
			var url="<s:url value='/resedu/manage/course/editChapter'/>?chapterFlow="+resps[1]+"&level=2&courseFlow=${param.courseFlow}";
			jboxLoad("contentDiv",url,false);
		}else{
	    	jboxTip("${GlobalConstant.SAVE_FAIL}");
	    }
	   },null,false);
	}
}

$(document).ready(function(){  
			//UEditor
			var ue = UE.getEditor('ueditor', {
			    autoHeight: false,
			    imagePath: '${sysCfgMap['upload_base_url']}/',
			    imageManagerPath: '${sysCfgMap['upload_base_url']}/',
			    filePath: '${sysCfgMap['upload_base_url']}/',
			    videoPath: '${sysCfgMap['upload_base_url']}/',
			    wordImagePath: '${sysCfgMap['upload_base_url']}/',
			    snapscreenPath: '${sysCfgMap['upload_base_url']}/',
			    catcherPath: '${sysCfgMap['upload_base_url']}/',
			    scrawlPath: '${sysCfgMap['upload_base_url']}/',
			    toolbars:[
			                [/* 'fullscreen' */, /*'source',*/ '|', 'undo', 'redo', '|','lineheight',
			                    'bold', 'italic', 'underline', 'fontborder', /* 'strikethrough', */ /*'superscript', 'subscript', 'removeformat', 'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', '|',*/
			                    /* 'rowspacingtop', 'rowspacingbottom', 'lineheight', '|',
			                    'customstyle', 'paragraph', */ 'fontfamily', 'fontsize', '|',
			                    /* 'directionalityltr', 'directionalityrtl', 'indent', '|',*/ 
			                    'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|', 'touppercase', 'tolowercase', '|',
			                    /* 'link', 'unlink', 'anchor', '|', 'imagenone', 'imageleft', 'imageright', 'imagecenter', '|', */
			                    'insertimage', /* 'emotion','scrawl', 'insertvideo', 'music', 'attachment'*/, /*'map', 'gmap', 'insertframe','insertcode', 'webapp', 'pagebreak',*/ /*'template', 'background'*/, '|',
			                    /* 'horizontal', 'date', 'time', 'spechars', 'snapscreen',  'wordimage', '|',*/
			                    /*'inserttable', 'deletetable', 'insertparagraphbeforetable', 'insertrow', 'deleterow', 'insertcol', 'deletecol', 'mergecells', 'mergeright', 'mergedown', 'splittocells', 'splittorows', 'splittocols', 'charts', '|'*/,
			                    /*'print'*/,  'preview', /*'searchreplace', 'help' */, /*'drafts'*/'wordimage']
			            ]
		});
});

//上传文件
function uploadFile(id){
	var url;
	var obj = $("#"+id+"Form");
	var fileName;
	if(id=='video'){
		fileName=$("#video").val();
		if(fileName==""){
			jboxTip("请先选择文件！");
			return false;
		}
		url = "<s:url value='/resedu/manage/course/saveCourseVideo'/>";
		$("#uploadChapterVideoResult").html('<font color="red">文件上传中，请稍后...</font>');
		$("#videoStatus").val("uping");
		saveFile(url,obj,$("#uploadChapterVideoResult"),id); 
	}else if(id=='img'){
		fileName=$("#img").val();
		if(fileName==""){
			jboxTip("请先选择文件！");
			return false;
		}
		url = "<s:url value='/resedu/manage/course/saveCourseImg'/>";
		$("#uploadChapterImgResult").html('<font color="red">文件上传中，请稍后...</font>');
		$("#imgStatus").val("uping");
		saveFile(url,obj,$("#uploadChapterImgResult"),id); 
	}
}		
//上传文件原子方法		
function saveFile(url,obj,result,id){
	$("#"+id+"Btn").hide();
	jboxSubmitNoLoad($(obj), url, 
	  function(resp){
		 var jsonStr = "";
		  for(var key in resp){
			jsonStr+=resp[key];
		  }
				if(eval('('+jsonStr+')').fileUrl!=null && eval('('+jsonStr+')').fileName!=null){
					if(id=='video'){
						var chapterTime=eval('('+jsonStr+')').min+":"+eval('('+jsonStr+')').sec;
						$("#chapterTime").val(chapterTime);
						$("#chapterTimeText").text(chapterTime);
					}
					$(result).html('<font color="red">文件上传成功！</font>');
					$("#"+id+"Status").val("finish");
					$("#"+id+"File").val(eval('('+jsonStr+')').fileUrl);
					$("#"+id+"FileName").val(eval('('+jsonStr+')').fileName);
					$("#"+id+"Form")[0].reset();
					checkBlock(id);
				}else{
					var fileSizeScope=0;
					if(id=="video"){
						fileSizeScope=${sysCfgMap['res_edu_chapter_file_size']};
					}
					if(id=="img"){
						fileSizeScope=${sysCfgMap['res_edu_course_img_size']};
					}
                    if(eval('('+jsonStr+')').fileSize>fileSizeScope*1024*1024){
                    	$(result).html('<font color="red">文件太大，请重新选择文件！</font>');
                    	jboxTip("文件太大，请重新选择文件！");
                    }else{
                    	$(result).html('<font color="red">文件上传失败！</font>');
                    	jboxTip("文件上传失败！");
                    }
					$("#"+id+"Status").val("fail");
				}
				$("#"+id+"Btn").show();
			},
			function(resp){},false);
}
//选择文件
function chooseFile(id){
	return $("#"+id).click();
}
//文件业务处理
function swapFileName(id){
	var obj=$("#"+id);
	if(id=='video'){
	   $('#uploadChapterVideoName').text("");
	   $("#uploadChapterVideoResult").text("");
	   $('#uploadChapterVideoName').text(obj.val().substring(12,obj.val().length));
	   $('#videoFile').val("");
	   $('#videoFileName').val("");
	}else if(id=='img'){
	   $('#uploadChapterImgName').text("");
	   $("#uploadChapterImgResult").text("");
	   $('#uploadChapterImgName').text(obj.val().substring(12,obj.val().length));
	   $('#imgFile').val("");
	   $('#imgFileName').val("");
	}
}
//检测文件是否选择
function checkBlock(id){
	if($("#"+id).val()!=""){
	    $("#"+id+"UpLoadBtn").show();  
	}else{
		$("#"+id+"UpLoadBtn").hide();  
	}
}

//检查视频参数
function checkVideoType(obj){
     var url=$(obj).val();
     var fileType=url.substring(url.lastIndexOf('.')+1,url.length);
     var typeBox="${sysCfgMap['res_edu_chapter_file_type']}".split(",");
     var crossFlag=false;
     for(var item in typeBox){
    	 if(typeBox[item]==fileType){
    		 crossFlag=true;
	 	 } 
     }
     if(crossFlag==false){
    	 $(obj).val("");
 		 $("#uploadChapterVideoName").text("");
 		 checkBlock("video");
 		 jboxTip("只能上传类型为${sysCfgMap['res_edu_chapter_file_type']}的视频");
     }
}
//检查图片参数
function checkImgType(obj){
     var url=$(obj).val();
     var fileType=url.substring(url.lastIndexOf('.')+1,url.length);
     var typeBox="${sysCfgMap['res_edu_course_img_type']}".split(",");
     var crossFlag=false;
     for(var item in typeBox){
    	 if(typeBox[item]==fileType){
    		 crossFlag=true;
	 	 } 
     }
 	 if(crossFlag==false){
 		 $(obj).val("");
 		$("#uploadChapterImgName").text("");
 		 checkBlock("img");
 		 jboxTip("只能上传类型为${sysCfgMap['res_edu_course_img_type']}的图片");
 	 }
}
//检查学分
function checkCredit(){
	//所有章节总学分
	var allChapterCredit=parseFloat($("#allChapterCredit").val());
	if(allChapterCredit == null || allChapterCredit == undefined || allChapterCredit == '' || isNaN(allChapterCredit)){
		allChapterCredit=0;
	}
	//当前课程学分
	var courseCredit=parseFloat($("#courseCredit").val());
	if(courseCredit == null || courseCredit == undefined || courseCredit == '' || isNaN(courseCredit)){
		courseCredit=0;
	}
	//当前章节学分
	var chapterCredit=parseFloat($("#chapterCredit").val());
	if(chapterCredit == null || chapterCredit == undefined || chapterCredit == '' || isNaN(chapterCredit)){
		chapterCredit=0;
	}
	//当前章节原学分
	var currChapterCredit=parseFloat($("#currChapterCredit").val());
	if(currChapterCredit == null || currChapterCredit == undefined || currChapterCredit == '' || isNaN(currChapterCredit)){
		currChapterCredit=0;
	}
	//计算所填学分是否超限
	if((parseFloat(allChapterCredit.toFixed(2))-parseFloat(currChapterCredit.toFixed(2))+parseFloat(chapterCredit.toFixed(2)))>parseFloat(courseCredit)){
		jboxTip("您输入的学分值过大！");
		return false;
	}else{
		return true;
	}
	
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
						<input type="hidden" id="courseFlow" name="courseFlow"
						  <c:if test="${not empty chapter.courseFlow }">value="${chapter.courseFlow }"</c:if>
						  <c:if test="${empty chapter.courseFlow }">value="${param.courseFlow }"</c:if>/>
						<input type="hidden" id="chapterFlow" name="chapterFlow" value="${chapter.chapterFlow }"/>
						<input type="hidden" id="parentChapterFlow" name="parentChapterFlow"
						  <c:if test="${not empty chapter.parentChapterFlow }">value="${chapter.parentChapterFlow }"</c:if>
						  <c:if test="${empty chapter.parentChapterFlow }">value="${parentChapterFlow }"</c:if>/>
						<input type="hidden" id="chapterOrder" name="chapterOrder" value="${chapter.chapterOrder }"/>
						<input type="hidden" id="videoStatus" value=""/>
		                <input type="hidden" id="imgStatus" value=""/>
						<table class="basic" style="border-style: hidden;" id="editChapterL2"> 
							<tr>
								<th width="14%" id="chapterType"><span style="color: red">*</span>&nbsp;名&#12288;&#12288;称：</th>
								<td style="text-align: left;"><input type="text" id="chapterName" name="chapterName" class="validate[required] inputText" value="${chapter.chapterName }"/></td>
								<th width="14%"><span style="color: red">*</span>&nbsp;序&#12288;&#12288;号：</th>
								<td style="text-align: left;"><input type="text" id="chapterNo" name="chapterNo" class="validate[required] inputText" value="${chapter.chapterNo }"/></td>
							</tr>
							<tr>
								<th>章节视频：</th>
								<td colspan="3" style="text-align: left;">
								<span id="uploadChapterVideoName">
				                  <c:if test="${not empty chapter.chapterFileName }">
				                   <a href="<s:url value='/resedu/manage/course/previewCourseVideo'/>?chapterFlow=${chapter.chapterFlow}" target="_blank" title="点击预览视频">
				                                                            预览${chapter.chapterFileName }
				                   </a>
				                  </c:if>
				                </span>
				                &#12288;<span id="uploadChapterVideoResult"></span>
				                <c:if test="${param.type!='local' }">
				                <span id="videoBtn">
				                  &#12288;<a href="javascript:chooseFile('video');">[选择文件]</a>&#12288;
				                  <a href="javascript:uploadFile('video');" style="display: none;" id="videoUpLoadBtn">[上传]</a>
				                </span>
				                </c:if>
				                 <input type="hidden" name="chapterFile" id="videoFile" value="${chapter.chapterFile }"/>
				                 <input type="hidden" name="chapterFileName" id="videoFileName" value="${chapter.chapterFileName }"/>
				                 &#12288;<c:if test="${param.type!='local' }">
				                 <font color="red">可以上传类型为${sysCfgMap['res_edu_chapter_file_type']}的视频</font>
				                 </c:if>
				                 &#12288;&#12288;<a href="<s:url value='/jsp/res/edu/teacher/help.docx'/>">点击获取帮助文档</a>
								</td>
							</tr>
							<tr>
								<th>章节图片：</th>
								<td colspan="3" style="text-align: left;">
									<span id="uploadChapterImgName">
				                      <c:if test="${not empty chapter.chapterImgName }">
				                        <a href="${sysCfgMap['upload_base_url']}${chapter.chapterFile}" target="_blank" title="点击查看大图">预览${chapter.chapterImgName }</a>
				                      </c:if>
				                    </span>
				                    &#12288;<span id="uploadChapterImgResult"></span>
				                    <span id="imgBtn">
				                      &#12288;<a href="javascript:chooseFile('img');">[选择文件]</a>&#12288;
				                      <a href="javascript:uploadFile('img');" style="display: none;" id="imgUpLoadBtn">[上传]</a>
				                    </span>
				                     <input type="hidden" name="chapterImg" id="imgFile" value="${chapter.chapterImg }"/>
				                     <input type="hidden" name="chapterImgName" id="imgFileName" value="${chapter.chapterImgName }"/>
				                     &#12288;<font color="red">可以上传类型为${sysCfgMap['res_edu_course_img_type']}的图片</font>
								</td>
							</tr>
							<tr>
							    <th>时&#12288;&#12288;长：</th>
								<td colspan="3" style="text-align: left;" id="chapterTimeTd">
                	                 <input type="hidden" id="chapterTime" name="chapterTime" value="${chapter.chapterTime}"/>
                                     <span id="chapterTimeText">${chapter.chapterTime}</span>
								</td>
							</tr>
							<tr>
							    <th><span style="color: red">*</span>&nbsp;学&#12288;&#12288;分：</th>
								<td style="text-align: left;">
								     <input type="hidden" id="currChapterCredit" value="${chapter.chapterCredit}"/>
                	                 <input type="text" id="chapterCredit" class="validate[required] inputText" name="chapterCredit" value="${chapter.chapterCredit}" onblur="checkCredit();"/>
								</td>
								<th><span style="color: red">*</span>&nbsp;授课教师：</th>
								<td style="text-align: left;">
								   <select name="teacherId" class="xlselect validate[required]">
								      <option value="">请选择</option>
								      <c:forEach items="${userList }" var="user">
								         <option value="${user.userFlow }" <c:if test="${user.userFlow eq chapter.teacherId }">selected</c:if>>${user.userName }</option>
								      </c:forEach>
								   </select>
								</td>
							</tr>
							<tr>
								<th>介绍：</th>
								<td colspan="3">
									<script id="ueditor" name="chapterIntro" type="text/plain" style="height:300px;">${chapter.chapterIntro}</script>
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<input type="button" value="保&#12288;存" class="search" onclick="save()">
								</td>
							</tr>
						</table>
						</form>
						<form id="videoForm" style="display: none;">
		                   <input id="video" type="file" name="file" class="validate[required]" onchange="swapFileName('video');checkBlock('video');checkVideoType(this);" />
		                </form>
		                <form id="imgForm" style="display: none;">
		                   <input id="img" type="file" name="file" class="validate[required]" onchange="swapFileName('img');checkBlock('img');checkImgType(this);"/>
		                </form>
					</td>
				</tr>
			</table>
</c:if>