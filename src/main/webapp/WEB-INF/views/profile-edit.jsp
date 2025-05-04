<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile - Travel Management System</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<jsp:include page="common/header.jsp" />

<div class="container mt-5">
    <div class="row">
        <div class="col-md-3">
            <div class="card mb-4">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">My Account</h5>
                </div>
                <div class="card-body text-center">
                    <div class="mb-3">
                        <img src="https://via.placeholder.com/150" class="rounded-circle img-thumbnail" alt="Profile Picture">
                        <div class="mt-2">
                            <button class="btn btn-sm btn-outline-primary">Change Photo</button>
                        </div>
                    </div>
                    <h5>${user.fullName}</h5>
                    <p class="text-muted">${user.username}</p>
                    <p><span class="badge badge-info">${user.role}</span></p>
                </div>
                <div class="list-group list-group-flush">
                    <a href="profile" class="list-group-item list-group-item-action active">
                        <i class="fas fa-user mr-2"></i> My Profile
                    </a>
                    <a href="bookings" class="list-group-item list-group-item-action">
                        <i class="fas fa-calendar-check mr-2"></i> My Bookings
                    </a>
                    <a href="#" class="list-group-item list-group-item-action">
                        <i class="fas fa-heart mr-2"></i> Wishlist
                    </a>
                    <a href="#" class="list-group-item list-group-item-action">
                        <i class="fas fa-credit-card mr-2"></i> Payment Methods
                    </a>
                    <a href="#" class="list-group-item list-group-item-action">
                        <i class="fas fa-bell mr-2"></i> Notifications
                    </a>
                </div>
            </div>
        </div>

        <div class="col-md-9">
            <div class="card mb-4">
                <div class="card-header bg-light">
                    <h5 class="mb-0">Edit Profile</h5>
                </div>
                <div class="card-body">
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger" role="alert">
                                ${errorMessage}
                        </div>
                    </c:if>

                    <ul class="nav nav-tabs" id="profileTabs" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" id="personal-tab" data-toggle="tab" href="#personal" role="tab" aria-controls="personal" aria-selected="true">Personal Information</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="password-tab" data-toggle="tab" href="#password" role="tab" aria-controls="password" aria-selected="false">Change Password</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="preferences-tab" data-toggle="tab" href="#preferences" role="tab" aria-controls="preferences" aria-selected="false">Preferences</a>
                        </li>
                    </ul>

                    <div class="tab-content mt-4" id="profileTabsContent">
                        <!-- Personal Information Tab -->
                        <div class="tab-pane fade show active" id="personal" role="tabpanel" aria-labelledby="personal-tab">
                            <form action="profile" method="post">
                                <input type="hidden" name="action" value="update">

                                <div class="form-group">
                                    <label for="username">Username</label>
                                    <input type="text" class="form-control" id="username" value="${user.username}" readonly>
                                    <small class="form-text text-muted">Username cannot be changed.</small>
                                </div>

                                <div class="form-group">
                                    <label for="fullName">Full Name</label>
                                    <input type="text" class="form-control" id="fullName" name="fullName" value="${user.fullName}" required>
                                </div>

                                <div class="form-group">
                                    <label for="email">Email</label>
                                    <input type="email" class="form-control" id="email" name="email" value="${user.email}" required>
                                </div>

                                <div class="form-group">
                                    <label for="phone">Phone</label>
                                    <input type="text" class="form-control" id="phone" name="phone" value="${user.phone}" required>
                                </div>

                                <button type="submit" class="btn btn-primary">Save Changes</button>
                                <a href="profile" class="btn btn-outline-secondary">Cancel</a>
                            </form>
                        </div>

                        <!-- Change Password Tab -->
                        <div class="tab-pane fade" id="password" role="tabpanel" aria-labelledby="password-tab">
                            <form action="profile" method="post">
                                <input type="hidden" name="action" value="changePassword">

                                <div class="form-group">
                                    <label for="currentPassword">Current Password</label>
                                    <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
                                </div>

                                <div class="form-group">
                                    <label for="newPassword">New Password</label>
                                    <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                                    <small class="form-text text-muted">Password must be at least 8 characters long and include a mix of letters and numbers.</small>
                                </div>

                                <div class="form-group">
                                    <label for="confirmPassword">Confirm New Password</label>
                                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                                </div>

                                <button type="submit" class="btn btn-primary">Change Password</button>
                                <a href="profile" class="btn btn-outline-secondary">Cancel</a>
                            </form>
                        </div>

                        <!-- Preferences Tab -->
                        <div class="tab-pane fade" id="preferences" role="tabpanel" aria-labelledby="preferences-tab">
                            <form action="profile" method="post">
                                <input type="hidden" name="action" value="updatePreferences">

                                <h6>Communication Preferences</h6>
                                <div class="form-group">
                                    <div class="custom-control custom-switch">
                                        <input type="checkbox" class="custom-control-input" id="emailNotifications" name="emailNotifications" checked>
                                        <label class="custom-control-label" for="emailNotifications">Email Notifications</label>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="custom-control custom-switch">
                                        <input type="checkbox" class="custom-control-input" id="smsNotifications" name="smsNotifications">
                                        <label class="custom-control-label" for="smsNotifications">SMS Notifications</label>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="custom-control custom-switch">
                                        <input type="checkbox" class="custom-control-input" id="promotionalEmails" name="promotionalEmails" checked>
                                        <label class="custom-control-label" for="promotionalEmails">Promotional Emails</label>
                                    </div>
                                </div>

                                <h6 class="mt-4">Travel Preferences</h6>
                                <div class="form-group">
                                    <label for="preferredDestinations">Preferred Destinations</label>
                                    <select class="form-control" id="preferredDestinations" name="preferredDestinations" multiple>
                                        <option value="europe">Europe</option>
                                        <option value="asia">Asia</option>
                                        <option value="northAmerica">North America</option>
                                        <option value="southAmerica">South America</option>
                                        <option value="africa">Africa</option>
                                        <option value="oceania">Oceania</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label for="travelStyle">Travel Style</label>
                                    <select class="form-control" id="travelStyle" name="travelStyle">
                                        <option value="luxury">Luxury</option>
                                        <option value="budget">Budget</option>
                                        <option value="adventure">Adventure</option>
                                        <option value="cultural">Cultural</option>
                                        <option value="relaxation">Relaxation</option>
                                    </select>
                                </div>

                                <button type="submit" class="btn btn-primary">Save Preferences</button>
                                <a href="profile" class="btn btn-outline-secondary">Cancel</a>
                            </form>
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
<script>
    // Activate tab based on hash in URL
    $(document).ready(function() {
        if (window.location.hash) {
            $(`#${window.location.hash.substring(1)}-tab`).tab('show');
        }
    });

    // Password validation
    document.getElementById('confirmPassword').addEventListener('input', function() {
        const newPassword = document.getElementById('newPassword').value;
        const confirmPassword = this.value;

        if (newPassword !== confirmPassword) {
            this.setCustomValidity('Passwords do not match');
        } else {
            this.setCustomValidity('');
        }
    });
</script>
</body>
</html>
