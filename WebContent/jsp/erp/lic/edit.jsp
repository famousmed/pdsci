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
<script type="text/javascript" src="<s:url value='/js/j.suggest.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
 <script type="text/javascript">
 $(document).ready(function(){
	 loadCustomerList();
 });
 function loadCustomerList() {
		var customers = new Array();
		var url = "<s:url value='/erp/crm/searchCustomerJson'/>";
		jboxPost(url,null,function(data){
			if(data!=null){
				for (var i = 0; i < data.length; i++) {
					var aliasName=data[i].aliasName;
					if(data[i].aliasName==null){
						aliasName="";
					}
					customers[i]=new Array(data[i].customerFlow,data[i].customerName,aliasName);
				}
			}
		},null,false);
		$("#searchParam_Customer").suggest(customers,{
			attachObject:'#suggest_Customer',
			dataContainer:'#result_Customer',
			triggerFunc:function(customerFlow){
				showMainContactInfo(customerFlow);
				showCustomerDetail(customerFlow);
			},
		    enterFunc:function(customerFlow){
		    	showMainContactInfo(customerFlow);
		    	showCustomerDetail(customerFlow);
		    }
		});
 }
 function adjustResults() {
		$("#suggest_Customer").css("left",$("#searchParam_Customer").offset().left);
		$("#suggest_Customer").css("top",$("#searchParam_Customer").offset().top+$("#searchParam_Customer").outerHeight());
	}
//重置客户名称
 function resetCustomerName(){
	 var customerFlow=$("#result_Customer").val();
	 var customerName=$("#searchParam_Customer");
	 if(customerFlow==""){
		 customerName.val("");
	 }
 }
 //重置客户流水号
 function resetCustomerFlow(){
	 var customerFlow=$("#result_Customer");
	 $("#detailFlag").remove();
	 customerFlow.val("");
}
 //考试系统特殊选项
 function showSpecial(){
	 var status=$("#radio_Net").attr("checked");
	 if(status=="checked" && $("#exam").attr("checked")=="checked"){
		$("#specialCheck").show(); 
	 }else{
		$("#specialCheck").hide();
	 }
 }
 function accreditChange(obj){
	 if($(obj).val()=='${accreditTypeEnumDevelop.id}' || $(obj).val()=='${accreditTypeEnumShow.id}'){
		 $("#normalCus").hide();
		 $("#contractTb").hide();
		 $("#speCus").show();
	 }else{
		 $("#normalCus").show();
		 $("#contractTb").show();
		 $("#speCus").hide();
	 }
 }
</script>
</head>
<body>
     <div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
			   <div style="margin-bottom: 10px">
			              授权类型：<c:forEach items="${accreditTypeEnumList }" var="accredit">
			                <input type="radio" name="accredit" id="${accredit.id }_radio" onclick="accreditChange(this);" value="${accredit.id }"/><label for="${accredit.id }_radio">${accredit.name }</label>
			            </c:forEach>
			    &#12288; 客户名称：<span id="normalCus"><input id="searchParam_Customer"  placeholder="输入客户名称/别名" class="inputText validate[required]"  style="width: 260px;text-align: left;padding-left: 5px;" onblur="resetCustomerName('');" onchange="resetCustomerFlow('main');" onkeydown="adjustResults();" onfocus="adjustResults();"/>
				       <div id="suggest_Customer" class="ac_results" style="margin:0;position: fixed; z-index: 100;width: 370px;"></div>
				       <input type="hidden" id="result_Customer" name="customerFlow" />
				       </span>
				       <span id="speCus" style="display: none;">南京品德信息网络技术有限公司</span>
			   </div>
			   <table id="contractTb" class="xllist" style="margin-bottom: 10px">
			       <colgroup>
			           <col width="5%"/>
			           <col width="32%"/>
			           <col width="32%"/>
			           <col width="31%"/>
			        </colgroup>
			        <tr>
			           <th><input type="checkbox" title="全选"></th>
			           <th>客户名称</th>
			           <th>合同号</th>
			           <th>产品名称</th>
			        </tr>
			        <tr>
			           <td><input type="checkbox"></td>
			           <td>江苏省中医院</td>
			           <td>PX20150321</td>
			           <td>住院医师管理系统</td>
			           
			        </tr>
			        <tr>
			           <td><input type="checkbox"></td>
			           <td>江苏省中医院</td>
			           <td>PX20150322</td>
			           <td>科研项目管理系统</td>
			        </tr>
			        <tr>
			           <td><input id="exam" type="checkbox" onclick="showSpecial();"></td>
			           <td>江苏省中医院</td>
			           <td>PX20150323</td>
			           <td>考试系统</td>
			        </tr>
			   </table>
			   <div style="margin-bottom: 10px">
			    <table  width="100%" cellpadding="0" cellspacing="0" class="basic">
			     <colgroup>
			           <col width="30%"/>
			           <col width="70%"/>
			        </colgroup>
			     <tr>
			      <th colspan="2" style="text-align: left;padding-left: 10px">license信息</th>
			     </tr>
			     <tr> 
			       <th>开发语言：</th>         
			       <td>
			              <c:forEach items="${developLanguageEnumList }" var="lan">
			                <input type="radio" name="lan" id="radio_${lan.id }" onclick="showSpecial();" value="${lan.id }"/><label for="radio_${lan.id }">${lan.name }</label> 
			              </c:forEach>  
			            <span id="specialCheck" style="display: none;">
			                &#12288;<input type="checkbox" id="isEncrypt" value=""><label for="isEncrypt">加密</label>
			                &#12288;<input type="checkbox" id="isQlist" value=""><label for="isEncrypt">题库</label>                                  
			            </span>
			       </td>
			     </tr>
			     <tr>
			        <th>授权文件内容：</th>
			        <td id="content"></td>
			     </tr>
			     <tr>
			        <th>机&nbsp;&nbsp;器&nbsp;&nbsp;码：</th>
			        <td><input type="text"  class="inputText" style="width:400px;text-align: left"></td>
			     </tr>
			     <tr>
			        <th>到&nbsp;&nbsp;期&nbsp;&nbsp;日：</th>
			        <td>
			           <input type="text" class="inputText ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly">
			        </td>
			     </tr>
			     <tr>
			        <th>申请部门：</th>
			        <td><select style="width:120px;">
			               <option>请选择</option>
			               <option>销售一部</option>
			               <option>销售二部</option>
			               <option>商务部</option>
			            </select>
			        </td>
			     </tr>
			     <tr>
			        <th>申&nbsp;&nbsp;请&nbsp;&nbsp;人：</th>
			        <td>
			           <select style="width:120px;">
			               <option>请选择</option>
			               <option>张三</option>
			               <option>李四</option>
			               <option>王五</option>
			            </select>
			        </td>
			     </tr>
			     <tr>
			        <th>接收邮件地址：</th>
			        <td><input type="text" class="inputText"  style="width: 200px;text-align: left;"/></td>
			     </tr>
			     </table>
			   </div>
			   
			   <div class="button" style="width: 100%">
					<input id="saveButton" class="search" type="button" value="保&#12288;存" onclick="save();" />
					<input class="search" type="button" value="关&#12288;闭" onclick="jboxCloseMessager();" />
				</div>
	        </div>
	   </div>
	  </div>
	  <span id="javaContent">
	     <c:forEach items="${workStationList }" var="workStation">
	       <%-- <li>
	        <input type="checkbox" id="${workStation.id }_lic"/><label for="${workStation.id }_lic">${workStation.name }</label>
	       </li> --%>
	     </c:forEach>
	  </span>
	  <span id=".netContent"></span>
</body>
</html>