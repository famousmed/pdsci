<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
<title>多文件上传</title>
<script type="text/javascript">
function synResume(){
	jboxGet("<s:url value='/makeup/synResume'/>",null,function(resp){alert(resp);},null,false);
}
function synArchiveFile(){
	jboxGet("<s:url value='/makeup/synArchiveFile'/>",null,function(resp){alert(resp);},null,false);
}
function synMinute(){
	jboxGet("<s:url value='/makeup/synMinute'/>",null,function(resp){alert(resp);},null,false);
}
function synDecisionFile(){
	jboxGet("<s:url value='/makeup/synDecisionFile'/>",null,function(resp){alert(resp);},null,false);
}
function synSchedule(){
	jboxGet("<s:url value='/makeup/synSchedule'/>",null,function(resp){alert(resp);},null,false);
}
function synScheduleWork(){
	jboxGet("<s:url value='/makeup/synScheduleWork'/>",null,function(resp){alert(resp);},null,false);
}
function synRetrialRevise(){
	jboxGet("<s:url value='/makeup/synRetrialRevise'/>",null,function(resp){alert(resp);},null,false);
}
function synOther(){
	jboxGet("<s:url value='/makeup/synOther'/>",null,function(resp){alert(resp);},null,false);
}
function synInit(){
	jboxGet("<s:url value='/makeup/synInit'/>",null,function(resp){alert(resp);},null,false);
}
function synThesis(){
	jboxGet("<s:url value='/makeup/synThesis'/>",null,function(resp){alert(resp);},null,false);
}
function synBook(){
	jboxGet("<s:url value='/makeup/synBook'/>",null,function(resp){alert(resp);},null,false);
}
function synPatent(){
	jboxGet("<s:url value='/makeup/synPatent'/>",null,function(resp){alert(resp);},null,false);
}
function synSat(){
	jboxGet("<s:url value='/makeup/synSat'/>",null,function(resp){alert(resp);},null,false);
}
</script>
</head>
<body>
<h2>上传多个文件 实例</h2>  
    <form action="<s:url value='/makeup/uploadUser'/>" method="post"  
        enctype="multipart/form-data">  
        <p>  
            Excel:<input type="file" name="file">  
        </p>
            <input type="submit" value="提交">  
    </form> 
    <input type="button" value="同步工作、教育、学会" onclick="synResume();">  <br/>
     <input type="button" value="同步存档文件" onclick="synArchiveFile();">  <br/>
    <input type="button" value="同步参会人员" onclick="synIrbMeetingUser();"> 
    <br/>
    <input type="button" value="同步会议记录" onclick="synMinute();"> <br/>
     <input type="button" value="同步会议记录" onclick="synMinute();"> <br/>
     <input type="button" value="同步审查表、决定文件" onclick="synDecisionFile();"> <br/>
     <input type="button" value="同步进展报告申请表" onclick="synSchedule();"> <br/>
      <input type="button" value="同步进展报告审查表" onclick="synScheduleWork();"> <br/>
      <input type="button" value="同步复审、修正案申请，审查表" onclick="synRetrialRevise();"> <br/>
      <input type="button" value="同步违背方案，结题" onclick="synOther();"> <br/>
       <input type="button" value="同步初始审查申请、审查" onclick="synInit();"> <br/>
        <input type="button" value="同步论文" onclick="synThesis();"> <br/>
         <input type="button" value="同步著作" onclick="synBook();"> <br/>
          <input type="button" value="同步专利" onclick="synPatent();"> <br/>
           <input type="button" value="同步获奖" onclick="synSat();"> <br/>
</body>
</html>