<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Biblioteca de Videojuegos - Login</title>
    <link rel="stylesheet" href="css/estilo.css">
</head>
<body>
<div class="login-container">
    <div class="login-box">
        <h1>Biblioteca de Videojuegos</h1>

        <% if(request.getParameter("error") != null) { %>
        <div class="error-msg">
            Usuario o contraseña incorrectos
        </div>
        <% } %>

        <form action="biblioteca.jsp" method="post">
            <div class="input-group">
                <label> Usuario</label>
                <input type="text" name="usuario" required>
            </div>

            <div class="input-group">
                <label> Contraseña</label>
                <input type="password" name="password" required>
            </div>

            <button type="submit" class="btn-login">Iniciar Sesión</button>
        </form>
    </div>
</div>
</body>
</html>