<%@page import="dao.InterruptorDAO"%>
<%@page import="modelo.Interruptor"%>
<%@page import="modelo.Ambiente"%>
<%@page import="modelo.Usuario"%>
<%@page import="dao.UsuarioDAO"%>
<%@page import="dao.SistemaDAO"%>
<%
    UsuarioDAO userD = new UsuarioDAO();
    Usuario user = userD.buscarPorChavePrimaria(session.getAttribute("usuario").toString());
    if (request.getParameter("act") != null) {
        if (request.getParameter("act").equals("del") && user.getLogin().equals(session.getAttribute("usuario"))) {
            SistemaDAO siDAO = new SistemaDAO();
            Ambiente obj = siDAO.buscarPorChavePrimaria(Integer.parseInt(request.getParameter("p")));
            siDAO.excluir(obj);
            siDAO.fecharEmf();
            response.sendRedirect("main.jsp?p="+user.getAmbienteList().get(0).getIdevr());
            return;
        }
    }
%>
<div class="sidebar" data-background-color="white" data-active-color="danger">

    <!--
                Tip 1: you can change the color of the sidebar's background using: data-background-color="white | black"
                Tip 2: you can change the color of the active button using the data-active-color="primary | info | success | warning | danger"
    -->
    <%
        String p = (request.getParameter("p") != null) ? request.getParameter("p") : "";
    %>
    <div class="sidebar-wrapper">
        <div class="logo">
            <a href="main.jsp" class="simple-text">
                Hyperion
            </a>
        </div>

        <ul class="nav">
            <%
                userD.fecharEmf();
                for (Ambiente amb : user.getAmbienteList()) {
            %>

            <li class="<%=(p.equals(amb.getIdevr().toString()) ? "active" : "")%>">
                <a href="main.jsp?p=<%=amb.getIdevr()%>">
                    <i class="ti-cloud"></i>
                    <p><%=amb.getName().toString()%></p>
                </a>
            </li>

            <%}
            %>

            <li class="<%=(p.equals("sisreg") ? "active" : "")%>">
                <a href="sisreg.jsp?p=sisreg">
                    <i class="ti-settings"></i>
                    <!--<i class="ti-pie-chart"></i>-->
                    <p>ADD AMBIENTE</p>
                </a>
            </li>

        </ul>

    </div>
</div>