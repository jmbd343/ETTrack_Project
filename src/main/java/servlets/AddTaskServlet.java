package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AddTaskServlet")
public class AddTaskServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String employeeName = request.getParameter("employee_name");
        String role = request.getParameter("role");
        String project = request.getParameter("project");
        String taskDate = request.getParameter("task_date");
        String startTime = request.getParameter("start_time");
        String endTime = request.getParameter("end_time");
        String category = request.getParameter("category");
        String description = request.getParameter("description");

        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DBUtil.getConnection();

            String query = "INSERT INTO Tasks (employee_name, role, project, task_date, start_time, end_time, category, description) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            ps = con.prepareStatement(query);
            ps.setString(1, employeeName);
            ps.setString(2, role);
            ps.setString(3, project);
            ps.setString(4, taskDate);
            ps.setString(5, startTime);
            ps.setString(6, endTime);
            ps.setString(7, category);
            ps.setString(8, description);

            int result = ps.executeUpdate();

            if (result > 0) {
                response.sendRedirect("Dashboard.jsp");
            } else {
                response.sendRedirect("addTask.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // Redirect to an error page if there's an exception
        } finally {
            if (ps != null) {
                try {
                    ps.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            DBUtil.closeConnection(con);
        }
    }
}
