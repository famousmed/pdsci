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
	<jsp:param name="jquery_ui_sortable" value="true"/>
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
<style>
  #eleSortable { list-style-type: none; margin: 0; padding: 0; width: 60%; }
  #eleSortable li { margin: 0 3px 3px 3px; padding: 0.4em; padding-left: 1.5em; font-size: 1.4em; height: 18px; }
  #eleSortable li tr td span { position: absolute; margin-left: -1.3em; }
.curr{color:red}
</style>
<script type="text/javascript">
	function showAttr(eleCode,eleName,eleVarName) {
		jboxStartLoading();
		$(".curr").removeClass("curr");
		$("#"+eleCode).addClass("curr");
		$("#currEleCode").val(eleCode);
		$("#currEleNameSpan").html(eleName+"("+eleVarName+")");
		jboxGet("<s:url value='/pub/module/showAttr'/>?elementCode="
				+ eleCode + "&moduleCode=${currModule.moduleCode }",null,function(resp){
					$("#attrDiv").html(resp);
					$("#attrDiv").slideDown(500);
		},null,false);
	}
	
	function editEle(elementFlow,moduleFlow) {
		jboxOpen("<s:url value='/pub/module/edit'/>?moduleFlow="
				+ moduleFlow+"&elementFlow="+elementFlow, "元素维护", 500, 350);
	}
	function addAttr(moduleCode) {
		if ($("#currEleCode").val() == "") {
			jboxTip("请选选择一个元素!");
			return;
		}
		jboxOpen(
				"<s:url value='/pub/module/addAttr'/>?moduleCode="
						+ moduleCode + "&elementCode="
						+ $("#currEleCode").val(), "属性维护", 600, 600);

	}

	var fixHelper = function(e, ui) {
	     ui.children().each(function() {
	    	//在拖动时，拖动行的cell（单元格）宽度会发生改变。在这里做了处理就没问题了  
	         $(this).width($(this).width());
	     });
	     return ui;
	};
	$(function() {
    	var oldPostData = "";
	    $( "#eleSortable" ).sortable({
	    	helper: fixHelper,  
	    	create: function(e, ui){
	    		var oldSortedIds = $( "#eleSortable" ).sortable( "toArray" );
	    		$.each(oldSortedIds,function(i,sortedId){
	    			oldPostData = oldPostData+"&elementFlow="+sortedId;
	    		});
	    	},
	    	start:function(e, ui){
	    	     //拖动时的行，要用ui.helper
	    	    ui.helper.css({"background":"#eee"});
	    	    return ui; 
	    	}, 
	    	stop: function( event, ui ) {
	    		ui.item.css({"background":"#fff"});
	    		var sortedIds = $( "#eleSortable" ).sortable( "toArray" );
	    		var postdata = "";
	    		$.each(sortedIds,function(i,sortedId){
	    			postdata = postdata+"&elementFlow="+sortedId;
	    		});
	    		if(oldPostData==postdata){
	    			return;
	    		}
	    		var url = "<s:url value='/pub/module/saveElementOrder'/>";
	    		jboxPost(url, postdata, function() {
	    			},null,false);
	    		oldPostData = postdata;
	    	}
	    });
	    $( "#eleSortable" ).disableSelection();
	    init();
	});
	function init(){
		$(".viewTd").hover(function() {
			$(this).find("div").stop().animate({left: "210", opacity:1}, "slow").css("display","block");
		},function(){
			$(this).find("div").stop().animate({left: "0", opacity: 0}, "slow");
		});
	}
	function doBack(){
		window.location.href="<s:url value='/pub/module/list'/>?moduleTypeId=${currModule.moduleTypeId}";
	}
	function showElement(moduleCode){
		window.location.href="<s:url value='/pub/module/show'/>?moduleCode="+moduleCode;
	}
	function editModule(){
		jboxOpen("<s:url value='/pub/module/getModuleByFlow?moduleFlow=${currModule.moduleFlow}'/>"
				+"&moduleTypeId=${currModule.moduleTypeId}", "编辑模块信息", 500, 300);
	}
	function delModule(){
		jboxGet("<s:url value='/pub/module/delModuleConfirm'/>?moduleCode=${currModule.moduleCode}",null,function(resp){
			if(resp != '${GlobalConstant.OPRE_FAIL}'){
				jboxConfirm("确认删除?",function(){
					jboxGet("<s:url value='/pub/module/delModule?moduleFlow=${currModule.moduleFlow}'/>"
							,null,function(){
								doBack();
					},null,true);
				});
			}else{
				jboxOpen("<s:url value='/pub/module/edcModuleRemind'/>?moduleCode=${currModule.moduleCode}","已添加模块列表",700,500);
			}
		},null,false);
	}
	function delEle(elementFlow,elementCode,moduleCode){
		jboxGet("<s:url value='/pub/module/delElementConfirm'/>?elementCode="+elementCode,null,function(resp){
			if(resp != '${GlobalConstant.OPRE_FAIL}'){
				jboxConfirm("确认删除?",function(){
					jboxGet("<s:url value='/pub/module/delElement?elementFlow="+elementFlow+"'/>"
							,null,function(){
						showElement(moduleCode);	
					},null,true);
				});
			}else{
				jboxOpen("<s:url value='/pub/module/edcElementRemind'/>?elementCode="+elementCode,"已添加元素列表",700,500);
			}
		},null,false);
	}
	
	function copyEle(elementFlow,moduleCode){
		jboxConfirm("确认复制?",function(){
			jboxGet("<s:url value='/pub/module/copyElement?elementFlow="+elementFlow+"'/>"
					,null,function(){
				showElement(moduleCode);	
			},null,true);
		});
	}
	
</script>
</head>
<body>

		 <div class="title1 clearfix" >         
			&#12288;&#12288;当前域：${pdfn:getDictName(dictTypeEnumModuleType,currModule.moduleTypeId) }(${currModule.moduleTypeId })&#12288;&#12288;当前模块：
			<select name="moduleCode" style="width: 200px" onchange="showElement(this.value);">
				<c:forEach items="${moduleList }" var="module">
					<option value="${module.moduleCode }" <c:if test="${module.moduleFlow == currModule.moduleFlow }">selected</c:if>>${module.moduleName}</option>
				</c:forEach>
			</select>
			<input type="button" class="search" value="修&#12288;改" onclick="editModule();"/>
			<input type="button" class="search" value="删&#12288;除" onclick="delModule();"/>
			<input type="button" class="search" value="返&#12288;回" onclick="doBack();"/>
		</div>
		
		
		<div class="main_fix" style="overflow: hidden">
			<div id="main">
			<div class="side" style="height: 98%;">
				<table width="300" cellspacing="0" cellpadding="0" class="bs_tb" >
									<tr>
										<th class="bs_name" colspan="2">元素名称<a href="javascript:editEle('','${currModule.moduleFlow}');"><img
												src="<s:url value="/css/skin/${skinPath}/images/add.png" />" title="新增元素"></a></th>
									</tr>
									<tbody id="eleSortable">
										<c:forEach items="${elementList}" var="element" varStatus="status">
										<tr id="${element.elementFlow}" style="cursor: pointer;"> 
											<td class="bs_mod viewTd" >
													<a id="${element.elementCode }" href="javascript:showAttr('${element.elementCode }','${element.elementName }','${element.elementVarName }');" style="float: left;padding-left: 20px">${element.elementName}</a>
													<div style="display: none;float: right">
							                		<a href="javascript:editEle('${element.elementFlow}','${currModule.moduleFlow}');" >[编辑]</a>
							                		<a href="javascript:delEle('${element.elementFlow}','${element.elementCode}','${currModule.moduleCode}');" >[删除]</a>
							                		<a href="javascript:copyEle('${element.elementFlow}','${currModule.moduleCode}');" >[复制]</a>
													</div>
											</td>
										</tr>			
										</c:forEach>						
									</tbody>
									<c:if test="${elementList == null || elementList.size()==0 }"> 
										<tr> 
											<td align="center" style="text-align: center;">无记录</td>
										</tr>
									</c:if>													
								</table>
									<input type="hidden" id="currEleCode" name="currEleCode" value=""/>
		</div>
	 	 		
		<div class="side1" style="height: 98%;">
				 <div class="bs_title">
			    <span id="currEleNameSpan"></span>
			          &#12288;属性 <a href="javascript:addAttr('${currModule.moduleCode}');"><img
											src="<s:url value="/css/skin/${skinPath}/images/add.png" />" title="新增属性" style="float: right;padding-top: 10px;padding-right: 10px"></a>
				</div>
				<div  id="attrDiv" >
				    
			    </div>
				
			    </div>
			</div>
		</div>
</body>
</html>