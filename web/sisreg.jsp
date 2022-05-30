<%@page import="java.util.Map"%>
<%@page import="dao.UsuarioDAO"%>
<%@page import="modelo.Ambiente"%>
<%@page import="dao.SistemaDAO"%>
<%@include file="assets/top.jsp" %>

<%
    if (session.getAttribute("usuario") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    try {
        if (request.getParameter("name") != null) {
            SistemaDAO dao = new SistemaDAO();
            Ambiente obj = new Ambiente();

            obj.setName(request.getParameter("name"));
            obj.setLogin(new UsuarioDAO().buscarPorChavePrimaria(session.getAttribute("usuario").toString()));

            dao.incluir(obj);
            dao.fecharEmf();
            System.gc();
        }
%>

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
                <a class="navbar-brand">Adicionar ambiente</a>
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
            <div class="row">

                <div class="col-lg-8 col-md-7">
                    <div class="card">
                        <div class="header">
                            <h4 class="title">Criar novo ambiente</h4>
                        </div>
                        <div class="content">
                            <form action="sisreg.jsp" method="GET">
                                <div class="row">

                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label>Nome</label>
                                            <input type="text" class="form-control border-input" placeholder="Nome" name="name">
                                        </div>
                                    </div>

                                </div>
                                <div class="text-center">
                                    <button type="submit" class="btn btn-info btn-fill btn-wd">Criar</button>
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
            response.sendRedirect("sisreg.jsp" + param);
            return;
        }
    %>