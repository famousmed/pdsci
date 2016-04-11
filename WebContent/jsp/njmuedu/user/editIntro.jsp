<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title></title>
<jsp:include page="/jsp/njmuedu/htmlhead-edu.jsp">
    <jsp:param name="basic" value="true"/>
    <jsp:param name="jbox" value="true"/>
    <jsp:param name="userCenter" value="true"/>
	<jsp:param name="findCourse" value="true"/>
	<jsp:param name="jquery_scrollTo" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
</jsp:include>
<script>
    function saveIntro(){
    	var form=$("#searchForm");
    	var url='<s:url value='/njmuedu/user/saveIntro'/>';
    	var requestData = form.serialize();
    	jboxPost(url,requestData,function(resp){
    		if(resp=="${GlobalConstant.SAVE_SUCCESSED}"){
    			jboxDelayClose();
    		}
    	},null,true);
    }
    function doClose(){
    	jboxClose();
    }
</script>
<head>
<body style="background:#fff;">      	
        	<!--  <div class="registerMsg-m2 fl">
    	<div class="registerMsg-m-inner registerBgw">
        	<div class="registerMsg-tabs">-->
               <div class="clear"></div> 
              <div style=" padding:10px;">
 	     <table border="0" cellpadding="0" cellspacing="0" class="course-table">
 	       <col width="20%">
 	       <col width="80%">
 	     
						<thead>
						<tr id="top" >
							<th style="border-top:1px solid #d8e7f0;">个<br/>人<br/>介<br/>绍</th>
							<td valign="top" style="border-top:1px solid #eaedf2;border-right:1px solid #eaedf2;">
							 <form id="searchForm" >
							 <input type="hidden" name="userFlow" value="${eduUserExt.userFlow }">
							 <textarea style="width:524px; line-height:20px; padding:10px; text-indent:28px; height:140px;" name="intro" placeholder="这里填写教师的个人介绍">${eduUserExt.intro }</textarea>
							 </form>
							</td>
						</tr>
						</thead>
						
					</table>
					<div class="editBtn">
					   <input type="button"  value="保存" onclick='saveIntro();'/>
					   <input type="button" class="search2" value="关闭" onclick='doClose();'/>
					</div>
 </div>
    <!--  </div>
          </div>
        </div> -->
        </body>
        </html>