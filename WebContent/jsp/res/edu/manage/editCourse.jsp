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
<script type="text/javascript">
		function saveCourse(){
			if(false == $("#editForm").validationEngine("validate")){
				return false;
			}
			/* if($.trim($("#file").val())==""){
				jboxTip("请选择课程图片！");
				return false;
			} */
			var url = "<s:url value='/edu/manage/course/saveCourse'/>";
			jboxSubmit($('#editForm'), url, 
						function(resp){
							if(resp != "${GlobalConstant.SAVE_FAIL}"){
								if(resp.length==32){
									var url = "<s:url value='/edu/manage/course/editCourse'/>?courseFlow=" + resp;
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
		
		function reuploadScoreRange(){
			$("#scoreRangeSpan").hide();
			$("#reuploadScoreRange").hide();
			$("#reuploadScoreRangeFile").show();
		}
		
		function back(){
			var url = "<s:url value='/jsp/res/edu/manage/courseList.jsp'/>";
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
		
		function requiredRangeType(obj) {
			$(obj).closest("td").find("span").hide();
			$("#"+$(obj).val()).show();
		}
		
	</script>
</head>
<body>	
<div class="mainright">
   <div class="content">
     <div class="title1 clearfix">
		<form id="editForm" action="<s:url value='/edu/manage/course/saveCourse'/>" style="position: relative;" enctype="multipart/form-data" method="post">
		<input name="courseFlow" type="hidden" value="${course.courseFlow}"/>
   		<table class="basic" style="width: 100%;">
	   		<colgroup>
	   			<col width="15%"/>
	   			<col width="35%"/>
	   			<col width="15%"/>
	   			<col width="35%"/>
	   		</colgroup>
   			<tr>
                <td class="bs_name" colspan="4">课程信息：</td>
            </tr>
            <tr>
                <th style="width: 17%;"><span style="color: red">*</span>&nbsp;课程名称：</th>
                <td colspan="3">临床医学专业基础知识</td>
            </tr>
            <tr>
                <th>学分：</th>
            	<td>
                	<input name="courseCredit" value="5" class="validate[custom[number]] text-input xltext" type="text" />
                </td>
                <th>学时（分:秒）：</th>
            	<td>60:00</td>
            </tr>
            <tr>
            	<th><span style="color: red">*</span>&nbsp;课程类别：</th>
            	<td colspan="3">
           			<input type="radio" name="courseTypeId" class="validate[required]" value="" checked/><label>&nbsp;普通培训</label>&nbsp;
           			<input type="radio" name="courseTypeId" class="validate[required]" value=""/><label>&nbsp;岗前培训</label>&nbsp;
                </td>
            </tr>
            <tr>
            	<th>必修人员范围：</th>
            	<td colspan="3">
            		按专业：
            		<span id="specialtySpan"style="">
	           			<input type="checkbox" name="courseTypeId" class="validate[required]" value=""/><label>&nbsp;基础医学</label>&nbsp;
	           			<input type="checkbox" name="courseTypeId" class="validate[required]" value=""/><label>&nbsp;临床医学</label>&nbsp;
	                	<input type="checkbox" name="courseTypeId" class="validate[required]" value=""/><label>&nbsp;口腔医学</label>&nbsp;
	           			<input type="checkbox" name="courseTypeId" class="validate[required]" value=""/><label>&nbsp;中医学</label>&nbsp;
                    </span><br/>   
                                                 按科室：                
                    <span id="deptSpan" style="">          
	           			<input type="checkbox" name="courseTypeId" class="validate[required]" value=""/><label>&nbsp;急诊科 </label>&nbsp;
	           			<input type="checkbox" name="courseTypeId" class="validate[required]" value=""/><label>&nbsp;儿科</label>&nbsp;
	                	<input type="checkbox" name="courseTypeId" class="validate[required]" value=""/><label>&nbsp;眼科</label>&nbsp;
	           			<input type="checkbox" name="courseTypeId" class="validate[required]" value=""/><label>&nbsp;妇科</label>&nbsp;
	           			<input type="checkbox" name="courseTypeId" class="validate[required]" value=""/><label>&nbsp;产科</label>&nbsp;
               	    	<input type="checkbox" name="courseTypeId" class="validate[required]" value=""/><label>&nbsp;消化科</label>&nbsp;
               	    	<input type="checkbox" name="courseTypeId" class="validate[required]" value=""/><label>&nbsp;心内科</label>&nbsp;
               	    </span><br/>
               	          按人员：<input type="button" value="&nbsp;&nbsp;选择人员&nbsp;&nbsp;"  onclick="userMain();" />
                </td>
            </tr>
            <tr>
            	<th>计分人员范围：</th>
            	<td colspan="3">
            		按专业：
            		<span id="specialtySpan"style="">
	           			<input type="checkbox" name="courseTypeId" class="validate[required]" value=""/><label>&nbsp;基础医学</label>&nbsp;
	           			<input type="checkbox" name="courseTypeId" class="validate[required]" value=""/><label>&nbsp;临床医学</label>&nbsp;
	                	<input type="checkbox" name="courseTypeId" class="validate[required]" value=""/><label>&nbsp;口腔医学</label>&nbsp;
	           			<input type="checkbox" name="courseTypeId" class="validate[required]" value=""/><label>&nbsp;中医学</label>&nbsp;
                    </span><br/>   
                                                 按科室：                
                    <span id="deptSpan" style="">          
	           			<input type="checkbox" name="courseTypeId" class="validate[required]" value=""/><label>&nbsp;急诊科 </label>&nbsp;
	           			<input type="checkbox" name="courseTypeId" class="validate[required]" value=""/><label>&nbsp;儿科</label>&nbsp;
	                	<input type="checkbox" name="courseTypeId" class="validate[required]" value=""/><label>&nbsp;眼科</label>&nbsp;
	           			<input type="checkbox" name="courseTypeId" class="validate[required]" value=""/><label>&nbsp;妇科</label>&nbsp;
	           			<input type="checkbox" name="courseTypeId" class="validate[required]" value=""/><label>&nbsp;产科</label>&nbsp;
               	    	<input type="checkbox" name="courseTypeId" class="validate[required]" value=""/><label>&nbsp;消化科</label>&nbsp;
               	    	<input type="checkbox" name="courseTypeId" class="validate[required]" value=""/><label>&nbsp;心内科</label>&nbsp;
               	    </span><br/>
               	          按人员：<input type="button" value="&nbsp;&nbsp;选择人员&nbsp;&nbsp;"  onclick="userMain();" />
                </td>
            </tr>
            <tr>
				<th>课程视频：</th>
				<td colspan="3">[<a href="<s:url value='/jsp/res/edu/manage/courseVideo.jsp'/>" target="_blank">预览</a>]</td>
			</tr>
			<tr>
				<th style="width: 17%;">课程图片：</th>
	            <td colspan="3">[<a href="<s:url value='/jsp/edu/css/images/loginbar.jpg'/>" target="_blank">预览</a>]</td>
			</tr>
			<tr>
				<th>课程介绍：</th>
				<td colspan="3">
					临床医学专业是一门实践性很强的应用科学专业。它致力于培养具备基础医学、临床医学的基本理论和医疗预防的基本技能；能在医疗卫生单位、医学科研等部门从事医疗及预防、医学科研等方面工作的医学高级专门人才。该专业学生主要学习医学方面的基础理论和基本知识，人类疾病的诊断、治疗、预防方面的基本训练．具有对人类疾病的病因、发病机制做出分类鉴别的能力。
				</td>
			</tr>
			</table>
			
			<p align="center" style="width:100%">
				<input class="search" type="button" value="发&#12288;布"  onclick="" />
				<input class="search" type="button" value="返&#12288;回"  onclick="back();" />
			</p>
		</form>
    </div>
  </div> 	
</div>
</body>
</html>