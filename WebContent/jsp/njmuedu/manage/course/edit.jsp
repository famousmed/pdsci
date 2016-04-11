<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="compatible" value="true"/>
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
	<jsp:param name="jquery_ztree" value="true"/>
	<jsp:param name="ueditor" value="true"/>
</jsp:include>
<style type="text/css">
	#ueditor{
		width: 85%;
		margin: 10px 10px 10px 0px;
	}
</style>
<script type="text/javascript">
		$(document).ready(function(){
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
		
		function saveCourse(){
			if(false == $("#editForm").validationEngine("validate")){
				return false;
			}
			/* if($.trim($("#file").val())==""){
				jboxTip("请选择课程图片！");
				return false;
			} */
			var url = "<s:url value='/njmuedu/manage/course/saveCourse'/>";
			jboxSubmit($('#editForm'), url, 
						function(resp){
							if(resp != "${GlobalConstant.SAVE_FAIL}"){
								if(resp.length==32){
									var url = "<s:url value='/njmuedu/manage/course/editCourse'/>?courseFlow=" + resp;
									window.location.href=url;
									jboxTip("${GlobalConstant.SAVE_SUCCESSED}");
								}else{
									jboxTip(resp);
								}
							}else{
								jboxTip("${GlobalConstant.SAVE_FAIL}");
							}
						},
						function(resp){},false);
		}
		
		function delImg(courseFlow){
			jboxConfirm("确认删除？", function(){
				var url = "<s:url value='/njmuedu/manage/course/deleteCourseImg'/>?courseFlow=" + courseFlow;
				jboxPost(url,null,function(resp){
					if(resp=='${GlobalConstant.DELETE_SUCCESSED}'){
						$("input[name='courseImg']").val("");
						reuploadImg();
						jboxTip("删除图片成功！");
					}
				},null,true);
			});
		}
		
		function reuploadImg(){
			$("#viewImgLink").hide();
			$("#delImgLink").hide();
			$("#reuploadImgLink").hide();
			$("#newFile").show(); 
		}
		
		function back(){
			var url = "<s:url value='/njmuedu/manage/course/courseList'/>";
			window.location.href=url;
		}
		function checkTime(field, rules, i, options){
			var time = field.val();
			var regxString = /^[1-9][0-9]*:[0-9]{2}$/;
			if (time!="") {
				if(!regxString.test(time)){
					return "* 请输入指定格式的时间";
					}
			}
		}
	</script>
</head>
<body>	
<div class="mainright">
   <div class="content">
     <div class="title1 clearfix">
     	<c:if test="${empty sysCfgMap['upload_base_url']}">请联系系统管理员先在系统配置中配置上传图片的路径</c:if>
     	<c:if test="${not empty sysCfgMap['upload_base_url']}">
		<form id="editForm" action="<s:url value='/njmuedu/manage/course/saveCourse'/>" style="position: relative;" enctype="multipart/form-data" method="post">
		<input name="courseFlow" type="hidden" value="${course.courseFlow}"/>
   		<table class="basic" style="width: 100%;">
   			<tr>
                <td class="bs_name" colspan="4">课程信息：</td>
            </tr>
            <tr>
                <th style="width: 17%;"><span style="color: red">*</span>&nbsp;课程名称：</th>
                <td colspan="3">
                	<input name="courseName" value="${course.courseName}" class="validate[required] text-input xltext" type="text" style="width: 70%" />
                </td>
            </tr>
            <tr>
            	<th><span style="color: red">*</span>&nbsp;专业名称：</th>
            	<td>
            		<select name="courseMajorId" class="xlselect validate[required]">
		               <option value="">请选择</option>
		               <c:forEach var="dict" items="${dictTypeEnumNjmuCourseMajorList}">
		               <option value="${dict.dictId }" <c:if test="${course.courseMajorId eq dict.dictId }">selected="selected"</c:if>>${dict.dictName }</option> 
		               </c:forEach>
		            </select>
                </td>
                <th><span style="color: red">*</span>&nbsp;学分：</th>
            	<td>
                	<input name="courseCredit" value="${course.courseCredit}" class="validate[required,custom[number]] text-input xltext" type="text" />
                </td>
            </tr>
            <tr>
            	<th><span style="color: red">*</span>&nbsp;课程类别：</th>
            	<td>
           			<c:forEach var="courseType" items="${njmuEduCourseTypeEnumList}">
           			<input type="radio" name="courseTypeId" id="courseType_${courseType.id}" class="validate[required]" value="${courseType.id}" <c:if test="${course.courseTypeId eq courseType.id}">checked="checked"</c:if>/><label for="courseType_${courseType.id}">&nbsp;${courseType.name}</label>&nbsp;
                   	</c:forEach>
                </td>
                <th><span style="color: red">*</span>&nbsp;总学时：</th>
            	<td>
                	<input name="coursePeriod" value="${course.coursePeriod}" class="validate[required,custom[number]] text-input xltext" type="text" />
                </td>
            </tr>
            
			<tr>
				<th style="width: 17%;">课程图片：</th>
				<c:if test="${empty course.courseImg}" >
	                <td colspan="3">
	                	<input type="file" name="file"/>
	                </td>	
                </c:if> 
                <c:if test="${not empty course.courseImg}" >
	                <td colspan="3">
	                	<input type="hidden" name="courseImg" value="${course.courseImg}"/>
	                	<input type="file" id="newFile" name="file" style="display: none;"/>
	                	<a id="viewImgLink" href="${sysCfgMap['upload_base_url']}/${course.courseImg}" target="_blank" title="点击查看大图"><img src="${sysCfgMap['upload_base_url']}/${course.courseImg}" width="150px" height="150px"/></a>&#12288;
	                	<a id="delImgLink" href="javascript:void(0)" onclick="delImg('${course.courseFlow}')" >[删除图片]</a>
	                	<a id="reuploadImgLink" href="javascript:void(0)" onclick="reuploadImg()">[重新上传图片]</a>
	                </td>
                </c:if>          
			</tr>
			<tr>
				<th>课程介绍：</th>
				<td colspan="3">
					<script id="ueditor" name="courseIntro" type="text/plain" style="height:300px;">${course.courseIntro}</script>
				</td>
			</tr>
			</table>
			
			<p align="center" style="width:100%">
				<input class="search" type="button" value="保&#12288;存"  onclick="saveCourse();" />
				<input class="search" type="button" value="返&#12288;回"  onclick="back();" />
			</p>
		</form>
		</c:if>
    </div>
  </div> 	
</div>
</body>
</html>