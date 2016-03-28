<jsp:include page="/jsp/cnres/htmlhead-cnres.jsp">
	<jsp:param name="font" value="true"/>
</jsp:include>
<script type="text/javascript">
	function savePlan(flow,orgFlow,speId,plan){
		var data = {};
		data.recordFlow = flow;
		data.orgFlow = orgFlow;
		data.speId = speId;
		data.assignPlan = plan;
		data.assignYear = "${sysCfgMap['res_reg_year']}";
		jboxPost("<s:url value='/cnres/singup/manage/savePlan'/>",data,null,null,false);
	}
	
	function goLabel(){
		if ($("#operA").html()=="编辑") {
			$("#operA").html("视图");
		} else {
			$("#operA").html("编辑");
		}
		$(".dataPut").toggle();
	}
	
</script>
      <div class="main_hd">
        <h2 class="underline">
       		 基地：
       		<c:choose>
			<c:when test="${GlobalConstant.USER_LIST_LOCAL eq param.source }">
			 	${sessionScope.currUser.orgName}
			</c:when>
			<c:otherwise>
				<select class="xlselect" name="orgFlow" onchange="planInfo(this.value);" style="border:1px solid #d6d7d9; height:34px; line-height:30px; width:260px; outline:none;font-family: microsoft yahei;">
				    <option value="">请选择</option>
					    <c:forEach var="org" items="${orgList}">
							<option value="${org.orgFlow}" <c:if test='${org.orgFlow == orgFlow}'>selected="selected"</c:if>>${org.orgName}</option>
						</c:forEach>
				</select>
			</c:otherwise>
			</c:choose>
			<c:if test="${GlobalConstant.USER_LIST_LOCAL != param.source }">
       		 &#12288;&#12288;
       		 <a id="operA" class="btn" href="javascript:goLabel();">编辑</a>
       		 </c:if>
        </h2>
      </div>
      <div class="main_bd" id="div_table_0">
         <div class="search_table">
           <c:forEach items="${dictTypeEnumDoctorTrainingSpeList}" var="dict">
            <div class="recruit">
			  <div class="recruit_top">${dict.dictName}</div>
			  <div class="recruit_body">
			  <c:set value="${dict.dictId}" var="key"/>
			  <input class="dataPut"  style="display: none;border: 1px #ccc solid;width: 30px;text-align: right; margin-top:20px;" type="text" value="${speAssignMap[key].assignPlan+0}" onchange="savePlan('${speAssignMap[key].recordFlow}','${orgFlow}','${dict.dictId}',this.value);$('#${key}').text(this.value);">
              <label class="dataPut" id="${key}">${speAssignMap[key].assignPlan+0 }</label>
			  </div>
			</div>
		</c:forEach>
         </div>
      </div>
      
