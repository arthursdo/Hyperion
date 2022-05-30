<%-- 
    Document   : charts
    Created on : 22/05/2018, 10:48:30
    Author     : arthur
--%>

<%@page import="dao.SensorDAO"%>
<%@page import="modelo.Value"%>
<%@page import="modelo.Sensor"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="modelo.Ambiente"%>
<%@page import="dao.SistemaDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="refresh" content="5" >
        <title>Charts</title>
        <%  String pag = "";
            try {%>
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <script type="text/javascript">
            google.charts.load('current', {'packages': ['corechart']});
            google.charts.setOnLoadCallback(drawChart);

            function drawChart() {
            <%  SimpleDateFormat form = new SimpleDateFormat("dd/MM HH:mm:ss");
                SensorDAO senDAO = new SensorDAO();
                Sensor sen = new Sensor();
                sen = senDAO.buscarPorChavePrimaria(Integer.parseInt(request.getParameter("sen")));
            %>


                var data = google.visualization.arrayToDataTable([
                ['Data'<%=",'" + sen.getName() + "'"%>]

            <%  if (sen.getValueList().size() != 0) {
                    for (Value val : sen.getValueList()) {%>
                , [<%="'" + form.format(val.getDate()) + "'"%>, <%=val.getValue()%>]
            <%}
            } else {%>
                , [null, 0]
            <%}%>
                ]);

                var options = {
                    title: '<%=sen.getIdsen() + "-" + sen.getName()%>',
                    legend: {position: 'none'},
                    hAxis: {title: 'Year', titleTextStyle: {color: '#333'}},
                    vAxis: {minValue: 0},
                    colors: ['orange']
                };

                var chart = new google.visualization.AreaChart(document.getElementById('chart_div'));
                chart.draw(data, options);
            }
        </script>

        <% senDAO.fecharEmf();
                System.gc();
            } catch (Exception e) {
            }%>


    </head>
</head>
<body>    
    <div id="chart_div" style="width: 100%; height: 480px;"></div>
</body>
</html>
