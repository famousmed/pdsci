<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
function searchProfessionrForStatus(obj){
	var id = $(obj).attr('id');
	$("#id").val(id);
	searchProfession();
}
function searchProfession(){
	var data = $("#searchForm").serialize();
	jboxPostLoad("content","<s:url value='/sczyres/hosptial/orgRecruitInfo'/>",data ,true);
}
</script>
   <div class="main_hd">
       <h2>招录概况
       <div class="fr">
       
       </div>
       </h2>
       <div class="title_tab" id="toptab">
          <ul>
            <li class="${empty param.id or param.id eq speCatEnumZy.id?'tab_select':tab}" id="${speCatEnumZy.id }" onclick="searchProfessionrForStatus(this);"><a>${speCatEnumZy.name}</a></li>
            <li class="${param.id==speCatEnumZyqk.id?'tab_select':tab}" id="${speCatEnumZyqk.id }" onclick="searchProfessionrForStatus(this);"><a>${speCatEnumZyqk.name }</a></li>
          </ul>
       </div>
	   
	   <div class="div_search" style="text-align:right;">
	       <form id="searchForm">
			<!--  <input type="text" id="key" style="width: 200px;" name="key" value="${param.key}" class="input" placeholder="姓名/手机号/邮件/身份证" 
			onchange="searchProfession()"
			/>  -->
			<input type="hidden" name="id" id="id" value='${param.id}'/>
		    </form>
		</div>
   </div>
     <div class="search_table">
        <table border="0" cellpadding="0" cellspacing="0" class="grid">
            <tr>
              <th style="width:200px;;  padding-left:20px;">专业</th>
              <th>录取人数</th>
            </tr>
            <c:if test="${empty param.id or param.id==speCatEnumZy.id}">
	            <c:forEach items="${dictTypeEnumZySpeList}"  var="doc">
		            <tr>
						<td style=" padding-left:20px;">${doc.dictName}</td>
						<td>${recruitCountMap[doc.dictId] }</td>
		            </tr>
	            </c:forEach>
            </c:if>
            <c:if test="${param.id==speCatEnumZyqk.id}">
            	 <c:forEach items="${dictTypeEnumZyqkSpeList}"  var="doc">
			            <tr>
							<td style=" padding-left:20px;">${doc.dictName}</td>
							<td>${recruitCountMap[doc.dictId] }</td>
			            </tr>
	            </c:forEach>
            </c:if>
            <c:if test="${empty dictTypeEnumZySpeList or empty dictTypeEnumZyqkSpeList }">
	            <tr>
	                <td colspan="5">无记录</td>
	            </tr>
        </c:if>
          </table>
    </div>

