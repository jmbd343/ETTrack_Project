<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap');

        body {
            font-family: 'Roboto', sans-serif;
            background-color: #CFE8EF;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            background: rgba(255, 255, 255, 0.8);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            width: 100%;
            max-width: 500px;
        }

        h1 {
            text-align: center;
            margin-bottom: 20px;
            color: #85C7DE;
        }

        label {
            display: block;
            margin: 10px 0 5px;
            font-weight: bold;
        }

        input[type="text"], input[type="password"], input[type="email"], select {
            width: calc(100% - 22px);
            padding: 10px;
            margin-bottom: 15px;
            border: 2px solid #85C7DE;
            border-radius: 5px;
            background: rgba(255, 255, 255, 0.8);
            color: #333;
        }

        select {
            appearance: none;
            -webkit-appearance: none;
            -moz-appearance: none;
            background: rgba(255, 255, 255, 0.8) url('data:image/svg+xml;base64,PHN2ZyBmaWxsPSIjRUNFQ0VFIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDE2IDE2Ij4gICAgPHBhdGggZD0iTTEuNiA2Ljc5TDggMTQuMTVsNi40LTEuMDJMOC4wMiA1Ljg3IDYuOTggMy45MiAzLjU5IDcuMjEgMi41NSAzLjkyeiIvPjwvc3ZnPg==') no-repeat right 10px center;
            padding-right: 30px;
        }

        input[type="submit"] {
            width: 100%;
            padding: 15px;
            border: none;
            border-radius: 5px;
            background-color: #85C7DE;
            color: #333;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s, transform 0.3s;
            position: relative;
            overflow: hidden;
        }

        input[type="submit"]:hover {
            background-color: #A0C4E2;
            transform: translateY(-3px);
        }

        input[type="submit"]:active {
            background-color: #85C7DE;
            transform: translateY(1px);
        }

        input[type="submit"]::before {
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

        input[type="submit"]:hover::before {
            transform: translateX(-50%) translateY(0);
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Employee Registration</h1>
        <form action="RegisterServlet" method="post">
            <label for="username">Username</label>
            <input type="text" id="username" name="username" required>

            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>

            <label for="email">Email</label>
            <input type="email" id="email" name="email" required>

            <label for="role">Role</label>
            <select id="role" name="role" required>
                <option value="Associate">Associate</option>
                <option value="Admin">Admin</option>
            </select>

            <input type="submit" value="Register">
        </form>
    </div>
</body>
</html>
