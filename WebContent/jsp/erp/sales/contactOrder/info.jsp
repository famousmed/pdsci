<script type="text/javascript" src="<s:url value='/js/j.suggest.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript">
function customerInfo(customerFlow){
	var w = $('.mainright').width();
	var h = $('.mainright').height();
	var url = "<s:url value='/erp/crm/customerInfo'/>?customerFlow=" + customerFlow+"&type=open&no=third";
	jboxOpen(url,"客户详细信息", w, h); 
}
function contractInfo(contractFlow) {
	var mainIframe = window.parent.frames["mainIframe"];
	var width = mainIframe.document.body.scrollWidth;
	var url = "<s:url value='/erp/crm/contractInfo'/>?contractFlow="+contractFlow+"&status=main&type=open";
	jboxOpen(url, "合同详细信息", width, 600);
}
function loadContactOrderContent(contactFlow){
	var url="<s:url value='/erp/sales/loadContactOrderContent'/>?contactFlow=" + contactFlow+"&historyFlag=${param.historyFlag}";
	jboxLoad("contentDiv", url, false);
}
function loadContactOrderAudit(contactFlow){
	var url="<s:url value='/erp/sales/loadContactOrderAudit'/>?contactFlow=" + contactFlow+"&historyFlag=${param.historyFlag}";
	jboxLoad("auditDiv", url, false);
}

$(document).ready(function(){
	loadContactOrderContent('${contactFlow}');
	loadContactOrderAudit('${contactFlow}');
});
function searchVisitOpinion(contactFlow){
	jboxOpen("<s:url value='/erp/sales/contactOrderVisitOpinion'/>?contactFlow="+contactFlow,"回访记录", 700, 400);
}

function closeContactOrder(contactFlow){
	var url;
	jboxConfirm("确认关闭联系单？", function(){
				 url="<s:url value='/erp/sales/checkContractMaintainDueDate'/>?contactFlow="+contactFlow;
				 jboxPost(url , null, function(resp){
					if(resp){
						  if(!resp.maintainDueDate){
						     jboxConfirm("是否回写合同维护到期日？", function(){	
						        url="<s:url value='/erp/sales/computeMaintainDueDate'/>?contactFlow="+contactFlow+"&contractFlow="+resp.contractFlow;
						        jboxOpen(url,"计算合同维护到期日",400,180);
						    },function(){ closeContact(contactFlow);});
						     
						 }else{
							 closeContact(contactFlow);
						 }
				   }else{
					 closeContact(contactFlow);
				 }
			 },null,false);
	},null);
}

function closeContact(contactFlow){
	var url = "<s:url value='/erp/sales/closeContactOrder'/>?contactFlow="+contactFlow;
		jboxPost(url , null, function(resp){
			if(resp != "${GlobalConstant.SAVE_FAIL}"){
				jboxTip("${GlobalConstant.OPRE_SUCCESSED}");
				setTimeout(function(){
					window.parent.frames['mainIframe'].window.search();
					jboxCloseMessager();
				},1000);
			}
		}, null , false);
}

function doClose(){
		jboxCloseMessager();
		jboxClose();
}

function recall(contactFlow){
	jboxConfirm("确认将联系单撤回至<font color='red'>实施中</font>？", function(){
		url="<s:url value='/erp/sales/recall'/>?contactFlow="+contactFlow;
		 jboxPost(url , null, function(resp){
			 if(resp != "${GlobalConstant.SAVE_FAIL}"){
					jboxTip("${GlobalConstant.OPRE_SUCCESSED}");
					setTimeout(function(){
						window.parent.frames['mainIframe'].window.search();
						jboxCloseMessager();
					},1000);
				}
		 },null,false);
	},null);
}

</script>
</head>
<body>
<div class="mainright">
<div class="content">
			<form id="implementForm">
			   <div id="contentDiv"></div>
				<div id="auditDiv"></div>
				<c:if test="${param.type!='noclose' }">
				<div class="button">
				   <c:if test="${param.closeFlag == GlobalConstant.FLAG_Y and sessionScope[GlobalConstant.USER_LIST_SCOPE] == GlobalConstant.USER_LIST_LOCAL}">
	       		    <input type="button" value="关&#12288;单" onclick="closeContactOrder('${param.contactFlow}');" class="search"/>
       		        <input type="button" value="撤&#12288;回" onclick="recall('${param.contactFlow}');" class="search"/>
       		        </c:if>
				   <input class="search" type="button" value="关&#12288;闭" onclick="doClose();" />
				</div>
				</c:if>
			</form>
			
		</div>
	</div>



</body>
</html>