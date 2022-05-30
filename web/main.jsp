<%@page import="java.util.Map"%>
<%@page import="dao.GenericDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="modelo.Value"%>
<%@page import="modelo.Sensor"%>
<%@page import="dao.SistemaDAO"%>
<%@page import="modelo.Ambiente"%>
<!doctype html>
<html lang="en">
    <%
        if (session.getAttribute("usuario") == null) {
            response.sendRedirect("index.jsp");
            return;
        }
        try {
            try {
                GenericDAO dao = new GenericDAO() {
                };
                dao.fecharEmf();
            } catch (Exception e) {
            }
            if (request.getParameter("p") == null) {
                UsuarioDAO userD = new UsuarioDAO();
                Usuario user = userD.buscarPorChavePrimaria(session.getAttribute("usuario").toString());
                if (!user.getAmbienteList().isEmpty()) {
                    response.sendRedirect("main.jsp?p=" + user.getAmbienteList().get(0).getIdevr());
                    return;
                } else {
                      response.sendRedirect("sisreg.jsp?p=sisreg");
                      return;
                }
            }
    %>
    <head>
        <meta charset="utf-8" />
        <link rel="apple-touch-icon" sizes="76x76" href="assets/img/apple-icon.png">
        <link rel="icon" type="image/png" sizes="96x96" href="assets/img/favicon.png">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

        <title>Paper Dashboard by Creative Tim</title>

        <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
        <meta name="viewport" content="width=device-width" />


        <!-- Bootstrap core CSS     -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" />

        <!-- Animation library for notifications   -->
        <link href="assets/css/animate.min.css" rel="stylesheet"/>

        <!--  Paper Dashboard core CSS    -->
        <link href="assets/css/paper-dashboard.css" rel="stylesheet"/>

        <!--  CSS for Demo Purpose, don't include it in your project     -->
        <link href="assets/css/demo.css" rel="stylesheet" />

        <!--  Fonts and icons     -->
        <link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
        <link href='https://fonts.googleapis.com/css?family=Muli:400,300' rel='stylesheet' type='text/css'>
        <link href="assets/css/themify-icons.css" rel="stylesheet">
    </head>
    <body>

        <div class="wrapper">
            <%@include file="assets/sideBar.jsp" %>

            <div class="main-panel">
                <nav class="navbar navbar-default">
                    <div class="container-fluid">
                        <div class="navbar-header">
                            <button type="button" class="navbar-toggle">
                                <span class="sr-only">Toggle navigation</span>
                                <span class="icon-bar bar1"></span>
                                <span class="icon-bar bar2"></span>
                                <span class="icon-bar bar3"></span>
                            </button>
                            <%                                SistemaDAO daoEvr = new SistemaDAO();
                            %>
                            <a class="navbar-brand" href="#"><%=daoEvr.buscarPorChavePrimaria(Integer.parseInt(request.getParameter("p"))).getName()%></a>
                            <%
                                daoEvr.fecharEmf();
                            %>
                        </div>
                        <div class="collapse navbar-collapse">
                            <ul class="nav navbar-nav navbar-right">


                                <li>
                                    <a href="user.jsp">
                                        <i class="ti-user"></i>
                                        <p><%=session.getAttribute("usuario")%></p>
                                    </a>
                                </li>
                                <li>
                                    <a href="logout.jsp">
                                        <i class="ti-shift-right"></i>
                                    </a>
                                </li>
                            </ul>

                        </div>
                    </div>
                </nav>
                <%if (request.getParameter("act") != null) {
                        if (request.getParameter("act").equals("new")) {
                %>
                <%@include file="assets/senreg.jsp" %>
                <%} else if (request.getParameter("act").equals("newBtn")) {%>
                <%@include file="assets/btnregister.jsp" %>
                <%} else if (request.getParameter("act").equals("edt")) {%>
                <%@include file="assets/edit.jsp" %>
                <%}
                } else {%>
                <%@include file="assets/page.jsp" %>

                <%}%>


            </div>
        </div>


    </body>

    <!--   Core JS Files   -->
    <script src="assets/js/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="assets/js/bootstrap.min.js" type="text/javascript"></script>

    <!--  Checkbox, Radio & Switch Plugins -->
    <script src="assets/js/bootstrap-checkbox-radio.js"></script>

    <!--  Charts Plugin -->
    <script src="assets/js/chartist.min.js"></script>

    <!--  Notifications Plugin    -->
    <script src="assets/js/bootstrap-notify.js"></script>

    <!--  Google Maps Plugin    -->
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js"></script>

    <!-- Paper Dashboard Core javascript and methods for Demo purpose -->
    <script src="assets/js/paper-dashboard.js"></script>

    <!-- Paper Dashboard DEMO methods, don't include it in your project! -->
    <script src="assets/js/demo.js"></script>


</html>
<%
    } catch (Exception e) {

        if (request.getParameter("act") != null) {
            if (request.getParameter("act").equals("del")) {
                response.sendRedirect("main.jsp");
                return;
            }
        }

        if (request.getParameter("btnapg") != null) {
            response.sendRedirect("main.jsp");
            return;
        }

        Map<String, String[]> parameters = request.getParameterMap();
        String param = "?";
        for (String parameter : parameters.keySet()) {
            param += parameter.toString();
            param += "=";
            param += request.getParameter(parameter.toString());
            param += "&";
        }
        response.sendRedirect("main.jsp" + param);
        return;
    }
%>