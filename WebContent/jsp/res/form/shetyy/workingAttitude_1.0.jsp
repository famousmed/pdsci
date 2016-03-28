<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<c:if test="${!param.noHead}">
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
	<jsp:param name="jquery_ui_sortable" value="false"/>
	<jsp:param name="jquery_cxselect" value="true"/>
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
</c:if>
<style type="text/css">
	.teacherItem {
		width: 100px;
		text-align: center;
	}
	.selfItem{
		width: 100px;
		text-align: center;
	}
	.center{
		width: 100px;
		text-align: center;
	}
</style>
<script type="text/javascript">
	
	function saveForm(){
		if($("#campaignForm").validationEngine("validate")){
			jboxPost("<s:url value='/res/rec/saveRegistryForm'/>",$('#campaignForm').serialize(),function(resp){
				if(resp="${GlobalConstant.SAVE_SUCCESSED}"){
					parentRefresh();
					jboxClose();
				}
			},null,true);
		}
	}
	function sum(flag){
		var zhonghe = 0;
		var $item = $("."+flag+"Item");
		$item.each(function(){
			var value = this.value;
			if(value!="" && !isNaN(value)){
				var numItem = parseInt(value);
				zhonghe+=numItem;
			}
		});
		$("#"+flag+"Total").val(zhonghe);
	}
	
	//$(function(){
		//<c:if test="${rec.auditStatusId eq recStatusEnumTeacherAuditY.id || !(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR) || param.isRead}">
// 			$("#campaignForm").find(":text,textarea").each(function(){
// 				$(this).replaceWith($('<label>'+$(this).val()+'</label>'));
// 			});
// 			$("#campaignForm select").each(function(){
// 				var text = $(this).find(":selected").text();
// 				$(this).replaceWith($('<label>'+text+'</label>'));
// 			});
// 			$("#campaignForm").find(":checkbox,:radio").attr("disabled",true);
// 			$(":file").remove();
	//	</c:if>
	//});
	$(function(){
		<c:if test="${rec.auditStatusId eq recStatusEnumTeacherAuditY.id}">
			$(":input").attr("readonly",true);
			$("select,:radio,:checkbox").attr("disabled",true);
			$(".BC").attr("hidden",true);
			$(".selfItem").removeAttr("onblur");
			$(".teacherItem").removeAttr("onblur");
		</c:if>
		<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">
			$(".teacherItem").attr("readonly",true);
			$("[type='checkbox']").attr("disabled",true);
			$(".teacherItem").removeAttr("onblur");
		</c:if>
		<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_TEACHER}">
			$(".selfItem").attr("readonly",true);
			$(".selfItem").removeAttr("onblur");
		</c:if>
		<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_HEAD}">
			$(":input").attr("readonly",true);
			$("select,:radio,:checkbox").attr("disabled",true);
			$(".BC").attr("hidden",true);
			$(".selfItem").removeAttr("onblur");
			$(".teacherItem").removeAttr("onblur");
		</c:if>
		


	});
	  function single(box){
	    var curr=box.checked;
		   if(curr){
			var name=box.name;
			$(":checkbox[name='"+name+"']").attr("checked",false);
		    }
		    box.checked = curr;
	  }

	
	function recSubmit(rec){
		jboxConfirm("确认提交?",function(){
			jboxPost("<s:url value='/res/rec/opreResRec'/>",rec,function(resp){
				if(resp=="${GlobalConstant.DELETE_SUCCESSED}" || resp=="${GlobalConstant.OPRE_SUCCESSED}"){
					parentRefresh();
					
					jboxClose();
				}
			},null,true);
		},null);
	}
	
	function parentRefresh(){
		//window.parent.frames['mainIframe'].window.$(".recTypeTag.active").click();
		window.parent.document.mainIframe.location.reload();
		//window.parent.frames['mainIframe'].window.loadProcess();
		
	}
</script>
</head>
<body>
	<div class="mainright">
      <div class="content">
        <div class="title1 clearfix">
		<form id="campaignForm">
		<input type="hidden" name="formFileName" value="${formFileName}"/>
		<input type="hidden" name="schDeptFlow" value="${param.schDeptFlow}"/>
		<input type="hidden" name="recFlow" value="${rec.recFlow}"/>
		<input type="hidden" name="processFlow" value="${currRegProcess.processFlow}"/>
		<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_TEACHER}">
			<input type="hidden" name="auditStatusId" value="${recStatusEnumTeacherAuditY.id}"/>
		</c:if>
   		<table class="basic" width="100%">
   			<tr>
                <th colspan="6" style="text-align: left;">&#12288;思想政治和工作态度</th>
            </tr>
      		<tr>
             	<td  colspan="1" style="text-align: left;">项目及标准分</td>
                <td  colspan="1" style="text-align: center;">考核分</td>
                <td  colspan="2" style="text-align: center;">自评分</td>
             </tr>
             	
             <tr>
                <td>坚持四项基本原则，遵纪守法(20分)</td>
                <td style="text-align: center;">
              		 <input  name="basicCheckBranch" type="text" onkeyup="sum('teacher');" class="teacherItem validate[custom[integer,min[0],max[20]]]"  value="${formDataMap['basicCheckBranch']}" />
				</td>
				<td style="text-align: center;">
              		 <input  name="basicSelfratingBranch" onkeyup="sum('self');" class="selfItem validate[custom[integer,min[0],max[20]]]" type="text"  value="${formDataMap['basicSelfratingBranch']}" />
				</td>
            </tr>
             <tr>
                <td>组织纪律性(10分)</td>
                <td style="text-align: center;">
              		 <input  name="disciplineCheckBranch" type="text" onkeyup="sum('teacher');" class="teacherItem validate[custom[integer,min[0],max[10]]]" value="${formDataMap['disciplineCheckBranch']}" />
				</td>
				<td style="text-align: center;">
              		 <input  name="disciplineSelfratingBranch" onkeyup="sum('self');" class="selfItem validate[custom[integer,min[0],max[10]]]" type="text" id="he" value="${formDataMap['disciplineSelfratingBranch']}" />
				</td>
            </tr>
             <tr>
                <td>团结协作(7分)</td>
                <td style="text-align: center;">
              		 <input  name="uniteCheckBranch" type="text" onkeyup="sum('teacher');" class="teacherItem validate[custom[integer,min[0],max[7]]]"  value="${formDataMap['uniteCheckBranch']}" />
				</td>
				<td style="text-align: center;">
              		 <input  name="uniteSelfratingBranch" type="text" class="selfItem validate[custom[integer,min[0],max[7]]]" onkeyup="sum('self');" value="${formDataMap['uniteSelfratingBranch']}" />
				</td>
            </tr>
             <tr>
                <td>政治活动和社会活动(8分)</td>
                <td style="text-align: center;">
              		 <input  name="activityCheckBranch" type="text" onkeyup="sum('teacher');" class="teacherItem validate[custom[integer,min[0],max[8]]]" value="${formDataMap['activityCheckBranch']}" />
				</td>
				<td style="text-align: center;">
              		 <input  name="activitySelfratingBranch" onkeyup="sum('self');" class="selfItem validate[custom[integer,min[0],max[8]]]" type="text" value="${formDataMap['activitySelfratingBranch']}" />
				</td>
            </tr>
            <tr>
                <td>履行本岗位职责,出勤率(20分)</td>
                <td style="text-align: center;">
              		 <input  name="attendanceCheckBranch" type="text" onkeyup="sum('teacher');" class="teacherItem validate[custom[integer,min[0],max[20]]]" value="${formDataMap['attendanceCheckBranch']}" />
				</td>
				<td style="text-align: center;">
              		 <input  name="attendanceSelfratingBranch" onkeyup="sum('self');" class="selfItem validate[custom[integer,min[0],max[20]]]" type="text" value="${formDataMap['attendanceSelfratingBranch']}" />
				</td>
            </tr>
            <tr>
                <td>职业道德和服务态度(20分)</td>
                <td style="text-align: center;">
              		 <input  name="attitudeCheckBranch" type="text" onkeyup="sum('teacher');"  class="teacherItem validate[custom[integer,min[0],max[20]]]" value="${formDataMap['attitudeCheckBranch']}" />
				</td>
				<td style="text-align: center;">
              		 <input  name="attitudeSelfratingBranch" onkeyup="sum('self');" class="selfItem validate[custom[integer,min[0],max[20]]]" type="text" value="${formDataMap['attitudeSelfratingBranch']}" />
				</td>
            </tr>
            <tr>
                <td>技术操作规程(10分)</td>
                <td style="text-align: center;">
              		 <input  name="technologyCheckBranch" type="text" onkeyup="sum('teacher');" class="teacherItem validate[custom[integer,min[0],max[10]]]" value="${formDataMap['technologyCheckBranch']}" />
				</td>
				<td style="text-align: center;">
              		 <input  name="technologySelfratingBranch" onkeyup="sum('self');" class="selfItem validate[custom[integer,min[0],max[10]]]" type="text" value="${formDataMap['technologySelfratingBranch']}" />
				</td>
            </tr>
            <tr>
                <td>业务活动和学习(5分)</td>
                <td style="text-align: center;">
              		 <input  name="studyCheckBranch" type="text" onkeyup="sum('teacher');" class="teacherItem validate[custom[integer,min[0],max[5]]]" value="${formDataMap['studyCheckBranch']}" />
				</td>
				<td style="text-align: center;">
              		 <input  name="studySelfratingBranch" onkeyup="sum('self');" class="selfItem validate[custom[integer,min[0],max[5]]]" type="text" value="${formDataMap['studySelfratingBranch']}" />
				</td>
            </tr>
            <tr>
                <td>计(100分)</td>
                <td style="text-align: center;">
              		 <input  name="checkBranchThetotalscore"  class="center" id="teacherTotal" type="text" value="${formDataMap['checkBranchThetotalscore']}" readonly="readonly" />
				</td>
				<td style="text-align: center;">
              		 <input  name="selfratingBranchThetotalscore" class="center" id="selfTotal"  type="text" value="${formDataMap['selfratingBranchThetotalscore']}" readonly="readonly"/>
				</td>
            </tr>
           
            <tr>
                <th colspan="3" style="text-align: left;">&#12288;其他</th>
            </tr>
            <tr >
            
               	<td colspan="3" style="text-align: left;" >
               		<label style="padding-left:70px;">
	               			医疗事故：<input type="checkbox" onchange="single(this)" name="accident" value="有" <c:if test="${formDataMap['accident']=='有'}">checked</c:if>/>有
               		</label>
               		&#12288;
               		<label>
	               		<input type="checkbox" onchange="single(this)" name="accident" value="无" <c:if test="${formDataMap['accident']=='无'}">checked</c:if>/>无
               		</label>
               		
               		<label style="padding-left:70px;">
	               			 医疗差错：<input type="checkbox" onchange="single(this)" name="error" value="有" <c:if test="${formDataMap['error']=='有'}">checked</c:if>/>有
               		</label>
               		&#12288;
               		<label>
	               		 <input type="checkbox" onchange="single(this)" name="error" value="无" <c:if test="${formDataMap['error']=='无'}">checked</c:if>/>无
               		</label>
               		
               		<label style="padding-left:70px;">
	               	 	工作错误：	<input type="checkbox" onchange="single(this)" name="wrong" value="有" <c:if test="${formDataMap['wrong']=='有'}">checked</c:if>/>有
               		</label>
               		&#12288;
               		<label>
	               		  <input type="checkbox" onchange="single(this)" name="wrong" value="无" <c:if test="${formDataMap['wrong']=='无'}">checked</c:if>/>无
               		</label>
               	</td>
            
               	
	              	 <c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">
		            	<input type="hidden" name="accident" value="${formDataMap['accident']}"/>
		            	<input type="hidden" name="error" value="${formDataMap['error']}"/>
		            	<input type="hidden" name="wrong" value="${formDataMap['wrong']}"/>
	             	</c:if>
              	
            </tr>
            
              </table>
            
			<p align="center">
				
				<input class="search BC" type="button" value="保&#12288;存"  onclick="saveForm();"/>
			
				<input class="search" type="button" value="关&#12288;闭"  onclick="jboxClose();"/>
			</p>
		</form>
         </div>
        
     </div> 	
   </div>	
</body>
</html>