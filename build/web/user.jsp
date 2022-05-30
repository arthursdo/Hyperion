<%@page import="java.util.Map"%>
<%@page import="util.Criptografia"%>
<%@page import="java.util.concurrent.ThreadLocalRandom"%>
<%@page import="util.RandomString"%>
<%@include file="assets/top.jsp" %>	
<%@include file="assets/sideBar.jsp" %>
<%    if (session.getAttribute("usuario") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    try {

        UsuarioDAO dao = new UsuarioDAO();
        Usuario usu = new Usuario();
        usu = dao.buscarPorChavePrimaria(session.getAttribute("usuario").toString());
        Boolean conf = true;
        Boolean old = true;
        Boolean succ = null;
        String msg = "Perfil atualizado com sucesso";

        if (request.getParameter("key") != null) {
            RandomString gen = new RandomString(8, ThreadLocalRandom.current());
            usu.setKey(gen.toString().replace("util.RandomString@", ""));
            dao.alterar(usu);
        }

        if (request.getParameter("upd") != null) {
            usu.setEmail(request.getParameter("email"));
            if (!request.getParameter("new").equals("")) {
                Criptografia cript = new Criptografia();
                old = cript.convertPasswordToMD5(request.getParameter("old")).equals(usu.getPass());
                conf = request.getParameter("new").equals(request.getParameter("conf"));
                if (old && conf) {
                    usu.setPass(cript.convertPasswordToMD5(request.getParameter("new")));
                }
            }
            succ = dao.alterar(usu);
            //succ=(old&&conf)&&(succ==true);
            if (!(old && conf) && (succ == true)) {
                succ = false;
                msg = "";
                msg += (old) ? "" : "Senha invalida!";
                msg += (conf) ? "" : " As senhas não conferem";
            }
        }

%>

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
                <a class="navbar-brand" href="#">User Profile</a>
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


    <div class="content">        
        <div class="container-fluid">
            <%if (succ != null) {%>
            <div class="row">
                <div class="col-md-12">
                    <div class="alert alert-<%=(succ) ? "success" : "danger"%>">
                        <span><%=msg%></span>
                    </div>
                </div>
            </div>
            <%}%>
            <div class="row">
                <div class="col-md-12">
                    <div class="card">
                        <div class="header">
                            <h4 class="title">Editar perfil</h4>
                        </div>
                        <div class="content">
                            <form method="POST">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label>Username</label>
                                            <input type="text" class="form-control border-input" disabled value="<%=usu.getLogin()%>">
                                        </div>
                                    </div>
                                    <div class="col-md-8">
                                        <div class="form-group">
                                            <label for="exampleInputEmail1">Email address</label>
                                            <input type="email" class="form-control border-input" value="<%=usu.getEmail()%>" name="email" required="">
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Key</label>
                                            <input type="text" class="form-control border-input" value="<%=usu.getKey()%>" disabled="">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <br>
                                            <div class="text-center">
                                                <button type="submit" class="btn btn-danger btn-fill btn-wd" name="key" value="1">Gerar uma nova key</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group <%=(conf) ? "" : "has-error"%> has-feedback">
                                            <label>Nova senha</label>
                                            <input type="password" class="form-control border-input" placeholder="Nova senha" name="new">
                                        </div>
                                    </div>

                                    <div class="col-md-4">
                                        <div class="form-group <%=(conf) ? "" : "has-error"%>">
                                            <label>Confirmar senha</label>
                                            <input type="password" class="form-control border-input" placeholder="Confirmar senha" name="conf">
                                        </div>
                                    </div>

                                    <div class="col-md-4">
                                        <div class="form-group <%=(old) ? "" : "has-error"%>">
                                            <label>Senha antiga</label>
                                            <input type="password" class="form-control border-input" placeholder="Senha antiga" name="old">
                                        </div>
                                    </div>
                                </div>
                                <div class="text-center">
                                    <button type="submit" class="btn btn-info btn-fill btn-wd" name="upd" value="1">Atualizar perfil</button>
                                </div>
                                <div class="clearfix"></div>
                            </form>
                        </div>
                    </div>
                </div>


            </div>
        </div>
    </div>


    <%@include file="assets/down.jsp" %>

    <%
        } catch (Exception e) {
            Map<String, String[]> parameters = request.getParameterMap();
            String param = "?";
            for (String parameter : parameters.keySet()) {
                param += parameter.toString();
                param += "=";
                param += request.getParameter(parameter.toString());
                param += "&";
            }
            response.sendRedirect("user.jsp" + param);
            return;
        }
    %>