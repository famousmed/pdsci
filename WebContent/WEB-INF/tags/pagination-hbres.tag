<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ tag body-content="scriptless" pageEncoding="UTF-8"%>
<%@ attribute name="toPage" required="true" %>
<script type="text/javascript">
<!--
function topage(page){
	if(parseInt(page)>parseInt('${pageView.totalpage}')){
		jboxTip("已至最后一页!");
		return;
	}
	${toPage}(page);
}
function change(obj){
	if(obj.options[obj.selectedIndex].value!="0"){
		${toPage}(obj.options[obj.selectedIndex].value);
	}
}
function topage1(){
	if($("#jumpPage").val()==""){
		jboxTip("跳转页面不能为空!");
		return;
	}
	var re = /^\+?[1-9][0-9]*$/; 
    if (!re.test($("#jumpPage").val()))  {
		jboxTip("页数必须为正整数");
		return;
	}
    var jumpPage = parseInt($("#jumpPage").val());
	if(jumpPage>parseInt('${pageView.totalpage}')){
		jboxTip("跳转页面不能大于总页数!");
		return;
	}
	topage(jumpPage);
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
<style>
.fenye_select{ padding:4px 0;vertical-align: middle;border: 1px solid #e7e7eb;border-radius: 3px;-moz-border-radius: 3px;-webkit-border-radius: 3px;font-size: 14px; color:#363636; font-family: "Microsoft YaHei"; outline:none;}
</style>
<span>
	<label style="font-size: 14px">
	<span id="pageSpan" class="page_num">
	<c:set var="cfgCode" value="${pageServletPath}/${sessionScope.currUser.userFlow }"/>
	每页&nbsp;<select name="pageSize"  onchange="selectPagesize(this)" class="fenye_select">
	   <c:forEach varStatus="status" begin="10" end="50" step="5">
	    	<option value="${status.index}" <c:if test="${status.index==sessionScope[cfgCode] }"> selected="selected"</c:if> >${status.index }</option>
	   </c:forEach>
    </select>&nbsp;条&nbsp;&nbsp;
   	 共<font style=" padding:0 2px; color:#459ae9;">${pageView.totalrecord}</font>条数据&nbsp;&nbsp;页次:
    </span>
    <!-- 前一页 -->
    <c:if test='${pageView.currentpage > 1}'>
        <input type="button" class="btn_prev" style=" width:35px;" onclick="topage(${pageView.currentpage-1})"></input> 
    </c:if>
    <strong class="page_num">
        <!-- 当前页 -->
        <c:if test="${pageView.totalrecord > 0}">
            ${pageView.currentpage}
	    </c:if> 
	    <c:if test="${pageView.totalrecord == 0}">${pageView.totalrecord}</c:if>/${pageView.totalpage}
	</strong>
    <!-- 下一页 -->
    <c:if test='${pageView.currentpage<pageView.totalpage}'>
        <input type="button" class="btn_next" style=" width:35px;" onclick="topage(${pageView.currentpage+1})"></input> 
    </c:if>
    <input type="text" id="jumpPage" class="input" value="${pageView.currentpage}" style=" width:50px; text-align: center;"/>
    <a class="btn"  href="javascript:topage1();">跳转</a>
    </label>
</span>
