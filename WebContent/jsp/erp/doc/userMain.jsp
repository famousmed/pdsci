<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
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
</jsp:include>
<script type="text/javascript">
	$(document).ready(function(){
		searchShareUsers();
	});

	function selShare(shareTypeId, shareRecordFlow, shareRecordName, source){
		var shareRecord = $("#"+shareRecordFlow);
		if (source=="tr") {
			if ($(shareRecord).attr("checked") !="checked") {
				$(shareRecord).attr("checked",true);
			} else {
				$(shareRecord).attr("checked",false);
			}
		}
		var shareRecordName = $(shareRecord).attr("shareRecordName");
		if ("${param.type}"=="add") {
			var jboxIfram = window.parent.frames["jbox-message-iframe"];
			if ($(shareRecord).attr("checked")=="checked") {
				if (jboxIfram.$("#"+shareRecordFlow+"_span").length==0) {
					var url = "<s:url value='/css/skin/${skinPath}/images/icon_close.png' />";
					var clickUrl = 'delRecord("'+shareRecordFlow+'");';
					jboxIfram.$("#shareUserSpan").append("<span id='"+shareRecordFlow+"_span'>"+shareRecordName+"<span class='editSpan' style='display: none;'><img title='删除' src='"+url+"' style='cursor: pointer;' onclick='"+clickUrl+"' </span>"+"<input type='hidden' name='shareTypeId' value='"+shareTypeId+"'><input type='hidden' name='shareRecordFlow' value='"+shareRecordFlow+"'><input type='hidden' name='shareRecordName' value='"+shareRecordName+"'></span>，");
					$("#shareUserSpan").append("<span id='"+shareRecordFlow+"_span'><input type='hidden' name='shareTypeId' value='"+shareTypeId+"'><input type='hidden' name='shareRecordFlow' value='"+shareRecordFlow+"'><input type='hidden' name='shareRecordName' value='"+shareRecordName+"'></span>");
				}
			} else {
				jboxIfram.$("#"+shareRecordFlow+"_span").remove();
				$("#"+shareRecordFlow+"_span").remove();
			}
		}
		else if("${param.type}"=="edit") {
			var url ="<s:url value='/erp/doc/modifySingleDocShare'/>";
			var data = {
				docFlow:"${param.docFlow}",
				shareTypeId:shareTypeId,
				shareRecordFlow:shareRecordFlow,
				shareRecordName:shareRecordName
			};
			jboxPost(url, data, null, null, false);
		}
		else if("${param.type}"=="share") {
			//$(shareRecord).click(function(e){ e.preventDefault();});
			jboxStartLoading();
			var recordStatus = "${GlobalConstant.RECORD_STATUS_Y}";
			if($(shareRecord).attr("checked") != "checked"){
				recordStatus = "${GlobalConstant.RECORD_STATUS_N}";
			}
			//批量共享
			var docFlow = "";
			var $mainIframe = window.parent.frames["mainIframe"];
			$mainIframe.$("input[name='doc']:checked").each(function(i,n){
				if(i==0){
					docFlow = $(this).val();
				}else{
					docFlow = docFlow +","+$(this).val();
				}
			});
			var requestData = {"docFlow":docFlow, "shareTypeId":shareTypeId, "shareRecordFlow":shareRecordFlow, "shareRecordName":shareRecordName,"recordStatus":recordStatus};
			var url = "<s:url value='/erp/doc/batchShare'/>";
			jboxPost(url, requestData, null, null, false);
		} 
	}
	
	function selectTag(url, data, id) {
	    // 操作标签
	    var tag = document.getElementById("tags").getElementsByTagName("li");
	    var taglength = tag.length;
	    for (i = 0; i < taglength; i++) {
	        tag[i].className = "ui-bluetag";
	    }
	    document.getElementById(id).parentNode.className = "selectTag";
	    // 操作内容
	    jboxPostLoad("contentDiv", url, data, true);
	}

	function searchShareUsers(){
		selectTag('<s:url value="/erp/doc/searchShareUsers"/>?type=${param.type}&docCategory=${param.docCategory}&shareTypeId=${shareTypeEnumUser.id}&recordFlows=${param.recordFlows}&docFlow=${param.docFlow}', $("#usersForm").serialize(), 'gr');
	}
	
	function searchShareDepts(){
		selectTag('<s:url value="/erp/doc/searchShareDepts"/>?type=${param.type}&docCategory=${param.docCategory}&shareTypeId=${shareTypeEnumDept.id}&recordFlows=${param.recordFlows}&docFlow=${param.docFlow}', $("#deptsForm").serialize(), 'bm');
	}
	
	//新增重选个人、部门checkbox回显
	function addCheckedRecords(){
		var jboxIfram = window.parent.frames["jbox-message-iframe"];
		jboxIfram.$("input[name='shareRecordFlow']").each(function(){
			var recordFlow = $(this).val();
			$("#" + recordFlow).attr("checked",true);
		});
	}
	
	//新增个人、部门切换Tag时 checkbox回显
	function addCheckedRecords2(){
		$("input[name='shareRecordFlow']").each(function(){
			var recordFlow = $(this).val();
			$("#" + recordFlow).attr("checked",true);
		});
	}
	
	function doConfirm(){
		if("${param.docCategory}"=="shared"){
			window.parent.frames["mainIframe"].window.search();
		}
		jboxClose();
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<ul id="tags">
				<li class="selectTag"><a onclick="searchShareUsers();" href="javascript:void(0)" id="gr">个人</a></li>
				<li><a onclick="searchShareDepts();" href="javascript:void(0)" id="bm">部门</a></li>
		    </ul>
		    <table class="i-trend-table" cellpadding="0" cellspacing="0" >
			    <tbody>
			        <tr>
			          <td>
			            <div id="contentDiv" style="border:none;">
						</div>
			          </td>
			        </tr>
			    </tbody>
		    </table>
		    
		    <div class="button">
				<input type="button" class="search" id="saveButton" value="确&#12288;定" onclick="doConfirm();" />
			</div>
			
		    <div id="shareUserSpan">
		    	
			</div>
		</div>
	</div>
</div>
</body>
</html>