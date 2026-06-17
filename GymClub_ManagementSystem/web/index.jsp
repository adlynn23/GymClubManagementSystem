<%-- 
    Document   : index
    Created on : 26 May 2026, 5:02:48 pm
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Gym Club Management System</title>

        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Icons -->
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

        <!-- CSS -->
        <link rel="stylesheet" href="css/index_style.css">
    </head>

    <body>
        <%
            String name = (String) session.getAttribute("name");
        %>
        <!-- NAVBAR -->
        <nav class="navbar navbar-expand-lg navbar-dark custom-navbar fixed-top">
            <div class="container">

                <a class="navbar-brand fw-bold" href="#">
                    UniGym
                </a>

                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                        data-bs-target="#navbarContent">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarContent">

                    <ul class="navbar-nav ms-auto align-items-center">

                        <li class="nav-item">
                            <a class="nav-link" href="#membership">Membership</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="#features">Features</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="#trainer">Trainers</a>
                        </li>

                        <li class="nav-item ms-3">
                            <a class="btn btn-login" href="login.jsp">
                                Login
                            </a>
                        </li>

                    </ul>

                </div>
            </div>
        </nav>

        <!-- HERO SECTION -->
        <section class="hero-section">

            <div class="overlay"></div>

            <div class="container hero-content">

                <div class="row align-items-center">

                    <div class="col-lg-6">

                        <h1 class="hero-title">
                            Transform Your Fitness Journey
                        </h1>

                        <p class="hero-text">
                            Manage gym attendance, bookings, memberships,
                            and trainer schedules in one smart platform.
                        </p>

                        <div class="hero-buttons">

                            <a href="login.jsp" class="btn btn-main">
                                Get Started
                            </a>

                            <a href="#membership" class="btn btn-outline-light">
                                Explore Plans
                            </a>

                        </div>

                    </div>

                </div>

            </div>

        </section>

        <!-- FEATURES -->
        <section class="features-section" id="features">

            <div class="container">

                <div class="section-title text-center">
                    <h2>Why Choose UniGym?</h2>
                    <p>Everything you need in one gym management platform.</p>
                </div>

                <div class="row g-4 mt-4">

                    <div class="col-md-4">
                        <div class="feature-card">

                            <i class="fa-solid fa-dumbbell feature-icon"></i>

                            <h4>Attendance Tracking</h4>

                            <p>
                                Easily monitor gym attendance and check-ins.
                            </p>

                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="feature-card">

                            <i class="fa-solid fa-calendar-check feature-icon"></i>

                            <h4>Class Booking</h4>

                            <p>
                                Book workout sessions and trainer appointments online.
                            </p>

                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="feature-card">

                            <i class="fa-solid fa-chart-line feature-icon"></i>

                            <h4>Performance Analytics</h4>

                            <p>
                                View attendance statistics and activity reports.
                            </p>

                        </div>
                    </div>

                </div>

            </div>

        </section>

        <!-- MEMBERSHIP -->
        <section class="membership-section" id="membership">

            <div class="container">

                <div class="section-title text-center">
                    <h2>Membership Plans</h2>
                    <p>Flexible plans for every student lifestyle.</p>
                </div>

                <div class="row g-4 mt-4">

                    <!-- BASIC -->
                    <div class="col-lg-4">
                        <div class="membership-card">

                            <h3>Basic</h3>

                            <div class="price">
                                RM39<span>/month</span>
                            </div>

                            <ul>
                                <li>Gym Access</li>
                                <li>Attendance Tracking</li>
                                <li>Locker Access</li>
                            </ul>

                            <a href="login.jsp" class="btn btn-plan">
                                Join Now
                            </a>

                        </div>
                    </div>

                    <!-- PREMIUM -->
                    <div class="col-lg-4">
                        <div class="membership-card premium-card">

                            <div class="popular-badge">
                                Popular
                            </div>

                            <h3>Premium</h3>

                            <div class="price">
                                RM79<span>/month</span>
                            </div>

                            <ul>
                                <li>Unlimited Classes</li>
                                <li>Trainer Sessions</li>
                                <li>Priority Booking</li>
                            </ul>

                            <a href="login.jsp" class="btn btn-plan">
                                Join Now
                            </a>

                        </div>
                    </div>

                    <!-- ELITE -->
                    <div class="col-lg-4">
                        <div class="membership-card">

                            <h3>Elite</h3>

                            <div class="price">
                                RM129<span>/month</span>
                            </div>

                            <ul>
                                <li>VIP Lounge</li>
                                <li>Personal Trainer</li>
                                <li>Full Facility Access</li>
                            </ul>

                            <a href="login.jsp" class="btn btn-plan">
                                Join Now
                            </a>

                        </div>
                    </div>

                </div>

            </div>

        </section>

        <!-- TRAINERS -->
        <section class="trainer-section" id="trainer">

            <div class="container">

                <div class="section-title text-center">
                    <h2>Professional Trainers</h2>
                    <p>Train with certified fitness experts.</p>
                </div>

                <div class="row g-4 mt-4">

                    <div class="col-md-4">
                        <div class="trainer-card">

                            <img src="https://images.unsplash.com/photo-1567013127542-490d757e6349?q=80&w=800"
                                 class="img-fluid">

                            <div class="trainer-info">
                                <h5>Alex Johnson</h5>
                                <p>Strength Coach</p>
                            </div>

                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="trainer-card">

                            <img src="https://images.unsplash.com/photo-1517836357463-d25dfeac3438?q=80&w=800"
                                 class="img-fluid">

                            <div class="trainer-info">
                                <h5>Sarah Lee</h5>
                                <p>Fitness Trainer</p>
                            </div>

                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="trainer-card">

                            <img src="https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?q=80&w=800"
                                 class="img-fluid">

                            <div class="trainer-info">
                                <h5>Daniel Kim</h5>
                                <p>Cardio Specialist</p>
                            </div>

                        </div>
                    </div>

                </div>

            </div>

        </section>

        <!-- FOOTER -->
        <footer class="footer">

            <div class="container text-center">

                <h4>UniGym Management System</h4>

                <p>
                    Smart gym management solution for university students.
                </p>

                <div class="social-icons">

                    <i class="fa-brands fa-facebook"></i>
                    <i class="fa-brands fa-instagram"></i>
                    <i class="fa-brands fa-x-twitter"></i>

                </div>

            </div>

        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
