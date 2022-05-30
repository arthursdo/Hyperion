<%@page import="modelo.Sensor"%>
<%@page import="java.util.Random"%>
<%@page import="java.util.Date"%>
<%@page import="dao.SensorDAO"%>
<%@page import="dao.UsuarioDAO"%>
<%@page import="modelo.Usuario"%>
<%@page import="java.util.Calendar"%>
<%@page import="modelo.Value"%>
<%@page import="dao.ValueDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <% try {

            ValueDAO dao = new ValueDAO();
            Calendar c = Calendar.getInstance();
            Usuario usr = new UsuarioDAO().buscarPorChavePrimaria(request.getParameter("log").toString());

            if (usr.getKey().equals(request.getParameter("key"))) {
                Random rand = new Random();
                Integer max = Integer.parseInt(request.getParameter("max"));
                Integer min = Integer.parseInt(request.getParameter("min"));
                Integer qtd = Integer.parseInt(request.getParameter("qtd"));
                Integer rands;
                Sensor sen = new SensorDAO().buscarPorChavePrimaria(Integer.parseInt(request.getParameter("sen")));
                for (int i = 0; i < qtd; ++i) {
                    Value val = new Value();
                    val.setDate(new Date());
                    val.setIdsen(sen);
                    rands=rand.nextInt() % max;
                    rands+=(rands<min)?min:0;
                    val.setValue(rands);
                    dao.incluir(val);
                }
                dao.fecharEmf();

            }
        } catch (Exception e) {
        }
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="generator.jsp" method="GET">
            <input type="number" name="sen" placeholder="Sensor"><br>
            <input type="text" name="log" placeholder="Login"><br>
            <input type="text" name="key" placeholder="key"><br>
            <input type="number" name="min" placeholder="Minimo"><br>
            <input type="number" name="max" placeholder="Maximo"><br>
            <input type="number" name="qtd" placeholder="Quantidade"><br>
            <input type="submit">
        </form>
    </body>
</html>
