<%@page import="dao.InterruptorDAO"%>
<%  try{
    InterruptorDAO dao=new InterruptorDAO();%>
<%=dao.buscarPorChavePrimaria(Integer.parseInt(request.getParameter("id"))).getEstado().booleanValue()%>
<%dao.fecharEmf();     
    } catch (Exception e) {
         out.print("ERROR!");
   }%>