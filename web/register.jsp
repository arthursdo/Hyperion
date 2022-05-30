<%-- 
    Document   : index
    Created on : 17/02/2018, 23:36:01
    Author     : arthur
--%>

<%@page import="java.util.concurrent.ThreadLocalRandom"%>
<%@page import="util.RandomString"%>
<%@page import="util.Criptografia"%>
<%@page import="dao.UsuarioDAO"%>
<%@page import="modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String msg = "";
    if (request.getMethod().equalsIgnoreCase("POST")) {
        Criptografia cript = new Criptografia();
        RandomString gen = new RandomString(8, ThreadLocalRandom.current());

        UsuarioDAO dao = new UsuarioDAO();
        Usuario obj = new Usuario();

        obj.setLogin(request.getParameter("login").toLowerCase());
        obj.setEmail(request.getParameter("email"));
        obj.setPass(request.getParameter("pass"));
        obj.setKey(gen.toString().replace("util.RandomString@", ""));

        if (!obj.getPass().equals(request.getParameter("passc"))) {
            msg = "senhas";
        }
        if (obj.getLogin().equals("")) {
            msg += ", null user";
        }
        if (obj.getEmail().equals("")) {
            msg += ", null email";
        }

        if (msg.equals("")) {
            obj.setPass(cript.convertPasswordToMD5(obj.getPass()));
            dao.incluir(obj);
            session.setAttribute("usuario", obj.getLogin().toLowerCase());
            response.sendRedirect("sisreg.jsp?p=sisreg");
            return;
        }
    }
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
                                            <h4>Registre-se</h4>
                                        </div>
                                    </div>
                                    <hr>
                                  
                                        <%=msg%>
                                   

                                    <form action="register.jsp" method="POST">
                                        <div class="row">
                                            <div class="col-md-11">
                                                <div class="form-group">
                                                    <label>Username</label>
                                                    <input type="text" class="form-control border-input" placeholder="Username" name="login" required>   
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-11">
                                                <div class="form-group">
                                                    <label>Email</label>
                                                    <input type="email" class="form-control border-input" placeholder="Email" name="email" required>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-11">
                                                <div class="form-group">
                                                    <label>Senha</label>
                                                    <input type="password" class="form-control border-input" placeholder="Passworld" name="pass" required>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-11">
                                                <div class="form-group">
                                                    <label>Confirmar senha</label>
                                                    <input type="password" class="form-control border-input" placeholder="Passworld" name="passc" required>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="text-center">
                                                <button type="submit" class="btn btn-info btn-fill btn-wd">Cadastrar</button>
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


