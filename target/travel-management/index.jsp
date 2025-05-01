<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.travel.dao.DestinationDAO" %>
<%@ page import="com.travel.model.Destination" %>
<%@ page import="java.util.List" %>
<%
    // Load featured destinations for the index page
    DestinationDAO destinationDAO = new DestinationDAO();
    List<Destination> featuredDestinations = destinationDAO.getFeaturedDestinations();
    request.setAttribute("featuredDestinations", featuredDestinations);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Travel Management System</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <!-- Hero Section -->
    <div class="jumbotron jumbotron-fluid hero-section">
        <div class="container text-center text-white">
            <h1 class="display-4">Explore the World with Us</h1>
            <p class="lead">Discover amazing destinations and create unforgettable memories.</p>
            <a href="destinations" class="btn btn-primary btn-lg">Explore Destinations</a>
        </div>
    </div>

    <!-- Featured Destinations -->
    <section class="container my-5">
        <h2 class="text-center mb-4">Featured Destinations</h2>
        <div class="row">
            <c:forEach var="destination" items="${featuredDestinations}" varStatus="loop">
                <div class="col-md-4 mb-4">
                    <div class="card h-100">
                        <img src="${destination.imageUrl}" class="card-img-top" alt="${destination.name}">
                        <div class="card-body">
                            <h5 class="card-title">${destination.name}</h5>
                            <p class="card-text">${destination.city}, ${destination.country}</p>
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <span class="text-warning">
                                        <c:forEach begin="1" end="5" varStatus="star">
                                            <i class="fas fa-star${star.index <= destination.rating ? '' : '-half-alt'}"></i>
                                        </c:forEach>
                                    </span>
                                    <small class="text-muted ml-1">${destination.rating}/5</small>
                                </div>
                                <a href="destinations?action=view&id=${destination.id}" class="btn btn-sm btn-outline-primary">View Details</a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty featuredDestinations}">
                <div class="col-12 text-center">
                    <p>No featured destinations available at the moment.</p>
                </div>
            </c:if>
        </div>
        <div class="text-center mt-4">
            <a href="destinations" class="btn btn-outline-primary">View All Destinations</a>
        </div>
    </section>

    <!-- Services Section -->
    <section class="bg-light py-5">
        <div class="container">
            <h2 class="text-center mb-4">Our Services</h2>
            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="card h-100 border-0 shadow-sm">
                        <div class="card-body text-center">
                            <i class="fas fa-plane-departure fa-3x text-primary mb-3"></i>
                            <h5 class="card-title">Flight Bookings</h5>
                            <p class="card-text">Book flights to your favorite destinations with the best prices and flexible options.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card h-100 border-0 shadow-sm">
                        <div class="card-body text-center">
                            <i class="fas fa-hotel fa-3x text-primary mb-3"></i>
                            <h5 class="card-title">Hotel Reservations</h5>
                            <p class="card-text">Find and book accommodations that suit your preferences and budget.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card h-100 border-0 shadow-sm">
                        <div class="card-body text-center">
                            <i class="fas fa-route fa-3x text-primary mb-3"></i>
                            <h5 class="card-title">Tour Packages</h5>
                            <p class="card-text">Explore our curated tour packages for a hassle-free travel experience.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Testimonials Section -->
    <section class="container my-5">
        <h2 class="text-center mb-4">What Our Customers Say</h2>
        <div class="row">
            <div class="col-md-4 mb-4">
                <div class="card h-100">
                    <div class="card-body">
                        <div class="text-warning mb-2">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                        <p class="card-text">"Amazing service! The booking process was smooth, and the tour guide was knowledgeable and friendly. Will definitely use their services again."</p>
                        <div class="d-flex align-items-center mt-3">
                            <div class="avatar mr-3">
                                <img src="https://via.placeholder.com/50" class="rounded-circle" alt="Customer">
                            </div>
                            <div>
                                <h6 class="mb-0">John Doe</h6>
                                <small class="text-muted">New York, USA</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card h-100">
                    <div class="card-body">
                        <div class="text-warning mb-2">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star-half-alt"></i>
                        </div>
                        <p class="card-text">"The travel itinerary was well-planned, and the accommodations were excellent. The customer support team was responsive and helpful throughout our trip."</p>
                        <div class="d-flex align-items-center mt-3">
                            <div class="avatar mr-3">
                                <img src="https://via.placeholder.com/50" class="rounded-circle" alt="Customer">
                            </div>
                            <div>
                                <h6 class="mb-0">Jane Smith</h6>
                                <small class="text-muted">London, UK</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card h-100">
                    <div class="card-body">
                        <div class="text-warning mb-2">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                        <p class="card-text">"We had a wonderful family vacation thanks to Travel Management System. The destinations were beautiful, and everything was organized perfectly."</p>
                        <div class="d-flex align-items-center mt-3">
                            <div class="avatar mr-3">
                                <img src="https://via.placeholder.com/50" class="rounded-circle" alt="Customer">
                            </div>
                            <div>
                                <h6 class="mb-0">Robert Johnson</h6>
                                <small class="text-muted">Sydney, Australia</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Newsletter Section -->
    <section class="bg-primary text-white py-5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-6 mb-3 mb-md-0">
                    <h3>Subscribe to Our Newsletter</h3>
                    <p>Get the latest travel deals, offers, and news directly to your inbox.</p>
                </div>
                <div class="col-md-6">
                    <form class="form-inline justify-content-md-end" onsubmit="alert('Thank you for subscribing to our newsletter!'); return false;">
                        <div class="input-group w-100">
                            <input type="email" class="form-control" placeholder="Your email address" required>
                            <div class="input-group-append">
                                <button class="btn btn-light" type="submit">Subscribe</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
