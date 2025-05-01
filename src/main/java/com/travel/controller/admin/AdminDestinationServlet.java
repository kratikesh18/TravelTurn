package com.travel.controller.admin;

import com.travel.dao.DestinationDAO;
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

@WebServlet("/admin/destinations")
public class AdminDestinationServlet extends HttpServlet {
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
            case "new":
                showNewForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteDestination(request, response);
                break;
            default:
                listDestinations(request, response);
                break;
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
            action = "create";
        }
        
        switch (action) {
            case "create":
                createDestination(request, response);
                break;
            case "update":
                updateDestination(request, response);
                break;
            default:
                response.sendRedirect("destinations");
                break;
        }
    }
    
    private void listDestinations(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DestinationDAO destinationDAO = new DestinationDAO();
        List<Destination> destinations = destinationDAO.getAllDestinations();
        
        request.setAttribute("destinations", destinations);
        request.getRequestDispatcher("/WEB-INF/views/admin/destinations.jsp").forward(request, response);
    }
    
    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/admin/destination-form.jsp").forward(request, response);
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        
        DestinationDAO destinationDAO = new DestinationDAO();
        Destination destination = destinationDAO.getDestinationById(id);
        
        if (destination != null) {
            request.setAttribute("destination", destination);
            request.getRequestDispatcher("/WEB-INF/views/admin/destination-form.jsp").forward(request, response);
        } else {
            response.sendRedirect("destinations");
        }
    }
    
    private void createDestination(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String country = request.getParameter("country");
        String city = request.getParameter("city");
        String imageUrl = request.getParameter("imageUrl");
        double rating = Double.parseDouble(request.getParameter("rating"));
        boolean featured = request.getParameter("featured") != null;
        
        Destination destination = new Destination();
        destination.setName(name);
        destination.setDescription(description);
        destination.setCountry(country);
        destination.setCity(city);
        destination.setImageUrl(imageUrl);
        destination.setRating(rating);
        destination.setFeatured(featured);
        
        DestinationDAO destinationDAO = new DestinationDAO();
        boolean success = destinationDAO.addDestination(destination);
        
        if (success) {
            request.setAttribute("successMessage", "Destination added successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to add destination. Please try again.");
        }
        
        response.sendRedirect("destinations");
    }
    
    private void updateDestination(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String country = request.getParameter("country");
        String city = request.getParameter("city");
        String imageUrl = request.getParameter("imageUrl");
        double rating = Double.parseDouble(request.getParameter("rating"));
        boolean featured = request.getParameter("featured") != null;
        
        Destination destination = new Destination();
        destination.setId(id);
        destination.setName(name);
        destination.setDescription(description);
        destination.setCountry(country);
        destination.setCity(city);
        destination.setImageUrl(imageUrl);
        destination.setRating(rating);
        destination.setFeatured(featured);
        
        DestinationDAO destinationDAO = new DestinationDAO();
        boolean success = destinationDAO.updateDestination(destination);
        
        if (success) {
            request.setAttribute("successMessage", "Destination updated successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to update destination. Please try again.");
        }
        
        response.sendRedirect("destinations");
    }
    
    private void deleteDestination(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        
        DestinationDAO destinationDAO = new DestinationDAO();
        boolean success = destinationDAO.deleteDestination(id);
        
        if (success) {
            request.setAttribute("successMessage", "Destination deleted successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to delete destination. Please try again.");
        }
        
        response.sendRedirect("destinations");
    }
}
