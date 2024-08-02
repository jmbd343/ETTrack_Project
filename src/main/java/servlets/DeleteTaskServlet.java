package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeleteTaskServlet")
public class DeleteTaskServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        
        // Log the received ID
        System.out.println("DeleteTaskServlet called with id: " + idStr);
        
        if (idStr == null || idStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Task ID is missing");
            return;
        }

        int id = Integer.parseInt(idStr);

        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DBUtil.getConnection();
            
            String query = "DELETE FROM Tasks WHERE task_id=?";
            ps = con.prepareStatement(query);
            ps.setInt(1, id);

            int result = ps.executeUpdate();

            if (result > 0) {
                System.out.println("Task with id " + id + " deleted successfully.");
                response.sendRedirect("viewTasks.jsp");
            } else {
                System.out.println("No task found with id " + id + ".");
                response.sendRedirect("viewTasks.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while deleting the task");
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
