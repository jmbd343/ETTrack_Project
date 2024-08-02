package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/FetchTaskDataServlet")
public class FetchTaskDataServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String username = (String) request.getSession().getAttribute("username");
        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Connection con = null;
        PreparedStatement psDaily = null;
        PreparedStatement psWeekly = null;
        PreparedStatement psMonthly = null;
        ResultSet rsDaily = null;
        ResultSet rsWeekly = null;
        ResultSet rsMonthly = null;

        try {
            con = DBUtil.getConnection();

            // Daily tasks
            String dailyQuery = "SELECT start_time, end_time FROM Tasks WHERE employee_name = ? AND DATE(task_date) = CURDATE()";
            psDaily = con.prepareStatement(dailyQuery);
            psDaily.setString(1, username);
            rsDaily = psDaily.executeQuery();

            JSONArray dailyTasks = new JSONArray();
            while (rsDaily.next()) {
                JSONObject task = new JSONObject();
                task.put("start_time", rsDaily.getString("start_time"));
                task.put("end_time", rsDaily.getString("end_time"));
                dailyTasks.put(task);
            }

            // Weekly tasks
            String weeklyQuery = "SELECT task_date, start_time, end_time FROM Tasks WHERE employee_name = ? AND WEEK(task_date) = WEEK(CURDATE())";
            psWeekly = con.prepareStatement(weeklyQuery);
            psWeekly.setString(1, username);
            rsWeekly = psWeekly.executeQuery();

            JSONArray weeklyTasks = new JSONArray();
            while (rsWeekly.next()) {
                JSONObject task = new JSONObject();
                task.put("task_date", rsWeekly.getString("task_date"));
                task.put("start_time", rsWeekly.getString("start_time"));
                task.put("end_time", rsWeekly.getString("end_time"));
                weeklyTasks.put(task);
            }

            // Monthly tasks
            String monthlyQuery = "SELECT task_date, start_time, end_time FROM Tasks WHERE employee_name = ? AND MONTH(task_date) = MONTH(CURDATE())";
            psMonthly = con.prepareStatement(monthlyQuery);
            psMonthly.setString(1, username);
            rsMonthly = psMonthly.executeQuery();

            JSONArray monthlyTasks = new JSONArray();
            while (rsMonthly.next()) {
                JSONObject task = new JSONObject();
                task.put("task_date", rsMonthly.getString("task_date"));
                task.put("start_time", rsMonthly.getString("start_time"));
                task.put("end_time", rsMonthly.getString("end_time"));
                monthlyTasks.put(task);
            }

            JSONObject result = new JSONObject();
            result.put("dailyTasks", dailyTasks);
            result.put("weeklyTasks", weeklyTasks);
            result.put("monthlyTasks", monthlyTasks);

            response.getWriter().write(result.toString());
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while fetching task data");
        } finally {
            if (rsDaily != null) {
                try {
                    rsDaily.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            if (rsWeekly != null) {
                try {
                    rsWeekly.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            if (rsMonthly != null) {
                try {
                    rsMonthly.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            if (psDaily != null) {
                try {
                    psDaily.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            if (psWeekly != null) {
                try {
                    psWeekly.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            if (psMonthly != null) {
                try {
                    psMonthly.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            DBUtil.closeConnection(con);
        }
    }
}
