<%@page import="java.util.concurrent.ThreadLocalRandom"%>
<%@page import="util.RandomString"%>
<%@page import="util.Criptografia"%>
<%@page import="dao.UsuarioDAO"%>
<%@page import="modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String ip = (request.getParameter("ip") != null) ? request.getParameter("ip") : "";
    String tp = (request.getParameter("tp") != null) ? request.getParameter("tp") : "";

    String dtt = (request.getParameter("dtt") != null) ? request.getParameter("dtt") : "";
    String dth = (request.getParameter("dth") != null) ? request.getParameter("dth") : "";

    int[] ids = new int[9];
    for (int i = 0; i < 9; i++) {
        if (request.getParameter("D" + i) != null) {
            ids[i] = Integer.parseInt(request.getParameter("D" + i));
        }
    }
    int a0 = (request.getParameter("A0") != null) ? Integer.parseInt(request.getParameter("A0")) : 0;
    int cicl = (request.getParameter("cicl") != null) ? Integer.parseInt(request.getParameter("cicl")) : 5000;
    String login = (request.getParameter("login") != null) ? request.getParameter("login") : "";
    String key = (request.getParameter("key") != null) ? request.getParameter("key") : "";

%>
<!doctype html>
<html lang="en">
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


        <br> <br 
            <div class="wrapper">

            <div class="content">
                <div class="container">
                    <div class="row">
                        <div class="col-md-4">

                        </div>
                        <div class="col-lg-4 col-md-5 container">
                            <div class="card card-user">
                                <div class="content">                                   
                                    <div class="text-center">
                                        <div class="row">
                                            <h4>Painel de controle</h4>

                                        </div>
                                    </div>
                                    <hr>
                                    <div class="text-center">
                                        <div class="row">
                                            <h4>Usuario</h4>                                            
                                        </div>
                                    </div>
                                    <form action="http://<%=ip%>" method="GET" target="_parent">
                                        <div class="row">
                                            <div class="col-md-11">
                                                <div class="form-group">

                                                    <input type="text" class="form-control border-input" placeholder="Login" name="login" required  value="<%=login%>">   
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-11">
                                                <div class="form-group">

                                                    <input type="text" class="form-control border-input" placeholder="key" name="key" required  value="<%=key%>">   
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="text-center">
                                                <button type="submit" class="btn btn-info btn-fill btn-wd"  name="upd" value="1">Salvar</button>
                                            </div>
                                        </div>
                                    </form>
                                    <hr>
                                    <div class="text-center">
                                        <div class="row">
                                            <h4>Pinos</h4>

                                        </div>
                                    </div>
                                    <form action="http://<%=ip%>/" method="GET"  target="_parent">
                                        <div class="row">
                                            <div class="col-md-11">
                                                <div class="form-group">
                                                    <label>A0</label>
                                                    <input type="number" class="form-control border-input" placeholder="A0" name="A0" value="<%=a0%>">
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-lg-1"></div>
                                            <div class="form-group">
                                                <label>Tipo </label>
                                                <select name="tp">
                                                    <option value="0"<%=(tp.equals("0")) ? "selected" : ""%>>Normal</option>
                                                    <option value="1"<%=(tp.equals("1")) ? "selected" : ""%>>Porcentagem</option>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>D0 Temperatura</label>
                                                    <input type="number" class="form-control border-input" name="dtt" value="<%=dtt%>">
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>D0 umidade</label>
                                                    <input type="number" class="form-control border-input" name="dth" value="<%=dth%>">
                                                </div>
                                            </div>
                                        </div>


                                        <div class="row">
                                            <div class="col-md-11">
                                                <div class="form-group">
                                                    <label>Delay</label>
                                                    <input type="text" class="form-control border-input" placeholder="Delay" name="cicl" value="<%=cicl%>">
                                                    <p class="category">Baseado em ciclos do processador</p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-5">
                                                <div class="form-group">
                                                    <label>D0</label>
                                                    <input type="number" class="form-control border-input" placeholder="D0" name="D0" value="<%=ids[0]%>">
                                                </div>
                                            </div>
                                            <div class="col-md-1"></div>
                                            <div class="col-md-5">
                                                <div class="form-group">
                                                    <label>D1</label>
                                                    <input type="number" class="form-control border-input" placeholder="D1" name="D1" value="<%=ids[1]%>">
                                                </div>
                                            </div>
                                        </div>


                                        <div class="row">
                                            <div class="col-md-5">
                                                <div class="form-group">
                                                    <label>D2</label>
                                                    <input type="number" class="form-control border-input" placeholder="D2" name="D2" value="<%=ids[2]%>">
                                                </div>
                                            </div>
                                            <div class="col-md-1"></div>
                                            <div class="col-md-5">
                                                <div class="form-group">
                                                    <label>D3</label>
                                                    <input type="number" class="form-control border-input" placeholder="D3" name="D3" value="<%=ids[3]%>">
                                                </div>
                                            </div>
                                        </div>


                                        <div class="row">
                                            <div class="col-md-5">
                                                <div class="form-group">
                                                    <label>D4</label>
                                                    <input type="number" class="form-control border-input" placeholder="D4" name="D4" value="<%=ids[4]%>">
                                                </div>
                                            </div>
                                            <div class="col-md-1"></div>
                                            <div class="col-md-5">
                                                <div class="form-group">
                                                    <label>D5</label>
                                                    <input type="number" class="form-control border-input" placeholder="D5" name="D5" value="<%=ids[5]%>">
                                                </div>
                                            </div>
                                        </div>


                                        <div class="row">
                                            <div class="col-md-5">
                                                <div class="form-group">
                                                    <label>D6</label>
                                                    <input type="number" class="form-control border-input" placeholder="D6" name="D6" value="<%=ids[6]%>">
                                                </div>
                                            </div>
                                            <div class="col-md-1"></div>
                                            <div class="col-md-5">
                                                <div class="form-group">
                                                    <label>D7</label>
                                                    <input type="number" class="form-control border-input" placeholder="D7" name="D7" value="<%=ids[7]%>">
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-5">
                                                <div class="form-group">
                                                    <label>D8</label>
                                                    <input type="number" class="form-control border-input" placeholder="D8" name="D8" value="<%=ids[8]%>">
                                                </div>
                                            </div>

                                        </div>

                                        <div class="row">
                                            <div class="text-center">
                                                <button type="submit" class="btn btn-info btn-fill btn-wd" name="upd" value="1">Salvar</button>
                                            </div>
                                        </div>
                                    </form>

                                </div>


                            </div>
                        </div>
                    </div>
                </div>
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