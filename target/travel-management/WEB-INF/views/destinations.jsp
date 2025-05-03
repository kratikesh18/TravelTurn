<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Destinations - Travel Management System</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<jsp:include page="common/header.jsp" />

<div class="container mt-4">
    <h2 class="mb-4">Explore Destinations</h2>

    <!-- Search Form -->
    <div class="card mb-4">
        <div class="card-body">
            <form action="destinations" method="get" class="form-inline">
                <input type="hidden" name="action" value="search">
                <div class="form-group flex-grow-1 mr-2">
                    <input type="text" name="keyword" class="form-control w-100" placeholder="Search destinations..." value="${keyword}">
                </div>
                <button type="submit" class="btn btn-primary">Search</button>
            </form>
        </div>
    </div>

    <!-- Destinations List -->
    <div class="row">
        <c:forEach var="destination" items="${destinations}">
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
                                <small class="text-muted ml-1">${destination.rating}/5</small>
                            </div>
                            <a href="destinations?action=view&id=${destination.id}" class="btn btn-sm btn-outline-primary">View Details</a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>

        <c:if test="${empty destinations}">
            <div class="col-12 text-center">
                <div class="alert alert-info">
                    No destinations found. Please try a different search or check back later.
                </div>
            </div>
        </c:if>
    </div>
</div>

<jsp:include page="common/footer.jsp" />

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
