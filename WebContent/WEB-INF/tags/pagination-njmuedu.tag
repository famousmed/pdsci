<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ tag body-content="scriptless" pageEncoding="UTF-8"%>
<%@ attribute name="toPage" required="true" %>
<jsp:include page="/jsp/njmuedu/htmlhead-edu.jsp">
	<jsp:param name="teacherMien" value="true"/>
</jsp:include>
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
//-->
</script>
	<%-- 共${pageView.totalrecord}条数据 页次: 
	  <c:if test="${pageView.totalrecord > 0}">
	     ${pageView.currentpage}
	  </c:if> 
	  <c:if test="${pageView.totalrecord == 0}">
	     ${pageView.totalrecord}</c:if>/${pageView.totalpage}页 --%>
	  <c:if test="${pageView.currentpage<=1}" >
	     <li class="page"><a class="fenye_button">首页</a></li>
	  </c:if>
	  <c:if test="${pageView.currentpage>1}" >
	     <li class="page"><a href="javascript:topage('1')" class="fenye_button">首页</a></li>
	  </c:if>
	  <c:if test="${pageView.currentpage<=1}" >
	     <li class="page"><a class="fenye_button">上一页</a></li>
	  </c:if>
	  <c:if test="${pageView.currentpage>1}" >
	     <li class="page"><a href="javascript:topage('${pageView.currentpage-1}')" class="fenye_button">上一页</a></li>
	  </c:if>
	  <c:forEach begin="${pageView.pageindex.startindex}" end="${pageView.pageindex.endindex}" var="wp">
	    <!-- 当前页 -->
	    <c:if test="${pageView.currentpage==wp}">
	      <li class="page active"><a class="fenye_num_s">${wp}</a></li>
	    </c:if>
	    <c:if test="${pageView.currentpage!=wp}">
	      <li class="page"><a href="javascript:topage('${wp}')" class="fenye_num">${wp}</a></li>
	    </c:if>
	  </c:forEach>
	   <c:if test="${pageView.currentpage>=pageView.totalpage}" >
	      <li class="page"><a class="fenye_button">下一页</a></li>
	   </c:if>
	   <c:if test="${pageView.currentpage<pageView.totalpage}" >
	      <li class="page"><a href="javascript:topage('${pageView.currentpage+1}')" class="fenye_button">下一页</a></li>
	   </c:if>
	   <c:if test="${pageView.currentpage>=pageView.totalpage}" >
	      <li class="page"><a class="fenye_button">尾页</a></li>
	   </c:if>
	   <c:if test="${pageView.currentpage<pageView.totalpage}" >
	      <li class="page"><a href="javascript:topage('${pageView.totalpage}')" class="fenye_button">尾页</a></li>
	   </c:if>
	<%-- 跳转到<select name="selectPage" onchange="change(this)">
	      <option value="0">页码</option>
	      <c:forEach begin="1" end="${pageView.totalpage}" var="sp">
	        <option value="${sp}"  <c:if test="${sp==pageView.currentpage}">selected="selected"</c:if> >${sp}</option>
	      </c:forEach>
	    </select> --%>
