<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="any" uri="http://www.anychart.com" %>
<html>
  <body>
    <any:chart width="550px" height="300px"  >
    	<charts >
    <chart  plot_type="CategorizedVertical" name="projType">
      <data >
        <series name="Series 1" palette="Default">
       <c:forEach items="${gcpProjSubTypeEnumList}" var="type" >
          <point name="${type.name}" y="${projCountMap[type.id] }" />
         </c:forEach>
        </series>
      </data>
       <data_plot_settings>
        <bar_series>
          <tooltip_settings enabled="True" />
          <label_settings enabled="true" rotation="0">
            <position anchor="Top" halign="Center" valign="Top" />
            <format>{%Value}{numDecimals:0}</format>
            <background enabled="False" />
          </label_settings>
        </bar_series>
      </data_plot_settings>
      <chart_settings>
        <title enabled="false">
          <background enabled="false" />
          <text>Style: Silver</text>
        </title>
        <axes>
          <y_axis>
            <scale minimum="0" />
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
              <text>研究类别</text>
            </title>
          </x_axis>
        </axes>
      </chart_settings>
      <data_plot_settings>
        <bar_series group_padding="0.3" />
      </data_plot_settings>
    </chart>
  </charts>
    </any:chart>
  </body>
</html>