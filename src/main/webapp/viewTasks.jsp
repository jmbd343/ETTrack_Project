<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, javax.servlet.http.*, java.util.*, servlets.DBUtil" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Tasks - Employee Time Tracker</title>
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
            background: #35424a;
            color: #ffffff;
            padding: 20px 0;
            text-align: center;
            border-bottom: #e8491d 3px solid;
            position: fixed;
            top: 0;
            z-index: 1000;
        }

        header h1 {
            margin: 0;
            font-size: 2em;
        }

        header a {
            color: #ffffff;
            text-decoration: none;
            text-transform: uppercase;
            font-size: 16px;
            margin: 0 15px;
            transition: color 0.3s ease;
        }

        header a:hover {
            color: #e0b94c;
        }

        .container {
            width: 90%;
            max-width: 1000px;
            margin: 100px auto 30px;
        }

        .main {
            background: #ffffff;
            color: #333333;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #35424a;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            font-size: 16px;
            text-align: left;
        }

        table th, table td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
        }

        table th {
            background-color: #35424a;
            color: white;
        }

        table tr:hover {
            background-color: #f1f1f1;
        }

        .button {
            display: inline-block;
            border-radius: 4px;
            background-color: #5cb85c;
            border: none;
            color: #ffffff;
            text-align: center;
            font-size: 14px;
            padding: 8px 16px;
            transition: all 0.3s ease;
            cursor: pointer;
            margin: 5px;
            text-decoration: none;
        }

        .button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <header>
        <h1>Employee Time Tracker</h1>
        <nav>
            <a href="Dashboard.jsp">Dashboard</a>
            <a href="LogoutServlet">Logout</a>
        </nav>
    </header>
    <div class="container main">
        <h2>View Tasks</h2>
        <table>
            <thead>
                <tr>
                    <th>Employee Name</th>
                    <th>Role</th>
                    <th>Project</th>
                    <th>Date</th>
                    <th>Start Time</th>
                    <th>End Time</th>
                    <th>Category</th>
                    <th>Description</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    String username = (String) session.getAttribute("username");
                    String role = (String) session.getAttribute("role");

                    if (username != null && role != null) {
                        Connection con = null;
                        PreparedStatement ps = null;
                        ResultSet rs = null;

                        try {
                            con = DBUtil.getConnection();

                            String query = "";
                            if ("Admin".equals(role)) {
                                query = "SELECT * FROM Tasks"; // Admin sees all tasks
                            } else if ("Associate".equals(role)) {
                                query = "SELECT * FROM Tasks WHERE employee_name=?"; // Associate sees their own tasks
                            }

                            ps = con.prepareStatement(query);
                            if ("Associate".equals(role)) {
                                ps.setString(1, username);
                            }

                            rs = ps.executeQuery();

                            while (rs.next()) {
                                int taskId = rs.getInt("task_id");

                                out.print("<tr>");
                                out.print("<td>" + rs.getString("employee_name") + "</td>");
                                out.print("<td>" + rs.getString("role") + "</td>");
                                out.print("<td>" + rs.getString("project") + "</td>");
                                out.print("<td>" + rs.getString("task_date") + "</td>");
                                out.print("<td>" + rs.getString("start_time") + "</td>");
                                out.print("<td>" + rs.getString("end_time") + "</td>");
                                out.print("<td>" + rs.getString("category") + "</td>");
                                out.print("<td>" + rs.getString("description") + "</td>");
                                out.print("<td><a href='editTask.jsp?id=" + taskId + "' class='button'>Edit</a> <a href='DeleteTaskServlet?id=" + taskId + "' class='button'>Delete</a></td>");
                                out.print("</tr>");
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                            out.print("<tr><td colspan='9'>Error retrieving tasks. Please try again later.</td></tr>");
                        } finally {
                            DBUtil.closeConnection(con);
                        }
                    } else {
                        response.sendRedirect("login.jsp");
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
