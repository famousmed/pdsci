<jsp:include page="/jsp/cnres/htmlhead-cnres.jsp">
	<jsp:param name="font" value="true"/>
</jsp:include>
<script type="text/javascript">
	function getOrgList(isY,id){
		org(isY,id);
	}
	
	$(function(){
		var li = $("#${param.id}");
		if(li.length>0){
			$(".tab_select").toggleClass("tab");
			$(".tab_select").toggleClass("tab_select");
			$(li).toggleClass("tab_select");
			$(li).toggleClass("tab");
		}
	});
</script>
      <div class="main_hd">
        <h2>基地维护</h2>
        <div class="title_tab" id="toptab">
          <ul>
            <li id="all" class="tab_select" onclick="getOrgList('',this.id);"><a>全部</a></li>
            <li id="country" class="tab" onclick="getOrgList('${GlobalConstant.FLAG_Y}',this.id);"><a>国家基地</a></li>
          </ul>
        </div>
      </div>
      <div class="main_bd" id="div_table_0"  >
        <div class="div_table">
          <table border="0" cellpadding="0" cellspacing="0" class="grid">
            <tr>
              <th style="text-align: left;padding-left: 40px;">基地编号</th>
              <th style="text-align: left;padding-left: 40px;">基地名称</th>
              <th>类型</th>
            </tr>
            <c:forEach items="${orgList}" var="org">
            	<tr>
            	<!-- 
            		<td style="text-align: left;padding-left: 40px;">${org.ordinal}</td>
            		 -->
            		<td style="text-align: left;padding-left: 40px;">${org.orgCode}</td>
            		<td style="text-align: left;padding-left: 40px;">${org.orgName}</td>
            		<td>
            			<c:if test="${!empty org.orgLevelId}">
            				<a class="btn" href="javascript:void(0);">${org.orgLevelName}</a>
            			</c:if>
            		</td>
            	</tr>
            </c:forEach>
            <c:if test="${empty orgList}">
            	<tr>
            		<td colspan="4">无记录</td>
            	</tr>
            </c:if>
          </table>
        </div>
      </div>
      
