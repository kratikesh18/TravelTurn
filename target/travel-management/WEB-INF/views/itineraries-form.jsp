<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty itinerary ? 'Add' : 'Edit'} Itinerary - Travel Management System</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<jsp:include page="common/header.jsp" />

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
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
                                <option value="">-- Select Day --</option>
                                <option value="Day 1" ${itinerary.day eq 'Day 1' ? 'selected' : ''}>Day 1</option>
                                <option value="Day 2" ${itinerary.day eq 'Day 2' ? 'selected' : ''}>Day 2</option>
                                <option value="Day 3" ${itinerary.day eq 'Day 3' ? 'selected' : ''}>Day 3</option>
                                <option value="Day 4" ${itinerary.day eq 'Day 4' ? 'selected' : ''}>Day 4</option>
                                <option value="Day 5" ${itinerary.day eq 'Day 5' ? 'selected' : ''}>Day 5</option>
                                <option value="Day 6" ${itinerary.day eq 'Day 6' ? 'selected' : ''}>Day 6</option>
                                <option value="Day 7" ${itinerary.day eq 'Day 7' ? 'selected' : ''}>Day 7</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="timeSlot">Time Slot</label>
                            <input type="text" class="form-control" id="timeSlot" name="timeSlot"
                                   value="${itinerary.timeSlot}" placeholder="e.g. 09:00 - 11:00" required>
                        </div>

                        <div class="form-group">
                            <label for="activity">Activity</label>
                            <input type="text" class="form-control" id="activity" name="activity"
                                   value="${itinerary.activity}" required>
                        </div>

                        <div class="form-group">
                            <label for="description">Description</label>
                            <textarea class="form-control" id="description" name="description" rows="4" required>${itinerary.description}</textarea>
                        </div>

                        <div class="form-group">
                            <label for="activityType">Activity Type</label>
                            <select class="form-control" id="activityType" name="activityType">
                                <option value="SIGHTSEEING">Sightseeing</option>
                                <option value="FOOD">Food & Dining</option>
                                <option value="ADVENTURE">Adventure</option>
                                <option value="CULTURAL">Cultural</option>
                                <option value="RELAXATION">Relaxation</option>
                                <option value="TRANSPORTATION">Transportation</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <div class="custom-control custom-checkbox">
                                <input type="checkbox" class="custom-control-input" id="includedInPackage" name="includedInPackage" checked>
                                <label class="custom-control-label" for="includedInPackage">Included in Package</label>
                            </div>
                        </div>

                        <div class="text-center mt-4">
                            <button type="submit" class="btn btn-primary mr-2">
                                <i class="fas fa-save mr-1"></i> ${empty itinerary ? 'Add' : 'Update'} Activity
                            </button>
                            <a href="itineraries?bookingId=${booking.id}" class="btn btn-outline-secondary">
                                <i class="fas fa-times mr-1"></i> Cancel
                            </a>
                        </div>
                    </form>
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
