
  <meta charset="UTF-8" />
  <title>A date range picker for Bootstrap</title>
    <link rel="stylesheet" type="text/css" 	href="<s:url value='/jsp/enso/css/bootstrap.min.css'/>"></link>
  <link rel="stylesheet" type="text/css" 	href="<s:url value='/jsp/enso/css/daterangepicker.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
  <script type="text/javascript" src="<s:url value='/jsp/enso/js/moment.js'/>"></script>
  <script type="text/javascript" src="<s:url value='/jsp/enso/js/daterangepicker.js'/>"></script>


	访视日期：<span
					class="frm_input_box" style="width:150px;">
						<input autofocus="" type="text" placeholder="" id="visitDate"
						class="frm_input js_option_input frm_msg_content" readonly="readonly"
						 value=""
					autocomplete="off">
					</span>
	&#12288;&#12288;下次随访日期：<span
					class="frm_input_box" style="width: 300px;"> 
						<input autofocus="" type="text" placeholder="" readonly="readonly"
						class="frm_input js_option_input frm_msg_content" id="visitWindow"
						 value=""
					autocomplete="off">
					</span>

      <script type="text/javascript">
      $(document).ready(function() {
    	  //scrollToModule("section_tab_wrap");
          var visitDateOptions = {
        		  locale: {
        		      format: 'YYYY-MM-DD',
        		    	  language:  'zh-CN'
        		  },
          };
          visitDateOptions.singleDatePicker = true;
          visitDateOptions.format = 'yyyy-MM-dd',
          $('#visitDate').daterangepicker(visitDateOptions, function(start, end, label) { console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')'); });
          
          visitDateOptions.singleDatePicker = false;
          $('#visitWindow').daterangepicker(visitDateOptions, function(start, end, label) { 
        	 });
      });
      </script>

