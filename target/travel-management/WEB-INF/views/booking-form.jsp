<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book ${destination.name} - Travel Management System</title>
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
            <li class="breadcrumb-item"><a href="destinations">Destinations</a></li>
            <li class="breadcrumb-item"><a href="destinations?action=view&id=${destination.id}">${destination.name}</a></li>
            <li class="breadcrumb-item active" aria-current="page">Book</li>
        </ol>
    </nav>

    <div class="row">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0">Book Your Trip to ${destination.name}</h4>
                </div>
                <div class="card-body">
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger" role="alert">
                                ${errorMessage}
                        </div>
                    </c:if>

                    <form action="bookings" method="post">
                        <input type="hidden" name="action" value="create">
                        <input type="hidden" name="destinationId" value="${destination.id}">

                        <div class="form-group">
                            <label for="bookingType">Booking Type</label>
                            <select class="form-control" id="bookingType" name="bookingType" required>
                                <option value="">Select Booking Type</option>
                                <option value="FLIGHT">Flight</option>
                                <option value="HOTEL">Hotel</option>
                                <option value="TOUR">Tour Package</option>
                            </select>
                        </div>

                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="startDate">Start Date</label>
                                <input type="date" class="form-control" id="startDate" name="startDate" required min="<fmt:formatDate value='${now}' pattern='yyyy-MM-dd' />">
                            </div>
                            <div class="form-group col-md-6">
                                <label for="endDate">End Date</label>
                                <input type="date" class="form-control" id="endDate" name="endDate" required min="<fmt:formatDate value='${now}' pattern='yyyy-MM-dd' />">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="numberOfPeople">Number of People</label>
                            <select class="form-control" id="numberOfPeople" name="numberOfPeople" required>
                                <option value="">Select Number of People</option>
                                <option value="1">1 Person</option>
                                <option value="2">2 People</option>
                                <option value="3">3 People</option>
                                <option value="4">4 People</option>
                                <option value="5">5 People</option>
                                <option value="6">6 People</option>
                                <option value="7">7 People</option>
                                <option value="8">8 People</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="totalPrice">Total Price ($)</label>
                            <input type="number" class="form-control" id="totalPrice" name="totalPrice" step="0.01" min="0" required readonly>
                        </div>

                        <button type="submit" class="btn btn-primary btn-block">Book Now</button>
                    </form>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card mb-4">
                <img src="${destination.imageUrl}" class="card-img-top" alt="${destination.name}">
                <div class="card-body">
                    <h5 class="card-title">${destination.name}</h5>
                    <p class="card-text">${destination.city}, ${destination.country}</p>
                    <div class="d-flex align-items-center mb-2">
                            <span class="text-warning mr-2">
                                <c:forEach begin="1" end="5" varStatus="star">
                                    <c:choose>
                                        <c:when test="${star.index <= destination.rating}">
                                            <i class="fas fa-star"></i>
                                        </c:when>
                                        <c:when test="${star.index <= destination.rating + 0.5}">
                                            <i class="fas fa-star-half-alt"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="far fa-star"></i>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </span>
                        <span>${destination.rating}/5</span>
                    </div>
                </div>
                <ul class="list-group list-group-flush">
                    <li class="list-group-item">
                        <div class="d-flex justify-content-between">
                            <span>Flight</span>
                            <span class="font-weight-bold">$499</span>
                        </div>
                    </li>
                    <li class="list-group-item">
                        <div class="d-flex justify-content-between">
                            <span>Hotel</span>
                            <span class="font-weight-bold">$699</span>
                        </div>
                    </li>
                    <li class="list-group-item">
                        <div class="d-flex justify-content-between">
                            <span>Tour Package</span>
                            <span class="font-weight-bold">$999</span>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp" />

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    // Calculate total price based on booking type and number of people
    document.addEventListener('DOMContentLoaded', function() {
        const bookingTypeSelect = document.getElementById('bookingType');
        const numberOfPeopleSelect = document.getElementById('numberOfPeople');
        const totalPriceInput = document.getElementById('totalPrice');
        const startDateInput = document.getElementById('startDate');
        const endDateInput = document.getElementById('endDate');

        function calculateTotalPrice() {
            const bookingType = bookingTypeSelect.value;
            const numberOfPeople = parseInt(numberOfPeopleSelect.value) || 0;
            const startDate = new Date(startDateInput.value);
            const endDate = new Date(endDateInput.value);

            let basePrice = 0;
            if (bookingType === 'FLIGHT') {
                basePrice = 499;
            } else if (bookingType === 'HOTEL') {
                basePrice = 699;
            } else if (bookingType === 'TOUR') {
                basePrice = 999;
            }

            let totalPrice = basePrice * numberOfPeople;

            // If dates are valid, calculate based on number of days
            if (!isNaN(startDate.getTime()) && !isNaN(endDate.getTime()) && endDate >= startDate) {
                const days = Math.ceil((endDate - startDate) / (1000 * 60 * 60 * 24)) + 1;
                if (bookingType === 'HOTEL' || bookingType  / (1000 * 60 * 60 * 24)) + 1;
                if (bookingType === 'HOTEL' || bookingType === 'TOUR') {
                    totalPrice = basePrice * numberOfPeople * days;
                }
            }

            totalPriceInput.value = totalPrice.toFixed(2);
        }

        bookingTypeSelect.addEventListener('change', calculateTotalPrice);
        numberOfPeopleSelect.addEventListener('change', calculateTotalPrice);
        startDateInput.addEventListener('change', calculateTotalPrice);
        endDateInput.addEventListener('change', calculateTotalPrice);
    });
</script>
</body>
</html>

```jsp file="src/main/webapp/WEB-INF/views/booking-details.jsp"
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
&lt;!DOCTYPE html>
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

<div class="container mt-4">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
            <li class="breadcrumb-item"><a href="bookings">My Bookings</a></li>
            <li class="breadcrumb-item active" aria-current="page">Booking #${booking.id}</li>
        </ol>
    </nav>

    <div class="card mb-4">
        <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
            <h4 class="mb-0">Booking Details</h4>
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
                    <span class="badge badge-secondary">${booking.status}</span>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <h5>Booking Information</h5>
                    <table class="table table-borderless">
                        <tr>
                            <th>Booking ID:</th>
                            <td>${booking.id}</td>
                        </tr>
                        <tr>
                            <th>Booking Date:</th>
                            <td><fmt:formatDate value="${booking.bookingDate}" pattern="MMMM dd, yyyy" /></td>
                        </tr>
                        <tr>
                            <th>Booking Type:</th>
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
                        </tr>
                        <tr>
                            <th>Destination:</th>
                            <td>${booking.destinationName}</td>
                        </tr>
                        <tr>
                            <th>Start Date:</th>
                            <td><fmt:formatDate value="${booking.startDate}" pattern="MMMM dd, yyyy" /></td>
                        </tr>
                        <tr>
                            <th>End Date:</th>
                            <td><fmt:formatDate value="${booking.endDate}" pattern="MMMM dd, yyyy" /></td>
                        </tr>
                        <tr>
                            <th>Number of People:</th>
                            <td>${booking.numberOfPeople}</td>
                        </tr>
                        <tr>
                            <th>Total Price:</th>
                            <td>$<fmt:formatNumber value="${booking.totalPrice}" pattern="#,##0.00" /></td>
                        </tr>
                    </table>
                </div>
                <div class="col-md-6">
                    <h5>Actions</h5>
                    <div class="list-group">
                        <a href="itineraries?bookingId=${booking.id}" class="list-group-item list-group-item-action">
                            <i class="fas fa-calendar-alt mr-2"></i> View Itinerary
                        </a>
                        <c:if test="${booking.status ne 'CANCELLED'}">
                            <a href="bookings?action=cancel&id=${booking.id}" class="list-group-item list-group-item-action text-danger"
                               onclick="return confirm('Are you sure you want to cancel this booking?');">
                                <i class="fas fa-times mr-2"></i> Cancel Booking
                            </a>
                        </c:if>
                        <a href="destinations?action=view&id=${booking.destinationId}" class="list-group-item list-group-item-action">
                            <i class="fas fa-info-circle mr-2"></i> View Destination Details
                        </a>
                    </div>

                    <h5 class="mt-4">Payment Information</h5>
                    <div class="card bg-light">
                        <div class="card-body">
                            <p class="mb-1"><strong>Payment Status:</strong>
                                <c:choose>
                                    <c:when test="${booking.status eq 'CONFIRMED'}">
                                        <span class="text-success">Paid</span>
                                    </c:when>
                                    <c:when test="${booking.status eq 'CANCELLED'}">
                                        <span class="text-danger">Refunded</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-warning">Pending</span>
                                    </c:otherwise>
                                </c:choose>
                            </p>
                            <p class="mb-1"><strong>Payment Method:</strong> Credit Card</p>
                            <p class="mb-0"><strong>Transaction ID:</strong> TXN-${booking.id}${booking.userId}${booking.destinationId}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="card">
        <div class="card-header">
            <h5 class="mb-0">Booking Terms and Conditions</h5>
        </div>
        <div class="card-body">
            <h6>Cancellation Policy</h6>
            <ul>
                <li>Free cancellation up to 7 days before the start date.</li>
                <li>50% refund for cancellations between 3-7 days before the start date.</li>
                <li>No refund for cancellations less than 3 days before the start date.</li>
            </ul>

            <h6>Important Information</h6>
            <p>Please note that all travelers must carry valid identification documents. For international destinations, a valid passport with at least 6 months validity is required.</p>

            <h6>Contact Information</h6>
            <p>For any queries or assistance regarding your booking, please contact our customer support at:</p>
            <p><i class="fas fa-phone mr-2"></i>+1-234-567-8900</p>
            <p><i class="fas fa-envelope mr-2"></i>support@travelmanagement.com</p>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp" />

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
