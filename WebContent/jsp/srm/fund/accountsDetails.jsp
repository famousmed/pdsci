<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
	<jsp:param name="jquery_ui_sortable" value="false"/>
	<jsp:param name="jquery_cxselect" value="false"/>
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
<script type="text/javascript">
    function saveDetails(){
    	if(!$("#detailsForm").validationEngine("validate")){
    		return false;
    	} 
    	jboxConfirm("确认保存?" , function(){
		var authTab = $('#test');
		var trs = authTab.children();
		var datas = [];
		var fundFlow = $("input[name='fundFlow']").val();
		$.each(trs , function(i , n){
			var realityTypeId =  $(n).find("select[name='realityTypeId']").val();
			var money= $(n).find("input[name='money']").val();
			var provideDateTime= $(n).find("input[name='provideDateTime']").val();
			var provideOrg= $(n).find("input[name='provideOrg']").val();
				
			var data = {
						"fundFlow":fundFlow,
						"realityTypeId":realityTypeId,
						"money":money,
						"provideDateTime":provideDateTime,
						"provideOrg":provideOrg
					};
			datas.push(data);
		});
		var requestData = JSON.stringify(datas);
		var url="<s:url value='/srm/fund/saveDetail'/>";
		jboxStartLoading();
		jboxPostJson(url,requestData,function(resp){
			if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
				window.parent.frames['mainIframe'].window.search();
				jboxCloseMessager(); 		
			}
		},null,true);
    	});	 
    }
    
    function doClose() {
    	jboxClose();
	}
    function check(obj){
       if(obj.checked==true){
    	   obj.value=1;  
       }	
       else{
    	   obj.value=0;   
       }	
    } 
    function addItem(){
    	$('#test').append($("#moban tr:eq(0)").clone());
    }
    function delItemTr(obj){
    	var tr=obj.parentNode.parentNode;
        tr.remove();
    }  
    function delFundDetail(detailFlow){
    	jboxConfirm("确认删除该记录?" , function(){
    		jboxStartLoading();
    		var url = "<s:url value='/srm/fund/delDetail?fundDetailFlow='/>"+detailFlow;
    		jboxGet(url , null , function(){
    			$("#searchForm",window.parent.frames['mainIframe'].document).submit(); 
		 		jboxCloseMessager(); 
    		} , null , true);
    	});
    	
    }
</script>
</head>
<body>
<div id="main">
   <div class="mainright">
      <div class="content">
          <p style="font-weight: bold;font-size: 14px;"> 项目名称：${proj.projName} &nbsp;&nbsp;&nbsp;&nbsp;项目编号：${proj.projNo }&nbsp;&nbsp;&nbsp;&nbsp;项目类型：${proj.projTypeName}</p>     
          <br/>
        <div class="title1 clearfix">
        <form id="detailsForm">
         <table class="bs_tb" width="100%" cellspacing="0" cellpadding="0">
           <tr>
	   		 <th colspan="8" class="bs_name">到账编辑<a href="javascript:void(0)"><img src="${ctxPath}/css/skin/${skinPath}/images/add.png" onclick="addItem();" title="添加"></img></a></th>
		   </tr>
		   <tr>
             <th style="text-align: center; width:10%">到账类型</th>
             <th style="text-align: center; width:10%;">到账金额(万元)</th>
             <th style="text-align: center; width:12%;">到账时间</th>
             <th style="text-align: center;">拨款单位</th>
             <th style="text-align: center;width: 10%;">操作</th>
           </tr>
            <c:forEach items="${details}" var="detail">
            <tr>
             <td>
            	${detail.realityTypeName}
             </td>
             <td>
                ${detail.money}
             </td>
             <td>
                ${detail.provideDateTime}
             </td>
             <td>
                ${detail.provideOrg}
             </td>
             <td>
                 <a href="javascript:void(0);" onclick="delFundDetail('${detail.fundDetailFlow}')">删除</a>
             </td>
           </tr>
           </c:forEach> 
           <tbody id="test">
           </tbody>
         </table>
       <div class="button" >
       		<input type="hidden" name="fundFlow" value="${param.fundFlow}" />
       		<input id="jsondata" type="hidden" name="jsondata" value=""/>
           <input type="button" value="保&#12288;存" onclick="saveDetails();" class="search"/>&#12288;<input type="button" value="关&#12288;闭" onclick="jboxCloseMessager();" class="search"/>
       </div>
       </form>
       
     <table id="moban" style="display: none">
        <tr>
             <td>
              <select name="realityTypeId" class="validate[required]" style="width: 80px;">
                <option value="">请选择</option>
                <c:forEach var="fundAccountsType" items="${projFundAccountsTypeEnumList}">
                   <option value="${fundAccountsType.id}" >${fundAccountsType.name}</option>
                </c:forEach>
              </select>
             </td>
             <td>
                <input style="width: 90%; text-align: center;" type="text" name="money" class="validate[required,custom[number],min[0]]" />
             </td>
             <td>
                 <input type="text" name="provideDateTime" class="validate[required]" style="width:90%" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
             </td>
             <td>
                 <input class="validate[required]" style="width:96%"  type="text" name="provideOrg"/>
             </td>
             <td> 
            	 <a href="javascript:void(0);" onclick="delItemTr(this)">删除</a>
             </td>
           </tr>
           </table>

         </div>
     </div> 	
   </div>
</div>
</body>
</html>