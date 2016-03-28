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

function search() {
	jboxStartLoading();
	$("#searchForm").submit();
}
function edit(talentsFlow) {
	jboxStartLoading();
	//jboxOpen("<s:url value='/srm/aid/talents/edit?talentsFlow='/>"+talentsFlow+"&role=${role}", "人才培养专项资金申请表", 1000, 500);
	jboxOpen("<s:url value='/jsp/srm/conedu/study/edit.jsp'/>","进修管理",1000,500);
}

function check(talentsFlow,role){
	jboxStartLoading();
	jboxOpen("<s:url value='/srm/aid/talents/assess?talentsFlow='/>"+talentsFlow+"&viewAll=N&role="+role, "审核", 900, 600);
}
function oper(talentsFlow,oper){
	var msg = "删除";
	var url = "<s:url value='/srm/aid/talents/del'/>?talentsFlow="+talentsFlow;
	if(oper=="sendCheck"){
		 msg = "送审";
		 url = "<s:url value='/srm/aid/talents/sendCheck'/>?talentsFlow="+talentsFlow;
	}
	jboxConfirm("确定"+msg+"该记录？",function(){
		jboxPost(url,null,function(resp){
			if(resp=='${GlobalConstant.OPRE_SUCCESSED}'){
				search();
			}
		},null,true);
	},null);
}
function toPage(page){
	var form = $("#searchForm");
	$("#currentPage").val(page);
	jboxStartLoading();
	form.submit();
}
function audit(){
	jboxConfirm("确认审核通过？", function() {
		jboxTip("审核失败！");			
	});
}
</script>
</head>
<body>

 <div class="mainright" id="mainright">
    <div class="content">
	  <form id="searchForm" action="<s:url value="/srm/aid/talents/list/${role}"/>" method="post">
	   <div class="title1 clearfix">
		<p>
					姓名：
					<input type="text" class="xltext " name="projYear"/>
					单位名称： <input type="text" name="projNo" value="${param.projNo}" class="xltext" />
					身份证号码：
					<input type="text" name="projName" value="${param.projName}" class="xltext"  />
					<input id="currentPage" type="hidden" name="currentPage" value=""/>
					<input type="button" class="search" onclick="searchProj();" value="查&#12288;询">
					<input type="button" class="search" onclick="edit();" value="新&#12288;增">
				</p>
		</div>
  <table class="xllist">
  	<thead>
         <tr>
            <th width="15%">单位</th>
            <th width="10%">姓名</th>
            <th width="10%">性别</th>
            <th width="10%">出生年月</th>
            <th width="10%">科室</th>
             <th width="10%">职务</th>
            <th width="10%">职称</th>
            <th width="15%">进修单位</th>
            <th width="10%">进修科目</th>
            <th width="17%">起止时间</th>
            <th width="10%">进修月份</th>
            <th width="10%">操作</th>
         </tr>
     </thead>
     
     <tr>
	     <td>鼓楼医院</td>
	     <td>沈振</td>
	   	 <td>男</td>
	     <td>1960-12-20</td>
	     <td>普通外科</td> 
	     <td>主任医生</td>
	     <td>教授</td>
	     <td>南京大学附属医院</td>
	     <td>普通外科</td>
	     <td>2014-06 至 2014-12</td>
	     <td>6个月</td>
	     <td>
		     <a href="javascript:void(0)" onclick="audit('${aid.talentsFlow}');">[审核]</a>
	      </td>
	 </tr>
     <tr>
	     <td>鼓楼医院</td>
	     <td>吴昊</td>
	   	 <td>男</td>
	     <td>1965-02-21</td>
	     <td>外科</td> 
	     <td>副主任医生</td>
	     <td>副教授</td>
	     <td>南京医科大学附属医院</td>
	     <td>普通外科</td>
	     <td>2014-01 至 2015-06</td>
	     <td>18个月</td>
	     <td>
		     <a href="javascript:void(0)" onclick="audit('${aid.talentsFlow}');">[审核]</a>
	      </td>
	 </tr>
     <tr>
	     <td>南京医科大学附属医院</td>
	     <td>贾云飞</td>
	   	 <td>男</td>
	     <td>1970-10-10</td>
	     <td>骨科</td> 
	     <td>主任医生</td>
	     <td>教授</td>
	     <td>天津一附院</td>
	     <td>骨科</td>
	     <td>2015-01 至 2015-06</td>
	     <td>6个月</td>
	     <td>
		     <a href="javascript:void(0)" onclick="audit('${aid.talentsFlow}');">[审核]</a>
	      </td>
	 </tr>
     <tr>
	     <td>江苏省中医院</td>
	     <td>韩兰叶</td>
	   	 <td>女</td>
	     <td>1964-10-02</td>
	     <td>神经内科</td> 
	     <td>主任医生</td>
	     <td>教授</td>
	     <td>明基医院</td>
	     <td>神经内科</td>
	     <td>2015-12 至 2015-12</td>
	     <td>12个月</td>
	     <td>
		     <a href="javascript:void(0)" onclick="audit('${aid.talentsFlow}');">[审核]</a>
	      </td>
	 </tr>
     <tr>
	     <td>南京医科大学附属医院</td>
	     <td>刘燕</td>
	   	 <td>女</td>
	     <td>1975-02-21</td>
	     <td>普通外科</td> 
	     <td>副主任医生</td>
	     <td>副教授</td>
	     <td>鼓楼医院</td>
	     <td>普通外科</td>
	     <td>2015-01 至 2015-01</td>
	     <td>12个月</td>
	     <td>
		     <a href="javascript:void(0)" onclick="audit('${aid.talentsFlow}');">[审核]</a>
	      </td>
	 </tr>
  </table>
  
 	<p>
		<input type="hidden" id="currentPage" name="currentPage" value="${param.currentPage}">
	    <c:set var="pageView" value="${pdfn:getPageView2(aidList, 10)}" scope="request"></c:set>
		<pd:pagination toPage="toPage"/>
	</p>
	
	  </form>
  </div>
</div> 	

</body>
</html>