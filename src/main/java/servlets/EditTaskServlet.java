package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Time;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/EditTaskServlet")
public class EditTaskServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("task_id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Task ID is missing");
            return;
        }

        int id = Integer.parseInt(idStr);
        String employeeName = request.getParameter("employee_name");
        String role = request.getParameter("role");
        String project = request.getParameter("project");
        String taskDate = request.getParameter("task_date");
        String startTimeStr = request.getParameter("start_time");
        String endTimeStr = request.getParameter("end_time");
        String category = request.getParameter("category");
        String description = request.getParameter("description");

        if (employeeName == null || role == null || project == null || taskDate == null ||
            startTimeStr == null || endTimeStr == null || category == null || description == null ||
            employeeName.isEmpty() || role.isEmpty() || project.isEmpty() || taskDate.isEmpty() ||
            startTimeStr.isEmpty() || endTimeStr.isEmpty() || category.isEmpty() || description.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "One or more fields are missing");
            return;
        }

        // Convert startTimeStr and endTimeStr to java.sql.Time
        Time startTime = Time.valueOf(startTimeStr);
        Time endTime = Time.valueOf(endTimeStr);

        // Validate if endTime is after startTime
        if (endTime.before(startTime)) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "End time must be after start time");
            return;
        }

        Connection con = null;
        PreparedStatement checkPs = null;
        PreparedStatement updatePs = null;
        ResultSet checkRs = null;

        try {
            con = DBUtil.getConnection();

            // Check total hours for the day
            String checkQuery = "SELECT SUM(TIMESTAMPDIFF(MINUTE, start_time, end_time) / 60) AS total_hours FROM Tasks WHERE employee_name = ? AND task_date = ? AND task_id != ?";
            checkPs = con.prepareStatement(checkQuery);
            checkPs.setString(1, employeeName);
            checkPs.setString(2, taskDate);
            checkPs.setInt(3, id);
            checkRs = checkPs.executeQuery();
            double totalHours = 0;
            if (checkRs.next()) {
                totalHours = checkRs.getDouble("total_hours");
            }
            double currentTaskHours = (endTime.getTime() - startTime.getTime()) / 3600000.0;
            if (totalHours + currentTaskHours > 8) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Cannot exceed 8 hours of work per day");
                return;
            }

            // Update task
            String query = "UPDATE Tasks SET employee_name=?, role=?, project=?, task_date=?, start_time=?, end_time=?, category=?, description=? WHERE task_id=?";
            updatePs = con.prepareStatement(query);
            updatePs.setString(1, employeeName);
            updatePs.setString(2, role);
            updatePs.setString(3, project);
            updatePs.setString(4, taskDate);
            updatePs.setTime(5, startTime);
            updatePs.setTime(6, endTime);
            updatePs.setString(7, category);
            updatePs.setString(8, description);
            updatePs.setInt(9, id);

            int result = updatePs.executeUpdate();

            if (result > 0) {
                response.sendRedirect("viewTasks.jsp");
            } else {
                response.sendRedirect("editTask.jsp?id=" + id);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while updating the task");
        } finally {
            if (checkRs != null) {
                try {
                    checkRs.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            if (checkPs != null) {
                try {
                    checkPs.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            if (updatePs != null) {
                try {
                    updatePs.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            DBUtil.closeConnection(con);
        }
    }
}
