<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="true"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="true"/>
	<jsp:param name="jquery_ui_sortable" value="false"/>
	<jsp:param name="jquery_cxselect" value="true"/>
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
<script type="text/javascript" src="<s:url value='/js/j.suggest.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript">
function switchProduct(obj,type) {
	var productTd = $(obj).closest("#productTd");
	var imageUrl = '<s:url value="/css/skin/${skinPath}/images/check.png" />';
	var clickUrl = "switchProduct(this,'project');";
	if (type=="project") {
		clickUrl = "switchProduct(this,'product');";
		productTd.html("");
		productTd.append($("#projectClone span[id='projectSpan']").clone());
		productTd.append('&#12288;<span title="切换为产品" style="cursor: pointer;" onclick="'+clickUrl+'">></span>');
	} else {
		productTd.html("");
		productTd.append($("#productClone span[id='productSpan']").clone());
		productTd.append('&#12288;<span title="切换为项目" style="cursor: pointer;" onclick="'+clickUrl+'">></span>');
	}
}


$(document).ready(function(){
	if($("#productTb tr").length<=0){
		addProduct();
	}
});

function addProduct(){
	var projectId = "projectClone";
	var contractTypeId = $("#contractType").val();
	 if (contractTypeId=="${contractTypeEnumProduct.id}") {
		projectId = "productClone";
	} else if (contractTypeId=="${contractTypeEnumProductProject.id}") {
		projectId = "productProjectClone";
	}
	$('#productTb').append($("#"+projectId+" tr:eq(0)").clone());
}

function delProduct(){
	var mIds = $("#productTb input[name='id']:checked");
	var ids="";
	if(mIds.length == 0){
		jboxTip("请勾选要删除的！");
		return false;
	}
	jboxConfirm("确认删除？", function(){
			$.each(mIds,function(i,n){
			  if($(n).val()!=""){
				  if(mIds.length-1==i){
						ids=ids+$(n).val();
					}else{
						ids=ids+$(n).val()+",";
					} 
			  }else{
				  $(n).parent().parent().remove(); 
			  }	
			});
			var url='<s:url value="/erp/crm/delProduct"/>?productFlows=' + ids;
			jboxGet(url , null , function(){
				mIds.each(function(){
					$(this).parent().parent().remove();
					window.parent.frames['jbox-message-iframe'].window.search();
				});
	 		}, null , true);
	        });
	      
}

function doClose(){
	jboxClose();
}

function showProductCheck(obj) {
	var productType = $(obj).val();
	if(productType!=""){
		if ($("select[name='productTypeId'] option[value='"+productType+"']:selected").parent().length>1) {
		     jboxTip("已存在该产品大项，请重新选择！");
			 $(obj).val("");
			 return; 
		 } 
	}
}

function save(){
	 if($("#productForm").validationEngine("validate")){
		 var productTr=$("#productTb").children();
		 var productDatas=[];
		 if(productTr.length>=1){
			 $.each(productTr , function(i , n){
				   var productFlow=$(n).find("input[name='productFlow']").val();
				   var contractFlow=$(n).find("input[name='contractFlow']").val();
				   var productTypeId=$(n).find("select[name='productTypeId']").val();
				   var productTypeName=$(n).find("input[name='productTypeName']").val();
				   var productItem=$(n).find("input[name='productItem']").val();
				   var installPlace=$(n).find("input[name='installPlace']").val();
				   var versions=$(n).find("input[name='versions']").val();
				   var regFileClientName=$(n).find("input[name='regFileClientName']").val();
				   var regFileIndate=$(n).find("input[name='regFileIndate']").val();
				   var productData;
				   if(productTypeId==undefined){
					   productData={
							   "productTypeName":productTypeName,
							   "productItem":productItem,
							   "productFlow":productFlow,
							   "contractFlow":contractFlow,
							   "installPlace":installPlace,
							   "versions":versions,
							   "regFileClientName":regFileClientName,
							   "regFileIndate":regFileIndate
					   };
				   }else{
					   productData={
							   "productTypeId":productTypeId,
							   "productItem":productItem,
							   "productFlow":productFlow,
							   "contractFlow":contractFlow,
							   "installPlace":installPlace,
							   "versions":versions,
							   "regFileClientName":regFileClientName,
							   "regFileIndate":regFileIndate
					   };
				   }  
				   productDatas.push(productData);
				}); 
			 var allData={
					 'productList':productDatas	
				};
		 }else{
			 jboxTip("至少选择一个产品大项!");
			  return false;
		 }
		
		 $('#jsondata').val(JSON.stringify(allData));
		 var url = "<s:url value='/erp/crm/saveContractInfo'/>";
			jboxSubmit($('#productForm'),url,function(resp){
				jboxTip('${GlobalConstant.SAVE_SUCCESSED}');
				setTimeout(function(){
					if('${param.type}'!='implement'){
						window.parent.frames['jbox-message-iframe'].window.search();
					}
					else{
						window.parent.frames['jbox-message-iframe'].loadProduct('${param.workFlow}','${param.contactFlow}');
					}
					jboxClose();
				},1000);
			},
			null,false);
	 }else{
		 return false;
	 }
}


</script>
</head>
<body>
<div class="mainright">
<div class="content">
	<div class="title1 clearfix">
			<form id="productForm">
			    <input id="jsondata" type="hidden" name="jsondata"/>
			    <input type="hidden" id="contractType" value="${contract.contractTypeId }"/>
				<table cellpadding="0" cellspacing="0" class="xllist" style="width: 100%;">
					<colgroup>
						<col width="4%"/>
						<col width="16%"/>
						<col width="25%"/>
						<col width="15%"/>
						<col width="15%"/>
						<col width="15%"/>
						<col width="10%"/>
					</colgroup>
					<tr>
						<th colspan="7" style="text-align: left;padding-left: 10px">合同产品
							<img title="删除" src="<s:url value="/css/skin/${skinPath}/images/del1.png" />" style="float: right;margin-right: 20px;cursor: pointer;" onclick="delProduct();"/>
							<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="float: right;margin-right: 10px;cursor: pointer;" onclick="addProduct();"/>
						</th>
					</tr>
					<tr>
						<th></th>
						<th>产品/项目名称</th>
						<th>备注</th>
						<th>安装地点</th>
						<th>版本号</th>
						<th>注册文件客户名</th>
						<th>注册文件有效期</th>
					</tr>
					<tbody id="productTb">
					   <c:forEach items="${productList }" var="product">
					      <tr>
		                    <td><input type="checkbox" name="id" value="${product.productFlow }"/></td>
		                    <td>
		                     <input type="hidden" name="productFlow" value="${product.productFlow }"/>
		                     <c:if test="${param.type != 'implement' }">
		                        <span id="productTd">
		                           <input type="hidden" name="contractFlow" value="${product.contractFlow }"/>
		                           <c:if test="${(not empty product.productTypeId) and (not empty product.productTypeName) }">
			                       <select class="inputText validate[required] productTypeId" name="productTypeId" style="width:80%;" onchange="showProductCheck(this);">
				                   <option value="">请选择</option>
				                   <c:forEach var="dict" items="${dictTypeEnumProductTypeList}">
					               <option value="${dict.dictId}"<c:if test="${dict.dictId eq product.productTypeId}">selected="selected"</c:if>>${dict.dictName}</option>
				                   </c:forEach>
			                       </select>
			                       <c:if test="${contract.contractTypeId eq contractTypeEnumProductProject.id }">
			                       &#12288;<span title="切换为项目" style="cursor: pointer;" onclick="switchProduct(this,'project');">></span>
			                       </c:if>
			                       </c:if>
			                       <c:if test="${empty product.productTypeId }">
			                       <input type="text" class="inputText validate[required]" style="width:80%;text-align: left;" name="productTypeName" value="${product.productTypeName }"/>
			                       <c:if test="${contract.contractTypeId eq contractTypeEnumProductProject.id }">
			                       &#12288;<span title="切换为产品" style="cursor: pointer;" onclick="switchProduct(this,'product');">></span>
			                       </c:if>
			                       </c:if>
			                    </span>
		                     </c:if>
		                     <c:if test="${param.type == 'implement' }">
		                           ${product.productTypeName }
		                           <input type="hidden" style="width:80%;" name="productTypeName" value="${product.productTypeName }"/>
		                           <input type="hidden" name="contractFlow" value="${product.contractFlow }"/>
		                     </c:if>
		                    </td>
		                    <td>
		                    <c:if test="${param.type != 'implement' }">
		                    <input type="text" class="inputText validate[maxSize[250]]" name="productItem" style="width:90%;text-align: left;" value="${product.productItem }"/>
		                    </c:if>
		                    <c:if test="${param.type == 'implement' }">
		                    ${product.productItem }
		                    <input type="hidden" class="inputText" name="productItem" style="width:90%;" value="${product.productItem }"/>
		                    </c:if>
		                    </td>
		                    <td>
		                    <input type="text" class="inputText validate[maxSize[250]]" name="installPlace" style="width:90%;text-align: left;" value="${product.installPlace }"/>
		                    </td>
		                    <td>
		                    <input type="text" class="inputText validate[maxSize[50]]" name="versions" style="width:90%;text-align: left;" value="${product.versions }"/>
		                    </td>
		                    <td> 
		                    <input type="text" class="inputText validate[maxSize[250]]" name="regFileClientName" value="${product.regFileClientName }" style="width:90%;text-align: left;"/>
		                    </td>
		                    <td> 
		                    <input type="text" class="inputText validate[maxSize[50]] " name="regFileIndate" value="${product.regFileIndate }" style="width:90%;text-align: left;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
		                    </td>
	                      </tr>
					   </c:forEach>
					</tbody>
				</table>
				</form>
				<div class="button" style="width: 100%">
					<input class="search" type="button" value="保&#12288;存" onclick="save();" />
					<input class="search" type="button" value="关&#12288;闭" onclick="jboxClose();" />
				</div>
			</div>
		</div>
	</div>

<table style="display: none;" id="productClone">
	<tr>
		<td><input type="checkbox" name="id" value=""/></td>
		<td style="text-align: center;">
		<span id="productSpan">
		    <input type="hidden" name="contractFlow" value="${param.contractFlow }"/>
			<select class="inputText validate[required]" id="productTypeId" name="productTypeId" style="width:80%;" onchange="showProductCheck(this);">
				<option value="">请选择</option>
				<c:forEach var="dict" items="${dictTypeEnumProductTypeList}">
					<option value="${dict.dictId}">${dict.dictName}</option>
				</c:forEach>
			</select>
		</span>
		</td>
		<td>
		 <input type="text" class="inputText validate[maxSize[250]]" name="productItem" style="width:90%;text-align: left;"/>
		</td>
		<td> 
		   <input type="text" class="inputText validate[maxSize[250]]" name="installPlace" style="width:90%;text-align: left;"/>
		</td>
		<td>
		   <input type="text" class="inputText validate[maxSize[50]]" name="versions" style="width:90%;text-align: left;"/>
		</td>
		<td> 
		   <input type="text" class="inputText validate[maxSize[250]]" name="regFileClientName" style="width:90%;text-align: left;"/>
		</td>
		<td> 
		   <input class="inputText" name="regFileIndate" style="text-align: left;" type="text" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
		</td>
	</tr>
</table>
<table style="display: none;" id="projectClone">
	<tr>
		<td><input type="checkbox" name="id" value=""/></td>
		<td style="text-align: center;">
			<span id="projectSpan">
			    <input type="hidden" name="contractFlow" value="${param.contractFlow }"/>
				<input type="text" class="inputText validate[required] validate[maxSize[25]]" name="productTypeName" style="width:80%;text-align: left;"/>
			</span>
		</td>
		<td>
		 <input type="text" class="inputText validate[maxSize[250]]" name="productItem" style="width:90%;text-align: left;"/>
		</td>
		<td> 
		   <input type="text" class="inputText validate[maxSize[250]]" name="installPlace" style="width:90%;text-align: left;"/>
		</td>
		<td>
		   <input type="text" class="inputText validate[maxSize[50]]" name="versions" style="width:90%;text-align: left;"/>
		</td>
		<td> 
		   <input type="text" class="inputText validate[maxSize[250]]" name="regFileClientName" style="width:90%;text-align: left;"/>
		</td>
		<td> 
		   <input class="inputText" name="regFileIndate" style="text-align: left;" type="text" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
		</td>
	</tr>
</table>
<table style="display: none;" id="productProjectClone" >
	<tr>
		<td><input type="checkbox" name="id" value=""/></td>
		<td style="text-align: center;" id="productTd">
		     <input type="hidden" name="contractFlow" value="${param.contractFlow }"/>
			 <select class="inputText validate[required]" id="productTypeId" name="productTypeId" style="width:80%;" onchange="showProductCheck(this);">
				<option value="">请选择</option>
				<c:forEach var="dict" items="${dictTypeEnumProductTypeList}">
					<option value="${dict.dictId}">${dict.dictName}</option>
				</c:forEach>
			</select>
			&#12288;<span title="切换为项目" style="cursor: pointer;" onclick="switchProduct(this,'project');">></span>
		</td>
		<td>
		 <input type="text" class="inputText validate[maxSize[250]]" name="productItem" style="width:90%;text-align: left;"/>
		</td>
		<td> 
		   <input type="text" class="inputText validate[maxSize[250]]" name="installPlace" style="width:90%;text-align: left;"/>
		</td>
		<td>
		   <input type="text" class="inputText validate[maxSize[50]]" name="versions" style="width:90%;text-align: left;"/>
		</td>
		<td> 
		   <input type="text" class="inputText validate[maxSize[250]]" name="regFileClientName" style="width:90%;text-align: left;"/>
		</td>
		<td> 
		   <input class="inputText" name="regFileIndate" style="text-align: left;" type="text" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
		</td>
	</tr>
</table>
</body>
</html>