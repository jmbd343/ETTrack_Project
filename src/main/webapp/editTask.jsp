<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*, java.io.*, java.util.*, servlets.DBUtil" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Task - Employee Time Tracker</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap');
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #CFE8EF;
            color: #333;
            margin: 0;
            padding: 0;
        }
        header {
            width: 100%;
            background-color: #85C7DE;
            color: #333;
            padding: 20px 0;
            text-align: center;
            border-bottom: 3px solid #333;
        }
        header h1 {
            margin: 0;
            font-size: 2em;
        }
        .container {
            width: 90%;
            max-width: 800px;
            margin: 100px auto 30px;
            text-align: center;
        }
        .main h2 {
            color: #85C7DE;
            font-size: 2em;
            margin-bottom: 20px;
        }
        .form-container {
            background-color: #FFFFFF;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.2);
        }
        .form-container input, .form-container select, .form-container textarea {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .form-container button {
            background-color: #85C7DE;
            color: white;
            padding: 10px 20px;
            margin: 10px 0;
            border: none;
            cursor: pointer;
            border-radius: 4px;
            transition: background 0.3s;
        }
        .form-container button:hover {
            background-color: #A0C4E2;
        }
    </style>
</head>
<body>
    <header>
        <h1>Employee Time Tracker</h1>
    </header>
    <div class="container main">
        <h2>Edit Task</h2>
        <div class="form-container">
            <%
                int taskId = Integer.parseInt(request.getParameter("id"));
                String username = (String) session.getAttribute("username");

                if (username != null) {
                    Connection con = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;

                    try {
                        con = DBUtil.getConnection();

                        String query = "SELECT * FROM Tasks WHERE task_id=? AND employee_name=?";
                        ps = con.prepareStatement(query);
                        ps.setInt(1, taskId);
                        ps.setString(2, username);

                        rs = ps.executeQuery();

                        if (rs.next()) {
            %>
            <form action="EditTaskServlet" method="post">
                <input type="hidden" name="task_id" value="<%= rs.getInt("task_id") %>">
                <label for="employee_name">Employee Name:</label>
                <input type="text" id="employee_name" name="employee_name" value="<%= rs.getString("employee_name") %>" readonly>
                
                <label for="role">Role:</label>
                <input type="text" id="role" name="role" value="<%= rs.getString("role") %>" required>
                
                <label for="project">Project:</label>
                <input type="text" id="project" name="project" value="<%= rs.getString("project") %>" required>
                
                <label for="task_date">Date:</label>
                <input type="date" id="task_date" name="task_date" value="<%= rs.getString("task_date") %>" required>
                
                <label for="start_time">Start Time:</label>
                <input type="time" id="start_time" name="start_time" value="<%= rs.getString("start_time") %>" required>
                
                <label for="end_time">End Time:</label>
                <input type="time" id="end_time" name="end_time" value="<%= rs.getString("end_time") %>" required>
                
                <label for="category">Category:</label>
                <select id="category" name="category" required>
                    <option value="Meeting" <%= rs.getString("category").equals("Meeting") ? "selected" : "" %>>Meeting</option>
                    <option value="Training" <%= rs.getString("category").equals("Training") ? "selected" : "" %>>Training</option>
                    <option value="Development" <%= rs.getString("category").equals("Development") ? "selected" : "" %>>Development</option>
                    <option value="Testing" <%= rs.getString("category").equals("Testing") ? "selected" : "" %>>Testing</option>
                </select>
                
                <label for="description">Description:</label>
                <textarea id="description" name="description" rows="4" required><%= rs.getString("description") %></textarea>
                
                <button type="submit">Update Task</button>
            </form>
            <%
                        } else {
                            out.println("<p>No task found or you're not authorized to edit this task.</p>");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<p>Error: " + e.getMessage() + "</p>");
                    } finally {
                        DBUtil.closeConnection(con);
                    }
                } else {
                    response.sendRedirect("login.jsp");
                }
            %>
        </div>
    </div>
</body>
</html>
