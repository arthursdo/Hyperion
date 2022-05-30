<%@page import="modelo.Interruptor"%>
<%@page import="dao.InterruptorDAO"%>
<%@page import="dao.SistemaDAO"%>
<%
    if (request.getParameter("name") != null) {
        InterruptorDAO dao= new InterruptorDAO();
        Interruptor obj = new Interruptor();
        
        obj.setIdevr(new SistemaDAO().buscarPorChavePrimaria(Integer.parseInt(request.getParameter("p"))));        
        obj.setName(request.getParameter("name"));
        obj.setEstado(false);
        dao.incluir(obj);
        dao.fecharEmf();
         System.gc();
        response.sendRedirect("main.jsp?p="+request.getParameter("p"));
    }
%>
<div class="content">
    <div class="container-fluid">
        <div class="row">

            <div class="col-lg-8 col-md-7">
                <div class="card">
                    <div class="header">
                        <h4 class="title">Cadastrar Botão</h4>
                    </div>
                    <div class="content">
                        <form action="main.jsp" method="GET">
                            <div class="row">

                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label>Nome</label>
                                        <input type="text" class="form-control border-input" required="true" placeholder="Nome" name="name">
                                        <input type="hidden" value="<%=request.getParameter("p")%>" name="p">
                                        <input type="hidden" value="newBtn" name="act">
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