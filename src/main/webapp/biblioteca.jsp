<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLDecoder" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Biblioteca de Videojuegos</title>
    <link rel="stylesheet" href="css/estilo.css">
</head>
<body>
<%

    String usuario = request.getParameter("usuario");
    String password = request.getParameter("password");

    if(usuario == null && session.getAttribute("usuario") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    if(usuario != null) {

        if("Grosbin".equals(usuario) && "1234".equals(password)) {
            session.setAttribute("usuario", usuario);
        } else {
            response.sendRedirect("login.jsp?error=1");
            return;
        }
    }


    List<Map<String, String>> juegos = (List<Map<String, String>>) session.getAttribute("juegos");
    if(juegos == null) {
        juegos = new ArrayList<>();

        Map<String, String> juego1 = new HashMap<>();
        juego1.put("id", "1");
        juego1.put("titulo", "The Legend of Zelda");
        juego1.put("descripcion", "Aventura épica en Hyrule");
        juego1.put("caratula", "https://images.pexels.com/photos/3945665/pexels-photo-3945665.jpeg");
        juego1.put("favorito", "false");

        Map<String, String> juego2 = new HashMap<>();
        juego2.put("id", "2");
        juego2.put("titulo", "Cyberpunk 2077");
        juego2.put("descripcion", "RPG futurista en Night City");
        juego2.put("caratula", "https://images.pexels.com/photos/442576/pexels-photo-442576.jpeg");
        juego2.put("favorito", "false");

        juegos.add(juego1);
        juegos.add(juego2);
        session.setAttribute("juegos", juegos);
    }


    String action = request.getParameter("action");
    String id = request.getParameter("id");

    if("eliminar".equals(action) && id != null) {
        juegos.removeIf(juego -> juego.get("id").equals(id));
        session.setAttribute("juegos", juegos);
        response.sendRedirect("biblioteca.jsp");
        return;
    }

    if("toggleFavorito".equals(action) && id != null) {
        for(Map<String, String> juego : juegos) {
            if(juego.get("id").equals(id)) {
                String favorito = juego.get("favorito");
                juego.put("favorito", "true".equals(favorito) ? "false" : "true");
                break;
            }
        }
        session.setAttribute("juegos", juegos);
        response.sendRedirect("biblioteca.jsp");
        return;
    }


    int nextId = juegos.size() + 1;
%>

<div class="container">
    <div class="header">
        <h1 class="titulo-principal">Biblioteca de Videojuegos</h1>
        <h2 class="subtitulo">Integrantes: Grosbin Jafeth Gutierrez Palma (202420130052) | Yeimy Alejandra Chavez Calix (202410080010) | Carlos David Cruz Romero 202320060194</h2>

        <div class="info-usuario">
            <span class="usuario-nombre">Bienvenido, <%= session.getAttribute("usuario") %></span>
            <form action="login.jsp" method="get" style="margin:0">
                <button type="submit" class="btn-cerrar" onclick="sessionStorage.clear()">Cerrar Sesión</button>
            </form>
        </div>
    </div>

    <div style="text-align: center;">
        <button class="btn-agregar" onclick="window.location.href='agregar-editar.jsp'">
            Agregar Nuevo Videojuego
        </button>
    </div>

    <div class="grid-juegos">
        <%
            for(Map<String, String> juego : juegos) {
                boolean esFavorito = "true".equals(juego.get("favorito"));
        %>
        <div class="card-juego">
            <img class="card-imagen" src="<%= juego.get("caratula") %>" alt="Carátula"
                 onerror="this.src='https://via.placeholder.com/280x200?text=Sin+Imagen'">
            <div class="card-content">
                <h3 class="card-titulo"><%= juego.get("titulo") %></h3>
                <p class="card-descripcion"><%= juego.get("descripcion") %></p>

                <% if(esFavorito) { %>
                <div class="card-favorito"> Favorito</div>
                <% } %>

                <div class="card-acciones">
                    <button class="btn-editar" onclick="window.location.href='agregar-editar.jsp?id=<%= juego.get("id") %>'">
                         Editar
                    </button>

                    <button class="btn-favorito <%= esFavorito ? "active" : "" %>"
                            onclick="window.location.href='biblioteca.jsp?action=toggleFavorito&id=<%= juego.get("id") %>'">
                        <%= esFavorito ? "★" : "☆" %> Favorito
                    </button>

                    <button class="btn-eliminar"
                            onclick="if(confirm('¿Eliminar este juego?')) window.location.href='biblioteca.jsp?action=eliminar&id=<%= juego.get("id") %>'">
                         Eliminar
                    </button>
                </div>
            </div>
        </div>
        <% } %>
    </div>
</div>
</body>
</html>