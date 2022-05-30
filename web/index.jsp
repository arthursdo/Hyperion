<%@page import="util.Criptografia"%>
<%@page import="java.util.List"%>
<%@page import="modelo.Ambiente"%>
<%@page import="modelo.Usuario"%>
<%@page import="dao.UsuarioDAO"%>
<%
    String status = "";
    if(session.getAttribute("usuario") != null){
        response.sendRedirect("main.jsp?");
    }
    if (request.getMethod().equalsIgnoreCase("POST")) {

        try {
            Criptografia cript = new Criptografia();
            UsuarioDAO dao = new UsuarioDAO();
            Usuario user = dao.buscarPorChavePrimaria(request.getParameter("login").toLowerCase());

            String login = request.getParameter("login").toLowerCase();
            String senha = cript.convertPasswordToMD5(request.getParameter("pass"));
            List<Ambiente> amb = user.getAmbienteList();

            if (login.equals(user.getLogin()) && senha.equals(user.getPass())) {
                session.setAttribute("usuario", login);
                if (amb.isEmpty()) {
                    response.sendRedirect("sisreg.jsp?p=sisreg");
                } else {
                    response.sendRedirect("main.jsp?p=" + amb.get(0).getIdevr());
                }
            } else {
                status = "<p class=\"login-box-msg\">Usuario ou Senha invalido</p>";
            }
        } catch (Exception e) {
            // status="error";
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


        <br> <br <br>
        <div class="wrapper">

            <div class="content">
                <div class="container">
                    <div class="row">
                        <div class="col-md-4">
                           
                        </div>
                        <div class="col-lg-4 col-md-5 container">
                            <div class="card card-user">
                                <div class="image">
                                    <img src="assets/img/background.jpg" alt="..."/>
                                </div>
                                <div class="content">
                                    <div class="author">
                                        <img class="avatar border-white" src="assets/img/faces/face-2.jpg" alt="..."/>
                                        <h4 class="title"><%=(session.getAttribute("usuario") == null)?"":session.getAttribute("usuario")%><br />
                                            <%=status%>

                                        </h4>
                                    </div>



                                    <form action="index.jsp" method="POST">
                                        <div class="row">
                                            <div class="col-md-11">
                                                <div class="form-group">
                                                    <label>Username</label>
                                                    <input type="text" class="form-control border-input" placeholder="Username" name="login">   
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-11">
                                                <div class="form-group">
                                                    <label>Senha</label>
                                                    <input type="password" class="form-control border-input" placeholder="Passworld" name="pass">
                                                </div>
                                            </div>
                                            <div class="text-center">
                                                <button type="submit" class="btn btn-info btn-fill btn-wd">Login</button>
                                            </div>
                                    </form>

                                </div>
                                <hr>
                                <div class="text-center">
                                    <div class="row">
                                        <a href="register.jsp">Registre-se</a>
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
