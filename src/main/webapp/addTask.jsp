<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Task - Employee Time Tracker</title>
    <style>
        body {
            background-color: #CFE8EF;
            font-family: Arial, sans-serif;
            color: #333;
        }

        header {
            background-color: #85C7DE;
            padding: 15px;
            text-align: center;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        header h1 {
            margin: 0;
            color: #FFF;
        }

        header a {
            color: #FFF;
            margin: 0 15px;
            text-decoration: none;
            font-weight: bold;
        }

        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: #AED1E6;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
        }

        .container h2 {
            text-align: center;
            color: #333;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            margin: 10px 0 5px;
            font-weight: bold;
        }

        input[type="text"], input[type="date"], input[type="time"], select, textarea {
            padding: 10px;
            border: 1px solid #A0C4E2;
            border-radius: 4px;
            background-color: #C6DBF0;
            font-size: 16px;
        }

        textarea {
            resize: vertical;
        }

        button {
            margin-top: 20px;
            padding: 10px;
            background-color: #85C7DE;
            color: #FFF;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #A0C4E2;
        }
    </style>
</head>
<body>
    <header>
        <h1>Employee Time Tracker</h1>
        <a href="Dashboard.jsp">Dashboard</a>
        <a href="LogoutServlet">Logout</a>
    </header>
    <div class="container form-container">
        <h2>Add Task</h2>
        <form action="AddTaskServlet" method="post">
            <label for="employee_name">Employee Name:</label>
            <input type="text" id="employee_name" name="employee_name" required>
            
            <label for="role">Role:</label>
            <input type="text" id="role" name="role" required>
            
            <label for="project">Project:</label>
            <input type="text" id="project" name="project" required>
            
            <label for="task_date">Date:</label>
            <input type="date" id="task_date" name="task_date" required>
            
            <label for="start_time">Start Time:</label>
            <input type="time" id="start_time" name="start_time" required>
            
            <label for="end_time">End Time:</label>
            <input type="time" id="end_time" name="end_time" required>
            
            <label for="category">Category:</label>
            <select id="category" name="category" required>
                <option value="Meeting">Meeting</option>
                <option value="Training">Training</option>
                <option value="Development">Development</option>
                <option value="Testing">Testing</option>
            </select>
            
            <label for="description">Description:</label>
            <textarea id="description" name="description" rows="4" required></textarea>
            
            <button type="submit">Add Task</button>
        </form>
    </div>
</body>
</html>
