package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.Gson;

@WebServlet("/WeeklyChartDataServlet")
public class WeeklyChartDataServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String username = (String) request.getSession().getAttribute("username");
        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<String> labels = new ArrayList<>();
        List<Integer> data = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBUtil.getConnection();

            String query = "SELECT WEEK(start_time) as week, SUM(TIMESTAMPDIFF(HOUR, start_time, end_time)) as hours FROM Tasks WHERE employee_name=? GROUP BY WEEK(start_time)";
            ps = con.prepareStatement(query);
            ps.setString(1, username);

            rs = ps.executeQuery();
            while (rs.next()) {
                labels.add("Week " + rs.getInt("week"));
                data.add(rs.getInt("hours"));
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while fetching weekly data");
            return;
        } finally {
            // Close resources using DBUtil
            DBUtil.closeConnection(con);
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        ChartData chartData = new ChartData(labels, data);
        String json = new Gson().toJson(chartData);
        response.getWriter().write(json);
    }

    private class ChartData {
        @SuppressWarnings("unused")
        List<String> labels;
        @SuppressWarnings("unused")
        List<Integer> data;

        public ChartData(List<String> labels, List<Integer> data) {
            this.labels = labels;
            this.data = data;
        }
    }
}
