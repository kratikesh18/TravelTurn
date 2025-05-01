package com.travel.controller.admin;

import com.travel.dao.BookingDAO;
import com.travel.dao.DestinationDAO;
import com.travel.dao.UserDAO;
import com.travel.model.Booking;
import com.travel.model.Destination;
import com.travel.model.User;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
        
        // Get counts for dashboard
        UserDAO userDAO = new UserDAO();
        List<User> users = userDAO.getAllUsers();
        
        DestinationDAO destinationDAO = new DestinationDAO();
        List<Destination> destinations = destinationDAO.getAllDestinations();
        
        BookingDAO bookingDAO = new BookingDAO();
        List<Booking> bookings = bookingDAO.getAllBookings();
        
        // Count bookings by status
        int pendingBookings = 0;
        int confirmedBookings = 0;
        int cancelledBookings = 0;
        
        for (Booking booking : bookings) {
            switch (booking.getStatus()) {
                case "PENDING":
                    pendingBookings++;
                    break;
                case "CONFIRMED":
                    confirmedBookings++;
                    break;
                case "CANCELLED":
                    cancelledBookings++;
                    break;
            }
        }
        
        request.setAttribute("userCount", users.size());
        request.setAttribute("destinationCount", destinations.size());
        request.setAttribute("bookingCount", bookings.size());
        request.setAttribute("pendingBookings", pendingBookings);
        request.setAttribute("confirmedBookings", confirmedBookings);
        request.setAttribute("cancelledBookings", cancelledBookings);
        request.setAttribute("recentBookings", bookings.size() > 5 ? bookings.subList(0, 5) : bookings);
        
        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
    }
}
