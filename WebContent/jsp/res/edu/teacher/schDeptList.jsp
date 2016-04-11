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

$(document).ready(function(){
	var type='${param.type}';
	var parentRamDiv=window.parent.frames['mainIframe'].$("#"+type+"SchDeptRam");
	var parentRomDiv=window.parent.frames['mainIframe'].$("#"+type+"SchDeptRom");
	var allCheckedDept=$(parentRomDiv).children();
	var nowCheckedDept=$(parentRamDiv).children();
	var pageDepts=$("#nowDeptTb").find("input[name='schDeptFlow']");
    //判断页面是否首次加载
	var readyFlag=$("#readyFlag");
    if(readyFlag.val()==""){
    	//把rom中的所有数据同步到ram中
    	var ramDeptFlag;
    	$.each(allCheckedDept,function(i,n){
    		ramDeptFlag=false;
    		$.each(nowCheckedDept,function(o,m){
    		   if($(n).attr("id")==$(m).attr("id")){
    			   ramDeptFlag=true;
    		   }
    		});
    		if(ramDeptFlag==false){
    			$(parentRamDiv).append($(n).clone());
    		}
    	});
    	readyFlag.val("N");
    }
	//把对应rom中的部门与当前列表比较，相符打钩
	$.each(pageDepts,function(i,n){
		$.each(allCheckedDept,function(o,m){
			if($(n).attr("id")==$(m).attr("id")){
				$(n).attr("checked","checked");
			}
		});
	});
	//把对应ram中的人员与当前列表比较，相符打钩
	$.each(pageDepts,function(i,n){
		$.each(nowCheckedDept,function(o,m){
			if($(n).attr("id")==$(m).attr("id")){
				$(n).attr("checked","checked");
			}
		});
	});
	decidePageCheck();
});
//如果当前页面所有人员都被选中，则全选框也被选中，反之同理
function decidePageCheck(){
	var checkAll=$("#checkAll");
	var pageDepts=$("#nowDeptTb").find("input[name='schDeptFlow']");
	if(pageDepts.length>0){
		var allCheckFlag=true;
		$.each(pageDepts,function(i,n){
			if($(n).attr("checked")!="checked"){
				allCheckFlag=false;
			}
		});
		if(allCheckFlag==true){
			checkAll.attr("checked",true);
		}
	}
}
function toPage(page){
	var form = $("#searchForm");
	$("#currentPage").val(page);
	form.submit();
}
function searchUser(){
	$("#searchForm").submit();
}
function deleteFromRam(){
	var type='${param.type}';
	var parentRamDiv=window.parent.frames['mainIframe'].$("#"+type+"SchDeptRam");
	$(parentRamDiv).html("");
	jboxClose();
}
//勾选人员保存并展现在父页面
function copyToRom(){
	var type='${param.type}';
	var parentRamDiv=window.parent.frames['mainIframe'].$("#"+type+"SchDeptRam");
	var parentRomDiv=window.parent.frames['mainIframe'].$("#"+type+"SchDeptRom");
	var parentSchDeptCount=window.parent.frames['mainIframe'].$("#"+type+"SchDeptCount");
	var content="<br/>";
	$.each(parentRamDiv.children(),function(i,n){
		content+=$(n).attr("aliasname");
		if(i<parentRamDiv.children().length-1){
			content+="，";
		}
	});
	ramToRom($(parentRamDiv),$(parentRomDiv));
	if(parentRomDiv.children().length>0){
		parentSchDeptCount.html(content);
	}else{
		parentSchDeptCount.html("");
	}
	parentSchDeptCount.html(content);
	$(parentRamDiv).html("");
	jboxClose();
}
//把源区域子节点移动到目标区域
function ramToRom(sourceObj,goalObj){
     $(goalObj).html($(sourceObj).html());    	
}
//及时保存勾选人员
function putDeptToParentRam(obj){
	var type='${param.type}';
	var parentRamDiv=window.parent.frames['mainIframe'].$("#"+type+"SchDeptRam");
	var ramDeptFlows=$(parentRamDiv).children();
	var thisFlag=false;
	$.each(ramDeptFlows,function(i,n){
		if($(n).attr("id")==$(obj).attr("id")){
			thisFlag=true;
			if($(obj).attr("checked")!="checked"){
				$(n).remove();
			}
		}
	  });
	 if(thisFlag==false){
		 if($(obj).attr("checked")=="checked"){
		   var userInput="<input type='text' id='"+$(obj).attr('id')+"' aliasname='"+$(obj).attr('aliasname')+"' name='"+type+"SchDept' value='"+$(obj).attr('id')+"'/>";
		   $(parentRamDiv).append(userInput);
		 }
	 }
	 decidePageCheck();
}

function checkAll(obj){
	var depts=$(".deptCheck");
	$.each(depts,function(i,n){
		if (obj.checked) {
			$(n).attr("checked",true);
		} else {
			$(n).attr("checked",false);
		}
		putDeptToParentRam($(n));
	});
}

</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
		<input type="hidden" id="readyFlag" name="readyFlag" value="${param.readyFlag }"/>
		 <table id="nowDeptTb" style="margin-left: 30px;" class="basic">
            <tr style="line-height: 30px;">
              <th style="text-align: left;padding-left: 10px;">
                <input  type="checkbox" value="" id="checkAll" title="全选" onclick="checkAll(this);"/>
                 <label for="checkAll">全选</label>
              </th>
            </tr>
            <tr>
            	      <td>
            	       <ul>
            	         <c:forEach items="${schDeptList }" var="schDept">
            	          <li style="width: 180px;float: left;line-height: 30px;">
            	          <input class="deptCheck" type="checkbox" id="${schDept.schDeptFlow }" aliasname="${schDept.schDeptName }" name="schDeptFlow" value="${schDept.schDeptFlow }" onclick="putDeptToParentRam(this)">
            	          <label for="${schDept.schDeptFlow }">${schDept.schDeptName }</label>
            	          </li>
            	        </c:forEach>
            	       </ul>
            	      </td>
            </tr>
		 </table>
	     <%-- <c:set var="pageView" value="${pdfn:getPageView(sysUserResDoctorExtList)}" scope="request"></c:set>
	     <pd:pagination toPage="toPage"/> --%>
	<p align="center" style="width:100%;margin-top: 40px;">
	   <c:if test="${param.show!='Y' }">
		<input class="search" type="button" value="确&#12288;定"  onclick="copyToRom();" />
	   </c:if>	
		<input class="search" type="button" value="关&#12288;闭"  onclick="deleteFromRam();" />
	</p>
	</div>
	</div>
</div>

</body>
</html>