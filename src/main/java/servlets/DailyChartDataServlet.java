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

@WebServlet("/DailyChartDataServlet")
public class DailyChartDataServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String username = (String) request.getSession().getAttribute("username");

        List<String> labels = new ArrayList<>();
        List<Integer> data = new ArrayList<>();

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBUtil.getConnection();

            String query = "SELECT category, SUM(TIMESTAMPDIFF(HOUR, start_time, end_time)) as hours FROM Tasks WHERE employee_name=? GROUP BY category";
            ps = con.prepareStatement(query);
            ps.setString(1, username);

            rs = ps.executeQuery();
            while (rs.next()) {
                labels.add(rs.getString("category"));
                data.add(rs.getInt("hours"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            DBUtil.closeConnection(con);
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
