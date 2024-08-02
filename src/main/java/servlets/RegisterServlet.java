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

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        // Validate input fields
        if (username == null || username.isEmpty() || password == null || password.isEmpty() || role == null || role.isEmpty()) {
            response.sendRedirect("register.jsp?error=Missing+fields");
            return;
        }

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBUtil.getConnection();

            // Check if username already exists
            PreparedStatement checkUserPs = con.prepareStatement("SELECT COUNT(*) FROM Users WHERE username = ?");
            checkUserPs.setString(1, username);
            rs = checkUserPs.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                response.sendRedirect("register.jsp?error=Username+already+exists");
                return;
            }

            // Insert new user
            ps = con.prepareStatement("INSERT INTO Users (username, password, role) VALUES (?, ?, ?)");
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, role);

            int result = ps.executeUpdate();
            
            if (result > 0) {
                response.sendRedirect("login.jsp");
            } else {
                response.sendRedirect("register.jsp?error=Registration+failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=Internal+server+error");
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
    }
}
