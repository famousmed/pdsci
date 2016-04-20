
  <meta charset="UTF-8" />
  <title>A date range picker for Bootstrap</title>
    <link rel="stylesheet" type="text/css" 	href="<s:url value='/jsp/enso/css/bootstrap.min.css'/>"></link>
  <link rel="stylesheet" type="text/css" 	href="<s:url value='/jsp/enso/css/daterangepicker.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
  <script type="text/javascript" src="<s:url value='/jsp/enso/js/moment.js'/>"></script>
  <script type="text/javascript" src="<s:url value='/jsp/enso/js/daterangepicker.js'/>"></script>


	访视日期：<span
					class="frm_input_box" style="width:150px;">
						<input autofocus="" type="text" placeholder="" id="visitDate" name="visitDate";
						class="frm_input js_option_input frm_msg_content validate[required]" readonly="readonly"
						 value="${visitWindow.visitDate }"
					autocomplete="off">
					</span>
	&#12288;&#12288;下次随访日期：
				<c:set var="window" value="${window.windowVisitLeft }~${window.windowVisitRight}"/>
				<span
					class="frm_input_box" style="width: 250px;"> 
						<input autofocus="" type="text" placeholder="" readonly="readonly" name="visitWindow";
						class="frm_input js_option_input frm_msg_content validate[required]" id="visitWindow"
						 value=""
					autocomplete="off">
					</span><span>&#12288;可据节假日或特殊情况自行调整</span>

      <script type="text/javascript">
      $(document).ready(function() {
    	  //scrollToModule("section_tab_wrap");
          var visitDateOptions = {
        		
        		  locale: {
        			 
        		      format: 'YYYY-MM-DD',
        		      applyLabel : '确定',
        		      separator: "~",
						cancelLabel : '取消',
						customRangeLabel: "自定义",
						daysOfWeek : [ '日', '一', '二', '三', '四', '五', '六' ],
						monthNames : [ '一月', '二月', '三月', '四月', '五月', '六月',
								'七月', '八月', '九月', '十月', '十一月', '十二月' ],
        		  },
        		    "alwaysShowCalendars": true,
          };
          visitDateOptions.singleDatePicker = true;
          $('#visitDate').daterangepicker(visitDateOptions, function(start, end, label) { 
			  var currDate = start.format('YYYY-MM-DD');
        	  visitDateOptions.ranges = 
			    		  {
			  		        "间隔一周(7天)": [
			  		            moment(currDate).add(7, 'd'),
			  		          	moment(currDate).add(7, 'd')
			  		        ],
			  		        "间隔十天(10天)": [
			  	        		             moment(currDate).add(10, 'd'),
			  		          				 moment(currDate).add(10, 'd')
			  	        		        ],
			  		        "间隔两周(14天)": [
			  		                    moment(currDate).add(14, 'd'),
		  		          				 moment(currDate).add(14, 'd')
			  		        ],
			  		        "间隔三周(21天)": [
			  		                    moment(currDate).add(21, 'd'),
		  		          				 moment(currDate).add(21, 'd')
			  		        ],
			  		        "间隔四周(28天)": [
			  		                    moment(currDate).add(28, 'd'),
		  		          				 moment(currDate).add(28, 'd')
			      		        ],
			  		        "间隔一月(30天)": [
			  		                    moment(currDate).add(1, 'months'),
		  		          				 moment(currDate).add(1, 'months')
				        		        ],
			  		        "间隔五周(35天)": [
			  		                    moment(currDate).add(35, 'd'),
		  		          				 moment(currDate).add(35, 'd')
				        		 ]
			  		    };
        	 		  visitDateOptions.singleDatePicker = false;
        	 		 $('#visitWindow').daterangepicker(visitDateOptions, function(start, end, label) { });
          });
          visitDateOptions.singleDatePicker = false;
          visitDateOptions.startDate = ${empty visitWindow}?moment():'${visitWindow.windowVisitLeft}';
          visitDateOptions.endDate =  ${empty visitWindow}?moment():'${visitWindow.windowVisitRight}';
          visitDateOptions.ranges = 
		  {
		        "间隔一周(7天)": [
		            moment().add(7, 'd'),
		          	moment().add(7, 'd')
		        ],
		        "间隔十天(10天)": [
	        		             moment().add(10, 'd'),
		          				 moment().add(10, 'd')
	        		        ],
		        "间隔两周(14天)": [
		                    moment().add(14, 'd'),
	          				 moment().add(14, 'd')
		        ],
		        "间隔三周(21天)": [
		                    moment().add(21, 'd'),
	          				 moment().add(21, 'd')
		        ],
		        "间隔四周(28天)": [
		                    moment().add(28, 'd'),
	          				 moment().add(28, 'd')
  		        ],
		        "间隔一月(30天)": [
		                    moment().add(1, 'months'),
	          				 moment().add(1, 'months')
        		        ],
		        "间隔五周(35天)": [
		                    moment().add(35, 'd'),
	          				 moment().add(35, 'd')
        		 ]
		    };
          $('#visitWindow').daterangepicker(visitDateOptions, function(start, end, label) {   	});
         });
      </script>

