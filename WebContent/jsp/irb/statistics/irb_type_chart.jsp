<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="any" uri="http://www.anychart.com" %>
<html>
  <body>
    <any:chart width="550px" height="300px">
    	<charts>
    <chart plot_type="CategorizedHorizontal" name="irbType">
     <data_plot_settings default_series_type="Bar">
        <bar_series>
          <label_settings enabled="true" rotation="0">
            <position anchor="Top" halign="Center" valign="Top" />
            <format>{%Value}{numDecimals:0}</format>
            <background enabled="False" />
          </label_settings>
        </bar_series>
      </data_plot_settings>
      <data>
        <series name="Year 2003" type="Bar"  palette="Default">
         <c:forEach items="${irbTypeEnumList}" var="type" >
         	 <point name="${type.scName }" y="${irbCountMap[type.id] }" />
         </c:forEach>
        </series>
      </data>
      <data_plot_settings>
        <bar_series>
          <tooltip_settings enabled="True" />
        </bar_series>
      </data_plot_settings>
      <chart_settings>
        <title enabled="false" />
        <axes>
          <y_axis position="Opposite">
            <title>
              <text>数量</text>
            </title>
            <labels>
              <format>{%Value}{numDecimals:0}</format>
            </labels>
          </y_axis>
          <x_axis>
            <labels align="Inside" />
             <title>
              <text>申请类型</text>
            </title>
          </x_axis>
        </axes>
      </chart_settings>
    </chart>
  </charts>
    </any:chart>
  </body>
</html>