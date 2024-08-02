<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home - Employee Time Tracker</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap');

        body {
            font-family: 'Roboto', sans-serif;
            background-color: #CFE8EF;
            color: #333;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        header {
            width: 100%;
            background-color: #85C7DE;
            color: #333;
            padding: 20px 0;
            text-align: center;
            border-bottom: 3px solid #333;
            position: fixed;
            top: 0;
            z-index: 1000;
        }

        header h1 {
            margin: 0;
            font-size: 2em;
        }

        .container {
            width: 100%;
            max-width: 600px;
            padding: 40px;
            background: rgba(255, 255, 255, 0.8);
            border-radius: 15px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.2);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            text-align: center;
            margin-top: 100px; /* Ensure the content is below the header */
        }

        .container h2 {
            margin-bottom: 30px;
            color: #85C7DE;
            font-size: 1.5em;
        }

        .container a {
            text-decoration: none;
            display: block;
            padding: 15px;
            margin: 10px 0;
            border-radius: 8px;
            background-color: #A0C4E2;
            color: #fff;
            font-size: 16px;
            font-weight: bold;
            transition: background 0.3s, transform 0.3s;
        }

        .container a:hover {
            background-color: #85C7DE;
            transform: translateY(-3px);
        }

        .container a:active {
            background-color: #A0C4E2;
            transform: translateY(1px);
        }
    </style>
</head>
<body>
    <header>
        <h1>Employee Time Tracker</h1>
    </header>
    <div class="container">
        <h2>Welcome</h2>
        <a href="login.jsp">Login</a>
    </div>
</body>
</html>
