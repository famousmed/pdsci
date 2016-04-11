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
	function doSave() {
		if(false==$("#sysDictForm").validationEngine("validate")){
			return ;
		}
		
		if(false==$("#subDictForm").validationEngine("validate")){
			return ;
		}
		var url = "<s:url value='/sys/dict/saveSubDict'/>";
		
		var j = $("#sysDictForm").serializeJson();
		var codeTab = $('#attrCodeTable');
		var trs = codeTab.children();
		var datas = [];
		$.each(trs , function(i , n){
			var dictFlow = $(n).find("input[name='dictFlow']").val();
			var dictId = $(n).find("input[name='dictId']").val();
			var dictName = $(n).find("input[name='dictName']").val();
			var dictDesc =  $(n).find("input[name='dictDesc']").val();
			var ordinal =  $(n).find("input[name='ordinal']").val();
			var data = {
					"dictFlow":dictFlow,
					"dictId":dictId,
					"dictName":dictName,
					"dictDesc":dictDesc,
					"ordinal":ordinal
			};
			datas.push(data);
			
		});
		var topDictFlow = $('#parentDictFlow').val();
		var t = {'subDicts':datas,'dict':j , 'topDictFlow':topDictFlow};
		jboxPostJson(url,JSON.stringify(t),function(resp){
			if(resp=='${GlobalConstant.OPRE_SUCCESSED_FLAG}'){
				jboxTip('${GlobalConstant.SAVE_SUCCESSED}');
				window.parent.frames['mainIframe'].window.viewChildNode($('#parentDictFlow').val());
				jboxClose();
			}else{
				jboxTip(resp);
			}
		},null,false); 
	}
	
	function addTr(){
		$('#attrCodeTable').append($("#template tr:eq(0)").clone());
	}
	function delEmptyTr(obj){
		   var tr=obj.parentNode.parentNode;
           tr.remove();
	}
	
	function delDict(dictFlow,recordStatus , parentDictFlow){
		var msg = "";
		if(recordStatus=='${GlobalConstant.RECORD_STATUS_N}'){
			msg = "停用";
		}else if(recordStatus=='${GlobalConstant.RECORD_STATUS_Y}'){
			msg = "启用";
		}
		msg = "确认" + msg + "该记录吗？";
		var url = '<s:url value="/sys/dict/delete"/>?dictFlow='+dictFlow+"&recordStatus="+recordStatus;
		jboxGet(url, null , function() {
			if(parentDictFlow==''){
				window.parent.frames['mainIframe'].window.search();
				jboxClose();
			}else{
				window.parent.frames['mainIframe'].window.viewChildNode(parentDictFlow);
				jboxClose();
			}
			
			
		});
	}
</script>
</head>
<body>
    <div style="margin-top: 25px;height:100%;"  class="mainright">
        <input type="hidden" id="parentDictFlow" name="parentDictFlow" value="${parentDict.dictFlow}"/>
	    <form id="sysDictForm" style="padding-left: 30px;">
	        <input name="dictFlow" value='${param.dictFlow}' type="hidden"/>
	            <table class="mation" style="width: 520px"  >
   		 		    <tr>
   		 			    <td style="text-align: right" width="100px">字典类型：</td>
   		 				<td>
   		 				    ${parentDict.dictName}
   		 				</td>
   		 			</tr>
   		 			<tr>
					    <td style="text-align: right" width="100px">字典代码：</td>
						<td style="text-align: left;padding-left: 5px" >
						    <input class="validate[required] xltext" name="dictId" type="text" value="${dict.dictId}" />
						</td>
					</tr>
   		 			<tr>
					    <td style="text-align: right" width="100px">字典名称：</td>
						<td style="text-align: left; padding-left: 5px" width="200px">
						    <input class="validate[required,maxSize[50]] xltext" name="dictName" type="text" value="${dict.dictName}" />
						</td>
					</tr>
   		 			<tr>
					    <td style="text-align: right" width="100px">代码描述：</td>
						<td style="text-align: left; padding-left: 5px" width="200px">
						    <input class="xltext validate[maxSize[25]]" name="dictDesc" type="text" value="${dict.dictDesc}" />
						</td>
					</tr>
					<tr>
					    <td style="text-align: right" width="100px">排序码：</td>
						<td style="text-align: left; padding-left: 5px"  >
						    <input class="validate[required,custom[integer]] xltext" name="ordinal" type="text" value="${dict.ordinal}" />
						</td>
					</tr>
                </table>
	    </form>
	    <c:if test='${level==3}'>
            <form id="subDictForm" style="padding-left: 30px;">
                <fieldset style="width: 500px"  class="mation" >
	                <legend>3级字典[<a href="javascript:addTr();">新增</a>]</legend>
		            <table>
			            <thead>
				            <tr>
				                <th width="100px" style="text-align: center;">字典代码</th>
				                <th width="100px" style="text-align: center;">字典名称</th>
				                <th width="200px" style="text-align: center;">代码描述</th>
				                <th width="80px" style="text-align: center;">排序码</th>
				                <th width="40px" style="text-align: center;">操作</th>
				            </tr>
				        </thead>
				        <tbody  id="attrCodeTable">
				        <c:forEach items="${subdicts}" var="subdict">
			                <tr>
						        <td>
						            <input type="text" style="width: 90%" class="validate[required]" name="dictId" value="${subdict.dictId}"/>
						            <input type="hidden" name="dictFlow" value="${subdict.dictFlow}"/>
							    </td>
							    <td><input type="text" style="width: 90%" class="validate[required]" name="dictName" value="${subdict.dictName}"/></td>
							    <td><input type="text" style="width: 90%" class="" value="${subdict.dictDesc}" name="dictDesc"/></td>
							    <td><input type="text" style="width: 90%" class="validate[required,custom[integer]]" value="${subdict.ordinal}" name="ordinal"/></td>
							    <td>
							        <c:if test="${subdict.recordStatus == GlobalConstant.RECORD_STATUS_Y }">
							            [<a href="javascript:void(0);" onclick="delDict('${subdict.dictFlow}','${GlobalConstant.RECORD_STATUS_N}' , '${parentDict.dictFlow}');">停用</a>]
							        </c:if>
							        <c:if test="${subdict.recordStatus == GlobalConstant.RECORD_STATUS_N }">
							            [<a href="javascript:void(0);" onclick="delDict('${subdict.dictFlow}','${GlobalConstant.RECORD_STATUS_Y}' , '${parentDict.dictFlow}');">启用</a>]</td>
							        </c:if>
						    </tr>
						</c:forEach>
				        </tbody>
			        </table>
		        </fieldset>
            </form>
        </c:if>
        <div class="button" style="width: 100%">
		    <input class="search" type="button" value="保&#12288;存" onclick="doSave();" />
			<input type="button" class="search" onclick="jboxClose();" value="关&#12288;闭">
		</div>
</div>
<table style="display: none" id="template">
    <tr>
	    <td>
            <input type="text" style="width: 90%" class="validate[required]" name="dictId" value=""/>
		</td>
		<td><input type="text" style="width: 90%" class="validate[required]" name="dictName" value=""/></td>
		<td><input type="text" style="width: 90%" class="" value="" name="dictDesc"/></td>
		<td><input type="text" style="width: 90%" class="validate[required,custom[integer]]" name="ordinal" value=""/></td>
		<td>	
		    [<label onclick="delEmptyTr(this)" style="color:blue" >删除</label>]
		</td>
    </tr>
</table>
</body>
</html>



