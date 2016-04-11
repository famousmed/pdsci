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
<script type="text/javascript">
  function search(){
	  
  }
  function add(){
	  var w = $('.mainright').width()*0.9;
	  var h = $('.mainright').height()*0.9;
	  var url="<s:url value='/erp/lic/edit'/>";
	  var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='"+h+"' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	  jboxMessager(iframe,'新增license文件',w,h,null,false);
  }
</script>
</head>
<body>
    <div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
			     <form>
			       <div style="margin-bottom: 10px">
                                                            客户名称：<input type="text" name="customerName" value="${param.customerName}" placeholder="客户名称/别名" class="xltext" style="width: 180px;"/>
                                                            合&nbsp;同&nbsp;号：<input type="text" name="contractNo" value="${param.contractNo}" placeholder="合同号" class="xltext" style="width: 180px;"/>                                        
                                                            产品名称：<input type="text" name="productName" value="${param.productName}" placeholder="产品/项目名称" class="xltext" style="width: 180px;"/>
                    <input type="button" class="search"  onclick="search();" value="查&#12288;询">
                    <input type="button" class="search"  onclick="add();" value="新&#12288;增">
                   </div>		     
			     </form>
			     <table class="xllist">
			        <colgroup>
			           <col width="15%"/>
			           <col width="10%"/>
			           <col width="10%"/>
			           <col width="20%"/>
			           <col width="15%"/>
			           <col width="10%"/>
			           <col width="10%"/>
			           <col width="10%"/>
			        </colgroup>
			        <tr>
			           <th>客户名称</th>
			           <th>合同号</th>
			           <th>开发语言</th>
			           <th>授权产品名称</th>
			           <th>授权文件到期日</th>
			           <th>申请部门</th>
			           <th>申请人</th>
			           <th>操作</th>
			        </tr>
			        <tr>
			           <td>江苏省中医院</td>
			           <td>PX20150321</td>
			           <td>java</td>
			           <td>住院医师管理系统，科研项目管理系统</td>
			           <td>2014-10-10</td>
			           <td>销售一部</td>
			           <td>张三</td>
			           <td><a>下载</a></td>
			        </tr>
			        <tr>
			           <td>江苏省中医院</td>
			           <td>PX20150322</td>
			           <td>java</td>
			           <td>医学知识平台</td>
			           <td>2015-07-08</td>
			           <td>销售二部</td>
			           <td>李四</td>
			           <td><a>下载</a></td>
			        </tr>
			        <tr>
			           <td>常州市儿童医院</td>
			           <td>PX20150324</td>
			           <td>.net</td>
			           <td>考试系统西医版</td>
			           <td>2016-05-04</td>
			           <td>销售三部</td>
			           <td>王五</td>
			           <td><a>下载</a></td>
			        </tr>
			     </table>
	        </div>
	</div>
   </div>
</body>
</html>