<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
&lt;!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty itinerary ? 'Add' : 'Edit'} Itinerary Activity - Travel Management System</title>
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
            <li class="breadcrumb-item"><a href="itineraries?bookingId=${booking.id}">Itinerary</a></li>
            <li class="breadcrumb-item active" aria-current="page">${empty itinerary ? 'Add' : 'Edit'} Activity</li>
        </ol>
    </nav>

    <div class="card">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">${empty itinerary ? 'Add New' : 'Edit'} Itinerary Activity</h4>
        </div>
        <div class="card-body">
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger" role="alert">
                        ${errorMessage}
                </div>
            </c:if>

            <form action="itineraries" method="post">
                <input type="hidden" name="action" value="${empty itinerary ? 'add' : 'update'}">
                <input type="hidden" name="bookingId" value="${booking.id}">
                <c:if test="${not empty itinerary}">
                    <input type="hidden" name="id" value="${itinerary.id}">
                </c:if>

                <div class="form-group">
                    <label for="day">Day</label>
                    <select class="form-control" id="day" name="day" required>
                        <option value="">Select Day</option>
                        <c:forEach var="i" begin="1" end="15">
                            <option value="Day ${i}" ${not empty itinerary && itinerary.day eq 'Day '.concat(i) ? 'selected' : ''}>Day ${i}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label for="timeSlot">Time Slot</label>
                    <input type="text" class="form-control" id="timeSlot" name="timeSlot"
                           placeholder="e.g., 09:00 - 12:00" value="${itinerary.timeSlot}" required>
                </div>

                <div class="form-group">
                    <label for="activity">Activity</label>
                    <input type="text" class="form-control" id="activity" name="activity"
                           placeholder="e.g., City Tour, Museum Visit" value="${itinerary.activity}" required>
                </div>

                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea class="form-control" id="description" name="description" rows="4"
                              placeholder="Describe the activity in detail" required>${itinerary.description}</textarea>
                </div>

                <div class="form-group text-right">
                    <a href="itineraries?bookingId=${booking.id}" class="btn btn-secondary mr-2">Cancel</a>
                    <button type="submit" class="btn btn-primary">${empty itinerary ? 'Add' : 'Update'} Activity</button>
                </div>
            </form>
        </div>
    </div>

    <div class="card mt-4">
        <div class="card-header">
            <h5 class="mb-0">Booking Information</h5>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <p><strong>Destination:</strong> ${booking.destinationName}</p>
                    <p><strong>Booking Type:</strong> ${booking.bookingType}</p>
                </div>
                <div class="col-md-6">
                    <p><strong>Start Date:</strong> <fmt:formatDate value="${booking.startDate}" pattern="MMMM dd, yyyy" /></p>
                    <p><strong>End Date:</strong> <fmt:formatDate value="${booking.endDate}" pattern="MMMM dd, yyyy" /></p>
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
