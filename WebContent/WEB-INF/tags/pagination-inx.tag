<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ tag body-content="scriptless" pageEncoding="UTF-8"%>
<%@ attribute name="toPage" required="true" %>
<script type="text/javascript">
<!--
function topage(page){
	${toPage}(page);
}
function change(obj){
	if(obj.options[obj.selectedIndex].value!="0"){
		${toPage}(obj.options[obj.selectedIndex].value);
	}
}
function changeInput(){
	var page = $("#inputPage").val();
	var totalPage = parseInt("${pageView.totalpage}");
	if(page==""){
		return false;
	}
	if(parseInt(page) > totalPage ){
		page = totalPage;
	}
	${toPage}(page);
}
function selectPagesize(obj){
	var size =$(obj).val();
	var url = rootPath()+"/sys/cfg/savePageSize?pageSize="+size+"&pageServletPath=${pageServletPath}";
	if(jboxPost){
		jboxPost(url,null,function(resp){
			if(resp){
				topage(1);
			}
		},null,false);
	}
}
//-->
</script>
<div style="margin-top: 15px; width:100%;text-align:center;">
	<div id="fenye">
	共${pageView.totalrecord}条数据 页次: 
	  <c:if test="${pageView.totalrecord > 0}">
	     ${pageView.currentpage}
	  </c:if> 
	  <c:if test="${pageView.totalrecord == 0}">
	     ${pageView.totalrecord}</c:if>/${pageView.totalpage}页
	  <c:if test="${pageView.currentpage<=1}" >
	     <a class="fenye_button">首页</a>
	  </c:if>
	  <c:if test="${pageView.currentpage>1}" >
	     <a href="javascript:topage('1')" class="fenye_button">首页</a>
	  </c:if>
	  <c:if test="${pageView.currentpage<=1}" >
	     <a class="fenye_button">上一页</a>
	  </c:if>
	  <c:if test="${pageView.currentpage>1}" >
	     <a href="javascript:topage('${pageView.currentpage-1}')" class="fenye_button">上一页</a>
	  </c:if>
	  <c:forEach begin="${pageView.pageindex.startindex}" end="${pageView.pageindex.endindex}" var="wp">
	    <c:if test="${pageView.currentpage==wp}">
	      <a class="fenye_num_s">${wp}</a>
	    </c:if>
	    <c:if test="${pageView.currentpage!=wp}">
	      <a href="javascript:topage('${wp}')" class="fenye_num">${wp}</a>
	    </c:if>
	  </c:forEach>
	   <c:if test="${pageView.currentpage>=pageView.totalpage}" >
	      <a class="fenye_button">下一页</a>
	   </c:if>
	   <c:if test="${pageView.currentpage<pageView.totalpage}" >
	      <a href="javascript:topage('${pageView.currentpage+1}')" class="fenye_button">下一页</a>
	   </c:if>
	   <c:if test="${pageView.currentpage>=pageView.totalpage}" >
	      <a class="fenye_button">尾页</a>
	   </c:if>
	   <c:if test="${pageView.currentpage<pageView.totalpage}" >
	      <a href="javascript:topage('${pageView.totalpage}')" class="fenye_button">尾页</a>
	   </c:if> 
	   <c:choose>
		   	<c:when test="${sysCfgMap['sys_page_style']=='input'}">
				页码<input class="fenye_input" id="inputPage" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" ><a href="javascript:changeInput();" class="fenye_button">GO</a>
		    </c:when>
		    <c:otherwise>
		    	跳转到<select name="selectPage" onchange="change(this)" class="fenye_select">
			      <option value="0">页码</option>
			      <c:forEach begin="1" end="${pageView.totalpage}" var="sp">
			        <option value="${sp}"  <c:if test="${sp==pageView.currentpage}">selected="selected"</c:if> >${sp}</option>
			      </c:forEach>
			    </select>
		    </c:otherwise>
	    </c:choose>
	</div>
</div>
