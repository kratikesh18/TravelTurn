package com.travel.controller;

import com.travel.dao.BookingDAO;
import com.travel.dao.ItineraryDAO;
import com.travel.model.Booking;
import com.travel.model.Itinerary;
import com.travel.model.User;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/itineraries")
public class ItineraryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "view";
        }

        switch (action) {
            case "add":
                showAddItineraryForm(request, response);
                break;
            case "edit":
                showEditItineraryForm(request, response);
                break;
            case "delete":
                deleteItinerary(request, response);
                break;
            default:
                viewItineraries(request, response);
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
            action = "add";
        }

        switch (action) {
            case "add":
                addItinerary(request, response);
                break;
            case "update":
                updateItinerary(request, response);
                break;
            default:
                response.sendRedirect("itineraries?bookingId=" + request.getParameter("bookingId"));
                break;
        }
    }

    private void viewItineraries(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));

        BookingDAO bookingDAO = new BookingDAO();
        Booking booking = bookingDAO.getBookingById(bookingId);

        if (booking != null) {
            ItineraryDAO itineraryDAO = new ItineraryDAO();
            List<Itinerary> itineraries = itineraryDAO.getItinerariesByBookingId(bookingId);

            request.setAttribute("booking", booking);
            request.setAttribute("itineraries", itineraries);
            request.getRequestDispatcher("/WEB-INF/views/itineraries.jsp").forward(request, response);
        } else {
            response.sendRedirect("bookings");
        }
    }

    private void showAddItineraryForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));

        BookingDAO bookingDAO = new BookingDAO();
        Booking booking = bookingDAO.getBookingById(bookingId);

        if (booking != null) {
            request.setAttribute("booking", booking);
            request.getRequestDispatcher("/WEB-INF/views/itinerary-form.jsp").forward(request, response);
        } else {
            response.sendRedirect("bookings");
        }
    }

    private void addItinerary(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        String day = request.getParameter("day");
        String activity = request.getParameter("activity");
        String description = request.getParameter("description");
        String timeSlot = request.getParameter("timeSlot");

        Itinerary itinerary = new Itinerary();
        itinerary.setBookingId(bookingId);
        itinerary.setDay(day);
        itinerary.setActivity(activity);
        itinerary.setDescription(description);
        itinerary.setTimeSlot(timeSlot);

        ItineraryDAO itineraryDAO = new ItineraryDAO();
        boolean success = itineraryDAO.addItinerary(itinerary);

        if (success) {
            request.setAttribute("successMessage", "Itinerary added successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to add itinerary. Please try again.");
        }

        response.sendRedirect("itineraries?bookingId=" + bookingId);
    }

    private void showEditItineraryForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));

        ItineraryDAO itineraryDAO = new ItineraryDAO();
        List<Itinerary> itineraries = itineraryDAO.getItinerariesByBookingId(bookingId);

        Itinerary itineraryToEdit = null;
        for (Itinerary itinerary : itineraries) {
            if (itinerary.getId() == id) {
                itineraryToEdit = itinerary;
                break;
            }
        }

        if (itineraryToEdit != null) {
            BookingDAO bookingDAO = new BookingDAO();
            Booking booking = bookingDAO.getBookingById(bookingId);

            request.setAttribute("booking", booking);
            request.setAttribute("itinerary", itineraryToEdit);
            request.getRequestDispatcher("/WEB-INF/views/itinerary-form.jsp").forward(request, response);
        } else {
            response.sendRedirect("itineraries?bookingId=" + bookingId);
        }
    }

    private void updateItinerary(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        String day = request.getParameter("day");
        String activity = request.getParameter("activity");
        String description = request.getParameter("description");
        String timeSlot = request.getParameter("timeSlot");

        Itinerary itinerary = new Itinerary();
        itinerary.setId(id);
        itinerary.setBookingId(bookingId);
        itinerary.setDay(day);
        itinerary.setActivity(activity);
        itinerary.setDescription(description);
        itinerary.setTimeSlot(timeSlot);

        ItineraryDAO itineraryDAO = new ItineraryDAO();
        boolean success = itineraryDAO.updateItinerary(itinerary);

        if (success) {
            request.setAttribute("successMessage", "Itinerary updated successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to update itinerary. Please try again.");
        }

        response.sendRedirect("itineraries?bookingId=" + bookingId);
    }

    private void deleteItinerary(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));

        ItineraryDAO itineraryDAO = new ItineraryDAO();
        boolean success = itineraryDAO.deleteItinerary(id);

        if (success) {
            request.setAttribute("successMessage", "Itinerary deleted successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to delete itinerary. Please try again.");
        }

        response.sendRedirect("itineraries?bookingId=" + bookingId);
    }
}
