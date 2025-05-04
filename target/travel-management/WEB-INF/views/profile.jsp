<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - Travel Management System</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<jsp:include page="common/header.jsp" />

<div class="container mt-5">
    <div class="row">
        <div class="col-md-3">
            <div class="card mb-4">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">My Account</h5>
                </div>
                <div class="card-body text-center">
                    <div class="mb-3">
                        <img src="https://via.placeholder.com/150" class="rounded-circle img-thumbnail" alt="Profile Picture">
                    </div>
                    <h5>${user.fullName}</h5>
                    <p class="text-muted">${user.username}</p>
                    <p><span class="badge badge-info">${user.role}</span></p>
                </div>
                <div class="list-group list-group-flush">
                    <a href="profile" class="list-group-item list-group-item-action active">
                        <i class="fas fa-user mr-2"></i> My Profile
                    </a>
                    <a href="bookings" class="list-group-item list-group-item-action">
                        <i class="fas fa-calendar-check mr-2"></i> My Bookings
                    </a>
                    <a href="#" class="list-group-item list-group-item-action">
                        <i class="fas fa-heart mr-2"></i> Wishlist
                    </a>
                    <a href="#" class="list-group-item list-group-item-action">
                        <i class="fas fa-credit-card mr-2"></i> Payment Methods
                    </a>
                    <a href="#" class="list-group-item list-group-item-action">
                        <i class="fas fa-bell mr-2"></i> Notifications
                    </a>
                </div>
            </div>
        </div>

        <div class="col-md-9">
            <div class="card mb-4">
                <div class="card-header bg-light d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Personal Information</h5>
                    <a href="profile?action=edit" class="btn btn-sm btn-primary">
                        <i class="fas fa-edit mr-1"></i> Edit Profile
                    </a>
                </div>
                <div class="card-body">
                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success" role="alert">
                                ${successMessage}
                        </div>
                    </c:if>
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger" role="alert">
                                ${errorMessage}
                        </div>
                    </c:if>

                    <div class="row">
                        <div class="col-md-6">
                            <p><strong>Full Name:</strong> ${user.fullName}</p>
                            <p><strong>Username:</strong> ${user.username}</p>
                            <p><strong>Email:</strong> ${user.email}</p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>Phone:</strong> ${user.phone}</p>
                            <p><strong>Role:</strong> ${user.role}</p>
                            <p><strong>Member Since:</strong> January 1, 2023</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card mb-4">
                <div class="card-header bg-light">
                    <h5 class="mb-0">Recent Bookings</h5>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${not empty recentBookings}">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                    <tr>
                                        <th>Booking ID</th>
                                        <th>Destination</th>
                                        <th>Date</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="booking" items="${recentBookings}">
                                        <tr>
                                            <td>${booking.id}</td>
                                            <td>${booking.destinationName}</td>
                                            <td>${booking.startDate} - ${booking.endDate}</td>
                                            <td>
                                                        <span class="badge ${booking.status eq 'CONFIRMED' ? 'badge-success' : booking.status eq 'CANCELLED' ? 'badge-danger' : 'badge-warning'}">
                                                                ${booking.status}
                                                        </span>
                                            </td>
                                            <td>
                                                <a href="bookings?action=view&id=${booking.id}" class="btn btn-sm btn-outline-primary">
                                                    <i class="fas fa-eye"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <div class="text-center mt-3">
                                <a href="bookings" class="btn btn-outline-primary">View All Bookings</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-4">
                                <i class="fas fa-calendar-times fa-3x text-muted mb-3"></i>
                                <p>You don't have any bookings yet.</p>
                                <a href="destinations" class="btn btn-primary">Explore Destinations</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="card">
                <div class="card-header bg-light">
                    <h5 class="mb-0">Account Security</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <h6>Password</h6>
                            <p class="text-muted">Last changed: Never</p>
                            <a href="profile?action=edit#password" class="btn btn-sm btn-outline-primary">
                                <i class="fas fa-key mr-1"></i> Change Password
                            </a>
                        </div>
                        <div class="col-md-6">
                            <h6>Two-Factor Authentication</h6>
                            <p class="text-muted">Status: Not Enabled</p>
                            <a href="#" class="btn btn-sm btn-outline-primary">
                                <i class="fas fa-shield-alt mr-1"></i> Enable 2FA
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp" />

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
