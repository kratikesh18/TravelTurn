package com.travel.controller.admin;

import com.travel.dao.BookingDAO;
import com.travel.model.Booking;
import com.travel.model.User;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/admin/bookings")
public class AdminBookingServlet extends HttpServlet {
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
        
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "view":
                viewBooking(request, response);
                break;
            case "confirm":
                confirmBooking(request, response);
                break;
            case "cancel":
                cancelBooking(request, response);
                break;
            default:
                listBookings(request, response);
                break;
        }
    }
    
    private void listBookings(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BookingDAO bookingDAO = new BookingDAO();
        List<Booking> bookings = bookingDAO.getAllBookings();
        
        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("/WEB-INF/views/admin/bookings.jsp").forward(request, response);
    }
    
    private void viewBooking(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        
        BookingDAO bookingDAO = new BookingDAO();
        Booking booking = bookingDAO.getBookingById(id);
        
        if (booking != null) {
            request.setAttribute("booking", booking);
            request.getRequestDispatcher("/WEB-INF/views/admin/booking-details.jsp").forward(request, response);
        } else {
            response.sendRedirect("bookings");
        }
    }
    
    private void confirmBooking(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        
        BookingDAO bookingDAO = new BookingDAO();
        boolean success = bookingDAO.updateBookingStatus(id, "CONFIRMED");
        
        if (success) {
            request.setAttribute("successMessage", "Booking confirmed successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to confirm booking. Please try again.");
        }
        
        response.sendRedirect("bookings");
    }
    
    private void cancelBooking(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        
        BookingDAO bookingDAO = new BookingDAO();
        boolean success = bookingDAO.updateBookingStatus(id, "CANCELLED");
        
        if (success) {
            request.setAttribute("successMessage", "Booking cancelled successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to cancel booking. Please try again.");
        }
        
        response.sendRedirect("bookings");
    }
}
