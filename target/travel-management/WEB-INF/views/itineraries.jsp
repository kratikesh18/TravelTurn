<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
&lt;!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Itinerary - Travel Management System</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<jsp:include page="common/header.jsp" />

<div class="container mt-4">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
            <li class="breadcrumb-item"><a href="bookings">My Bookings</a></li>
            <li class="breadcrumb-item"><a href="bookings?action=view&id=${booking.id}">Booking #${booking.id}</a></li>
            <li class="breadcrumb-item active" aria-current="page">Itinerary</li>
        </ol>
    </nav>

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

    <div class="card mb-4">
        <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
            <h4 class="mb-0">Itinerary for ${booking.destinationName}</h4>
            <span class="badge badge-light">
                    <fmt:formatDate value="${booking.startDate}" pattern="MMM dd" /> -
                    <fmt:formatDate value="${booking.endDate}" pattern="MMM dd, yyyy" />
                </span>
        </div>
        <div class="card-body">
            <div class="d-flex justify-content-between mb-4">
                <h5>
                    <c:choose>
                        <c:when test="${booking.bookingType eq 'FLIGHT'}">
                            <i class="fas fa-plane-departure mr-2"></i>Flight Itinerary
                        </c:when>
                        <c:when test="${booking.bookingType eq 'HOTEL'}">
                            <i class="fas fa-hotel mr-2"></i>Hotel Stay Itinerary
                        </c:when>
                        <c:when test="${booking.bookingType eq 'TOUR'}">
                            <i class="fas fa-route mr-2"></i>Tour Itinerary
                        </c:when>
                        <c:otherwise>
                            <i class="fas fa-calendar-alt mr-2"></i>${booking.bookingType} Itinerary
                        </c:otherwise>
                    </c:choose>
                </h5>
                <c:if test="${sessionScope.user.role eq 'admin' || booking.userId eq sessionScope.user.id}">
                    <a href="itineraries?action=add&bookingId=${booking.id}" class="btn btn-sm btn-primary">
                        <i class="fas fa-plus mr-1"></i> Add Activity
                    </a>
                </c:if>
            </div>

            <c:choose>
                <c:when test="${not empty itineraries}">
                    <div class="timeline">
                        <c:set var="currentDay" value="" />
                        <c:forEach var="itinerary" items="${itineraries}">
                            <c:if test="${currentDay ne itinerary.day}">
                                <c:set var="currentDay" value="${itinerary.day}" />
                                <div class="timeline-day mb-3">
                                    <h5 class="bg-light p-2 rounded">${itinerary.day}</h5>
                                </div>
                            </c:if>
                            <div class="timeline-item">
                                <div class="card mb-3">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-center mb-2">
                                            <h6 class="card-title mb-0">${itinerary.activity}</h6>
                                            <span class="timeline-time badge badge-primary">${itinerary.timeSlot}</span>
                                        </div>
                                        <p class="card-text">${itinerary.description}</p>
                                        <c:if test="${sessionScope.user.role eq 'admin' || booking.userId eq sessionScope.user.id}">
                                            <div class="btn-group btn-group-sm">
                                                <a href="itineraries?action=edit&id=${itinerary.id}&bookingId=${booking.id}" class="btn btn-outline-primary">
                                                    <i class="fas fa-edit"></i> Edit
                                                </a>
                                                <a href="itineraries?action=delete&id=${itinerary.id}&bookingId=${booking.id}" class="btn btn-outline-danger"
                                                   onclick="return confirm('Are you sure you want to delete this activity?');">
                                                    <i class="fas fa-trash-alt"></i> Delete
                                                </a>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-5">
                        <i class="fas fa-calendar-times fa-4x text-muted mb-3"></i>
                        <h5>No Itinerary Available</h5>
                        <p>There are no activities planned for this booking yet.</p>
                        <c:if test="${sessionScope.user.role eq 'admin' || booking.userId eq sessionScope.user.id}">
                            <a href="itineraries?action=add&bookingId=${booking.id}" class="btn btn-primary">
                                <i class="fas fa-plus mr-1"></i> Add First Activity
                            </a>
                        </c:if>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="card">
        <div class="card-header">
            <h5 class="mb-0">Booking Summary</h5>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <table class="table table-borderless">
                        <tr>
                            <th>Booking ID:</th>
                            <td>${booking.id}</td>
                        </tr>
                        <tr>
                            <th>Destination:</th>
                            <td>${booking.destinationName}</td>
                        </tr>
                        <tr>
                            <th>Dates:</th>
                            <td>
                                <fmt:formatDate value="${booking.startDate}" pattern="MMMM dd, yyyy" /> -
                                <fmt:formatDate value="${booking.endDate}" pattern="MMMM dd, yyyy" />
                            </td>
                        </tr>
                        <tr>
                            <th>Number of People:</th>
                            <td>${booking.numberOfPeople}</td>
                        </tr>
                    </table>
                </div>
                <div class="col-md-6">
                    <div class="alert alert-info">
                        <h6 class="alert-heading">Important Information</h6>
                        <p class="mb-0">This itinerary is subject to change based on weather conditions and local circumstances. Please check for updates before each activity.</p>
                    </div>
                    <div class="d-flex justify-content-between mt-3">
                        <a href="bookings?action=view&id=${booking.id}" class="btn btn-outline-primary">
                            <i class="fas fa-arrow-left mr-1"></i> Back to Booking
                        </a>
                        <button class="btn btn-success" onclick="window.print()">
                            <i class="fas fa-print mr-1"></i> Print Itinerary
                        </button>
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
