package com.travel.controller;

import com.travel.dao.BookingDAO;
import com.travel.dao.DestinationDAO;
import com.travel.model.Booking;
import com.travel.model.Destination;
import com.travel.model.User;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/bookings")
public class BookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "new":
                showNewBookingForm(request, response);
                break;
            case "view":
                viewBooking(request, response);
                break;
            case "cancel":
                cancelBooking(request, response);
                break;
            default:
                listBookings(request, response);
                break;
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "create";
        }
        
        switch (action) {
            case "create":
                createBooking(request, response);
                break;
            default:
                response.sendRedirect("bookings");
                break;
        }
    }
    
    private void listBookings(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        BookingDAO bookingDAO = new BookingDAO();
        List<Booking> bookings;
        
        if (user.isAdmin()) {
            bookings = bookingDAO.getAllBookings();
        } else {
            bookings = bookingDAO.getBookingsByUserId(user.getId());
        }
        
        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("/WEB-INF/views/bookings.jsp").forward(request, response);
    }
    
    private void showNewBookingForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int destinationId = Integer.parseInt(request.getParameter("destinationId"));
        
        DestinationDAO destinationDAO = new DestinationDAO();
        Destination destination = destinationDAO.getDestinationById(destinationId);
        
        if (destination != null) {
            request.setAttribute("destination", destination);
            request.getRequestDispatcher("/WEB-INF/views/booking-form.jsp").forward(request, response);
        } else {
            response.sendRedirect("destinations");
        }
    }
    
    private void createBooking(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        try {
            int destinationId = Integer.parseInt(request.getParameter("destinationId"));
            String bookingType = request.getParameter("bookingType");
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            int numberOfPeople = Integer.parseInt(request.getParameter("numberOfPeople"));
            double totalPrice = Double.parseDouble(request.getParameter("totalPrice"));
            
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date startDate = dateFormat.parse(startDateStr);
            Date endDate = dateFormat.parse(endDateStr);
            
            Booking booking = new Booking();
            booking.setUserId(user.getId());
            booking.setBookingType(bookingType);
            booking.setDestinationId(destinationId);
            booking.setStartDate(startDate);
            booking.setEndDate(endDate);
            booking.setNumberOfPeople(numberOfPeople);
            booking.setTotalPrice(totalPrice);
            booking.setStatus("PENDING");
            booking.setBookingDate(new Date());
            
            BookingDAO bookingDAO = new BookingDAO();
            boolean success = bookingDAO.createBooking(booking);
            
            if (success) {
                request.setAttribute("successMessage", "Booking created successfully!");
                response.sendRedirect("bookings");
            } else {
                request.setAttribute("errorMessage", "Failed to create booking. Please try again.");
                showNewBookingForm(request, response);
            }
        } catch (ParseException e) {
            request.setAttribute("errorMessage", "Invalid date format. Please use YYYY-MM-DD format.");
            showNewBookingForm(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid number format. Please enter valid numbers.");
            showNewBookingForm(request, response);
        }
    }
    
    private void viewBooking(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        
        BookingDAO bookingDAO = new BookingDAO();
        Booking booking = bookingDAO.getBookingById(id);
        
        if (booking != null) {
            request.setAttribute("booking", booking);
            request.getRequestDispatcher("/WEB-INF/views/booking-details.jsp").forward(request, response);
        } else {
            response.sendRedirect("bookings");
        }
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
