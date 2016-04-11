<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="compatible" value="false"/>
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="true"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
	<jsp:param name="jquery_ui_sortable" value="false"/>
	<jsp:param name="jquery_cxselect" value="false"/>
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
	<jsp:param name="jquery_ztree" value="false"/>
	<jsp:param name="ueditor" value="true"/>
</jsp:include>
<script type="text/javascript">
        function save(){
        	var videoStatusVal=$("#videoStatus").val();
        	var imgStatusVal=$("#imgStatus").val();
        	if(videoStatusVal=="uping" || imgStatusVal=="uping"){
        		jboxTip("文件正在上传中，请稍等！");
        		return false;
        	}else if(videoStatusVal=="fail"){
        		jboxTip("文件上传失败，请重试！");
        		return false;
        	}
        	if($("#editForm").validationEngine("validate")){
        		jboxStartLoading();
        		$("#editForm").submit();
        		jboxEndLoading();
        	}
        }
        
		$(document).ready(function(){
			if('${param.type}'=='save'){
				jboxTip('${GlobalConstant.SAVE_SUCCESSED}');
			}
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
		
		
		function delImg(courseFlow){
			jboxConfirm("确认删除？", function(){
				var url = "<s:url value='/edu/manage/course/deleteCourseImg'/>?courseFlow=" + courseFlow;
				jboxPost(url,null,function(resp){
					if(resp=='${GlobalConstant.DELETE_SUCCESSED}'){
						$("input[name='courseImg']").val("");
						reuploadImg();
						jboxTip("删除图片成功！");
					}
				},null,true);
			});
		}
	
		function back(){
			var page='${param.page}';
			if(page==""){
				page=1;
			}
			var url = "<s:url value='/resedu/manage/course/courseList/${sessionScope[GlobalConstant.USER_LIST_SCOPE] }'/>?courseFlow=${course.courseFlow}&currentPage="+page;
			window.location.href=url;
		}
		
		
		function requiredRangeType(obj) {
			$(obj).closest("td").find("span").hide();
			$("#"+$(obj).val()).show();
		}
		
		function chooseUser(type){
			var w = $('.mainright').width()*0.8;
			var h = $('.mainright').height()*0.8;
			var url = "<s:url value='/resedu/manage/course/searchUser'/>?type="+type+"&no=first";
			jboxOpen(url, "选择人员",w, h);
		}
		
		function chooseSchDept(type){
			var w = $('.mainright').width()*0.8;
			var h = $('.mainright').height()*0.6;
			var url = "<s:url value='/resedu/manage/course/searchSchDept'/>?type="+type;
			jboxOpen(url, "选择轮转科室",w, h);
		}
		
		function chooseMajor(type){
			var w = $('.mainright').width()*0.8;
			var h = $('.mainright').height()*0.6;
			var url = "<s:url value='/resedu/manage/course/searchMajor'/>?type="+type;
			jboxOpen(url, "选择培训专业",w, h);
		}
		
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
				$("#uploadCourseVideoResult").html('<font color="red">文件上传中，请稍后...</font>');
				$("#videoStatus").val("uping");
				saveFile(url,obj,$("#uploadCourseVideoResult"),id); 
			}else if(id=='img'){
				fileName=$("#img").val();
				if(fileName==""){
					jboxTip("请先选择文件！");
					return false;
				}
				url = "<s:url value='/resedu/manage/course/saveCourseImg'/>";
				$("#uploadCourseImgResult").html('<font color="red">文件上传中，请稍后...</font>');
				$("#imgStatus").val("uping");
				saveFile(url,obj,$("#uploadCourseImgResult"),id); 
			}
		}
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
		function chooseFile(id){
			return $("#"+id).click();
		}
		function swapFileName(id){
			var obj=$("#"+id);
			if(id=='video'){
			   $('#uploadCourseVideoName').text("");
			   $("#uploadCourseVideoResult").text("");
			   $('#uploadCourseVideoName').text(obj.val().substring(12,obj.val().length));
			   $('#videoFile').val("");
			   $('#videoFileName').val("");
			}else if(id=='img'){
			   $('#uploadCourseImgName').text("");
			   $("#uploadCourseImgResult").text("");
			   $('#uploadCourseImgName').text(obj.val().substring(12,obj.val().length));
			   $('#imgFile').val("");
			   $('#imgFileName').val("");
			}
		}
		function checkBlock(id){
			if($("#"+id).val()!=""){
			    $("#"+id+"UpLoadBtn").show();  
			}else{
				$("#"+id+"UpLoadBtn").hide();  
			}
		}
		
		
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
		 		 $("#uploadCourseVideoName").text("");
		 		 checkBlock("video");
		 		 jboxTip("只能上传类型为${sysCfgMap['res_edu_chapter_file_type']}的视频");
		     }
		}
		
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
		 		$("#uploadCourseImgName").text("");
		 		 checkBlock("img");
		 		 jboxTip("只能上传类型为${sysCfgMap['res_edu_course_img_type']}的图片");
		 	 }
		}
	</script>
	<style type="text/css">
	#ueditor{width: 85%;margin: 10px 10px 10px 0px;}
	</style>
</head>
<body>	
<div class="mainright">
   <div class="content">
     <div class="title1 clearfix">
     	<c:if test="${empty sysCfgMap['upload_base_url']}">请联系系统管理员先在系统配置中配置文件上传的路径</c:if>
     	<c:if test="${not empty sysCfgMap['upload_base_url']}">
		<form id="editForm" action="<s:url value='/resedu/manage/course/saveCourse'/>" style="position: relative;" method="post">
	    <input name="type" type="hidden" value="save"/> 
		<input name="courseFlow" type="hidden" value="${course.courseFlow}"/>
		<input name="chapterFlow" type="hidden" value="${chapter.chapterFlow}"/>
		<c:if test="${sessionScope[GlobalConstant.USER_LIST_SCOPE] eq GlobalConstant.USER_LIST_PERSONAL}">
		<input name="courseCategoryId" type="hidden" value="${course.courseCategoryId}"/>
		</c:if>
		<input type="hidden" id="videoStatus" value=""/>
		<input type="hidden" id="imgStatus" value=""/>
   		<table class="basic" style="width: 100%;">
   		<colgroup>
   		     <col width="16%"/>
   		     <col width="16%"/>
   		     <col width="16%"/>
   		     <col width="16%"/>
   		     <col width="16%"/>
   		     <col width="16%"/>
   		  </colgroup>
   			<tr>
                <td colspan="6">课程信息：</td>
            </tr>
            <tr>
                <th><span style="color: red">*</span>&nbsp;课程名称：</th>
                <td colspan="3">
                   <c:if test="${sessionScope[GlobalConstant.USER_LIST_SCOPE] != GlobalConstant.USER_LIST_LOCAL}">
                	<input name="courseName" value="${course.courseName}" class="validate[required] inputText" type="text" style="width: 90%;text-align: left;" />
                   </c:if>
                   <c:if test="${sessionScope[GlobalConstant.USER_LIST_SCOPE] eq GlobalConstant.USER_LIST_LOCAL}">
                     ${course.courseName}
                   </c:if>
                </td>
                <th><span style="color: red">*</span>&nbsp;主讲人：</th>
                <td>
                 <c:if test="${sessionScope[GlobalConstant.USER_LIST_SCOPE] != GlobalConstant.USER_LIST_LOCAL}">
                  <input type="text" name="courseSpeaker" value="${course.courseSpeaker }" class="inputText validate[required]" style="width:80%;text-align: left;"/>
                 </c:if>
                 <c:if test="${sessionScope[GlobalConstant.USER_LIST_SCOPE] eq GlobalConstant.USER_LIST_LOCAL}">
                   ${course.courseSpeaker }
                 </c:if>
                </td>
            </tr>
            <tr>
                <th><span style="color: red">*</span>&nbsp;学分：</th>
            	<td>
                	<input name="courseCredit" value="${course.courseCredit}" class="validate[required,custom[number]] inputText" type="text" style="text-align: left;"/>
                </td>
                <th><span style="color: red">*</span>&nbsp;学时：</th>
            	<td>
                	<input name="coursePeriod" value="${course.coursePeriod}" class="validate[required,custom[number]] inputText" type="text" style="text-align: left;"/>
                </td>
                <th><span style="color: red">*</span>&nbsp;上传科室：</th>
                <td>
                    <select name="deptFlow" class="xlselected">
                       <option value="">请选择</option>
                       <c:forEach items="${deptList }" var="dept">
                           <option value="${dept.deptFlow }" <c:if test="${course.deptFlow eq dept.deptFlow }">selected</c:if>>${dept.deptName }</option>
                       </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
               <th>课程类别：</th>
               <td colspan="5" style="text-align: left;">
                  <c:forEach items="${eduCourseCategoryEnumList }" var="courseCategory">
                      <input type="radio" id="courseCategory_${courseCategory.id }" name="courseCategoryId" value="${courseCategory.id }" <c:if test="${courseCategory.id eq course.courseCategoryId }">checked</c:if>>
                      <label for="courseCategory_${courseCategory.id }">${courseCategory.name }</label>
                  </c:forEach>
               </td>
            </tr>
            <tr>
            	<th>必修人员范围：</th>
            	<td colspan="5">
            	 <table width="100%">
            	  <colgroup>
            	    <col width="15%"/>
            	    <col width="85%"/>
            	  </colgroup>
            	   <tr>
            	      <td>${requiredUserScopeEnumMajor.name }：</td>
            	      <td>
            	        <input type="button" value="&#12288;选择培训专业&#12288;"  onclick="chooseMajor('required');" />
            	         <span id="requiredMajorCount"><c:if test="${not empty refMap['requireMajorList']}"><br/></c:if>
            	             <c:forEach items="${refMap['requireMajorList'] }" var="item" varStatus="num">
            	              <c:forEach items="${dictTypeEnumDoctorTrainingSpeList }" var="dict">
            	               <c:if test="${item eq dict.dictId }">
                               ${dict.dictName }<c:if test="${num.count!=fn:length(refMap['requireMajorList']) }">，</c:if> 
                               </c:if>
                             </c:forEach>
                            </c:forEach>
            	          </span>
            	      </td>
            	   </tr>
            	   <tr>
            	      <td>${requiredUserScopeEnumDept.name }：</td>
            	      <td>
            	          <input type="button"  value="&#12288;选择轮转科室&#12288;"  onclick="chooseSchDept('required');" />
            	          <span id="requiredSchDeptCount"><c:if test="${not empty refMap['requireDeptList']}"><br/></c:if>
            	             <c:forEach items="${refMap['requireDeptList'] }" var="item" varStatus="num">
            	               <c:forEach items="${schDeptList }" var="schDept">
            	               <c:if test="${item eq schDept.schDeptFlow }">
                               ${schDept.schDeptName }<c:if test="${num.count!=fn:length(refMap['requireDeptList']) }">，</c:if> 
                               </c:if>
                             </c:forEach>
                            </c:forEach>
            	          </span>
            	      </td>
            	   </tr>
            	   <tr>
            	      <td>${requiredUserScopeEnumUser.name }：</td>
            	      <td>
            	        <ul id="requiredUl"></ul>
            	        <input type="button" value="&#12288;选择必修人员&#12288"  onclick="chooseUser('required');" />
            	        &#12288;已选择&nbsp;<span id="requiredUserCount"><font color="red"><c:out default="0" value="${fn:length(refMap['requireUserList']) }"/></font>&nbsp;</span>人
            	      </td>
            	   </tr>
            	 </table>
            	</td>
            </tr>
            <tr>
            	<th>计分人员范围：</th>
            	<td colspan="5">
            	 <table width="100%">
            	  <colgroup>
            	    <col width="15%"/>
            	    <col width="85%"/>
            	  </colgroup>
            	   <tr>
            	      <td>${scoreUserScopeEnumMajor.name }：</td>
            	      <td>
            	        <input type="button" value="&#12288;选择培训专业&#12288;"  onclick="chooseMajor('score');" />
            	         <span id="scoreMajorCount"><c:if test="${not empty refMap['scoreMajorList']}"><br/></c:if>
            	             <c:forEach items="${refMap['scoreMajorList'] }" var="item" varStatus="num">
            	              <c:forEach items="${dictTypeEnumDoctorTrainingSpeList }" var="dict">
            	               <c:if test="${item eq dict.dictId }">
                               ${dict.dictName }<c:if test="${num.count!=fn:length(refMap['scoreMajorList']) }">，</c:if> 
                               </c:if>
                             </c:forEach>
                            </c:forEach>
            	          </span>
            	      </td>
            	   </tr>
            	   <tr>
            	      <td>${scoreUserScopeEnumDept.name }：</td>
            	      <td>
            	        <input type="button" value="&#12288;选择轮转科室&#12288;"  onclick="chooseSchDept('score');" />
            	          <span id="scoreSchDeptCount"><c:if test="${not empty refMap['scoreDeptList']}"><br/></c:if>
            	             <c:forEach items="${refMap['scoreDeptList'] }" var="item" varStatus="num">
                               <c:forEach items="${schDeptList }" var="schDept">
            	               <c:if test="${item eq schDept.schDeptFlow }">
                                  ${schDept.schDeptName }<c:if test="${num.count!=fn:length(refMap['scoreDeptList']) }">，</c:if> 
                               </c:if>
                               </c:forEach>
                             </c:forEach>
            	          </span>
            	      </td>
            	   </tr>
            	   <tr>
            	      <td>${scoreUserScopeEnumUser.name }：</td>
            	      <td>
            	        <ul id="scoreUl"></ul>
            	        <input type="button" value="&#12288;选择计分人员&#12288;"  onclick="chooseUser('score');" />
            	        &#12288;已选择&nbsp;<span id="scoreUserCount"><font color="red"><c:out default="0" value="${fn:length(refMap['scoreUserList']) }"/></font>&nbsp;</span>人
            	      </td>
            	   </tr>
            	 </table>
            	</td>
            </tr>
            <tr>
            	<th>计学时人员范围：</th>
            	<td colspan="5" >
            	 <table width="100%">
            	  <colgroup>
            	    <col width="15%"/>
            	    <col width="85%"/>
            	  </colgroup>
            	   <tr>
            	      <td>${periodUserScopeEnumMajor.name }：</td>
            	      <td>
            	       <input type="button" value="&#12288;选择培训专业&#12288;"  onclick="chooseMajor('period');" />
            	         <span id="periodMajorCount"><c:if test="${not empty refMap['periodMajorList']}"><br/></c:if>
            	             <c:forEach items="${refMap['periodMajorList'] }" var="item" varStatus="num">
            	              <c:forEach items="${dictTypeEnumDoctorTrainingSpeList }" var="dict">
            	               <c:if test="${item eq dict.dictId }">
                               ${dict.dictName }<c:if test="${num.count!=fn:length(refMap['periodMajorList']) }">，</c:if> 
                               </c:if>
                             </c:forEach>
                            </c:forEach>
            	          </span>
            	      </td>
            	   </tr>
            	   <tr>
            	      <td>${periodUserScopeEnumDept.name }：</td>
            	      <td>
            	       <input type="button" value="&#12288;选择轮转科室&#12288;"  onclick="chooseSchDept('period');" />
            	          <span id="periodSchDeptCount"><c:if test="${not empty refMap['periodDeptList']}"><br/></c:if>
            	             <c:forEach items="${refMap['periodDeptList'] }" var="item" varStatus="num">
                                <c:forEach items="${schDeptList }" var="schDept">
            	                  <c:if test="${item eq schDept.schDeptFlow }">
                                    ${schDept.schDeptName }<c:if test="${num.count!=fn:length(refMap['periodDeptList']) }">，</c:if> 
                                  </c:if>
                                </c:forEach>
                             </c:forEach>
            	          </span>
            	      </td>
            	   </tr>
            	   <tr>
            	      <td>${periodUserScopeEnumUser.name }：</td>
            	      <td>
            	        <ul id="periodUl"></ul>
            	        <input type="button" value="&nbsp;&nbsp;选择计学时人员&nbsp;&nbsp;"  onclick="chooseUser('period');" />
            	        &#12288;已选择&nbsp;<span id="periodUserCount"><font color="red"><c:out default="0" value="${fn:length(refMap['periodUserList']) }"/></font>&nbsp;</span>人
            	      </td>
            	   </tr>
            	 </table>
            	</td>
            </tr>
			<tr>
				<th>课程图片：</th>
				<td colspan="5">
				   <span id="uploadCourseImgName">
				     <c:if test="${not empty course.courseImgName }">
				      <a href="${sysCfgMap['upload_base_url']}${course.courseImg}" target="_blank" title="点击查看大图">${course.courseImgName }</a>
				     </c:if>
				   </span>
				   &#12288;<span id="uploadCourseImgResult"></span>
				   <span id="imgBtn">
				   &#12288;<a href="javascript:chooseFile('img');">[选择文件]</a>&#12288;
				   <a href="javascript:uploadFile('img');" style="display: none;" id="imgUpLoadBtn">[上传]</a>
				   </span>
				   <input type="hidden" name="courseImg" id="imgFile" value="${course.courseImg }"/>
				   <input type="hidden" name="courseImgName" id="imgFileName" value="${course.courseImgName }"/>
				   &#12288;<font color="red">可以上传类型为${sysCfgMap['res_edu_course_img_type']}的图片</font>
				</td>
			</tr>
			<tr>
				<th>课程介绍：</th>
				<td colspan="5" style="line-height: 20px;">
				 <c:if test="${param.type!='local' }">
					<script id="ueditor" name="courseIntro" type="text/plain" style="height:300px;">${course.courseIntro}</script>
				 </c:if>
				 <c:if test="${param.type=='local' }">
				    ${course.courseIntro}
				 </c:if>
				</td>
			</tr>
			</table>
			
			<p align="center" style="width:100%">
				<input class="search" type="button" id="saveButton" <c:if test="${param.type!='local' }">value="保&#12288;存"</c:if><c:if test="${param.type=='local' }">value="发&#12288;布"</c:if> onclick="save();" />
				<!-- <input class="search" type="button" value="发&#12288;布"  onclick="" /> -->
				<input class="search" type="button" value="返&#12288;回"  onclick="back();" />
			</p>
			<div id="requiredMajorRom" style="display: none;">
             <c:forEach items="${refMap['requireMajorList'] }" var="item">
                 <c:forEach items="${dictTypeEnumDoctorTrainingSpeList }" var="dict">
                   <c:if test="${item eq dict.dictId }">
                    <input type="text" id="${dict.dictId }" aliasname="${dict.dictName}" name="requiredDoctorTrainingSpe" value="${dict.dictId }"/> 
                   </c:if>
                 </c:forEach>
             </c:forEach>
            </div>
            <div id="requiredSchDeptRom" style="display: none;">
             <c:forEach items="${refMap['requireDeptList'] }" var="item">
                  <c:forEach items="${schDeptList }" var="schDept">
                     <c:if test="${item eq schDept.schDeptFlow }">
                     <input type="text" id="${schDept.schDeptFlow}" aliasname="${schDept.schDeptName}"  name="requiredSchDept" value="${schDept.schDeptFlow}"/> 
                     </c:if>
                 </c:forEach>
             </c:forEach>
            </div>
			<div id="requiredUserRom" style="display: none;">
             <c:forEach items="${refMap['requireUserList'] }" var="item">
                  <input type="text" id="${item }" name="requiredUserFlow" value="${item }"/> 
             </c:forEach>
            </div>
            <div id="scoreMajorRom" style="display: none;">
             <c:forEach items="${refMap['scoreMajorList'] }" var="item">
                <c:forEach items="${dictTypeEnumDoctorTrainingSpeList }" var="dict">
                   <c:if test="${item eq dict.dictId }">  
                     <input type="text" id="${dict.dictId }" aliasname="${dict.dictName}" name="scoreDoctorTrainingSpe" value="${dict.dictId }"/>  
                   </c:if>
                </c:forEach>
             </c:forEach>
            </div>
            <div id="scoreSchDeptRom" style="display: none;">
               <c:forEach items="${refMap['scoreDeptList'] }" var="item">
                  <c:forEach items="${schDeptList }" var="schDept">
                     <c:if test="${item eq schDept.schDeptFlow }">
                     <input type="text" id="${schDept.schDeptFlow}" aliasname="${schDept.schDeptName}"  name="scoreSchDept" value="${schDept.schDeptFlow}"/> 
                     </c:if>
                 </c:forEach>
             </c:forEach>
            </div>
            <div id="scoreUserRom" style="display: none;">
             <c:forEach items="${refMap['scoreUserList'] }" var="item">
                  <input type="text" id="${item }" name="scoreUserFlow" value="${item }"/> 
             </c:forEach>
            </div>
            <div id="periodMajorRom" style="display: none;">
             <c:forEach items="${refMap['periodMajorList'] }" var="item">
                  <c:forEach items="${dictTypeEnumDoctorTrainingSpeList }" var="dict">
                   <c:if test="${item eq dict.dictId }">  
                     <input type="text" id="${dict.dictId }" aliasname="${dict.dictName}" name="periodDoctorTrainingSpe" value="${dict.dictId }"/>  
                   </c:if>
                </c:forEach>
             </c:forEach>
            </div>
            <div id="periodSchDeptRom" style="display: none;">
                <c:forEach items="${refMap['periodDeptList'] }" var="item">
                   <c:forEach items="${schDeptList }" var="schDept">
                     <c:if test="${item eq schDept.schDeptFlow }">
                       <input type="text" id="${schDept.schDeptFlow}" aliasname="${schDept.schDeptName}"  name="periodSchDept" value="${schDept.schDeptFlow}"/> 
                     </c:if>
                   </c:forEach>
                 </c:forEach>
            </div>
            <div id="periodUserRom" style="display: none;">
             <c:forEach items="${refMap['periodUserList'] }" var="item">
                  <input type="text" id="${item }" name="periodUserFlow" value="${item }"/> 
             </c:forEach>
            </div>
		</form>
		 <form id="videoForm" style="display: none;">
		<input id="video" type="file" name="file" class="validate[required]" onchange="swapFileName('video');checkBlock('video');checkVideoType(this);" />
		</form>
		<form id="imgForm" style="display: none;">
		<input id="img" type="file" name="file" class="validate[required]" onchange="swapFileName('img');checkBlock('img');checkImgType(this);"/>
		</form>
		</c:if>
<div id="requiredMajorRam" style="display: none;"></div>
<div id="requiredSchDeptRam" style="display: none;"></div>
<div id="requiredUserRam" style="display: none;"></div>
<div id="scoreMajorRam" style="display: none;"></div>
<div id="scoreSchDeptRam" style="display: none;"></div>
<div id="scoreUserRam" style="display: none;"></div>
<div id="periodMajorRam" style="display: none;"></div>
<div id="periodSchDeptRam" style="display: none;"></div>
<div id="periodUserRam" style="display: none;"></div>
<span id="br" style="display: none;"><br id=""/></span>
    </div>
  </div> 	
</div>

</body>
</html>