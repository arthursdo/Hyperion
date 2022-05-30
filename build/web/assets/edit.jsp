<%@page import="dao.SensorDAO"%>
<%@page import="modelo.Sensor"%>
<%@page import="dao.InterruptorDAO"%>
<%@page import="modelo.Interruptor"%>
<%@page import="modelo.Ambiente"%>
<%@page import="dao.SistemaDAO"%>
<%
    SistemaDAO dao = new SistemaDAO();
    Ambiente evr = dao.buscarPorChavePrimaria(Integer.parseInt(request.getParameter("p")));
    dao.fecharEmf();
    Interruptor in = new Interruptor();
    Sensor sen = new Sensor();
    //Ambietes
    if (request.getParameter("nameE") != null) {
        evr.setName(request.getParameter("nameE"));
        dao.alterar(evr);
        dao.fecharEmf();
    }

    //Botoes
    if (request.getParameter("updbtn") != null) {
        InterruptorDAO indao = new InterruptorDAO();
        in = indao.buscarPorChavePrimaria(Integer.parseInt(request.getParameter("btn")));
        in.setName(request.getParameter("nameB"));
        indao.alterar(in);
        indao.fecharEmf();
        //response.sendRedirect("redirect.jsp?p="+request.getParameter("p"));
        //return;
        //in = new Interruptor();
    }
    if (request.getParameter("btnapg") != null) {
        InterruptorDAO indao = new InterruptorDAO();
        in = indao.buscarPorChavePrimaria(Integer.parseInt(request.getParameter("btn")));
        indao.excluir(in);
        response.sendRedirect("redirect.jsp?p=" + request.getParameter("p"));
        in = new Interruptor();
        return;
    }
    //sensores
    if (request.getParameter("updsen") != null) {
        SensorDAO sendao = new SensorDAO();
        sen = sendao.buscarPorChavePrimaria(Integer.parseInt(request.getParameter("ids")));
        sen.setName(request.getParameter("nameS"));
        sendao.alterar(sen);
        sendao.fecharEmf();
        //response.sendRedirect("redirect.jsp?p="+request.getParameter("p"));
        in = new Interruptor();
        //return;
    }
    if (request.getParameter("apgsen") != null) {
        SensorDAO sendao = new SensorDAO();
        sen = sendao.buscarPorChavePrimaria(Integer.parseInt(request.getParameter("ids")));
        sendao.excluir(sen);
        sen = new Sensor();
        sendao.fecharEmf();
        response.sendRedirect("redirect.jsp?p=" + request.getParameter("p"));
        return;
    }
    System.gc();
%>
<div class="content">
    <div class="container-fluid">
        <div class="row">

            <div class="col-md-12">
                <div class="card">
                    <div class="header">
                        <h4 class="title">Ambiente</h4>
                    </div>
                    <div class="content">
                        <form method="POST" action="main.jsp">
                            <div class="row">

                                <div class="col-md-2">
                                    <div class="form-group">
                                        <label>ID</label>
                                        <input type="text" class="form-control border-input" disabled="" value="<%=evr.getIdevr()%>">
                                    </div>
                                </div>

                                <div class="col-md-10">
                                    <div class="form-group">
                                        <label>Nome</label>
                                        <input type="text" class="form-control border-input" required="true" placeholder="Nome" name="nameE" value="<%=evr.getName()%>">
                                        <input type="hidden" value="<%=request.getParameter("p")%>" name="p">
                                        <input type="hidden" value="edt" name="act">
                                    </div>
                                </div>                             

                            </div>
                            <div class="text-center">
                                <button type="submit" class="btn btn-info btn-fill btn-wd">Atualizar</button>
                            </div>
                            <div class="clearfix"></div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card">

                    <div class="header">
                        <h4 class="title">Botoes</h4>
                    </div>
                    <div class="content">

                        <form method="GET">
                            <div class="row">
                                <div class="col-md-1"></div>
                                <input type="hidden" value="<%=request.getParameter("p")%>" name="p">
                                <input type="hidden" value="edt" name="act">
                                <div class="col-md-2">
                                    <br>

                                    <div class="dropdown">
                                        <a href="#" class="btn dropdown-toggle" data-toggle="dropdown">

                                            Selecione

                                        </a>
                                        <ul class="dropdown">
                                            <ul class="dropdown-menu">
                                                <%for (Interruptor intr : evr.getInterruptorList()) {%>
                                                <li><a href="?act=edt&p=<%=request.getParameter("p")%>&btn=<%=intr.getIdint()%>"><%=intr.getName()%></a></li>
                                                    <%}%>
                                            </ul>
                                        </ul>
                                    </div>
                                </div>


                                <%
                                    if (request.getParameter("btn") != null) {
                                        InterruptorDAO indao = new InterruptorDAO();
                                        in = indao.buscarPorChavePrimaria(Integer.parseInt(request.getParameter("btn")));
                                        indao.fecharEmf();
                                    } else {
                                        in.setName("");
                                    }
                                %>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <label>ID</label>
                                        <input type="text" class="form-control border-input" disabled="" value="<%=(in.getIdint() != null) ? in.getIdint() : ""%>">
                                        <input type="hidden" name="btn" value="<%=(in.getIdint() != null) ? in.getIdint() : ""%>">
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Nome</label>
                                        <input type="text" class="form-control border-input" required="true" placeholder="Nome" name="nameB" value="<%=in.getName()%>">
                                    </div>
                                </div>


                            </div>
                            <div class="row">
                                <div class="col-md-3"></div>
                                <div class="col-md-2">
                                    <div class="text-center">
                                        <button type="submit" class="btn btn-info btn-fill btn-wd" name="updbtn" value="1">Atualizar</button>
                                    </div>
                                </div>
                                <div class="col-md-2"></div>
                                <div class="col-md-2">
                                    <div class="text-center">
                                        <button type="submit" class="btn btn-danger btn-fill btn-wd" name="btnapg" value="1">Apagar</button>
                                    </div>
                                </div>
                            </div>
                    </div>
                    </form>
                </div>
            </div>                                    


            <div class="col-md-6">
                <div class="card">
                    <div class="header">
                        <h4 class="title">Sensores</h4>
                    </div>
                    <div class="content">
                        <form method="GET">
                            <div class="row">
                                <div class="col-md-1"></div>
                                <input type="hidden" value="<%=request.getParameter("p")%>" name="p">
                                <input type="hidden" value="edt" name="act">
                                <div class="col-md-2">
                                    <br>

                                    <div class="dropdown">
                                        <a href="#" class="btn dropdown-toggle" data-toggle="dropdown">

                                            Selecione

                                        </a>
                                        <ul class="dropdown">
                                            <ul class="dropdown-menu">
                                                <%for (Sensor sens : evr.getSensorList()) {%>
                                                <li><a href="?act=edt&p=<%=request.getParameter("p")%>&sen=<%=sens.getIdsen()%>"><%=sens.getName()%></a></li>
                                                    <%}%>
                                            </ul>
                                        </ul>
                                    </div>
                                </div>

                                <%
                                    if (request.getParameter("sen") != null) {
                                        SensorDAO sendao = new SensorDAO();
                                        sen = sendao.buscarPorChavePrimaria(Integer.parseInt(request.getParameter("sen")));
                                        sendao.fecharEmf();
                                    } else {
                                        sen.setName("");
                                    }
                                %>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <label>ID</label>
                                        <input type="text" class="form-control border-input" disabled="" value="<%=(sen.getIdsen() != null) ? sen.getIdsen() : ""%>">
                                        <input type="hidden" name="ids" value="<%=(sen.getIdsen() != null) ? sen.getIdsen() : ""%>">
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Nome</label>
                                        <input type="text" class="form-control border-input" required="true" placeholder="Nome" name="nameS" value="<%=sen.getName()%>">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3"></div>
                                <div class="col-md-2">
                                    <div class="text-center">
                                        <button type="submit" class="btn btn-info btn-fill btn-wd" name="updsen" value="1">Atualizar</button>
                                    </div>
                                </div>
                                <div class="col-md-2"></div>
                                <div class="col-md-2">
                                    <div class="text-center">
                                        <button type="submit" class="btn btn-danger btn-fill btn-wd" name="apgsen" value="1">Apagar</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>