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
	function saveInfo(){
		if(false==$("#editForm").validationEngine("validate")){
			return ;
		}
		var form = $("#editForm");
		var requestData = form.serialize();
		var url = "<s:url value='/irb/cfg/editInfo'/>";
		jboxPost(url,requestData,function(resp){
			if(resp=='${GlobalConstant.OPRE_SUCCESSED}'){
				window.parent.frames['mainIframe'].window.reload();
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
   		<table class="basic" width="100%" style="margin: 0 auto;">
   			<!-- <tr>
                <td class="bs_name" colspan="4">伦理委员会信息：</td>
            </tr> -->
            <tr>
                <th class="td_blue" width="100px">委员会名称：</th>
                <td >
                	<input class="validate[required] xltext" name="irbName"  type="text"  value="${info.irbName }"/>
                </td>
                 <th class="td_blue" width="100px">委员会简称：</th>
                <td>
                	<input class="xltext" name="irbShortName" type="text"  value="${info.irbShortName }"/>
                </td>
            </tr>
             <tr>
                <th class="td_blue" width="100px">联系人：</th>
                <td>
                	<input class="xltext" name="contactUser" type="text"  value="${info.contactUser }"/>
                </td>
                
                <th class="td_blue" width="100px">联系手机：</th>
                <td>
                	<input class="xltext" name="contactMobile" type="text"  value="${info.contactMobile }"/>
                </td>
            </tr>
             <tr>
                <th class="td_blue" width="100px">联系电话：</th>
                <td>
                	<input class="xltext" name="contactPhone" type="text" value="${info.contactPhone }"/>
                </td>
                 <th class="td_blue" width="100px">联系邮件：</th>
                <td>
                	<input class="xltext" name="contactEmail" type="text"  value="${info.contactEmail }"/>
                </td>
            </tr>
              <tr>
                <th class="td_blue" width="100px">会议地点：</th>
                <td colspan="3">
                	<input class="xltext" name="meetingAddress" type="text"  value="${info.meetingAddress }"/>
                </td>
            </tr>
			</table>
			<p align="center" style="width:100%">
				<input class="search" type="button" value="保&#12288;存"  onclick="saveInfo();" />
				<input name="recordFlow" type="hidden" value="${info.recordFlow }" />
			</p>
		</form>
         </div>
        
     </div> 	
   </div>
</body>
</html>