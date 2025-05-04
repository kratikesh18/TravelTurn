package com.travel.controller;

import com.travel.dao.UserDAO;
import com.travel.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
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
            case "edit":
                showEditForm(request, response);
                break;
            default:
                viewProfile(request, response);
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
            action = "update";
        }

        switch (action) {
            case "update":
                updateProfile(request, response);
                break;
            case "changePassword":
                changePassword(request, response);
                break;
            default:
                response.sendRedirect("profile");
                break;
        }
    }

    private void viewProfile(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Get fresh user data from database
        UserDAO userDAO = new UserDAO();
        User freshUserData = userDAO.getUserById(user.getId());

        if (freshUserData != null) {
            request.setAttribute("user", freshUserData);
            request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
        } else {
            // If user not found in database (unlikely but possible)
            session.invalidate();
            response.sendRedirect("login");
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        UserDAO userDAO = new UserDAO();
        User freshUserData = userDAO.getUserById(user.getId());

        if (freshUserData != null) {
            request.setAttribute("user", freshUserData);
            request.getRequestDispatcher("/WEB-INF/views/profile-edit.jsp").forward(request, response);
        } else {
            session.invalidate();
            response.sendRedirect("login");
        }
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");

        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserById(currentUser.getId());

        if (user != null) {
            user.setEmail(email);
            user.setFullName(fullName);
            user.setPhone(phone);

            boolean success = userDAO.updateUser(user);

            if (success) {
                // Update session with new user data
                session.setAttribute("user", user);
                request.setAttribute("successMessage", "Profile updated successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to update profile. Please try again.");
            }

            request.setAttribute("user", user);
            request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
        } else {
            session.invalidate();
            response.sendRedirect("login");
        }
    }

    private void changePassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate input
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "New passwords do not match");
            request.getRequestDispatcher("/WEB-INF/views/profile-edit.jsp").forward(request, response);
            return;
        }

        UserDAO userDAO = new UserDAO();
        User user = userDAO.authenticate(currentUser.getUsername(), currentPassword);

        if (user != null) {
            user.setPassword(newPassword);
            boolean success = userDAO.updateUser(user);

            if (success) {
                request.setAttribute("successMessage", "Password changed successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to change password. Please try again.");
            }

            request.setAttribute("user", user);
            request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Current password is incorrect");
            request.setAttribute("user", currentUser);
            request.getRequestDispatcher("/WEB-INF/views/profile-edit.jsp").forward(request, response);
        }
    }
}
