<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - Employee Time Tracker</title>
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
            max-width: 500px;
            padding: 40px;
            background: rgba(255, 255, 255, 0.8);
            border-radius: 15px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.2);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            text-align: center;
            margin-top: 100px; /* Ensure the login box is below the header */
        }

        .container h2 {
            margin-bottom: 30px;
            color: #85C7DE;
            font-size: 1.5em;
        }

        .input-container {
            position: relative;
            margin-bottom: 30px;
            width: 100%;
        }

        .input-container label {
            position: absolute;
            top: 20px;
            left: 15px;
            font-size: 16px;
            color: #333;
            pointer-events: none;
            transition: all 0.3s ease;
        }

        .input-container input[type="text"], .input-container input[type="password"] {
            width: calc(100% - 24px);
            padding: 12px;
            padding-left: 12px;
            border: 2px solid #85C7DE;
            border-radius: 8px;
            background: rgba(255, 255, 255, 0.3);
            color: #333;
            font-size: 16px;
            box-sizing: border-box;
        }

        .input-container input[type="text"]:focus + label, .input-container input[type="password"]:focus + label,
        .input-container input[type="text"]:not(:placeholder-shown) + label, .input-container input[type="password"]:not(:placeholder-shown) + label {
            top: -15px;
            left: 12px;
            font-size: 12px;
            color: #85C7DE;
        }

        .container button {
            width: 100%;
            padding: 15px;
            border: none;
            border-radius: 8px;
            background-color: #85C7DE;
            color: #333;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s, transform 0.3s;
            position: relative;
            overflow: hidden;
        }

        .container button:hover {
            background-color: #A0C4E2;
            transform: translateY(-3px);
        }

        .container button:active {
            background-color: #85C7DE;
            transform: translateY(1px);
        }

        .container button::before {
            content: '';
            position: absolute;
            top: 0;
            left: 50%;
            width: 300%;
            height: 300%;
            background: rgba(255, 255, 255, 0.15);
            transform: translateX(-50%) translateY(-100%);
            transition: transform 0.6s ease-in-out;
            border-radius: 50%;
        }

        .container button:hover::before {
            transform: translateX(-50%) translateY(0);
        }
    </style>
</head>
<body>
    <header>
        <h1>Employee Time Tracker</h1>
    </header>
    <div class="container">
        <h2>Login</h2>
        <form action="LoginServlet" method="post">
            <div class="input-container">
                <input type="text" id="username" name="username" required placeholder=" " />
                <label for="username">Username</label>
            </div>
            <div class="input-container">
                <input type="password" id="password" name="password" required placeholder=" " />
                <label for="password">Password</label>
            </div>
            <button type="submit">Login</button>
        </form>
    </div>
</body>
</html>
