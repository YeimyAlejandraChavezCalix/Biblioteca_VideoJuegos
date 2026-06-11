<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agregar/Editar Videojuego</title>
    <link rel="stylesheet" href="css/estilo.css">
</head>
<body>
<%
    if(session.getAttribute("usuario") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Map<String, String>> juegos = (List<Map<String, String>>) session.getAttribute("juegos");
    String id = request.getParameter("id");
    Map<String, String> juegoEdit = null;
    boolean esEdicion = false;

    if(id != null && juegos != null) {
        for(Map<String, String> juego : juegos) {
            if(juego.get("id").equals(id)) {
                juegoEdit = juego;
                esEdicion = true;
                break;
            }
        }
    }

    // Procesar guardado
    String titulo = request.getParameter("titulo");
    if(titulo != null && titulo.trim().length() > 0) {
        String descripcion = request.getParameter("descripcion");
        String caratula = request.getParameter("caratula");
        String juegoId = request.getParameter("id");

        if(juegoId != null && !juegoId.trim().isEmpty()) {

            for(Map<String, String> juego : juegos) {
                if(juego.get("id").equals(juegoId)) {
                    juego.put("titulo", titulo);
                    juego.put("descripcion", descripcion);
                    juego.put("caratula", caratula);
                    break;
                }
            }
        } else {

            Map<String, String> nuevoJuego = new HashMap<>();
            nuevoJuego.put("id", String.valueOf(juegos.size() + 1));
            nuevoJuego.put("titulo", titulo);
            nuevoJuego.put("descripcion", descripcion);
            nuevoJuego.put("caratula", caratula);
            nuevoJuego.put("favorito", "false");
            juegos.add(nuevoJuego);
        }

        session.setAttribute("juegos", juegos);
        response.sendRedirect("biblioteca.jsp");
        return;
    }
%>

<div class="container">
    <div class="form-container">
        <h1 style="color:#667eea; margin-bottom:30px; text-align:center">
            <%= esEdicion ? " Editar Videojuego" : " Agregar Nuevo Videojuego" %>
        </h1>

        <form method="post">
            <input type="hidden" name="id" value="<%= esEdicion ? juegoEdit.get("id") : "" %>">

            <div class="form-group">
                <label>Título del Videojuego</label>
                <input type="text" name="titulo" required
                       value="<%= esEdicion ? juegoEdit.get("titulo") : "" %>"
                       placeholder="Ej: The Witcher 3">
            </div>

            <div class="form-group">
                <label>Descripción</label>
                <textarea name="descripcion" rows="4" required
                          placeholder="Describe el juego..."><%= esEdicion ? juegoEdit.get("descripcion") : "" %></textarea>
            </div>

            <div class="form-group">
                <label>URL de la Carátula (imagen)</label>
                <input type="text" name="caratula"
                       value="<%= esEdicion ? juegoEdit.get("caratula") : "" %>"
                       placeholder="https://ejemplo.com/imagen.jpg">
                <small style="color:#666">Puedes usar URLs de imágenes de internet</small>
            </div>

            <div style="text-align: center; margin-top: 30px;">
                <button type="submit" class="btn-guardar"> Guardar</button>
                <a href="biblioteca.jsp" class="btn-cancelar"> Cancelar</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>