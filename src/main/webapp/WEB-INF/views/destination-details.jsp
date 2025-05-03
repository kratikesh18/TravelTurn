<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${destination.name} - Travel Management System</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<jsp:include page="common/header.jsp" />

<div class="container mt-4">
    <div class="row">
        <div class="col-md-8">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
                    <li class="breadcrumb-item"><a href="destinations">Destinations</a></li>
                    <li class="breadcrumb-item active" aria-current="page">${destination.name}</li>
                </ol>
            </nav>

            <div class="card mb-4">
                <img src="${destination.imageUrl}" class="card-img-top" alt="${destination.name}">
                <div class="card-body">
                    <h2 class="card-title">${destination.name}</h2>
                    <div class="d-flex align-items-center mb-3">
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
                        <span class="mx-2">|</span>
                        <span><i class="fas fa-map-marker-alt mr-1"></i>${destination.city}, ${destination.country}</span>
                    </div>
                    <p class="card-text">${destination.description}</p>
                </div>
            </div>

            <div class="card mb-4">
                <div class="card-header">
                    <h4>About ${destination.name}</h4>
                </div>
                <div class="card-body">
                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla quam velit, vulputate eu pharetra nec, mattis ac neque. Duis vulputate commodo lectus, ac blandit elit tincidunt id. Sed rhoncus, tortor sed eleifend tristique, tortor mauris molestie elit, et lacinia ipsum quam nec dui.</p>
                    <p>Donec pretium posuere tellus. Proin quam nisl, tincidunt et, mattis eget, convallis nec, purus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.</p>
                    <h5>Highlights</h5>
                    <ul>
                        <li>Beautiful scenery and landscapes</li>
                        <li>Rich cultural heritage and history</li>
                        <li>Delicious local cuisine</li>
                        <li>Friendly locals and vibrant atmosphere</li>
                        <li>Various activities and attractions</li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card mb-4">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0">Book Your Trip</h4>
                </div>
                <div class="card-body">
                    <p class="card-text">Ready to explore ${destination.name}? Book your trip now!</p>
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <a href="bookings?action=new&destinationId=${destination.id}" class="btn btn-primary btn-block">Book Now</a>
                        </c:when>
                        <c:otherwise>
                            <div class="alert alert-info">
                                Please <a href="login">login</a> to book this destination.
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="mb-0">Available Packages</h5>
                </div>
                <ul class="list-group list-group-flush">
                    <li class="list-group-item">
                        <div class="d-flex justify-content-between">
                            <span>Flight + Hotel</span>
                            <span class="font-weight-bold">$999</span>
                        </div>
                        <small class="text-muted">7 days, 6 nights</small>
                    </li>
                    <li class="list-group-item">
                        <div class="d-flex justify-content-between">
                            <span>Tour Package</span>
                            <span class="font-weight-bold">$1299</span>
                        </div>
                        <small class="text-muted">10 days, 9 nights</small>
                    </li>
                    <li class="list-group-item">
                        <div class="d-flex justify-content-between">
                            <span>Adventure Package</span>
                            <span class="font-weight-bold">$1499</span>
                        </div>
                        <small class="text-muted">12 days, 11 nights</small>
                    </li>
                </ul>
            </div>

            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0">Best Time to Visit</h5>
                </div>
                <div class="card-body">
                    <p>The best time to visit ${destination.name} is from April to June and September to November when the weather is pleasant and crowds are smaller.</p>
                    <div class="d-flex justify-content-between text-center">
                        <div>
                            <i class="fas fa-thermometer-half fa-2x text-danger"></i>
                            <p class="mb-0">Summer</p>
                            <small>25-35°C</small>
                        </div>
                        <div>
                            <i class="fas fa-leaf fa-2x text-success"></i>
                            <p class="mb-0">Spring</p>
                            <small>15-25°C</small>
                        </div>
                        <div>
                            <i class="fas fa-snowflake fa-2x text-primary"></i>
                            <p class="mb-0">Winter</p>
                            <small>5-15°C</small>
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
