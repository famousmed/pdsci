
       <div class="content_main">
	        <div style="margin-top: 20px;">
	        	<table border="0" cellpadding="0" cellspacing="0" class="grid" style="width: 100%">
		            <tr>
		                <th>药物名称</th>
		                <th>访视名称</th>
		                <th>药物批号</th>
		                <th>发药量</th>
		                <th>发药时间</th>
		            </tr>
		            <c:forEach items="${recipeList}" var="recipe">
		            	<c:forEach items="${recipeDrugMap[recipe.recipeFlow] }" var="drug">
		            	<tr><td>${drug.drugName }</td>
		            		<td>${projDescForm.visitMap[recipe.visitFlow].visitName }</td>
		            		<td>${drug.lotNo }</td>
		            		<td>${drug.drugAmount }</td>
		            		<td>${pdfn:transDate(recipe.recipeDate)}</td>
		            		</tr>
		            		</c:forEach>
		            </c:forEach>
	            </table>
	       </div>
       </div>
