 <c:if test="${not empty productNameList }">
    <c:forEach items="${productNameList }" var="productName" varStatus="num">${productName }
      <c:if test="${not empty productInsMap[productName] }">
	    &#12288;安装地点：${productInsMap[productName].installPlace }
	    <c:if test="${empty productInsMap[productName].installPlace }">无</c:if>&#12288;
	    &#12288;版本号：${productInsMap[productName].versions }
	    <c:if test="${empty productInsMap[productName].versions }">无</c:if>&#12288;
	    &#12288;注册文件客户名：${productInsMap[productName].regFileClientName }
	    <c:if test="${empty productInsMap[productName].regFileClientName }">无</c:if>&#12288;
	    <c:if test="${workOrderStatusEnumImplementing.id eq workOrder.workStatusId }">
	    <a href="javascript:void(0);" onclick="editProduct('${contactOrder.contractFlow}','${param.workFlow }','${contactOrder.contactFlow }')">修改</a>
	    </c:if>
	  </c:if>
 <c:if test="${num.count == (fn:length(productNameList)-1) }"><br/></c:if>
       
</c:forEach>
</c:if>