<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<script>
function saomiaoSubmit(){
	if(false==$("#saomiaoForm").validationEngine("validate")){
		return ;
	}
	jboxConfirm("确认提交,提交后不可更改！" , function(){
		var url = "<s:url value='/exam/manage/imp/registScanInfo'/>";
		var data = $('#saomiaoForm').serialize();
		jboxPost(url, data, function(data) {
			refreshRegistInfo();
		} , null , true);
	});
	
}

function shibieSubmit(){
	if(false==$("#shibieForm").validationEngine("validate")){
		return ;
	}
	jboxConfirm("确认提交,提交后不可更改！" , function(){
		var url = "<s:url value='/exam/manage/imp/registRecognizeInfo'/>";
		var data = $('#shibieForm').serialize();
		jboxPost(url, data, function(data) {
			refreshRegistInfo();
		} , null , true);
	});
	
}

function paibanSubmit(){
	if(false==$("#paibanForm").validationEngine("validate")){
		return ;
	}
	jboxConfirm("确认提交,提交后不可更改！" , function(){
		var url = "<s:url value='/exam/manage/imp/registComposInfo'/>";
		var data = $('#paibanForm').serialize();
		jboxPost(url, data, function(data) {
			refreshRegistInfo();
		} , null , true);
	});
	
}
</script>
                            <c:if test="${empty bookRegistInfo.registStatusId}">
                            <form id="saomiaoForm">
                                <input type="hidden" name="bookFlow" value="${bookRegistInfo.bookFlow}"/>
                                <table class="basic" style="width: 100%;height: 100%;">
	                                <tr>
		                                <th style="text-align: left;" colspan="3">&#12288;&#12288;扫描信息</th>
	                                </tr>
		                            <tr> 
			                            <td>
			                                <span>扫描人</span>
			                            </td>
			                            <td>
				                            <span>扫描日期</span>
			                            </td>
			                            <td>
			                                <span>扫描文档签收人</span>
			                            </td>
		                            </tr>	
		                            <tr> 
			                            <td>
			                                <span>
			                                    <select name="scanUserFlow" class="validate[required]">
			                                        <option value="">请选择</option>
			                                        <c:forEach items="${users}" var="user">
			                                            <option value="${user.userFlow}">${user.userName}</option>
			                                        </c:forEach>
			                                    </select>
			                                </span>
			                            </td>
			                            <td>
				                            <span><input type="text" name="scanTime" class="validate[required] ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/></span>
			                            </td>
			                            <td>
			                                <span>
			                                    <select name="signUserFlow" class="validate[required]">
			                                        <option value="">请选择</option>
			                                        <c:forEach items="${users}" var="user">
			                                            <option value="${user.userFlow}">${user.userName}</option>
			                                        </c:forEach>
			                                    </select>
			                                </span>
			                            </td>
		                            </tr>
		                            <tr>
		                                <td colspan="3" style="text-align: center;"><input type="button" class="search" value="提交" onclick="saomiaoSubmit();"/></td>
		                            </tr>		
                                </table>
                            </form>
                            </c:if>
						 	<c:if test="${bookRegistStatusEnumScan.id eq bookRegistInfo.registStatusId}">
						 	    <table class="basic" style="width: 100%;height: 100%;">
	                                <tr>
		                                <th style="text-align: left;" colspan="3">&#12288;&#12288;扫描信息</th>
	                                </tr>
		                            <tr> 
			                            <td>
			                                <span>扫描人</span>
			                            </td>
			                            <td>
				                            <span>扫描日期</span>
			                            </td>
			                            <td>
			                                <span>扫描文档签收人</span>
			                            </td>
		                            </tr>	
		                            <tr> 
			                            <td>
			                                <span>${bookRegistInfo.bookScanInfo.scanUserName}</span>
			                            </td>
			                            <td>
				                            <span>${bookRegistInfo.bookScanInfo.scanTime}</span>
			                            </td>
			                            <td>
			                                <span>${bookRegistInfo.bookScanInfo.signUserName}</span>
			                            </td>
		                            </tr>
                                </table>
						 	    
						 	    <form id="shibieForm">
						 	    <input type="hidden" name="bookFlow" value="${bookRegistInfo.bookFlow}"/>
						 	    <table class="basic" style="width: 100%;height: 100%;">
	                                <tr>
		                                <th style="text-align: left;" colspan="3">&#12288;&#12288;识别信息</th>
	                                </tr>
		                            <tr> 
			                            <td>
			                                <span>识别人</span>
			                                
			                            </td>
			                             <td>
			                                <span>
			                                    <select name="recognizeUserFlow" class="validate[required]">
			                                        <option value="">请选择</option>
			                                        <c:forEach items="${users}" var="user">
			                                            <option value="${user.userFlow}">${user.userName}</option>
			                                        </c:forEach>
			                                    </select>
			                                </span>
			                             </td>
			                        </tr>
			                        <tr>
			                            <td>
				                            <span>识别日期</span>
			                            </td>
			                            <td>
			                                <span>
			                                   <input type="text" name="recognizeTime" class="validate[required] ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
			                                </span>
			                            </td>
			                        </tr>
			                        <tr>
			                            <td>
				                            <span>存在问题</span>
			                            </td>
			                            <td>
			                                <span><textarea name="problem" style="width:100%;height: 100px;" rows="" cols=""></textarea></span>
			                            </td>
			                        </tr>
			                        <tr>
			                            <td>
				                            <span>解决方法</span>
			                            </td>
			                            <td>
			                                <span><textarea name="solution" style="width:100%;height: 100px;" rows="" cols=""></textarea></span>
			                            </td>
			                        </tr>
			                        <tr>
			                            <td>
			                                <span>签收人</span>
			                            </td>
			                            <td>
			                                <span>
			                                    <select name="signUserFlow" class="validate[required]">
			                                        <option value="">请选择</option>
			                                        <c:forEach items="${users}" var="user">
			                                            <option value="${user.userFlow}">${user.userName}</option>
			                                        </c:forEach>
			                                    </select>
			                                </span>
			                            </td>
		                            </tr>
		                             <tr>
		                                <td colspan="2" style="text-align: center;"><input type="button" class="search" value="提交" onclick="shibieSubmit();"/></td>
		                            </tr>		
                                </table>
                                </form>
                            </c:if>
						 	<c:if test="${bookRegistStatusEnumRecognize.id eq bookRegistInfo.registStatusId}">
						 	     <table class="basic" style="width: 100%;height: 100%;">
	                                <tr>
		                                <th style="text-align: left;" colspan="3">&#12288;&#12288;扫描信息</th>
	                                </tr>
		                            <tr> 
			                            <td>
			                                <span>扫描人</span>
			                            </td>
			                            <td>
				                            <span>扫描日期</span>
			                            </td>
			                            <td>
			                                <span>扫描文档签收人</span>
			                            </td>
		                            </tr>	
		                            <tr> 
			                            <td>
			                                <span>${bookRegistInfo.bookScanInfo.scanUserName}</span>
			                            </td>
			                            <td>
				                            <span>${bookRegistInfo.bookScanInfo.scanTime}</span>
			                            </td>
			                            <td>
			                                <span>${bookRegistInfo.bookScanInfo.signUserName}</span>
			                            </td>
		                            </tr>
                                </table>
						 	     
						 	     <table class="basic" style="width: 100%;height: 100%;">
	                                <tr>
		                                <th style="text-align: left;" colspan="3">&#12288;&#12288;识别信息</th>
	                                </tr>
		                            <tr> 
			                            <td>
			                                <span>识别人</span>
			                            </td>
			                             <td>
			                                <span>${bookRegistInfo.bookRecognizeInfo.recognizeUserName}</span>
			                             </td>
			                        </tr>
			                        <tr>
			                            <td>
				                            <span>识别日期</span>
			                            </td>
			                            <td>
			                                <span>${bookRegistInfo.bookRecognizeInfo.recognizeTime}</span>
			                            </td>
			                        </tr>
			                        <tr>
			                            <td>
				                            <span>存在问题</span>
			                            </td>
			                            <td>
			                                <span>${bookRegistInfo.bookRecognizeInfo.problem}</span>
			                            </td>
			                        </tr>
			                        <tr>
			                            <td>
				                            <span>解决方法</span>
			                            </td>
			                            <td>
			                                <span>${bookRegistInfo.bookRecognizeInfo.solution}</span>
			                            </td>
			                        </tr>
			                        <tr>
			                            <td>
			                                <span>签收人</span>
			                            </td>
			                            <td>
			                                <span>${bookRegistInfo.bookRecognizeInfo.signUserName}</span>
			                            </td>
		                            </tr>
                                </table>
						 	     <form id="paibanForm">
						 	     <input type="hidden" name="bookFlow" value="${bookRegistInfo.bookFlow}"/>
						 	     <table class="basic" style="width: 100%;height: 100%;">
	                                <tr>
		                                <th style="text-align: left;" colspan="3">&#12288;&#12288;排版信息</th>
	                                </tr>
		                            <tr> 
			                            <td>
			                                <span>排版人</span>
			                            </td>
			                             <td>
			                               <span>
			                                    <select name="composUserFlow" class="validate[required]">
			                                        <option value="">请选择</option>
			                                        <c:forEach items="${users}" var="user">
			                                            <option value="${user.userFlow}">${user.userName}</option>
			                                        </c:forEach>
			                                    </select>
			                                </span>
			                             </td>
			                        </tr>
			                        <tr>
			                            <td>
				                            <span>排版日期</span>
			                            </td>
			                            <td>
			                                <span><input type="text" name="composTime" class="validate[required] ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/></span>
			                            </td>
			                        </tr>
			                        <tr>
			                            <td>
				                            <span>存在问题</span>
			                            </td>
			                            <td>
			                                <span><textarea name="problem" style="width:100%;height: 100px;" rows="" cols=""></textarea></span>
			                            </td>
			                        </tr>
			                        <tr>
			                            <td>
				                            <span>解决方法</span>
			                            </td>
			                            <td>
			                                <span><textarea name="solution" style="width:100%;height: 100px;" rows="" cols=""></textarea></span>
			                            </td>
			                        </tr>
			                        <tr>
			                            <td>
			                                <span>签收人</span>
			                            </td>
			                            <td>
			                                <span>
			                                    <select name="signUserFlow" class="validate[required]">
			                                        <option value="">请选择</option>
			                                        <c:forEach items="${users}" var="user">
			                                            <option value="${user.userFlow}">${user.userName}</option>
			                                        </c:forEach>
			                                    </select>
			                                </span>
			                            </td>
		                            </tr>
		                             <tr>
		                                <td colspan="2" style="text-align: center;"><input type="button" class="search" value="提交" onclick="paibanSubmit();"/></td>
		                            </tr>		
                                </table>
                                </form>
                            </c:if>                            
                            <c:if test="${bookRegistStatusEnumCompos.id eq bookRegistInfo.registStatusId}">
                             <table class="basic" style="width: 100%;height: 100%;">
	                                <tr>
		                                <th style="text-align: left;" colspan="3">&#12288;&#12288;扫描信息</th>
	                                </tr>
		                            <tr> 
			                            <td>
			                                <span>扫描人</span>
			                            </td>
			                            <td>
				                            <span>扫描日期</span>
			                            </td>
			                            <td>
			                                <span>扫描文档签收人</span>
			                            </td>
		                            </tr>	
		                            <tr> 
			                            <td>
			                                <span>${bookRegistInfo.bookScanInfo.scanUserName}</span>
			                            </td>
			                            <td>
				                            <span>${bookRegistInfo.bookScanInfo.scanTime}</span>
			                            </td>
			                            <td>
			                                <span>${bookRegistInfo.bookScanInfo.signUserName}</span>
			                            </td>
		                            </tr>
                                </table>
						 	     
						 	     <table class="basic" style="width: 100%;height: 100%;">
	                                <tr>
		                                <th style="text-align: left;" colspan="3">&#12288;&#12288;识别信息</th>
	                                </tr>
		                            <tr> 
			                            <td>
			                                <span>识别人</span>
			                            </td>
			                             <td>
			                                <span>${bookRegistInfo.bookRecognizeInfo.recognizeUserName}</span>
			                             </td>
			                        </tr>
			                        <tr>
			                            <td>
				                            <span>识别日期</span>
			                            </td>
			                            <td>
			                                <span>${bookRegistInfo.bookRecognizeInfo.recognizeTime}</span>
			                            </td>
			                        </tr>
			                        <tr>
			                            <td>
				                            <span>存在问题</span>
			                            </td>
			                            <td>
			                                <span>${bookRegistInfo.bookRecognizeInfo.problem}</span>
			                            </td>
			                        </tr>
			                        <tr>
			                            <td>
				                            <span>解决方法</span>
			                            </td>
			                            <td>
			                                <span>${bookRegistInfo.bookRecognizeInfo.solution}</span>
			                            </td>
			                        </tr>
			                        <tr>
			                            <td>
			                                <span>签收人</span>
			                            </td>
			                            <td>
			                                <span>${bookRegistInfo.bookRecognizeInfo.signUserName}</span>
			                            </td>
		                            </tr>
                                </table>
						 	     
						 	     <table class="basic" style="width: 100%;height: 100%;">
	                                <tr>
		                                <th style="text-align: left;" colspan="3">&#12288;&#12288;排版信息</th>
	                                </tr>
		                            <tr> 
			                            <td>
			                                <span>排版人</span>
			                            </td>
			                             <td>
			                                <span>${bookRegistInfo.bookComposInfo.composUserName}</span>
			                             </td>
			                        </tr>
			                        <tr>
			                            <td>
				                            <span>排版日期</span>
			                            </td>
			                            <td>
			                                <span>${bookRegistInfo.bookComposInfo.composTime}</span>
			                            </td>
			                        </tr>
			                        <tr>
			                            <td>
				                            <span>存在问题</span>
			                            </td>
			                            <td>
			                                <span>${bookRegistInfo.bookComposInfo.problem}</span>
			                            </td>
			                        </tr>
			                        <tr>
			                            <td>
				                            <span>解决方法</span>
			                            </td>
			                            <td>
			                                <span>${bookRegistInfo.bookComposInfo.solution}</span>
			                            </td>
			                        </tr>
			                        <tr>
			                            <td>
			                                <span>签收人</span>
			                            </td>
			                            <td>
			                                <span>${bookRegistInfo.bookComposInfo.signUserName}</span>
			                            </td>
		                            </tr>
                                </table>
                            </c:if>