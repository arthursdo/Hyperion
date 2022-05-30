<%@page import="java.util.Date"%>
<%@page import="dao.SensorDAO"%>
<%@page import="dao.SistemaDAO"%>
<%@page import="modelo.Usuario"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dao.UsuarioDAO"%>
<%@page import="modelo.Value"%>
<%@page import="dao.ValueDAO"%>
<%  ValueDAO dao = new ValueDAO();
    Value val = new Value();
    //?val=xx&sen=xx&log=xx&key=xx
    //http://localhost:8084/TCCC/commit.jsp?val=26&sen=14&log=arthur&key=75669deb

    val.setValue(Math.round(Float.parseFloat(request.getParameter("val"))));
    Calendar c = Calendar.getInstance();
    val.setDate(new Date());
    val.setIdsen(new SensorDAO().buscarPorChavePrimaria(Integer.parseInt(request.getParameter("sen"))));

    Usuario usr = new UsuarioDAO().buscarPorChavePrimaria(request.getParameter("log").toLowerCase());
    String sts = "fail";
    if (usr.getKey().equals(request.getParameter("key"))) {
        if (dao.incluir(val)) {
            sts = "ok";
        }
    }
    dao.fecharEmf();
%>
<%=sts%>