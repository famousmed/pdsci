<jsp:include page="/jsp/cnres/htmlhead-cnres.jsp">
	<jsp:param name="font" value="true"/>
	<jsp:param name="echarts" value="true"/>
</jsp:include>
<script type="text/javascript">
function createCharts(ec){
	var charts = $(".chart:visible");
	$.each(charts, function(i , n){
		var d = $(n).attr("title").split("-");
		creatChart(ec , $(n).attr("id") , d[0] , d[1]);
	});
}
function creatChart(ec , id , pass , sum){
	var myChart = ec.init(document.getElementById(id)); 
	var labelTop = {
		    normal : {
		        label : {
		            show : true,
		            position : 'center',
		            formatter : '{b}',
		            textStyle: {
		                baseline : 'bottom'
		            }
		        },
		        labelLine : {
		            show : false
		        }
		    }
		};
		var labelFromatter = {
		    normal : {
		        label : {
		        	//formatter:'{d}%',
		        	formatter:function (a , b , c){
		                return (jisuanbaifenbi((pass/sum))) + '%';
		            },
		            textStyle: {
		                baseline : 'top'
		            }
		        }
		    },
		};
		var labelBottom = {
		    normal : {
		        color: '#ccc',
		        label : {
		            show : true,
		            position : 'center'
		        },
		        labelLine : {
		            show : false
		        }
		    },
		    emphasis: {
		        color: 'rgba(0,0,0,0)'
		    }
		};
		var radius = [20, 25];
		option = {
		    series : [
		        {
		            type : 'pie',
		            center : ['40%', '50%'],
		            radius : radius,
		            x: '0%', // for funnel
		            itemStyle : labelFromatter,
		            data : [
                        {name:'other', value:(sum-pass),itemStyle : labelBottom},
                        {name:'', value:pass,itemStyle : labelTop}
		                
		            ]
		        }
		    ]
		};
		myChart.setOption(option); 
}
require(
	    [
	        'echarts',
	        'echarts/chart/pie'
	    ],
	    createCharts
	);
$(function(){
	//加载分数段
	var examFlow = $("#examFlow").val();
	jboxLoad("gradesteps" , "<s:url value='/cnres/grade/getgradesteps'/>?examFlow="+examFlow);
});
function setGrageLine(){
	jboxOpen("<s:url value='/cnres/grade/setgradeline'/>","划定分数线",600,400,true);
}

function showGradeLine(){
	jboxPostLoad("content", "<s:url value='/cnres/grade/gradeline'/>", $("#examResultForm").serialize(), true);
}
function getPasscount(borderlineFlow , examFlow , speId , obj){
	var grade = $(obj).val();
	var f_x = parseFloat(grade);
	if (isNaN(f_x)){
	   jboxTip("数值错误");
	   return false;
	}
	if(f_x<0){
		jboxTip("数值错误");
		return false;
	}
	if(grade){
		jboxPostLoad("content", "<s:url value='/cnres/grade/getpasscount'/>", {"borderlineFlow":borderlineFlow,"examFlow":examFlow , "speId":speId , "gradeBorderline":grade}, true);
	}
}

function publishGradeBorderline(borderlineFlow , speId){
	jboxConfirm("确认发布？", function(){
		var step = $("#inp_step_"+speId).val();
		jboxPostLoad("content", "<s:url value='/cnres/grade/publishgradeborderline'/>", {"borderlineFlow":borderlineFlow,"gradeStep":step}, true);
	});
	
}

function changeTwoDecimal(floatvar)
{
var f_x = parseFloat(floatvar);
if (isNaN(f_x))
{
alert('function:changeTwoDecimal->parameter error');
return false;
}
var f_x = Math.round(floatvar*10000)/10000;
return f_x;
}

function jisuanbaifenbi(floatvar){
	var f_x = changeTwoDecimal(floatvar);
	return changeTwoDecimal(f_x*100);
	
}
</script>
<div class="main_hd">
    <h2 class="underline">分数划定</h2>
</div>
<div id="search" class="div_search">
    <form id="examResultForm">
    <span>考试：</span>
    <select class="select" style="width: 150px;" id="examFlow" name="examFlow" onchange="showGradeLine();">
	    <c:forEach items="${exams}" var="exam">
		    <option value="${exam.examFlow}" <c:if test='${param.examFlow eq exam.examFlow}'>selected="selected"</c:if>>${exam.examName}</option>
		</c:forEach>  
    </select>&nbsp;&nbsp;
    </form>
</div>
<div class="main_bd" id="div_table_0" >
    <ul class="search_table">
        <li class="score_frame">
                <h1>${currExam.examName}<span class="fr">总人数：${joinExamSumDoctor}</span></h1>
                <div class="score_table">
                <table cellpadding="0" cellspacing="0" width="100%">
                <colgroup>
                  <col width="18%"/>
                  <col width="18%"/>
                  <col width="18%"/>
                  <col width="18%"/>
                  <col width="18%"/>
                  <col width="10%"/>
                </colgroup>
                    <thead>
                        <tr>
                            <th>专业</th>
                            <th>人数</th>
                            <th>分数线</th>
                            <th>过线人数</th>
                            <th>过线率</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="dict" items="${dictTypeEnumGraduateMajorList}" varStatus="status">
	                        <tr>
	                            <td>${dict.dictName}</td>
	                            <td>${statisticsMap[dict.dictId].sum}</td>
	                            <td>
	                                <c:choose>
	                                    <c:when test='${statisticsMap[dict.dictId].gradeBorderline.publishFlag eq "Y"}'>
	                                         ${statisticsMap[dict.dictId].gradeBorderline.gradeBorderline}
	                                    </c:when>
	                                    <c:when test='${statisticsMap[dict.dictId].sum>0}'>
	                                        <input type="text" style="width: 50px;text-align: center;" value="${statisticsMap[dict.dictId].gradeBorderline.gradeBorderline}" onchange="getPasscount('${statisticsMap[dict.dictId].gradeBorderline.borderlineFlow}' , '${currExam.examFlow}' , '${dict.dictId}' , this);"/>
	                                    </c:when>
	                                </c:choose>
	                            </td>
	                            <td>${statisticsMap[dict.dictId].passCount}</td>
	                            <td>
	                                <div title="${statisticsMap[dict.dictId].passCount}-${statisticsMap[dict.dictId].sum}" id="mychart${status.count}" class="chart" style="height:60px;<c:if test='${statisticsMap[dict.dictId].passCount==0 || statisticsMap[dict.dictId].passCount==null}'>display: none;</c:if>"></div>
	                            <td>
	                                <c:choose>
	                                    <c:when test='${statisticsMap[dict.dictId].gradeBorderline.publishFlag eq "Y"}'>
	                                         <a href="javascript:void(0);" class="grey_l">发布</a>
	                                    </c:when>
	                                    <c:when test='${statisticsMap[dict.dictId].sum>0}'>
	                                        <a href="javascript:void(0);" onclick="publishGradeBorderline('${statisticsMap[dict.dictId].gradeBorderline.borderlineFlow}' , '${dict.dictId}');" class="blue_l">发布</a>
	                                    </c:when>
	                                </c:choose>
	                            </td>
	                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
                </div>
        </li>
    </ul>
</div>
<div id="gradesteps" style="margin-left: 40px;">
</div>
