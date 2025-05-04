<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmation - Travel Management System</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<jsp:include page="common/header.jsp" />

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card border-success mb-4">
                <div class="card-header bg-success text-white">
                    <h4 class="mb-0"><i class="fas fa-check-circle mr-2"></i>Booking Confirmed!</h4>
                </div>
                <div class="card-body">
                    <div class="text-center mb-4">
                        <i class="fas fa-check-circle text-success" style="font-size: 5rem;"></i>
                        <h2 class="mt-3">Thank You for Your Booking</h2>
                        <p class="lead">Your booking has been successfully processed.</p>
                        <p>Booking Reference: <strong>BK-${booking.id}${booking.userId}</strong></p>
                    </div>

                    <div class="row mb-4">
                        <div class="col-md-6">
                            <h5>Booking Details</h5>
                            <p><strong>Destination:</strong> ${booking.destinationName}</p>
                            <p><strong>Booking Type:</strong> ${booking.bookingType}</p>
                            <p><strong>Start Date:</strong> <fmt:formatDate value="${booking.startDate}" pattern="MMM dd, yyyy" /></p>
                            <p><strong>End Date:</strong> <fmt:formatDate value="${booking.endDate}" pattern="MMM dd, yyyy" /></p>
                            <p><strong>Number of People:</strong> ${booking.numberOfPeople}</p>
                        </div>
                        <div class="col-md-6">
                            <h5>Payment Information</h5>
                            <p><strong>Total Amount:</strong> $<fmt:formatNumber value="${booking.totalPrice}" pattern="#,##0.00" /></p>
                            <p><strong>Payment Method:</strong> Credit Card</p>
                            <p><strong>Payment Status:</strong> <span class="badge badge-success">Paid</span></p>
                            <p><strong>Transaction ID:</strong> TXN-${booking.id}${booking.userId}${booking.destinationId}</p>
                        </div>
                    </div>

                    <div class="alert alert-info" role="alert">
                        <h5><i class="fas fa-info-circle mr-2"></i>What's Next?</h5>
                        <p class="mb-0">A confirmation email has been sent to your registered email address with all the details of your booking. Our team will review your booking and send you an itinerary within 24 hours.</p>
                    </div>

                    <div class="text-center mt-4">
                        <a href="bookings?action=view&id=${booking.id}" class="btn btn-primary mr-2">
                            <i class="fas fa-eye mr-1"></i> View Booking Details
                        </a>
                        <a href="bookings" class="btn btn-outline-secondary">
                            <i class="fas fa-list mr-1"></i> My Bookings
                        </a>
                    </div>
                </div>
            </div>

            <div class="card mb-4">
                <div class="card-header bg-light">
                    <h5 class="mb-0">Recommended Add-ons</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <div class="card h-100">
                                <div class="card-body text-center">
                                    <i class="fas fa-car fa-2x text-primary mb-2"></i>
                                    <h5>Car Rental</h5>
                                    <p class="small">Explore at your own pace</p>
                                    <a href="#" class="btn btn-sm btn-outline-primary">Add Now</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4 mb-3">
                            <div class="card h-100">
                                <div class="card-body text-center">
                                    <i class="fas fa-utensils fa-2x text-primary mb-2"></i>
                                    <h5>Meal Package</h5>
                                    <p class="small">All-inclusive dining options</p>
                                    <a href="#" class="btn btn-sm btn-outline-primary">Add Now</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4 mb-3">
                            <div class="card h-100">
                                <div class="card-body text-center">
                                    <i class="fas fa-umbrella-beach fa-2x text-primary mb-2"></i>
                                    <h5>Activities</h5>
                                    <p class="small">Exciting local experiences</p>
                                    <a href="#" class="btn btn-sm btn-outline-primary">Add Now</a>
                                </div>
                            </div>
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
