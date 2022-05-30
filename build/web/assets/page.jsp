<%@page import="dao.InterruptorDAO"%>
<%@page import="modelo.Interruptor"%>
<%@page import="dao.SistemaDAO"%>
<%@page import="modelo.Sensor"%>
<%@page import="modelo.Ambiente"%>
<div class="content">
    <div class="container-fluid">
        <div class="row">

            <div class="content">
                <div class="container-fluid">
                    <div class="row">
                        <%
                            if (request.getParameter("btnAct") != null) {
                                if (request.getParameter("btnAct").equals("toggleBtn")) {
                                    InterruptorDAO indao = new InterruptorDAO();
                                    Interruptor inobj = indao.buscarPorChavePrimaria(Integer.parseInt(request.getParameter("btnId")));
                                    //Boolean etd=!inobj.getEstado();
                                    inobj.setEstado(!inobj.getEstado().booleanValue());
                                    indao.alterar(inobj);
                                }
                            }

                            SistemaDAO dao = new SistemaDAO();
                            Ambiente amb = dao.buscarPorChavePrimaria(Integer.parseInt(request.getParameter("p")));
                            dao.fecharEmf();
                            for (Sensor sen : amb.getSensorList()) {%>
                        <div class="col-md-12">
                            <div class="card ">
                                <iframe src="assets/charts.jsp?sen=<%=sen.getIdsen()%>" style="border:none" width="100%" height="500px"></iframe>
                            </div>
                        </div>

                        <%}%>


                        <div class="col-md-12">
                            
                            <div class="card ">
                                <div class="header">
                                    <h4 class="title">Botoes</h4>
                                    <p class="category">Podem ser usados como interruptores</p>
                                </div>
                                <br>
                                <div class="places-buttons center-block">
                                    <div class="row">
                                        <div class="col-md-1">
                                            
                                        </div>
                                        <% for (Interruptor intr : amb.getInterruptorList()) {%>
                                        <div class="col-md-2">
                                            <form action="main.jsp" method="post" target="_self">
                                                <input type="hidden" name="p" value="<%=request.getParameter("p")%>">
                                                <input type="hidden" value="toggleBtn" name="btnAct">
                                                <input type="hidden" value="<%=intr.getIdint()%>" name="btnId">
                                                <div class="text-center">
                                                    <button type="submit" class="btn btn-fill btn-<%=(intr.getEstado().booleanValue()) ? "success" : "default"%> btn-wd" ><%=intr.getIdint() + "-" + intr.getName()%></button>
                                                </div>
                                            </form>                                            
                                        </div>
                                        <%}%>

                                        <div class="col-md-2">
                                            <form action="main.jsp" method="post" target="_self">
                                                <input type="hidden" name="p" value="<%=request.getParameter("p")%>">
                                                <input type="hidden" name="act" value="newBtn">
                                                <div class="text-center">
                                                    <button type="submit" class="btn btn-info btn-fill btn-wd" >Add Botão</button>
                                                </div>
                                            </form>                                            
                                        </div>                                      

                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="places-buttons">
                            <div class="row">
                                <div class="col-md-6">

                                </div>
                                <div class="col-md-2">
                                    <form action="main.jsp" method="post" target="_self">
                                        <input type="hidden" name="p" value="<%=request.getParameter("p")%>">
                                        <input type="hidden" name="act" value="new">
                                        <div class="text-center">
                                            <button type="submit" class="btn btn-info btn-fill btn-wd" >Add sensor</button>
                                        </div>
                                    </form>
                                </div>


                                <div class="col-md-2">
                                    <form action="main.jsp" method="post" target="_self">
                                        <input type="hidden" name="p" value="<%=request.getParameter("p")%>">
                                        <input type="hidden" name="act" value="edt">
                                        <div class="text-center">
                                            <button type="submit" class="btn btn-info btn-fill btn-wd" >Editar</button>
                                        </div>
                                    </form>
                                </div>


                                <div class="col-md-2">
                                    <form action="main.jsp" method="post" target="_self">
                                        <input type="hidden" name="p" value="<%=request.getParameter("p")%>">
                                        <input type="hidden" name="act" value="del">
                                        <div class="text-center">
                                            <button type="submit" class="btn btn-danger btn-fill btn-wd" >Apagar</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>


                    </div>
                </div>
            </div>


