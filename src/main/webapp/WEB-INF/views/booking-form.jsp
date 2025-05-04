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

<div class="container mt-5">
    <div class="row">
        <div class="col-md-8">
            <div class="card mb-4">
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
                                <option value="">-- Select Booking Type --</option>
                                <option value="FLIGHT">Flight</option>
                                <option value="HOTEL">Hotel</option>
                                <option value="TOUR">Tour Package</option>
                            </select>
                        </div>

                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="startDate">Start Date</label>
                                <input type="date" class="form-control" id="startDate" name="startDate" required min="${java.time.LocalDate.now()}">
                            </div>
                            <div class="form-group col-md-6">
                                <label for="endDate">End Date</label>
                                <input type="date" class="form-control" id="endDate" name="endDate" required min="${java.time.LocalDate.now()}">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="numberOfPeople">Number of People</label>
                            <input type="number" class="form-control" id="numberOfPeople" name="numberOfPeople" min="1" value="1" required>
                        </div>

                        <div class="form-group">
                            <label for="totalPrice">Total Price ($)</label>
                            <input type="number" class="form-control" id="totalPrice" name="totalPrice" step="0.01" min="0" required>
                            <small class="form-text text-muted">Price will be calculated based on your selections.</small>
                        </div>

                        <div class="form-group">
                            <label>Additional Requirements</label>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="airportPickup" name="requirements" value="airportPickup">
                                <label class="form-check-label" for="airportPickup">Airport Pickup</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="breakfast" name="requirements" value="breakfast">
                                <label class="form-check-label" for="breakfast">Breakfast Included</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="tourGuide" name="requirements" value="tourGuide">
                                <label class="form-check-label" for="tourGuide">Tour Guide</label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="specialRequests">Special Requests</label>
                            <textarea class="form-control" id="specialRequests" name="specialRequests" rows="3"></textarea>
                        </div>

                        <button type="submit" class="btn btn-primary btn-lg btn-block">Book Now</button>
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
                    <h5 class="mb-0">Price Calculator</h5>
                </div>
                <div class="card-body">
                    <div class="form-group">
                        <label for="calculatorBookingType">Booking Type</label>
                        <select class="form-control" id="calculatorBookingType">
                            <option value="FLIGHT">Flight</option>
                            <option value="HOTEL">Hotel</option>
                            <option value="TOUR">Tour Package</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="calculatorDays">Number of Days</label>
                        <input type="number" class="form-control" id="calculatorDays" min="1" value="1">
                    </div>
                    <div class="form-group">
                        <label for="calculatorPeople">Number of People</label>
                        <input type="number" class="form-control" id="calculatorPeople" min="1" value="1">
                    </div>
                    <button type="button" class="btn btn-outline-primary btn-block" id="calculateBtn">Calculate Price</button>
                    <div class="mt-3 text-center">
                        <h4>Estimated Price: <span id="estimatedPrice">$0.00</span></h4>
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
<script>
    // Date validation
    document.getElementById('startDate').addEventListener('change', function() {
        document.getElementById('endDate').min = this.value;
    });

    // Price calculator
    document.getElementById('calculateBtn').addEventListener('click', function() {
        const bookingType = document.getElementById('calculatorBookingType').value;
        const days = parseInt(document.getElementById('calculatorDays').value);
        const people = parseInt(document.getElementById('calculatorPeople').value);

        let basePrice = 0;
        switch(bookingType) {
            case 'FLIGHT':
                basePrice = 300;
                break;
            case 'HOTEL':
                basePrice = 150;
                break;
            case 'TOUR':
                basePrice = 500;
                break;
        }

        const totalPrice = basePrice * days * people;
        document.getElementById('estimatedPrice').textContent = '$' + totalPrice.toFixed(2);
        document.getElementById('totalPrice').value = totalPrice.toFixed(2);
    });

    // Copy values from calculator to form
    document.getElementById('calculatorBookingType').addEventListener('change', function() {
        document.getElementById('bookingType').value = this.value;
    });

    document.getElementById('calculatorPeople').addEventListener('change', function() {
        document.getElementById('numberOfPeople').value = this.value;
    });
</script>
</body>
</html>
