<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VendoraX 🏠</title>
    <link rel="shortcut icon" href="res/images/vendor comapany logo.webp" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
     <link rel="stylesheet" href="res/css/index.css">
    <style>
     
        /* footer styling end */
    </style>
</head>

<body>
    <div class="container-fluid p-0">
        <header class="sticky-top py-1 shadow-sm header">
            <div class="container-fluid">
                <div class="row align-items-center">
                    <div class="col-md-12 text-end">
                        <nav class="navbar navbar-expand-lg navbar-dark">
                            <a class="navbar-brand" href="#">
                                  <div class="logo-container">
                                    <img src="res/images/vendor comapany logo.webp" alt="Company Logo" width="50" height="40"
                                        class="nav-logo">
                                    <span class="company-name">VendoraX</span>
                                </div>
                            </a>
                            <button class="navbar-toggler ms-auto" type="button" id="toggleSidebar">
                                <i class="fas fa-bars"></i>
                            </button>
                            <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                                <ul class="navbar-nav">
                                    <!-- User Dropdown -->
                                    <li class="nav-item dropdown">
                                        <a class="nav-link dropdown-toggle text-white" href="#" role="button"
                                            data-bs-toggle="dropdown" aria-expanded="false">
                                            USER
                                        </a>
                                        <ul class="dropdown-menu">
                                            <li><a class="dropdown-item" href="logInPage">Sign In</a></li>
                                            <li><a class="dropdown-item" href="registerPage">Sign Up</a></li>
                                        </ul>
                                    </li>
                                    <!-- Admin Link -->
                                    <li class="nav-item">
                                        <a class="nav-link" href="adminLoginPage">ADMIN</a>
                                    </li>
                                </ul>
                            </div>
                        </nav>
                    </div>
                </div>
            </div>
        </header>

        <!-- Sidebar structure -->
        <div id="sidebar" class="offcanvas-sidebar">
            <div class="sidebar-content">
                <button type="button" class="btn-close-sidebar" id="closeSidebar">X</button>
                <ul class="navbar-nav">
                    <li class="nav-item"><a class="nav-link" href="logInPage">Sign In</a></li>
                    <li class="nav-item"><a class="nav-link" href="registerPage">Sign Up</a></li>
                    <li class="nav-item"><a class="nav-link" href="adminLoginPage">Admin</a></li>
                </ul>
            </div>
        </div>


        <section id="about" class="py-5">
            <div class="container">
                <h2 class="text-center mb-4">About VendoraX</h2>
                <!-- Company logo -->
                <div class="text-center mb-4 about-logo-container">
                    <img src="res/images/vendor comapany logo.webp" alt="VendoraX Logo" class="about-logo">
                </div>
                <p class="text-center about-text">VendoraX is a leading vendor management system that provides
                    streamlined
                    solutions for businesses to efficiently manage their vendor relationships. With a focus on
                    innovation,
                    technology, and seamless integration, VendoraX empowers organizations to optimize their procurement
                    and vendor operations, fostering growth and collaboration.
                </p>
                <div class="row mt-4">
                    <div class="col-md-4 text-center feature">
                        <i class="fas fa-users fa-3x mb-3 icon"></i>
                        <p>Experienced Team</p>
                    </div>
                    <div class="col-md-4 text-center feature">
                        <i class="fas fa-trophy fa-3x mb-3 icon"></i>
                        <p>Award Winning</p>
                    </div>
                    <div class="col-md-4 text-center feature">
                        <i class="fas fa-globe fa-3x mb-3 icon"></i>
                        <p>Global Reach</p>
                    </div>
                </div>
            </div>
        </section>
        <section id="announcements" class="py-5 bg-light">
            <div class="container">
                <h2 class="text-center mb-4">Latest Announcements</h2>
                <div id="announcementCarousel" class="carousel slide" data-bs-ride="carousel" data-bs-interval="3000">
                    <div class="carousel-inner" id="vendorAnnouncementsContent">
                        <!-- Default content if announcements are not fetched -->
                        <div class="carousel-item active">
                            <div class="card announcement-card">
                                <div class="card-body">
                                    <h5 class="card-title">No Announcements Available</h5>
                                    <p class="card-text">Please check back later for updates.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div> 
            </div>
        </section>
        
        <section id="services" class="py-5">
            <div class="container">
                <h2 class="text-center mb-4  ">Our Services</h2>
                <div class="row">
                    <div class="col-md-4 mb-4">
                        <div class="card h-100">
                            <img src="res/images/service1.png" class="card-img-top" alt="Vendor Onboarding">
                            <div class="card-body">
                                <h5 class="card-title">Vendor OnBoarding & Management</h5>
                                <p class="card-text">Simplify the process of onBoarding new vendors and manage their
                                    profiles efficiently.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="card h-100">
                            <img src="res/images/service2.jpeg" class="card-img-top" alt="Performance Tracking">
                            <div class="card-body">
                                <h5 class="card-title">Performance Tracking & Analytics</h5>
                                <p class="card-text">Monitor vendor performance with detailed analytics and reporting
                                    features.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="card h-100">
                            <img src="res/images/service3.webp" class="card-img-top" alt="Contract Management">
                            <div class="card-body">
                                <h5 class="card-title">Contract Management</h5>
                                <p class="card-text">Manage and track vendor contracts with ease, ensuring compliance
                                    and timely renewals.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="card h-100">
                            <img src="res/images/service4.png" class="card-img-top" alt="Automated Alerts">
                            <div class="card-body">
                                <h5 class="card-title">Automated Alerts & Notifications</h5>
                                <p class="card-text">Receive automated notifications for important events like contract
                                    expirations and compliance deadlines.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="card h-100">
                            <img src="res/images/service5.jpeg" class="card-img-top" alt="Document Storage">
                            <div class="card-body">
                                <h5 class="card-title">Secure Document Storage</h5>
                                <p class="card-text">Store and manage vendor documents securely with our cloud storage
                                    solution.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="card h-100">
                            <img src="res/images/service6.jpeg" class="card-img-top" alt="Communication Portal">
                            <div class="card-body">
                                <h5 class="card-title">Vendor Communication Portal</h5>
                                <p class="card-text">Enhance communication with vendors through our integrated
                                    communication portal.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>


        <section id="location" class="py-5 bg-light">
            <div class="container">
                <h2 class="text-center mb-4">Location & Timing</h2>
                <div class="row">
                    <div class="col-md-6">
                        <h4 class="mb-3">Contact Information</h4>
                        <p><strong>Address:</strong> 123 Main Street, City, State, Zip</p>
                        <p><strong>Phone:</strong> (123) 456-7890</p>
                        <p><strong>Email:</strong> info@company.com</p>
                        <p><strong>Hours:</strong> Monday-Friday, 9:00 AM - 5:00 PM</p>
                    </div>
                    <div class="col-md-6">
                        <iframe
                            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3023.423373792811!2d-74.0060152847527!3d40.71282197933282!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x89c2598f3f047201%3A0x80c2c80878e83a3c!2s123%20Main%20Street%2C%20New%20York%2C%20NY%2010001!5e0!3m2!1sen!2sus!4v1688478036450!5m2!1sen!2sus"
                            width="100%" height="250" style="border:0;" allowfullscreen="" loading="lazy"
                            referrerpolicy="no-referrer-when-downgrade"></iframe>
                    </div>
                </div>
            </div>
        </section>
        <section id="enquiry" class="py-5">
            <div class="container">
                <h2 class="text-center mb-4">Enquiry Form</h2>
                <form id="enquiryForm">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="name" class="form-label">Name:</label>
                            <input type="text" class="form-control" id="name" placeholder="Enter your name" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="email" class="form-label">Email:</label>
                            <input type="email" class="form-control" id="email" placeholder="Enter your email" required>
                        </div>
                        <div class="col-md-12 mb-3">
                            <label for="message" class="form-label">Message:</label>
                            <textarea class="form-control" id="message" rows="4" placeholder="Enter your message"
                                required></textarea>
                        </div>
                        <div class="col-md-12 text-center">
                            <button type="submit" class="btn btn-primary">Submit</button>
                        </div>
                    </div>
                </form>
            </div>
        </section>

        <footer class="bg-dark text-light py-4">
            <div class="container">
                <div class="row">
                  <div class="col-md-12 text-center">
                        <ul class="nav justify-content-center">
                            <li class="nav-item"><a class="nav-link" href="#about">About Us</a></li>
                            <li class="nav-item"><a class="nav-link" href="#services">Services</a></li>
                            <li class="nav-item"><a class="nav-link" href="#announcements">Announcements</a></li>
                            <li class="nav-item"><a class="nav-link" href="#enquiry">Enquiry Form</a></li>
                        </ul>
                    </div>  
                </div>
                <div class="row mt-3">
                   <div class="col-md-12 text-center">
                        <ul class="nav justify-content-center">
                            <li class="nav-item"><a href="#" class="nav-link"><i class="fab fa-facebook-f"></i></a></li>
                            <li class="nav-item"><a href="#" class="nav-link"><i class="fab fa-twitter"></i></a></li>
                            <li class="nav-item"><a href="#" class="nav-link"><i class="fab fa-linkedin-in"></i></a>
                            </li>
                        </ul>
                    </div> 
                </div>
                <div class="row mt-3">
                    
                    <div class="col-md-12 text-center">
                        <p class="mb-1">&copy; 2024 VendoraX. All rights reserved.</p>
                        <p class="mb-0">Designed by <a href="https://ravikumarxworkz.github.io/"
                                class="text-info">Ravikumar Shankar Kumbar</a></p>
                    </div>
                </div>
            </div>
        </footer>

    </div>
</body>

<script src="https://code.jquery.com/jquery-3.6.0.min.js">
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.2/jspdf.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script>
    document.getElementById('toggleSidebar').addEventListener('click', function () {
        document.getElementById('sidebar').classList.toggle('active');
    });

    document.getElementById('closeSidebar').addEventListener('click', function () {
        document.getElementById('sidebar').classList.remove('active');
    });
</script>
<script type="text/javascript">
$(document).ready(function() {
    function loadVendorAnnouncements() {
        $.ajax({
            type: "GET",
            url: "getVendorAnnouncements", 
            dataType: "json",
            success: function(announcements) {
                var content = ""; 
                if (announcements && announcements.length > 0) {
                    for (var i = 0; i < announcements.length; i++) {
                        var announcement = announcements[i];
                        var isActive = i === 0 ? 'active' : ''; 
                        
                        content += "<div class='carousel-item " + isActive + "'>"
                                + "<div class='card announcement-card'>"
                                + "<div class='card-body'>"
                                + "<h5 class='card-title'>" + announcement.title + "</h5>"
                                + "<p class='card-text'>" + announcement.message + "</p>"
                                + "</div></div></div>";
                    }
                } else {
                    content = "<div class='carousel-item active'>"
                            + "<div class='card announcement-card'>"
                            + "<div class='card-body'>"
                            + "<h5 class='card-title'>No Announcements Available</h5>"
                            + "<p class='card-text'>Please check back later for updates.</p>"
                            + "</div></div></div>";
                }
                $("#vendorAnnouncementsContent").html(content);
            },
            error: function() {
                var errorContent = "<div class='carousel-item active'>"
                                 + "<div class='card announcement-card'>"
                                 + "<div class='card-body'>"
                                 + "<h5 class='card-title'>Failed to Fetch Announcements</h5>"
                                 + "<p class='card-text'>There was an error loading the announcements. Please try again later.</p>"
                                 + "</div></div></div>";
                $("#vendorAnnouncementsContent").html(errorContent);
            }
        });
    }

    loadVendorAnnouncements();
});
</script>


</html>