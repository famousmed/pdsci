<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">
function selectSingle(obj) {
	var value = $(obj).val();
	var name = $(obj).attr("name");
	$("input[name="+name+"][value!="+value+"]:checked").attr("checked",false);
}
</script>
<table width="100%" cellpadding="0" cellspacing="0" class="basic">
                          <c:if test="${not empty visitFormList }">
                            <tr>
								<th colspan="4" style="text-align: left; padding-left: 10px">回访记录</th>
							</tr>
							<c:forEach items="${visitFormList }" var="form" varStatus="num">
							<tr>
					         <td colspan="4">
					       ${num.count }、回访日期：${form.visitDate }&#12288;&#12288;
					                    客户联系人：${form.customerLinkMan }&#12288;&#12288;
					                    回访结果：<c:if test="${form.isSolved eq 'Y' }">已解决问题</c:if>
					              <c:if test="${form.isSolved eq 'N' }">未解决问题</c:if>&#12288;&#12288;
					                    回访人：${form.visitor }</td>
					       </tr>
					        <tr> 
						       <td>回访内容：${form.visitContent }</td>
					        </tr>
					        </c:forEach>
					        </c:if>
                            <tr>
								<th colspan="4" style="text-align: left; padding-left: 10px">客户回访</th>
							</tr>
							<tr>
								<td style="text-align: right; padding-right: 10px;">客户联系人：
								    <select name="customerLinkManFlow" class="xlselect validate[required]" style="width: 130px;">
									    <c:forEach items="${userList }" var="user">
									    <option value="">请选择</option>
									    <option value="${user.userFlow }">${user.userName }</option>
									    </c:forEach>
									</select>
								</td>
								<td style="text-align: right; padding-right: 10px;">回访日期：
								  <input onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" name="visitDate" style="width: 130px; text-align: left;" value="${pdfn:getCurrDateTime('yyyy-MM-dd HH:mm') }" readonly="readonly" class="inputText validate[required]" type="text" />
								</td>
								<td style="text-align: right; padding-right: 10px;">
								<font style="font-weight: bold;">回&nbsp;访&nbsp;结&nbsp;果：</font>
								<input type="checkbox" id="is_${GlobalConstant.FLAG_Y}" name="isSolved" class="validate[required]" value="${GlobalConstant.FLAG_Y }" onchange="selectSingle(this);"><label for="is_${GlobalConstant.FLAG_Y }">&nbsp;已解决问题&#12288;</label>
								<input type="checkbox" id="is_${GlobalConstant.FLAG_N}" name="isSolved" class="validate[required]" value="${GlobalConstant.FLAG_N }" onchange="selectSingle(this);"><label for="is_${GlobalConstant.FLAG_N }">&nbsp;未解决问题</label> <br/>
								</td>
								<td style="text-align: right; padding-right: 10px;">回&#12288;访&#12288;人：
								 ${sessionScope.currUser.userName}
									<input type="hidden" name="visitor" value="${sessionScope.currUser.userName}" class="inputText validate[required]" style="width: 130px; text-align: left;" />
								</td>
							</tr>
							<tr>
							    <td colspan="4" style="text-align: center;">
							       <textarea id="visitContent" name="visitContent" placeholder="请输入回访内容" class="xltxtarea validate[required]" style="width: 98%;"></textarea>
							    </td>
							</tr>
							<tr>
								
							</tr>
</table>
     <div class="button">
	       		<input type="button" value="提&#12288;交" onclick="saveVisit();" class="search"/>
			    <input type="button" class="search" value="关&#12288;闭" onclick="jboxCloseMessager();" >
     </div>