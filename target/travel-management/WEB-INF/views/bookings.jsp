<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings - Travel Management System</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<jsp:include page="common/header.jsp" />

<div class="container mt-4">
    <h2 class="mb-4">My Bookings</h2>

    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${successMessage}
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${errorMessage}
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </c:if>

    <div class="card">
        <div class="card-body">
            <c:choose>
                <c:when test="${not empty bookings}">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead class="thead-light">
                            <tr>
                                <th>Booking ID</th>
                                <th>Destination</th>
                                <th>Type</th>
                                <th>Dates</th>
                                <th>People</th>
                                <th>Total</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="booking" items="${bookings}">
                                <tr>
                                    <td>${booking.id}</td>
                                    <td>${booking.destinationName}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${booking.bookingType eq 'FLIGHT'}">
                                                <span><i class="fas fa-plane-departure mr-1"></i>Flight</span>
                                            </c:when>
                                            <c:when test="${booking.bookingType eq 'HOTEL'}">
                                                <span><i class="fas fa-hotel mr-1"></i>Hotel</span>
                                            </c:when>
                                            <c:when test="${booking.bookingType eq 'TOUR'}">
                                                <span><i class="fas fa-route mr-1"></i>Tour</span>
                                            </c:when>
                                            <c:otherwise>
                                                ${booking.bookingType}
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${booking.startDate}" pattern="MMM dd, yyyy" /> -
                                        <fmt:formatDate value="${booking.endDate}" pattern="MMM dd, yyyy" />
                                    </td>
                                    <td>${booking.numberOfPeople}</td>
                                    <td>$<fmt:formatNumber value="${booking.totalPrice}" pattern="#,##0.00" /></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${booking.status eq 'PENDING'}">
                                                <span class="badge badge-warning">Pending</span>
                                            </c:when>
                                            <c:when test="${booking.status eq 'CONFIRMED'}">
                                                <span class="badge badge-success">Confirmed</span>
                                            </c:when>
                                            <c:when test="${booking.status eq 'CANCELLED'}">
                                                <span class="badge badge-danger">Cancelled</span>
                                            </c:when>
                                            <c:otherwise>
                                                ${booking.status}
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="btn-group btn-group-sm">
                                            <a href="bookings?action=view&id=${booking.id}" class="btn btn-info" title="View Details">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            <a href="itineraries?bookingId=${booking.id}" class="btn btn-primary" title="View Itinerary">
                                                <i class="fas fa-calendar-alt"></i>
                                            </a>
                                            <c:if test="${booking.status ne 'CANCELLED'}">
                                                <a href="bookings?action=cancel&id=${booking.id}" class="btn btn-danger" title="Cancel Booking"
                                                   onclick="return confirm('Are you sure you want to cancel this booking?');">
                                                    <i class="fas fa-times"></i>
                                                </a>
                                            </c:if>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-5">
                        <i class="fas fa-suitcase-rolling fa-4x text-muted mb-3"></i>
                        <h4>No Bookings Found</h4>
                        <p>You haven't made any bookings yet.</p>
                        <a href="destinations" class="btn btn-primary">Explore Destinations</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp" />

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
