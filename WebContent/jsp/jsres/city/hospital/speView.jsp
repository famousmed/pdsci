<script>
$(document).ready(function(){
		$(":checkbox").attr("disabled",true);
});
</script>
<div class="infoAudit"   <c:if test="${param.openType != 'open'}">style="height: auto;"</c:if>>
<div class="main_bd" style="margin-top: 20px;">
    <ul class="search_table">
        <li class="score_frame">
            <h1 style="text-align: left;">基地培训专业管理 <span style="float: right;">
                <input type="checkbox"  onclick="choose();"name="choose" />全选 </span></h1>
                   <c:forEach items="${trainCategoryEnumList }" var="trainCategory" varStatus="status">
			       <c:if test="${trainCategory.typeId eq param.trainCategoryType}">
			       <c:set var="dictName" value="dictTypeEnum${trainCategory.id }List" />
			  <div>
				<table border="0" cellpadding="0" cellspacing="0" class="base_info" style="border-top-style: none;">
                	<tr>
                		<th style="width: 20%;text-align: center;">${trainCategory.name}</th>
                		<td style="width: 80%;">
                			<ul>
						        <c:forEach items="${applicationScope[dictName] }" var="dict">
						        	<c:set var="speMapKey" value="${trainCategory.id}${dict.dictId}"/>
						            <li style="width: 220px;float: left;line-height: 25px;" >
						            	<input type="checkbox" class="spe" id="${trainCategory.id}_${dict.dictId }" name="speId" value="${dict.dictId}" 
						            	 <c:if  test="${rbsMap[speMapKey]!=null}">
						            	 checked="checked"</c:if>/>
						            	<input type="hidden" name ="speTypeId" value="${trainCategory.id}"/>
						            	<input type="hidden" name ="speTypeName" value="${trainCategory.name}"/>
						            	<input type="hidden" name ="speName" value="${dict.dictName }"/>
						            	<label for="${trainCategory.id}_${dict.dictId }">${dict.dictName }</label>
						            </li>
								</c:forEach>
							</ul>
                		</td>
                	</tr>
                </table>
			</div>
			</c:if>
		</c:forEach>
        </li>
    </ul>
</div>
<div class="btn_info" style="margin-bottom: 60px">
	<jsp:include page='/jsp/jsres/province/hospital/passBtn.jsp'/>
</div>
</div>