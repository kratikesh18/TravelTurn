<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
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

<div class="container mt-5">
    <div class="row">
        <div class="col-md-8">
            <div class="card mb-4">
                <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                    <h4 class="mb-0">Itinerary for ${booking.destinationName}</h4>
                    <c:if test="${sessionScope.user.role eq 'admin'}">
                        <a href="itineraries?action=add&bookingId=${booking.id}" class="btn btn-light btn-sm">
                            <i class="fas fa-plus mr-1"></i> Add Activity
                        </a>
                    </c:if>
                </div>
                <div class="card-body">
                    <div class="mb-4">
                        <h5>Trip Summary</h5>
                        <div class="row">
                            <div class="col-md-6">
                                <p><strong>Destination:</strong> ${booking.destinationName}</p>
                                <p><strong>Booking Type:</strong> ${booking.bookingType}</p>
                                <p><strong>Number of People:</strong> ${booking.numberOfPeople}</p>
                            </div>
                            <div class="col-md-6">
                                <p><strong>Start Date:</strong> <fmt:formatDate value="${booking.startDate}" pattern="MMM dd, yyyy" /></p>
                                <p><strong>End Date:</strong> <fmt:formatDate value="${booking.endDate}" pattern="MMM dd, yyyy" /></p>
                                <p><strong>Status:</strong>
                                    <span class="badge ${booking.status eq 'CONFIRMED' ? 'badge-success' : booking.status eq 'CANCELLED' ? 'badge-danger' : 'badge-warning'}">
                                        ${booking.status}
                                    </span>
                                </p>
                            </div>
                        </div>
                    </div>

                    <h5>Daily Itinerary</h5>
                    <c:choose>
                        <c:when test="${not empty itineraries}">
                            <div class="timeline">
                                <c:set var="currentDay" value="" />
                                <c:forEach var="itinerary" items="${itineraries}">
                                    <c:if test="${currentDay ne itinerary.day}">
                                        <c:set var="currentDay" value="${itinerary.day}" />
                                        <div class="day-header mt-4 mb-3">
                                            <h5 class="text-primary">${itinerary.day}</h5>
                                        </div>
                                    </c:if>

                                    <div class="timeline-item">
                                        <div class="card mb-3">
                                            <div class="card-body">
                                                <div class="d-flex justify-content-between align-items-center mb-2">
                                                    <h6 class="timeline-time mb-0">${itinerary.timeSlot}</h6>
                                                    <c:if test="${sessionScope.user.role eq 'admin'}">
                                                        <div class="btn-group btn-group-sm">
                                                            <a href="itineraries?action=edit&id=${itinerary.id}&bookingId=${booking.id}" class="btn btn-outline-primary">
                                                                <i class="fas fa-edit"></i>
                                                            </a>
                                                            <a href="itineraries?action=delete&id=${itinerary.id}&bookingId=${booking.id}"
                                                               class="btn btn-outline-danger"
                                                               onclick="return confirm('Are you sure you want to delete this activity?');">
                                                                <i class="fas fa-trash-alt"></i>
                                                            </a>
                                                        </div>
                                                    </c:if>
                                                </div>
                                                <h6 class="card-title">${itinerary.activity}</h6>
                                                <p class="card-text">${itinerary.description}</p>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="alert alert-info" role="alert">
                                <i class="fas fa-info-circle mr-2"></i> No itinerary has been created for this booking yet.
                                <c:if test="${sessionScope.user.role eq 'admin'}">
                                    <a href="itineraries?action=add&bookingId=${booking.id}" class="alert-link">Add activities</a> to create an itinerary.
                                </c:if>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="text-center mb-4">
                <a href="bookings?action=view&id=${booking.id}" class="btn btn-outline-primary mr-2">
                    <i class="fas fa-arrow-left mr-1"></i> Back to Booking
                </a>
                <button class="btn btn-outline-secondary" onclick="window.print();">
                    <i class="fas fa-print mr-1"></i> Print Itinerary
                </button>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card mb-4">
                <div class="card-header bg-light">
                    <h5 class="mb-0">Destination Information</h5>
                </div>
                <img src="https://via.placeholder.com/400x300?text=${booking.destinationName}" class="card-img-top" alt="${booking.destinationName}">
                <div class="card-body">
                    <h5 class="card-title">${booking.destinationName}</h5>
                    <p class="card-text">Explore the beauty and culture of ${booking.destinationName} with our carefully planned itinerary.</p>
                    <a href="destinations?action=view&id=${booking.destinationId}" class="btn btn-outline-primary btn-block">
                        <i class="fas fa-info-circle mr-1"></i> Destination Details
                    </a>
                </div>
            </div>

            <div class="card mb-4">
                <div class="card-header bg-light">
                    <h5 class="mb-0">Travel Tips</h5>
                </div>
                <div class="card-body">
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item">
                            <i class="fas fa-passport text-primary mr-2"></i> Carry your passport and travel documents
                        </li>
                        <li class="list-group-item">
                            <i class="fas fa-clock text-primary mr-2"></i> Arrive at least 3 hours before international flights
                        </li>
                        <li class="list-group-item">
                            <i class="fas fa-plug text-primary mr-2"></i> Check if you need power adapters
                        </li>
                        <li class="list-group-item">
                            <i class="fas fa-money-bill-wave text-primary mr-2"></i> Carry local currency for small expenses
                        </li>
                        <li class="list-group-item">
                            <i class="fas fa-mobile-alt text-primary mr-2"></i> Download offline maps before your trip
                        </li>
                    </ul>
                </div>
            </div>

            <div class="card">
                <div class="card-header bg-light">
                    <h5 class="mb-0">Weather Forecast</h5>
                </div>
                <div class="card-body">
                    <div class="text-center">
                        <i class="fas fa-cloud-sun fa-3x text-primary mb-3"></i>
                        <h5>Weather information will be available closer to your travel date.</h5>
                        <p class="text-muted">Check back 7 days before your trip for accurate weather forecasts.</p>
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
