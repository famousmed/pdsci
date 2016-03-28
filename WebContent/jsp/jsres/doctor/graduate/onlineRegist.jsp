<script type="text/javascript">

function changeFile(fileTempId){
	var content = '<input type="file" class="validate[required]" style="width: 90%;"/>';
	$("#operTd_"+fileTempId).html(content);
}

function showDoctorInfo(){
	jboxOpen("<s:url value='/jsp/jsres/doctor/doctorInfo.jsp'/>?type=open","基本信息",900,550);
}
</script>
<body>
<div class="content">
	<div class="title1 clearfix">
	<div id="tagContent">
	<div class="tagContent selectTag" id="tagContent0">
		<form id="step1Form" style="position:relative;">
		 <table border="0" cellpadding="0" cellspacing="0" class="grid">
			<colgroup>
              <!-- <col width="5%"/> -->
              <col width="60%"/>
              <!-- <col width="30%"/> -->
              <col width="40%"/>
            </colgroup>
            <thead>
            	<tr>
	              <th colspan="2" style="text-align: left;padding-left: 20px;padding-right: 10px;">报名材料列表
	              <!-- <span style="float: right;font-weight: normal;">
						<a class="btn">删除</a>
					</span> -->
	              </th>
	           </tr>
	           <tr>
	              <!-- <th></th> -->
	              <th style="text-align: left;padding-left: 20px;">文件名</th>
	              <!-- <th>修改意见</th> -->
	              <th style="text-align: left;padding-left: 20px;">浏览</th>
	           </tr>
	        </thead>
	        <tbody>
				<tr>
					<!-- <td><input type="checkbox" value=""></td> -->
					<td style="text-align: left;padding-left: 20px;">
					1、报名表
					</td>
					<!-- <td></td> -->
					<td style="text-align: left;"><input type="file" style="width: 90%;"/></td>
				</tr>
				<tr>
					<!-- <td><input type="checkbox" value=""></td> -->
					<td style="text-align: left;padding-left: 20px;">
					2、<a href="javascript:void(0)" onclick="showDoctorInfo();" >报名人员信息</a>
					</td>
					<!-- <td></td> -->
					<td style="text-align: left;">
					</td>
				</tr>
				<tr>
					<!-- <td><input type="checkbox" value=""></td> -->
					<td style="text-align: left;padding-left: 20px;">
					3、公共科目成绩
					</td>
					<!-- <td></td> -->
					<td style="text-align: left;">
					合格（成绩：82，分数线：65）
					<!-- <input type="text" class="input" style="width: 95px;margin: 0;"/> -->
					</td>
				</tr>
				<tr>
					<!-- <td><input type="checkbox" value=""></td> -->
					<td style="text-align: left;padding-left: 20px;">
					<a>4、学历证书复印件</a>
					</td>
					<!-- <td></td> -->
					<td id="operTd_${file.id}" style="text-align: left;">
						<a class="btn" href="javascript:void(0)" onclick="changeFile('${file.id}')" >重新上传</a>
					</td>
				</tr>
				<tr>
					<!-- <td><input type="checkbox" value=""></td> -->
					<td style="text-align: left;padding-left: 20px;">
					5、规培登记手册原件
					</td>
					<!-- <td></td> -->
					<td style="text-align: left;">
					</td>
				</tr>
				<tr>
					<!-- <td><input type="checkbox" value=""></td> -->
					<td style="text-align: left;padding-left: 20px;">
					6、规培理论考试资格表原件
					</td>
					<!-- <td></td> -->
					<td style="text-align: left;">
					</td>
				</tr>
				<tr>
					<!-- <td><input type="checkbox" value=""></td> -->
					<td style="text-align: left;padding-left: 20px;">
					<a>7、医师执业证书/医师资格证书/执业证书成绩单</a>
					</td>
					<!-- <td></td> -->
					<td id="operTd_${file.id}" style="text-align: left;">
						<a class="btn" href="javascript:void(0)" onclick="changeFile('${file.id}')" >重新上传</a>
					</td>
				</tr>
			</tbody>	
			</table>
			<div align="center" style="margin-top: 20px; margin-bottom:20px;">
				<input type="button" style="width:100px;" class="btn_blue"  onclick="" value="保存"></input>
				<input type="button" style="width:100px;" class="btn_red" onclick="" value="提交"></input>
			</div>
		</form>
		</div>
		</div>
	</div>
</div>
</body>
					