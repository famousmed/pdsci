<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
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
</jsp:include>
<script type="text/javascript">
	function save(){
		var form = $("#editForm");
		var requestData = form.serialize();
		var url = "<s:url value='/gcp/rec/saveMeeting'/>?saveType=meeting";
	 	jboxPost(url,requestData,function(resp){
			if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
				window.parent.frames['mainIframe'].window.loadStartMeeting();
				jboxClose();
			}
		},null,true);
	}
</script>
</head>
<body>
	<div class="mainright">
      <div class="content">
        <div class="title1 clearfix">
		<form id="editForm">
		<input name="projFlow" type="hidden" value="${param.projFlow }" />
   		<table width="100%" cellpadding="0" cellspacing="0" class="basic">
   			<tr>
				<th colspan="4" style="text-align: left;padding-left: 10px;">会议信息</th>
			</tr>
   			<tr>
   				<td width="100px" style="text-align: right;">会议日期：</td>
                <td width="25%">
                	<input type="text" name="date" class="xltext ctime" readonly="readonly" value="${meetingForm.date }" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
                </td>
                <td width="100px" style="text-align: right;">会议地点：</td>
                <td>
                	<input type="text" name="address" value="${meetingForm.address }" class="xltext" style="width:300px;" />
                </td>
            </tr>
             <tr>
             	<td width="100px" style="text-align: right;">主&nbsp;持&nbsp;人：</td>
                <td width="25%" >
                	<input type="text" name="compere" value="${meetingForm.compere }" class="xltext" />
                </td>
                <td width="100px" style="text-align: right;">参会人员：</td>
                <td colspan="3" >
                	<input type="text" name="user" value="${!empty meetingForm.user?meetingForm.user:meetingUserNames}" class="xltext" style="width:300px;" />
                </td>
            </tr>
            <tr>
            </tr>
            <tr>
                <td width="100px" style="text-align: right;">会议简介：</td>
                <td colspan="3" >
                	<textarea name="intro" rows="4" style="width:615px;margin:8px 0px;" placeholder="请填写会议简介">${meetingForm.intro }</textarea>
                </td>
            </tr>
			</table>
		</form>
         </div>
         <div style="width: 100%;margin-top: 10px;" align="center" >
			<input class="search" type="button" value="保&#12288;存"  onclick="save();" />
			<input class="search" type="button" value="关&#12288;闭" onclick="jboxClose();" />
		</div>
     </div> 	
   </div>
</body>
</html>