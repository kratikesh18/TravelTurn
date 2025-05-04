<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Details - Travel Management System</title>
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
                    <h4 class="mb-0">Booking #${booking.id}</h4>
                    <span class="badge ${booking.status eq 'CONFIRMED' ? 'badge-success' : booking.status eq 'CANCELLED' ? 'badge-danger' : 'badge-warning'}">
                        ${booking.status}
                    </span>
                </div>
                <div class="card-body">
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <h5>Booking Information</h5>
                            <p><strong>Booking Type:</strong> ${booking.bookingType}</p>
                            <p><strong>Destination:</strong> ${booking.destinationName}</p>
                            <p><strong>Start Date:</strong> <fmt:formatDate value="${booking.startDate}" pattern="MMM dd, yyyy" /></p>
                            <p><strong>End Date:</strong> <fmt:formatDate value="${booking.endDate}" pattern="MMM dd, yyyy" /></p>
                            <p><strong>Number of People:</strong> ${booking.numberOfPeople}</p>
                            <p><strong>Total Price:</strong> $<fmt:formatNumber value="${booking.totalPrice}" pattern="#,##0.00" /></p>
                            <p><strong>Booking Date:</strong> <fmt:formatDate value="${booking.bookingDate}" pattern="MMM dd, yyyy" /></p>
                        </div>
                        <div class="col-md-6">
                            <h5>Payment Information</h5>
                            <p><strong>Payment Status:</strong> <span class="badge badge-success">Paid</span></p>
                            <p><strong>Payment Method:</strong> Credit Card</p>
                            <p><strong>Transaction ID:</strong> TXN-${booking.id}${booking.userId}${booking.destinationId}</p>
                            <p><strong>Payment Date:</strong> <fmt:formatDate value="${booking.bookingDate}" pattern="MMM dd, yyyy" /></p>
                        </div>
                    </div>

                    <div class="mb-4">
                        <h5>Booking Actions</h5>
                        <div class="btn-group">
                            <a href="itineraries?bookingId=${booking.id}" class="btn btn-outline-primary">
                                <i class="fas fa-calendar-alt mr-1"></i> View Itinerary
                            </a>
                            <c:if test="${booking.status eq 'PENDING'}">
                                <a href="bookings?action=cancel&id=${booking.id}" class="btn btn-outline-danger"
                                   onclick="return confirm('Are you sure you want to cancel this booking?');">
                                    <i class="fas fa-times-circle mr-1"></i> Cancel Booking
                                </a>
                            </c:if>
                            <a href="#" class="btn btn-outline-secondary" onclick="window.print();">
                                <i class="fas fa-print mr-1"></i> Print Details
                            </a>
                        </div>
                    </div>

                    <c:if test="${sessionScope.user.role eq 'admin'}">
                        <div class="mb-4">
                            <h5>Admin Actions</h5>
                            <div class="btn-group">
                                <c:if test="${booking.status eq 'PENDING'}">
                                    <a href="admin/bookings?action=confirm&id=${booking.id}" class="btn btn-success">
                                        <i class="fas fa-check-circle mr-1"></i> Confirm Booking
                                    </a>
                                </c:if>
                                <c:if test="${booking.status ne 'CANCELLED'}">
                                    <a href="admin/bookings?action=cancel&id=${booking.id}" class="btn btn-danger"
                                       onclick="return confirm('Are you sure you want to cancel this booking?');">
                                        <i class="fas fa-times-circle mr-1"></i> Cancel Booking
                                    </a>
                                </c:if>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>

            <div class="card mb-4">
                <div class="card-header bg-light">
                    <h5 class="mb-0">Customer Feedback</h5>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${booking.status eq 'CONFIRMED' && booking.endDate lt now}">
                            <form action="reviews" method="post">
                                <input type="hidden" name="bookingId" value="${booking.id}">
                                <div class="form-group">
                                    <label for="rating">Rating</label>
                                    <select class="form-control" id="rating" name="rating" required>
                                        <option value="5">5 - Excellent</option>
                                        <option value="4">4 - Very Good</option>
                                        <option value="3">3 - Good</option>
                                        <option value="2">2 - Fair</option>
                                        <option value="1">1 - Poor</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="comment">Your Review</label>
                                    <textarea class="form-control" id="comment" name="comment" rows="3" required></textarea>
                                </div>
                                <button type="submit" class="btn btn-primary">Submit Review</button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <p class="text-muted">You can submit a review after your trip is completed.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card mb-4">
                <div class="card-header bg-light">
                    <h5 class="mb-0">Destination Information</h5>
                </div>
                <img src="${destination.imageUrl}" class="card-img-top" alt="${destination.name}">
                <div class="card-body">
                    <h5 class="card-title">${destination.name}</h5>
                    <p class="card-text">${destination.city}, ${destination.country}</p>
                    <div class="mb-2">
                            <span class="text-warning">
                                <c:forEach begin="1" end="5" varStatus="star">
                                    <i class="fas fa-star${star.index <= destination.rating ? '' : '-half-alt'}"></i>
                                </c:forEach>
                            </span>
                        <small class="text-muted ml-1">${destination.rating}/5</small>
                    </div>
                    <p class="card-text">${destination.description}</p>
                </div>
            </div>

            <div class="card">
                <div class="card-header bg-light">
                    <h5 class="mb-0">Need Help?</h5>
                </div>
                <div class="card-body">
                    <p>If you have any questions or need assistance with your booking, please contact our customer support team.</p>
                    <p><i class="fas fa-phone mr-2"></i> (123) 456-7890</p>
                    <p><i class="fas fa-envelope mr-2"></i> support@travelmanagement.com</p>
                    <a href="#" class="btn btn-outline-primary btn-block">
                        <i class="fas fa-comment-dots mr-1"></i> Live Chat
                    </a>
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
