package com.travel.controller;

import com.travel.dao.DestinationDAO;
import com.travel.model.Destination;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/destinations")
public class DestinationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "view":
                viewDestination(request, response);
                break;
            case "search":
                searchDestinations(request, response);
                break;
            default:
                listDestinations(request, response);
                break;
        }
    }
    
    private void listDestinations(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DestinationDAO destinationDAO = new DestinationDAO();
        List<Destination> destinations = destinationDAO.getAllDestinations();
        
        request.setAttribute("destinations", destinations);
        request.getRequestDispatcher("/WEB-INF/views/destinations.jsp").forward(request, response);
    }
    
    private void viewDestination(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        
        DestinationDAO destinationDAO = new DestinationDAO();
        Destination destination = destinationDAO.getDestinationById(id);
        
        if (destination != null) {
            request.setAttribute("destination", destination);
            request.getRequestDispatcher("/WEB-INF/views/destination-details.jsp").forward(request, response);
        } else {
            response.sendRedirect("destinations");
        }
    }
    
    private void searchDestinations(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        
        DestinationDAO destinationDAO = new DestinationDAO();
        List<Destination> destinations = destinationDAO.searchDestinations(keyword);
        
        request.setAttribute("destinations", destinations);
        request.setAttribute("keyword", keyword);
        request.getRequestDispatcher("/WEB-INF/views/destinations.jsp").forward(request, response);
    }
}
