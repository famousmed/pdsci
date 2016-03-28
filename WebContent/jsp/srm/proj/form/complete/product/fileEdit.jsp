<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
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
		$('#sv').attr({"disabled":"disabled"});
		jboxStartLoading();
		$('#fileForm').submit();
	}
	
	var callBack = function(result){
		if(result=="1"){
			jboxTip("保存成功");
			doClose();
		}else{
			jboxTip("保存失败");
		}
		
	};
	function refreshOpener(){
		window.parent.frames['mainIframe'].location.reload(true);
	}
	function doClose() {
		refreshOpener();
		jboxClose();
	}
</script>
</head>

<body>
<div id="main">
   <div class="mainright">
      <div class="content">
        <div class="title1 clearfix">
        <form id="fileForm" action="<s:url value="/srm/proj/mine/savePageGroupStep"/>" method="post" enctype="multipart/form-data" target="screct_frame">
			<input type="hidden" name="pageName" value="${param.pageName}"/>
			<input type="hidden" name="itemGroupName" value="${param.itemGroupName}"/>
			<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
			<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
			<input type="hidden" name="itemGroupFlow" value="${param.itemGroupFlow}"/>
           <table class="basic" width="100%">
                 <tbody>
                    <tr>
                        <th colspan="4" style="text-align: left;padding-left: 15px;font-size: 14px;font-weight: bold;">附件</th>
                    </tr>
                 
                 
                      <tr>
                         <td width="90px;">附件名称：</td>
                         <td width="200px;">
                         	<input class="validate[required] inputText" name="fileEdit_fileName" type="text" value="${file.fileEdit_fileName}" style="width: 90%"/>
                         </td>
                         <td width="90px">附&#12288;件:</td>
                         <td>
                         	<input type="file" name="fileEdit_file" class="validate[required] inputText" style="width: 80%" />
                         	
                         </td>
                      </tr>
                      <tr>
                         <td width="90px">附件备注：</td>
                         <td colspan="3">
                         	<input class="validate[required] inputText" name="fileEdit_fileRemark" type="text" style="width: 80%" value="${file.fileEdit_fileName}" />
                         </td>
                         
                      </tr>
                      
                 </tbody>
           </table>
           <div class="button">
		   	<input class="search" id="sv" type="button" onclick="save();" value="保存"/>
      	   </div>
           </form>
         </div>
        
     </div> 	
   </div>
</div>
</body>

<!-- 
<body>
	<form id="fileForm" action="<s:url value="/srm/proj/mine/savePageGroupStep"/>" method="post" enctype="multipart/form-data" target="screct_frame">
		<input type="hidden" name="pageName" value="${param.pageName}"/>
		<input type="hidden" name="itemGroupName" value="${param.itemGroupName}"/>
		<input type="hidden" name="projRecFlow" value="${param.projRecFlow}"/>
		<input type="hidden" name="projFlow" value="${param.projFlow}"/>
		<input type="hidden" name="itemGroupFlow" value="${param.itemGroupFlow}"/>
		<div>
			<table>
				<tbody>
					<tr>
						<td height="10px;"></td>
					</tr>
					<tr>
						<td>
							<p class="xixititle"></p>
							<table class="mation">
								<tr>
									<td class="mation-nab">附件名称：
									</td>
									<td>
										<input class="validate[required] name" style="width: 200px" name="fileName" type="text" value="${file.fileName}"/>
									</td>
								</tr>
								<tr>
									<td class="mation-nab">附件内容：</td>
									<td>
										<input type="file" name="file" class="validate[required] " style="width: 200px;" />
									</td>
								</tr>
								<tr>
									<td class="mation-nab">备注：</td>
									<td>
									<input class="name" style="width: 500px" name="fileRemark" type="text" value="${file.fileRemark}" />
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td>
							<table class="hddata" align="center">
								<tr>
									<td><input class="xiugaidata" type="button" value="保存" onclick="save();" /></td>
									<td><input class="close" type="button" value="关闭" onclick="doClose();" /></td>
								</tr>
							</table>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</form> -->
	
	<iframe name="screct_frame" style="display: none"></iframe>
</body>
</html>