<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true" %>
<c:if test="${empty sessionScope.loggedInUserEmail || empty sessionScope.loggedInUserId || empty sessionScope.userProfileImage}">
    <c:redirect url="logInPage" />
</c:if>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User Profile Menu 👤</title>
<link rel="shortcut icon" href="res/iamges/vendor comapany logo.webp"
	type="image/x-icon">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
<style>
body {
	font-family: Arial, sans-serif;
}

.sidebar {
	height: 100vh;
	position: fixed;
	top: 0;
	left: 0;
	width: 200px;
	background-color: #1d1f21;
	color: white;
	padding-top: 20px;
}

.sidebar .nav-link {
	color: white;
	padding: 10px;
	display: block;
}

.sidebar .nav-link.active {
	background-color: #28a745;
}

.sidebar-header img {
	width: 100px;
	height: auto;
	border-radius: 50%;
}

.content {
	margin-left: 220px;
	padding: 20px;
}

.card {
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.display-4 {
	font-size: 2rem;
	font-weight: bold;
}

.dropdown-toggle img {
	margin-right: 10px;
}

.modern-dashboard .card {
	border-radius: 10px;
	margin-bottom: 20px;
}

.modern-dashboard .card-title {
	font-size: 1.2rem;
	font-weight: bold;
}

.modern-dashboard .display-4 {
	font-size: 2.5rem;
	color: #4a69bd;
}

/* Responsive */
@media ( max-width : 767px) {
	.sidebar {
		position: relative;
		width: 100%;
	}
	.content {
		margin-left: 0;
	}
}

/* Hide all sections by default */
.section {
	display: none;
}

/* Display active section */
.section.active {
	display: block;
}

/* Table styles */
.table-responsive {
	margin-top: 20px;
}

.table thead {
	background-color: #28a745;
	color: white;
}

.table th, .table td {
	padding: 15px;
	text-align: center;
}

.sidebar-header h3 {
	color: #28a745;
}

/* Notification Badge */
.dropdown-menu {
	max-height: 200px;
	overflow-y: auto;
}

.badge {
	background-color: #f14668;
}
/* Ensure the profile dropdown doesn't overlap */
#profileContainer {
	position: relative;
	z-index: 1;
}

#notificationContainer {
	position: relative;
	z-index: 4;
}

.chart-container {
	width: 100%;
	height: 400px;
	margin-top: 20px;
}
/* Custom styles for the User Details Modal */
.custom-modal-content {
	background-color: #f4f7f6;
	border-radius: 15px;
}

.custom-card-header {
	background-color: #3e4444;
	color: #fff;
	font-weight: 600;
}

.card-body {
	padding: 1.5rem;
}

.custom-input {
	background-color: #eef1f5;
	border-radius: 8px;
	border: none;
	padding: 10px;
	font-size: 16px;
	box-shadow: 0px 1px 3px rgba(0, 0, 0, 0.1);
}

.custom-input:focus {
	border: 2px solid #007bff;
	box-shadow: none;
}

.big-image {
	border: 5px solid #007bff;
	box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
}

.custom-divider {
	border: 0;
	height: 2px;
	background-image: linear-gradient(to right, #007bff, #00c4ff);
}

.btn-group button {
	padding: 10px 20px;
	border-radius: 5px;
}

#editBtn {
	background-color: #007bff;
	border: none;
}

#submitBtn {
	background-color: #28a745;
	border: none;
}

#cancelBtn {
	background-color: #dc3545;
	border: none;
}

/* Modal Header */
.modal-header.bg-dark {
	background-color: #2c3e50;
	color: #fff;
	border-bottom: none;
}

.modal-header .btn-close-white {
	filter: invert(1);
}

/* Ensure the styles are unique to this modal */
#userDetailsModal .modal-dialog {
	max-width: 900px;
}

#userDetailsModal .modal-content {
	border-radius: 20px;
	overflow: hidden;
}

.hidden {
	display: none;
}
/* Styles for Success Modal */
#successModal .modal-content {
	border-radius: 0.5rem;
}

#successModal .modal-header {
	border-bottom: 1px solid rgba(0, 0, 0, 0.125);
}

#successModal .modal-footer {
	border-top: 1px solid rgba(0, 0, 0, 0.125);
}

#successModal .btn-close-white {
	filter: invert(1);
}

#errorModal .modal-content {
	border-radius: 0.5rem;
}

#errorModal .modal-header {
	border-bottom: 1px solid rgba(0, 0, 0, 0.125);
}

#errorModal .modal-footer {
	border-top: 1px solid rgba(0, 0, 0, 0.125);
}

#errorModal .btn-close-white {
	filter: invert(1);
}

#fileInput {
	display: none; /* Hide the input element */
}
/*message css  */
#chat-container {
	width: 100%;
	max-width: 600px;
	margin: 30px auto;
	background-color: #ffffff;
	border-radius: 10px;
	box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
	overflow: hidden;
}

#chat-header {
	background-color: #007bff;
	color: white;
	padding: 15px;
	display: flex;
	align-items: center;
}

#admin-profile {
	width: 40px;
	height: 40px;
	border-radius: 50%;
	overflow: hidden;
	margin-right: 10px;
}

#admin-profile img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

#chat-box {
	height: 400px;
	overflow-y: auto;
	padding: 10px;
	background-color: #f9f9f9;
	border-top: 1px solid #ddd;
}

/* Styling messages */
.message {
	display: flex;
	padding: 10px;
	margin: 10px 0;
	border-radius: 20px;
	max-width: 75%;
	word-wrap: break-word;
	font-size: 15px;
	box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
	position: relative; /* Enable absolute positioning of children */
}

.message-content {
	flex: 1; /* Allow this to grow and take available space */
	margin-right: 50px; /* Leave space for time */
}

.message-time {
	position: absolute; /* Use absolute positioning */
	right: 10px; /* Position it to the right */
	bottom: 5px; /* Position it slightly above the bottom */
	color: #6c757d; /* Muted color */
	font-size: 12px; /* Small text */
}

.user-message {
	background-color: #dcf8c6; /* Light green for user */
	align-self: flex-end;
	text-align: right;
	margin-left: auto;
}

.admin-message {
	background-color: #f1f0f0; /* Light grey for admin */
	align-self: flex-start;
}

.message .avatar {
	width: 35px;
	height: 35px;
	border-radius: 50%;
	overflow: hidden;
	margin-right: 10px;
}

.message .avatar img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

/* Chat input area */
#chat-input {
	display: flex;
	padding: 15px;
	background-color: #fff;
	border-top: 1px solid #ddd;
}

#chat-input input {
	flex-grow: 1;
	padding: 10px;
	border-radius: 20px;
	border: 1px solid #ddd;
	outline: none;
}

#chat-input button {
	margin-left: 10px;
	background-color: #007bff;
	color: white;
	padding: 10px 15px;
	border-radius: 20px;
	border: none;
	cursor: pointer;
	outline: none;
}

#chat-input button:hover {
	background-color: #0056b3;
}
</style>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>

<body>
	<div class="container-fluid">
		<c:set var="userProfile" value="${userProfile}" />
		<div class="row">
			<!-- Sidebar -->
			<div class="col-md-2 sidebar">
				<div class="sidebar-header text-center">
					<img src="res/images/vendor comapany logo.webp"
						alt="Company Logo">
					<h3 class="mt-3">VendorX</h3>
				</div>
				<ul class="nav flex-column">
					<li class="nav-item"><a class="nav-link active" href="#"
						onclick="showSection('dashboard')"><i
							class="fas fa-tachometer-alt"></i> Dashboard</a></li>
					<li class="nav-item"><a class="nav-link" href="#"
						onclick="showSection('products')"><i class="fas fa-box"></i>
							Products</a></li>
					<li class="nav-item"><a class="nav-link" href="#"
						onclick="showSection('orders')"><i
							class="fas fa-clipboard-list"></i> Orders</a></li>
					<li class="nav-item"><a class="nav-link" href="#"
						onclick="showSection('history')"><i class="fas fa-history"></i>
							Order History</a></li>
					<li class="nav-item"><a class="nav-link" href="#"
						onclick="showSection('payment')"><i class="fas fa-credit-card"></i>
							Payment</a></li>
					<li class="nav-item"><a class="nav-link" href="#"
						onclick="showSection('messages')"><i class="fas fa-envelope"></i>
							Messages</a></li>
				</ul>
			</div>

			<!-- Main Content -->
			<div class="col-md-10 content">
				<div class="d-flex justify-content-between align-items-center mb-3">
					<h2 id="section-title" class="mb-0">Dashboard</h2>
					<div class="d-flex">
						<!-- Notification Dropdown -->
						<div class="dropdown me-2" id="notificationContainer">
							<button class="btn btn-outline-info dropdown-toggle"
								type="button" id="notificationDropdown"
								data-bs-toggle="dropdown" aria-expanded="false">
								<i class="fas fa-bell"></i> <span class="badge">0</span>
							</button>
							<ul class="dropdown-menu p-3 dropdown-menu-start"
								aria-labelledby="notificationDropdown" style="width: 400px;">
								<li><a class="dropdown-item" href="#">No notifications</a></li>
							</ul>
						</div>
						<!-- Profile Dropdown -->
						<div class="dropdown" id="profileContainer">
							<button class="btn btn-outline-info dropdown-toggle"
								type="button" id="profileDropdown" data-bs-toggle="dropdown"
								aria-expanded="false">
								<img src="display?imagePath=${userProfileImage}"
									style="width: 30px; height: 30px;" alt="Profile Picture"
									class="rounded-circle"> <span id="userName"></span>
							</button>
							<ul class="dropdown-menu" aria-labelledby="profileDropdown">
								<li><a class="dropdown-item" href="#"
									onclick="viewProfile()"> Profile</a></li>
								<li><a class="dropdown-item" href="vendorLogout">Logout</a></li>
							</ul>
						</div>
					</div>
				</div>


				<!-- Sections -->
				<div id="dashboard" class="section active">
					<div class="row modern-dashboard">
						<div class="col-md-3">
							<div class="card bg-light">
								<div class="card-body">
									<h5 class="card-title">Total Products</h5>
									<div class="display-4" id="totalProducts"></div>
									<!-- Updated with id -->
								</div>
							</div>
						</div>
						<div class="col-md-3">
							<div class="card bg-light">
								<div class="card-body">
									<h5 class="card-title">Total Orders</h5>
									<div class="display-4" id="totalOrders"></div>
									<!-- Updated with id -->
								</div>
							</div>
						</div>
						<div class="col-md-3">
							<div class="card bg-light">
								<div class="card-body">
									<h5 class="card-title">Delivered Orders</h5>
									<div class="display-4" id="deliveredOrders"></div>
									<!-- Updated with id -->
								</div>
							</div>
						</div>
						<div class="col-md-3">
							<div class="card bg-light">
								<div class="card-body">
									<h5 class="card-title">Pending Orders</h5>
									<div class="display-4" id="pendingOrders"></div>
									<!-- Updated with id -->
								</div>
							</div>
						</div>
					</div>

					<!-- Charts -->
					<div class="row">
						<div class="col-md-6 chart-container">
							<h4>Order Statistics</h4>
							<canvas id="orderChart"></canvas>
						</div>
						<div class="col-md-6 chart-container mt-5">
							<h4>Payment Summary</h4>

							<!-- Payment Summary Card -->
							<div
								class="row modern-dashboard justify-content-between align-items-center">
								<div class="col-md-3">
									<div class="card bg-light">
										<div class="card-body">
											<h5 class="card-title">Total Amount To Pay</h5>
											<div class="display-4" id="totalAmountToPay"></div>
											<!-- Updated with id -->
										</div>
									</div>
								</div>
								<div class="col-md-3">
									<div class="card bg-light">
										<div class="card-body">
											<h5 class="card-title">Amount Paid</h5>
											<div class="display-4" id="amountPaid"></div>
											<!-- Updated with id -->
										</div>
									</div>
								</div>
								<div class="col-md-3">
									<div class="card bg-light">
										<div class="card-body">
											<h5 class="card-title">Remaining Balance</h5>
											<div class="display-4" id="remainingBalance">25</div>
											<!-- Updated with id -->
										</div>
									</div>
								</div>
							</div>

							<!-- Payment Chart -->
							<canvas id="paymentChart"></canvas>
						</div>
					</div>
				</div>

				<div id="products" class="section">
					<div class="row mt-4">
						<div class="col-md-12">
							<div class="card bg-light text-dark">
								<div class="card-body">
									<a class="btn btn-primary mb-3" id="addProductBtn"
										data-bs-toggle="modal" data-bs-target="#addProductModal"
										role="button"> <i class="fas fa-plus-circle"></i> Add
										Product
									</a>

									<!-- Search Bar -->
									<input type="text"
										class="form-control mt-2 search-product-input"
										placeholder="Search Products by Name" id="productSearch"
										onkeyup="fetchProducts(1)">

									<!-- Products Table -->
									<div class="table-responsive">
										<table id="viewAllProductsTable"
											class="table table-striped mt-2">
											<thead class="table-info">
												<tr>
													<th>#</th>
													<th>productID</th>
													<th>Category</th>
													<th>Product Name</th>
													<th>Price</th>
													<th>Status</th>
													<th>Actions</th>
												</tr>
											</thead>
											<tbody id="viewAllProductTableBody"></tbody>
										</table>
									</div>
									<nav aria-label="Page navigation">
										<ul class="pagination justify-content-center"
											id="productPagination">
											<li class="page-item"><a class="page-link" href="#"
												onclick="prevPageProducts()">Previous</a></li>
											<li class="page-item"><a class="page-link" href="#"
												onclick="nextPageProducts()">Next</a></li>
										</ul>
									</nav>
								</div>
							</div>
						</div>
					</div>


				</div>

				<div id="orders" class="section">
					<div class="row mt-4">
						<div class="col-md-12">
							<div class="card bg-light text-dark">
								<div class="card-body">
									<!-- Search Bar -->
									<input type="text" class="form-control mt-2 search-order-input"
										placeholder="Search Orders by Product Name" id="orderSearch"
										onkeyup="fetchOrders(1)">

									<!-- Orders Table -->
									<div class="table-responsive">
										<table id="viewAllOrdersTable"
											class="table table-striped mt-2">
											<thead class="table-info">
												<tr>
													<th>#</th>
													<th>Order ID</th>
													<th>Product Name</th>
													<th>Quantity</th>
													<th>Order Date</th>
													<th>Delivery Date</th>
													<th>Status</th>
													<th>Actions</th>
												</tr>
											</thead>
											<tbody id="viewAllOrdersTableBody"></tbody>
										</table>
									</div>

									<nav aria-label="Page navigation">
										<ul class="pagination justify-content-center"
											id="orderPagination">
											<li class="page-item"><a class="page-link" href="#"
												onclick="prevPageOrders()">Previous</a></li>
											<li class="page-item"><a class="page-link" href="#"
												onclick="nextPageOrders()">Next</a></li>
										</ul>
									</nav>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div id="history" class="section mt-4">
					<div class="card bg-light text-dark">
						<div class="card-body">
							<!-- Search Bar -->
							<input type="text" class="form-control mt-2 search-order-input"
								placeholder="Search Orders by Product Name"
								id="orderHistorySearch" onkeyup="fetchOrderHistory(1)">

							<!-- Order History Table -->
							<div class="table-responsive">
								<table id="orderHistoryTable" class="table table-striped mt-2">
									<thead class="table-info">
										<tr>
											<th>#</th>
											<th>Order ID</th>
											<th>Product Name</th>
											<th>Quantity</th>
											<th>Order Date</th>
											<th>Delivery Date</th>
											<th>Status</th>
											<th>Actions</th>
										</tr>
									</thead>
									<tbody id="orderHistoryTableBody"></tbody>
								</table>
							</div>

							<nav aria-label="Page navigation">
								<ul class="pagination justify-content-center"
									id="orderPaginationHistory"></ul>
							</nav>
						</div>
					</div>
				</div>


				<div id="payment" class="section">
					<div class="card bg-light text-dark">
						<div class="card-body">
							<!-- Search Bar -->
							<input type="text" class="form-control mt-2 search-payment-input"
								placeholder="Search Payments by Payment ID"
								id="paymentSummarySearch" onkeyup="fetchPaymentSummary(1)">

							<!-- Payment Summary Table -->
							<div class="table-responsive">
								<table id="paymentSummaryTable" class="table table-striped mt-2">
									<thead class="table-info">
										<tr>
											<th>#</th>
											<th>Payment ID</th>
											<th>Order ID</th>
											<th>Amount</th>
											<th>Payment Date</th>
											<th>Payment Status</th>
											<th>view invoice</th>
										</tr>
									</thead>
									<tbody id="paymentSummaryTableBody"></tbody>
								</table>
							</div>

							<nav aria-label="Page navigation">
								<ul class="pagination justify-content-center"
									id="paymentPaginationSummary"></ul>
							</nav>
						</div>
					</div>
				</div>

				<div id="messages" class="section">
					<div id="chat-container">
						<div id="chat-header">
							<div id="admin-profile">
								<img src="res/images/vendor comapany logo.webp"
									alt="Admin Profile">
							</div>
							<h4>Admin Chat</h4>
						</div>

						<!-- Chat Box to display the messages -->
						<div id="chat-box"></div>

						<!-- Chat Input for sending messages -->
						<div id="chat-input">
							<input type="text" id="chatMessage"
								placeholder="Type a message..." />
							<button onclick="sendMessage()">
								<i class="fas fa-paper-plane"></i> Send
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-------------------------------------------- Add Product Modal ------------------------------->
	<!-- Add Product Modal -->


	<div class="modal fade" id="userDetailsModal" tabindex="-1"
		aria-labelledby="userDetailsModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg modal-dialog-centered">
			<div class="modal-content custom-modal-content">
				<div class="modal-header bg-dark text-white">
					<h5 class="modal-title" id="userDetailsModalLabel">User
						Details</h5>
					<button type="button" class="btn-close btn-close-white"
						data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form id="userProfileForm" method="post"
						enctype="multipart/form-data">
						<div class="card-body">
							<div class="row">
								<div class="col-md-4 text-center">
									<img id="userPhoto" src="display?imagePath=${userProfileImage}"
										width="200px" height="200px"
										class="rounded-circle big-image img-fluid shadow"
										alt="User Profile Image">
									<div class="mt-3" id="uploadButtonWrapper"
										style="display: none;">
										<label for="newPhoto" class="btn btn-warning"> <span
											id="uploadLabel">Upload New Photo</span> <input type="file"
											id="newPhoto" name="imageFile" accept="image/*"
											style="display: none;" onchange="previewNewPhoto(event)">
										</label>
									</div>
									<h5 class="mt-3" id="ownerNameDisplay"></h5>
									<p class="text-muted" id="emailDisplay"></p>
								</div>

								<div class="col-md-8">
									<div class="row mb-3">
										<div class="col-md-6">
											<label for="ownerName">Owner Name:</label> <input type="text"
												class="form-control custom-input" id="ownerName"
												onchange="onName()" required readonly> <span
												id="errorownerName" class="validError"></span>

										</div>
										<div class="col-md-6">
											<label for="email">Email:</label> <input type="email"
												class="form-control custom-input" id="email" readonly>
										</div>
									</div>

									<div class="row mb-3">
										<div class="col-md-6">
											<label for="contactNumber">Contact Number:</label> <input
												type="tel" class="form-control custom-input"
												onchange="validateContactNumber()" required="required"
												id="contactNumber" readonly> <span
												id="errorContactNumber" class="validError"></span>
										</div>
										<div class="col-md-6">
											<label for="altContactNumber">Alt Contact Number:</label> <input
												type="tel" class="form-control custom-input"
												id="altContactNumber" readonly required
												onchange="validateAltContactNumber()"> <span
												id="erroraltContactNumber" class="validError"></span>

										</div>
									</div>

									<hr class="custom-divider">

									<h5 class="mb-3">Business Details</h5>

									<div class="row mb-3">
										<div class="col-md-6">
											<label for="vendorName">Vendor Name:</label> <input
												type="text" class="form-control custom-input"
												id="vendorName" readonly>
										</div>
										<div class="col-md-6">
											<label for="startDate">Start Date:</label> <input type="date"
												class="form-control custom-input" id="startDate" readonly>
										</div>
									</div>

									<div class="row mb-3">
										<div class="col-md-6">
											<label for="gstNumber">GST Number:</label> <input type="text"
												class="form-control custom-input" id="gstNumber" readonly
												onchange="onGSTNumber()" required> <span
												id="errorGSTNumber" class="validError"></span>
										</div>
										<div class="col-md-6">
											<label for="website">Website:</label> <input type="url"
												class="form-control custom-input" id="website" readonly
												required>
										</div>
									</div>

									<div class="row mb-3">
										<div class="col-md-6">
											<label for="address">Address:</label> <input type="text"
												class="form-control custom-input" id="address" readonly
												required>
										</div>
										<div class="col-md-6">
											<label for="pinCode">Pin Code:</label> <input type="text"
												class="form-control custom-input" id="pinCode" readonly
												required onchange="validatePincode()"> <span
												id="errorpincode" class="validError"></span>
										</div>
									</div>

									<div class="text-center btn-group">
										<button type="button" class="btn btn-primary" id="editBtn">Edit</button>
										<button type="button" class="btn btn-success hidden"
											id="submitBtn">Submit</button>
										<button type="button" class="btn btn-danger hidden"
											id="cancelBtn">Cancel</button>
									</div>

								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-------------------------------------------------------EDIT ORDERS MODAL------------>
	<div class="modal fade" id="editOrderModal" tabindex="-1" role="dialog"
		aria-labelledby="editOrderModal" aria-hidden="true">
		<div class="modal-dialog modal-lg modal-dialog-centered"
			role="document">
			<div class="modal-content shadow-lg border-0 rounded-lg">
				<div class="modal-header bg-primary text-white">
					<h5 class="modal-title" id="editOrderModalLabel">
						<i class="fas fa-info-circle"></i> Order Details
					</h5>
					<button type="button" class="btn-close btn-close-white"
						data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body p-4">
					<div class="row mb-3">
						<div class="col-md-6">
							<strong><i class="fas fa-tag"></i> Order ID:</strong> <span
								id="orderId" class="ml-2 text-muted"></span>
						</div>
						<div class="col-md-6">
							<strong><i class="fas fa-cube"></i> Product Name:</strong> <span
								id="productName" class="ml-2 text-muted"></span>
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-md-6">
							<button class="btn btn-primary" onclick="viewOrderProduct()">
								<i class='fas fa-eye'></i> View Product
							</button>
						</div>
						<div class="col-md-6">
							<strong><i class="fas fa-shopping-cart"></i> Order
								Quantity:</strong> <span id="orderQuantity" class="ml-2 text-muted"></span>
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-md-6">
							<strong><i class="far fa-calendar-alt"></i> Order Date:</strong>
							<span id="orderDate" class="ml-2 text-muted"></span>
						</div>
						<div class="col-md-6">
							<strong><i class="far fa-calendar-check"></i> Delivery
								Date:</strong> <span id="deliveryDate" class="ml-2 text-muted"></span>
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-md-6">
							<strong><i class="fas fa-map-marker-alt"></i> Delivery
								Address:</strong> <span id="deliveryAddress" class="ml-2 text-muted"></span>
						</div>
						<div class="col-md-6">
							<strong><i class="fas fa-credit-card"></i> Payment
								Status:</strong> <span id="orderPaymentStatus" class="ml-2 text-muted"></span>
						</div>

					</div>
					<div class="row mb-3">
						<div class="col-md-6">
							<strong><i class="far fa-comment"></i> Message:</strong> <span
								id="message" class="ml-2 text-muted"></span>
						</div>
						<div class="col-md-6">
							<strong><i class="fas fa-info-circle"></i> Order Status:</strong>
							<span id="orderStatus" class="ml-2 text-muted"></span>
						</div>
					</div>
					<div class="row">
						<div class="col-6" id="orderStatusDiv" style="display: none;">
							<!-- Initially hidden -->
							<input type="hidden" id="orderId"> <label
								for="SelectOrderStatus">Order Status</label> <select
								id="SelectOrderStatus" class="form-control">
								<option value="">Select order status</option>
								<option value="can't_delivered">Can't Delivered</option>
								<option value="delivered">Delivered</option>
								<option value="Confirmed">Confirmed</option>
							</select>
						</div>

						<div class="col-6">
							<div id="uploadInvoiceSection" style="display: none;">
								<label for="fileInput" class="btn btn-info"> <span
									id="fileLabel">Upload Order Invoice</span> <input type="file"
									id="fileInput" name="file" accept=".pdf"
									class="form-control-file" style="display: none;">
								</label>
							</div>
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-6">
							<button id="viewOrderInvoice" class="btn btn-outline-info"
								style="display: none;" onclick="openOrderInvoice()">
								<i class="fas fa-file-pdf"></i> View Order Invoice
							</button>
						</div>
						<div class="col-6">
							<button id="viewPaymentInvoice" class="btn btn-outline-info"
								style="display: none;" onclick="openPaymentInvoice()">
								<i class="fas fa-file-pdf"></i> View Payment Invoice
							</button>
						</div>
					</div>
					<div class="modal-footer bg-light">
						<button id="downloadPDFBtn" type="button"
							class="btn btn-outline-success" onclick="downloadPDF()">Download
							PDF</button>
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Close</button>
						<button id="submitOrderBtn" type="button" class="btn btn-primary"
							onclick="submitOrder()">Submit</button>
					</div>
				</div>
			</div>
		</div>
	</div>


	<div class="modal fade" id="addProductModal" tabindex="-1"
		aria-labelledby="addProductModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="addProductModalLabel">
						<i class="fas fa-plus"></i> Add Product
					</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form id="addProductForm">
						<div class="row">
							<div class="col">
								<div class="mb-3">
									<input type="hidden" id="productId" name="productId"> <label
										for="category" class="form-label"><i
										class="fas fa-tags"></i> Category</label> <select class="form-select"
										id="category" name="category" required>
										<option value="">Select Category</option>
										<option value="grocery">Grocery</option>
										<option value="electronics">Electronics</option>
										<option value="cloths">Cloth's</option>
										<option value="home_furnitures">Home and Furniture's</option>
										<option value="cosmetics">Cosmetics</option>
										<option value="appliances">Appliances</option>
									</select>
								</div>
							</div>
							<div class="col">
								<div class="mb-3">
									<label for="productName" class="form-label"><i
										class="fas fa-cube"></i> Product Name</label> <input type="text"
										class="form-control" id="productName" name="productName"
										placeholder="Enter Product Name" required>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col">
								<div class="mb-3">
									<label for="productPrice" class="form-label"><i
										class="fas fa-dollar-sign"></i> Product Price (per item)</label>
									<div class="input-group">
										<input type="number" class="form-control" id="productPrice"
											name="productPrice" required> <span
											class="input-group-text">₹</span>
									</div>
								</div>
							</div>
							<div class="col">
								<div class="mb-3">
									<label for="deliveryCharge" class="form-label"><i
										class="fas fa-truck"></i> Delivery Charge</label>
									<div class="input-group">
										<input type="number" class="form-control" id="deliveryCharge"
											name="deliveryCharge" required> <span
											class="input-group-text">₹</span>
									</div>
								</div>
							</div>
						</div>
						<div class="mb-3">
							<label for="available" class="form-label"><i
								class="fas fa-check-circle"></i> Available</label> <select
								class="form-select" id="available" name="available" required>
								<option value="">Select Availability</option>
								<option value="StockIn">Stock In</option>
								<option value="OutofStock">Out of Stock</option>
							</select>
						</div>
						<div class="mb-3">
							<label for="descriptionAboutProduct" class="form-label"><i
								class="fas fa-info-circle"></i> Description About Product</label>
							<textarea class="form-control" id="descriptionAboutProduct"
								name="descriptionAboutProduct" rows="3" required></textarea>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary" id="submitProductBtn">
						<i class="fas fa-check"></i> Submit
					</button>
				</div>
			</div>
		</div>
	</div>



	<!-- Success Modal -->
	<!-- Success Modal -->
	<div class="modal fade" id="successModal" tabindex="-1"
		aria-labelledby="successModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content border-success">
				<div class="modal-header bg-success text-white">
					<h5 class="modal-title" id="successModalLabel">Success</h5>
					<button type="button" class="btn-close btn-close-white"
						data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body text-success" id="successMessage">
					<!-- Success message will be displayed here -->
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-success"
						data-bs-dismiss="modal">OK</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Error Modal -->
	<div class="modal fade" id="errorModal" tabindex="-1"
		aria-labelledby="errorModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content border-danger">
				<div class="modal-header bg-danger text-white">
					<h5 class="modal-title" id="errorModalLabel">Error</h5>
					<button type="button" class="btn-close btn-close-white"
						data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body text-danger" id="errorMessage">
					<!-- Error message will be displayed here -->
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger"
						data-bs-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>





	<!-- JS and Bootstrap -->
	<!-- Add jQuery CDN -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

	<!-- Bootstrap 5 & Font Awesome CDN -->
	<script src="https://kit.fontawesome.com/a076d05399.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script>
	/*====================== this code is part of sidebar naigation =================*/
    function showSection(section) {
        // Hide all sections
        document.querySelectorAll('.section').forEach(sec => {
            sec.classList.remove('active');
        });

        // Show the selected section
        document.getElementById(section).classList.add('active');

        // Update the section title
        document.getElementById('section-title').innerText = section.charAt(0).toUpperCase() + section.slice(1);

        // If the section is 'products', call fetchProducts(1)
        if (section === 'products') {
            fetchProducts(1);
        }
        if(section === 'orders'){
        	fetchOrders(1);
        }
        if(section==='history'){
        	fetchOrderHistory(1);
        }
        if(section==='payment'){
        	fetchPaymentSummary(1);
        }
    }

    /*====================== this code is part of Order Chart =================*/   
    </script>
	<script type="text/javascript">
    $(document).ready(function() {
    	const vendorId = '${sessionScope.loggedInUserId}'; // Get the vendor ID from session storage

        function fetchDataAndUpdateCharts() {
            $.ajax({
                url: 'getVendorDashboard/' + vendorId, // Update with your actual endpoint
                type: 'GET',
                success: function(response) {
                    var orderStatistics = response.orderStatistics;
                    var paymentSummary = response.paymentSummary;

                    // Update dashboard values
                    $('#totalProducts').text(orderStatistics.totalProducts || 0);
                    $('#totalOrders').text(orderStatistics.totalOrders || 0);
                    $('#deliveredOrders').text(orderStatistics.deliveredCount || 0);
                    $('#pendingOrders').text(orderStatistics.pendingOrders || 0);

                    $('#totalAmountToPay').text(paymentSummary.totalAmountToPay || 0);
                    $('#amountPaid').text(paymentSummary.amountPaid || 0);
                    $('#remainingBalance').text(paymentSummary.remainingBalance || 0);

                    // Update Order Chart
                    var ctx = document.getElementById('orderChart').getContext('2d');
                    var orderChart = new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: ['Delivered', 'Pending', 'Cancelled'],
                            datasets: [{
                                label: 'Order Count',
                                data: [
                                    orderStatistics.deliveredCount || 0,
                                    orderStatistics.pendingOrders || 0,
                                    orderStatistics.cancelledCount || 0 // Assuming you have this value in your backend
                                ],
                                backgroundColor: ['#28a745', '#ffc107', '#dc3545'],
                                borderWidth: 1
                            }]
                        },
                        options: {
                            scales: {
                                y: {
                                    beginAtZero: true
                                }
                            }
                        }
                    });

                    // Update Payment Chart
                    var paymentCtx = document.getElementById('paymentChart').getContext('2d');
                    var paymentChart = new Chart(paymentCtx, {
                        type: 'doughnut',
                        data: {
                            labels: ['Paid', 'Pending', 'Failed'],
                            datasets: [{
                                label: 'Payment Status',
                                data: [
                                    paymentSummary.amountPaid || 0,         // Amount paid
                                    (paymentSummary.totalAmountToPay - paymentSummary.amountPaid) || 0, // Pending
                                    paymentSummary.failedAmount || 0   // Assuming you have failed amount, set to 0 if not
                                ],
                                backgroundColor: ['#28a745', '#ffc107', '#dc3545'],
                                hoverOffset: 4
                            }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                        }
                    });
                },
                error: function(xhr, status, error) {
                    console.error("Error fetching data:", error);
                }
            });
        }

        // Initial fetch
        fetchDataAndUpdateCharts();

        // Set interval to fetch data every 60 seconds (60000 milliseconds)
        setInterval(fetchDataAndUpdateCharts, 60000);
    });

    
    
    </script>

	<script>
	 /*====================== this code is part of to disply venodr name =================*/
		document.addEventListener("DOMContentLoaded", function() {
			var email = "${sessionScope.loggedInUserEmail}";
			var userName = email.substring(0, email.indexOf('@'));
			document.getElementById("userName").textContent = userName;
		});
	</script>

	<script>
	  /*====================== this code is part of to disply venodr profile and update code =================*/
	  function viewProfile() {
	    const vendorId = '${sessionScope.loggedInUserId}';
         
	    // AJAX request to fetch the vendor details by ID
	    $.ajax({
	        url: 'getVendorById',
	        method: 'GET',
	        data: { vendorId: vendorId },
	        success: function(vendor) {
	         

	            // Check if the vendor object is valid
	            if (!vendor || typeof vendor !== 'object') {
	                $('#errorMessage').text('Invalid vendor data received.');
	                $('#errorModal').modal('show');
	                return;
	            }

	            // Populate the form fields with vendor data
	            $('#ownerName').val(vendor.ownerName);
	            $('#email').val(vendor.emailId);
	            $('#contactNumber').val(vendor.contactNumber);
	            $('#altContactNumber').val(vendor.altContactNumber);
	            $('#vendorName').val(vendor.vendorName);
	            $('#gstNumber').val(vendor.gstnumber); // Fixed key from `GSTNumber` to `gstNumber`
	            $('#startDate').val(vendor.startDate);
	            $('#address').val(vendor.address);
	            $('#pinCode').val(vendor.pincode);
	            $('#website').val(vendor.website);
	            $('#ownerNameDisplay').text(vendor.ownerName);
	            $('#emailDisplay').text(vendor.emailId);

	            // Update profile photo
	            $('#userPhoto').attr('src', '/VendoraX/display?imagePath=' + vendor.imagePath);

	            // Show the modal with vendor details
	            $('#userDetailsModal').modal('show');
	        },
	        error: function(err) {
	            console.error('Error fetching vendor details:', err);
	            $('#errorMessage').text('Error fetching vendor details.');
	            $('#errorModal').modal('show');
	        }
	    });
	}
	  
	  
  const editBtn = document.getElementById('editBtn');
  const submitBtn = document.getElementById('submitBtn');
  const cancelBtn = document.getElementById('cancelBtn');
  const inputs = document.querySelectorAll('.form-control');
  
  // Store the original image source before allowing user to change it
  const userPhoto = document.getElementById('userPhoto');
  let originalPhotoSrc = userPhoto.src; // Save the original image src

  editBtn.addEventListener('click', function () {
	    // Select all inputs and textareas inside the form except the email input
	    var inputs = document.querySelectorAll('#userProfileForm input:not([id="email"]), #userProfileForm textarea');

	    // Loop through each input and enable them
	    inputs.forEach(function(input) {
	        input.removeAttribute('readonly'); // Remove readonly if it exists
	        input.disabled = false;            // Enable the input if it's disabled
	    });
	    
	    editBtn.classList.add('hidden');
	    submitBtn.classList.remove('hidden');
	    cancelBtn.classList.remove('hidden');
	    document.getElementById('uploadButtonWrapper').style.display = 'block';

  });

  cancelBtn.addEventListener('click', function () {
    inputs.forEach(input => input.setAttribute('readonly', true));
    submitBtn.classList.add('hidden');
    cancelBtn.classList.add('hidden');
    editBtn.classList.remove('hidden');
    document.getElementById('uploadButtonWrapper').style.display = 'none';
    
    // Reset the profile image to the original one
    userPhoto.src = originalPhotoSrc;
    
    // Reset the file input field and label
    newPhotoInput.value = '';
    uploadLabel.textContent = 'Upload New Photo';
  });

  const newPhotoInput = document.getElementById('newPhoto');
  const uploadLabel = document.getElementById('uploadLabel');

  newPhotoInput.addEventListener('change', function() {
    if (newPhotoInput.files.length > 0) {
      const fileName = newPhotoInput.files[0].name;
      uploadLabel.textContent = fileName;
    } else {
      uploadLabel.textContent = 'Upload New Photo';
    }
  });

  function previewNewPhoto(event) {
    var file = event.target.files[0];

    var reader = new FileReader();

    reader.onload = function(e) {
      userPhoto.src = e.target.result;
    };

    reader.readAsDataURL(file);
  } 
	// Assuming jQuery is already included in your project
	$('#submitBtn').on('click', function() {
	    const photoInput = document.getElementById('newPhoto');
	    const formData = new FormData();

	    // Append text fields to FormData
	    formData.append('ownerName', document.getElementById('ownerName').value);
	    formData.append('emailId', document.getElementById('email').value);
	    formData.append('contactNumber', document.getElementById('contactNumber').value);
	    formData.append('altContactNumber', document.getElementById('altContactNumber').value);
	    formData.append('vendorName', document.getElementById('vendorName').value);
	    formData.append('startDate', document.getElementById('startDate').value);
	    formData.append('GSTNumber', document.getElementById('gstNumber').value);
	    formData.append('website', document.getElementById('website').value);
	    formData.append('address', document.getElementById('address').value);
	    formData.append('pincode', document.getElementById('pinCode').value);

	    // If a new photo is uploaded, append it; otherwise, append the old image path
	    if (photoInput.files[0]) {
	        formData.append('imageFile', photoInput.files[0]);
	    } else {
	        const oldPhotoPath = document.getElementById('userPhoto').src;
	        formData.append('imagePath', oldPhotoPath); // Send the old photo path if no new photo
	    }

	    // AJAX request to save updated data along with the photo
	    $.ajax({
	        url: 'updateVendorProfile',
	        type: 'POST',
	        data: formData,
	        processData: false, // Important for FormData
	        contentType: false, // Important for FormData
	        success: function(data) {
	            if (data.message) {
	                // If success, show success message and hide the modal
	                $('#userDetailsModal').modal('hide');
	                $('#successMessage').text(data.message);
	                $('#successModal').modal('show');

	                // Disable input fields and toggle buttons on success
	                $('input').prop('readonly', true);
	                $('#submitBtn').addClass('hidden');
	                $('#cancelBtn').addClass('hidden');
	                $('#editBtn').removeClass('hidden');
	                document.getElementById('uploadButtonWrapper').style.display = 'none';

	            } else if (data.errors) {
	            	let errorMessages = '';

	            	data.errors.forEach(error => {
	            	    errorMessages += error + '<br>';
	            	});
	            	// Use .html() to render HTML tags correctly
	            	$('#errorMessage').html(errorMessages);
	            	$('#errorModal').modal('show');
	            	  document.querySelectorAll('#userProfileForm input').forEach(input => input.setAttribute('readonly', true));
	                  submitBtn.classList.add('hidden');
	                  cancelBtn.classList.add('hidden');
	                  editBtn.classList.remove('hidden');
	                  document.getElementById('uploadButtonWrapper').style.display = 'none';
	                  $('#userDetailsModal').modal('hide');
	              

	            } 
	        },
	        error: function() {
	            // Handle network/server error
	            $('#errorMessage').html('An error occurred while updating your profile. Please try again.');
            	$('#errorModal').modal('show');
            	  document.querySelectorAll('#userProfileForm input').forEach(input => input.setAttribute('readonly', true));
            	  document.getElementById('uploadButtonWrapper').style.display = 'none';
            	  submitBtn.classList.add('hidden');
                  cancelBtn.classList.add('hidden');
                  editBtn.classList.remove('hidden');
                  $('#userDetailsModal').modal('hide');
	        }
	    });
	});
	</script>

	<script type="text/javascript">
	let currentPage = 1;
	const pageSize = 10;
	function fetchProducts(page) {
	    const searchQuery = $('#productSearch').val();
	    const vendorId = '${sessionScope.loggedInUserId}';
	    $.ajax({
	        url: 'getAllProductsByVendorId',
	        type: 'GET',
	        data: {
	            page: page,
	            size: pageSize,
	            query: searchQuery,
	            vendorId: vendorId
	        },
	        dataType: 'json',
	        success: function (response) {
	            populateProductTable(response.products);
	            updatePagination(response.totalPages, page);
	        },
	        error: function (xhr) {
	            console.error('Error fetching employees:', xhr);
	        }
	    });
	}
	
	function populateProductTable(products) {
	    const tableBody = $('#viewAllProductTableBody');
	    tableBody.empty();

	    if (products.length === 0) {
	        tableBody.append('<tr><td colspan="6" class="text-center">No Products found.</td></tr>');
	        return;
	    }

	    products.forEach((product, index) => { // Use index as the second parameter
	        var row = '<tr>' +
	            '<td>' + (index + 1) + '</td>' + // Show the index (1-based)
	            '<td>' + product.id + '</td>' +
	            '<td>' + product.category + '</td>' +
	            '<td>' + product.productName + '</td>' +
	            '<td>' + product.productPrice + '</td>' +
	            '<td>' + product.available + '</td>' +
	            '<td>' +
	            '<button class="btn btn-info view-products" data-id="' + product.id + '"><i class="fas fa-eye"></i> View</button>' +
	            '</td>' +
	            '</tr>';
	        tableBody.append(row);
	        
	        // Attach click event handler
	        $('.view-products').last().click(function() { // Use .last() to ensure we attach to the current button
	            const productId = $(this).data('id');
	            viewProducts(productId);
	        });
	    });

	}
	function updatePagination(totalPages ,currentPage) {
	    const pagination = $('#productPagination');
	    pagination.empty();

	    if (totalPages <= 1) return;

	    pagination.append(`<li class="page-item"><a class="page-link" href="#" onclick="prevPageProducts()">Previous</a></li>`);

	    for (let i = 1; i <= totalPages; i++) {
	        const activeClass = (i == currentPage) ? 'active' : '';
	        pagination.append('<li class="page-item ' + activeClass + '"><a class="page-link" href="#" onclick="goToPage(' + i + ')">' + i + '</a></li>');
	    }

	    pagination.append(`<li class="page-item"><a class="page-link" href="#" onclick="nextPageProducts()">Next</a></li>`);
	}
	
	// Pagination controls
	function prevPageProducts() {
	    if (currentPage > 1) {
	        currentPage--;
	        fetchProducts(currentPage);
	    }
	}

	function nextPageProducts() {
	    if (currentPage < $('#productPagination li').length - 2) {  // Ignore 'Previous' and 'Next' buttons
	        currentPage++;
	        fetchProducts(currentPage);
	    }
	}
	
	function goToPage(page) {
	    currentPage = page;
	    fetchProducts(currentPage);
	}
       
	function viewProducts(productId) {
	    // AJAX request to fetch the product details by ID
	    $.ajax({
	        url: 'getProductById',  // Replace with your actual endpoint URL
	        method: 'GET',
	        data: { productId: productId },
	        success: function(product) {

	            // Check if the product object is valid
	            if (!product || typeof product !== 'object') {
	                return;
	            }

	            // Populate the form fields with product data
	            $('#addProductForm #productId').val(product.id);
	            $('#addProductForm #category').val(product.category);
	            $('#addProductForm #productName').val(product.productName);
	            $('#addProductForm #productPrice').val(product.productPrice);
	            $('#addProductForm #deliveryCharge').val(product.deliveryCharge);
	            $('#addProductForm #descriptionAboutProduct').val(product.descriptionAboutProduct);
	            $('#addProductForm #available').val(product.available);

	            $('#addProductModalLabel').text('Edit Product');
	            $('#submitProductBtn').text('Save Changes').off('click').on('click', function() {
	                updateProduct(product.id);
	            });

	            $('#addProductModal').modal('show');
	        },
	        error: function(err) {
	            $('#errorMessage').text('Error fetching product details.');
	            $('#errorModal').modal('show');
	        }
	    });
	}


	function updateProduct() {	    
	    var productId = $('#productId').val();
	    var category = $('#category').val();
	    var productName = $('#addProductForm #productName').val();
	    var productPrice = $('#productPrice').val();
	    var deliveryCharge = $('#deliveryCharge').val();
	    var available = $('#available').val();
	    var descriptionAboutProduct = $('#descriptionAboutProduct').val();

	    var productData = {
	    	id:productId,
	        category: category,
	        productName: productName,
	        productPrice: productPrice,
	        deliveryCharge: deliveryCharge,
	        available: available,
	        descriptionAboutProduct: descriptionAboutProduct
	    };
	    $.ajax({
	        url: 'updateProduct',
	        method: 'POST',
	        contentType: 'application/json', 
	        data: JSON.stringify(productData), 
	        success: function(response) {
	            $('#addProductModal').modal('hide');
	            $('#successMessage').text(response);
	            $('#successModal').modal('show');
	            fetchProducts(currentPage);  
	        },
	        error: function(err) {
	
	            $('#errorMessage').text('Error updating product: ' + err.responseText);
	            $('#errorModal').modal('show');
	        }
	    });
	}

	
	$('#addProductBtn').on('click', function() {
	    $('#addProductForm').trigger('reset');
	 
	    $('#addProductModalLabel').text('Add Product');
	    $('#submitProductBtn').text('Submit').off('click').on('click', function() {
	        addProduct();
	    });

	    $('#addProductModal').modal('show');
	});

	function addProduct() {
	    const vendorId = '${sessionScope.loggedInUserId}'; // Ensure this is properly set on the server side

	    // Validate vendorId
	    if (!vendorId || isNaN(vendorId)) {
	        return;
	    }

	    // Collect form data
	    var category = $('#category').val();
	    var productName = $('#addProductForm #productName').val();
	    var productPrice = $('#productPrice').val();
	    var deliveryCharge = $('#deliveryCharge').val();
	    var available = $('#available').val();
	    var descriptionAboutProduct = $('#descriptionAboutProduct').val();

	    // Create the ProductDTO object
	    var productData = {
	    	vendorId:vendorId,
	        category: category,
	        productName: productName,
	        productPrice: productPrice,
	        deliveryCharge: deliveryCharge,
	        available: available,
	        descriptionAboutProduct: descriptionAboutProduct
	    };

	    $.ajax({
	        url:'addProduct',
	        method: 'POST',
	        contentType: 'application/json', 
	        data: JSON.stringify(productData), 
	        success: function(response) {
	            $('#addProductModal').modal('hide');
	            $('#successMessage').text(response);
	            $('#successModal').modal('show');
	            fetchProducts(currentPage);  
	        },
	        error: function(err) {
	            $('#errorMessage').text('Error saving product: ' + err.responseText);
	            $('#errorModal').modal('show');
	        }
	    });
	}
	</script>
	<!-- order codes  -->
	<script type="text/javascript">
	let currentOrderPage = 1;
	const orderPageSize = 10;

	function fetchOrders(page) {
	    const searchQuery = $('#orderSearch').val();
	    const vendorId = '${sessionScope.loggedInUserId}'; 

	    $.ajax({
	        url: 'getAllOrdersByVendorId',
	        type: 'GET',
	        data: {
	            page: page,
	            size: orderPageSize,
	            query: searchQuery,
	            vendorId: vendorId
	        },
	        dataType: 'json',
	        success: function (response) {
	            populateOrderTable(response.orders);
	            updateOrderPagination(response.totalPages, page);
	        },
	        error: function (xhr) {
	            console.error('Error fetching orders:', xhr);
	        }
	    });
	}
	function populateOrderTable(orders) {
	    console.log(orders);
	    const tableBody = $('#viewAllOrdersTableBody');
	    tableBody.empty();

	    if (orders.length === 0) {
	        tableBody.append('<tr><td colspan="8" class="text-center">No Orders found.</td></tr>');
	        return;
	    }

	    orders.forEach((order, index) => {
	        var row = '<tr>' +
	            '<td>' + (index + 1) + '</td>' +  // Serial number starting from 1
	            '<td>' + order.orderId + '</td>' +
	            '<td>' + order.productName + '</td>' +
	            '<td>' + order.orderQuantity + '</td>' +
	            '<td>' + order.orderDate + '</td>' +
	            '<td>' + (order.deliveryDate || 'N/A') + '</td>' +
	            '<td>' + order.orderStatus + '</td>' +
	            '<td>' +
	            '<button class="btn btn-info view-order" data-id="' + order.orderId + '"><i class="fas fa-eye"></i> View</button>' +
	            '</td>' +
	            '</tr>';
	        tableBody.append(row);
	    });

	    // Attach click event handler for the view-order buttons
	    $('.view-order').click(function() {
	        const orderId = $(this).data('id');
	        viewOrder(orderId);
	    });
	}


	function updateOrderPagination(totalPages, currentPage) {
	    const pagination = $('#orderPagination');
	    pagination.empty();

	    if (totalPages <= 1) return;

	    pagination.append('<li class="page-item"><a class="page-link" href="#" onclick="prevPageOrders()">Previous</a></li>');

	    for (let i = 1; i <= totalPages; i++) {
	        const activeClass = (i == currentPage) ? 'active' : '';
	        pagination.append('<li class="page-item ' + activeClass + '"><a class="page-link" href="#" onclick="goToOrderPage(' + i + ')">' + i + '</a></li>');
	    }

	    pagination.append('<li class="page-item"><a class="page-link" href="#" onclick="nextPageOrders()">Next</a></li>');
	}

	// Pagination Controls
	function prevPageOrders() {
	    if (currentOrderPage > 1) {
	        currentOrderPage--;
	        fetchOrders(currentOrderPage);
	    }
	}

	function nextPageOrders() {
	    if (currentOrderPage < $('#orderPagination li').length - 2) {
	        currentOrderPage++;
	        fetchOrders(currentOrderPage);
	    }
	}

	function goToOrderPage(page) {
	    currentOrderPage = page;
	    fetchOrders(currentOrderPage);
	}

	// View Order Details Function
let orderProductID;
let orderInvoiceFile;
let paymentInvoiceFile;

function viewOrder(orderId) {
    $.ajax({
        url: 'getOrderById', // Replace with your actual endpoint
        method: 'GET',
        data: { orderId: orderId },
        success: function(order) {

            if (!order || typeof order !== 'object') {
                return;
            }

            // Populate the modal with order details
            $('#editOrderModal #orderId').text(order.orderId);
            $('#editOrderModal #orderId').val(order.orderId);
            $('#editOrderModal #productName').text(order.productName);
            $('#editOrderModal #orderQuantity').text(order.orderQuantity);
            $('#editOrderModal #orderDate').text(order.orderDate);
            $('#editOrderModal #deliveryDate').text(order.deliveryDate);
            $('#editOrderModal #deliveryAddress').text(order.deliveryAddress);
            $('#editOrderModal #message').text(order.message || 'No message available');
            $('#editOrderModal #orderStatus').text(order.orderStatus);
            $('#editOrderModal #orderPaymentStatus').text(order.paymentStatus || 'NA');
            
            // Store order ID for future reference
            orderProductID = order.orderId;

            // Hide the invoice upload section initially
            document.getElementById('uploadInvoiceSection').style.display = 'none';

            // Store invoice file paths
            orderInvoiceFile = order.orderInvoicePath; // Assuming order contains this property
            paymentInvoiceFile = order.paymentInvoicePath; // Assuming order contains this property
            console.log(paymentInvoiceFile);

            // Get the order status div
            const orderStatusDiv = document.getElementById('orderStatusDiv');

            // Check the order status and update the modal accordingly
            if (order.orderStatus.toLowerCase() === 'confirmed' || order.orderStatus.toLowerCase() === 'order') {
                $('#editOrderModal #SelectOrderStatus').val(order.orderStatus); // Set the status
                orderStatusDiv.style.display = 'block'; // Show the order status dropdown if status is 'confirmed' or 'order'
            } else {
                orderStatusDiv.style.display = 'none'; // Hide the order status dropdown for other statuses
            }

            // Show invoice buttons if file paths exist
            if (orderInvoiceFile) {
                $('#editOrderModal #viewOrderInvoice').show();
            } else {
                $('#editOrderModal #viewOrderInvoice').hide();
            }

            if (paymentInvoiceFile) {
                $('#editOrderModal #viewPaymentInvoice').show();
            } else {
                $('#editOrderModal #viewPaymentInvoice').hide();
            }

            // Show the modal
            $('#editOrderModal').modal('show');
        },
        error: function(err) {
            $('#errorMessage').text('Error fetching order details.');
            $('#errorModal').modal('show');
        }
    });
}

// Function to open order invoice files in a new window
function openOrderInvoice() {
    if (orderInvoiceFile) {
        console.log(orderInvoiceFile);
        const url = 'displayInvoice?filePath=' + encodeURIComponent(orderInvoiceFile);
        window.open(url, '_blank');
    } else {
        alert('No invoice available.');
    }
}

// Function to open payment invoice files in a new window
function openPaymentInvoice() {
    if (paymentInvoiceFile) {
        console.log(paymentInvoiceFile);
        const url = 'displayInvoice?filePath=' + encodeURIComponent(paymentInvoiceFile);
        window.open(url, '_blank');
    } else {
        alert('No invoice available.');
    }
}

// Function to view order product details
function viewOrderProduct() {
    if (orderProductID) {
        viewProducts(orderProductID);
    } else {
        $('#errorMessage').text('Error fetching product details.');
        $('#errorModal').modal('show');
    }
}

// Handle status change and show/hide upload invoice section
document.getElementById('SelectOrderStatus').addEventListener('change', function() {
    const selectedStatus = this.value;
    const uploadInvoiceSection = document.getElementById('uploadInvoiceSection');

    // Show/Hide "Upload Invoice" section based on status
    if (selectedStatus === 'delivered') {
        uploadInvoiceSection.style.display = 'block';
    } else {
        uploadInvoiceSection.style.display = 'none';
    }
});

    function submitOrder() {
        const vendorId = '${sessionScope.loggedInUserId}'; // Ensure this is properly set on the server side

        // Validate vendorId
        if (!vendorId || isNaN(vendorId)) {
            return;
        }

        // Collect form data
        const orderStatus = $('#SelectOrderStatus').val();
        const orderId = $('#orderId').val();
        const fileInput = $('#fileInput')[0].files[0];

        // Validate file if orderStatus is 'delivered'
        if (orderStatus === 'delivered' && !fileInput) {
            alert('Please upload an invoice before submitting the status as "Delivered".');
            return; // Stop submission if no file is uploaded
        }

        // Create FormData object to include the file
        const formData = new FormData();
        formData.append('orderStatus', orderStatus);
        formData.append('orderId', orderId);
        if (fileInput) {
            formData.append('file', fileInput); // Attach the invoice file if uploaded
        }

        $.ajax({
            url: 'submitOrderStatus', // Your endpoint URL
            method: 'POST',
            processData: false, // Important for FormData
            contentType: false, // Important for FormData
            data: formData,
            success: function(response) {
                $('#successMessage').text('Order status and invoice submitted successfully!');
                $('#successModal').modal('show');
                $('#editOrderModal').modal('hide');
                fetchOrders(currentPage); // Refresh orders list
            },
            error: function(err) {
                $('#errorMessage').text('There was an error submitting the order status: ' + err.responseText);
                $('#errorModal').modal('show');
            }
        });
    }

   
</script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.2/jspdf.min.js"></script>
	<script>
		function downloadPDF() {
			const orderId = $("#orderId").text().trim();
			if (!orderId) {
				console.error("Order ID is missing.");
				return;
			}

			const doc = new jsPDF();
			doc.setFont("Arial");

			// Add page border
			doc.rect(5, 5, 200, 280); // Border with (x, y, width, height)

			// Add header
			doc.setFontSize(20);
			doc.setFont("bold");
			doc.text("xworkz vendor management ", 70, 18, {
				align : "center"
			});

			// Add download time and date
			const currentDate = new Date().toLocaleDateString();
			const currentTime = new Date().toLocaleTimeString();
			doc.setFontSize(10);
			doc.text("Downloaded on: " + currentDate + " " + currentTime, 135,
					24);

			// Add complaint details
			doc.setFontSize(14);
			doc.text("Order Details", 70, 35, {
				align : "center"
			});
			doc.setFontSize(10);
			doc.text("Order ID: " + orderId, 10, 50);
			doc.text("Product Name: "
					+ $("#editOrderModal #productName").text().trim(), 10, 60);
			doc.text("Product Price: "
					+ $("#editOrderModal #productPrice").text().trim(), 10, 70);
			doc.text("Delivery Charge: "
					+ $("#editOrderModal #deliveryCharge").text().trim(), 10,
					80);
			doc.text("Description About Product: "
					+ $("#editOrderModal #descriptionAboutProduct").text()
							.trim(), 10, 90);
			doc.text("Order Date: " + $("#orderDate").text().trim(), 10, 100);
			doc.text("Order Quantity: " + $("#orderQuantity").text().trim(),
					10, 110);
			doc.text("Delivery Date: " + $("#deliveryDate").text().trim(), 10,
					120);
			doc.text(
					"Delivery Address: " + $("#deliveryAddress").text().trim(),
					10, 130);
			doc.text("Message: " + $("#message").text().trim(), 10, 140);
			doc.text("Order Status: " + $("#orderStatus").text().trim(), 10,
					150);

			// Add signature at the bottom
			doc.text("Signature", 170, 240, {
				align : "center"
			});

			// Add footer
			doc.setFontSize(10);
			doc.text("Website: http://localhost:8080/VendoraX",
					15, 265);
			doc.text("Email: xworkzvendormanagement@gmail.com", 15, 272);
			doc.text("Phone: +919834567890", 15, 279);
			doc.text("Address: 123 Main Street, Bengaluru, Karnataka, India",
					15, 284);

			// Save the PDF
			doc.save("order_details_" + orderId + ".pdf");
		}
	</script>

	<script>
    let currentOrderHistoryPage = 1;
    const orderPageHistorySize = 10;

    function fetchOrderHistory(page) {
        const searchQuery = $('#orderHistorySearch').val();
        const vendorId = '${sessionScope.loggedInUserId}'; // Vendor ID from session

        $.ajax({
            url: 'getAllOrderHistoryByVendorId',
            type: 'GET',
            data: {
                page: page,
                size: orderPageHistorySize,
                query: searchQuery,
                vendorId: vendorId
            },
            dataType: 'json',
            success: function (response) {
                populateOrderHistoryTable(response.orders);
                updateOrderHistoryPagination(response.totalPages, page);
            },
            error: function (xhr) {
                console.error('Error fetching orders:', xhr);
            }
        });
    }

    function populateOrderHistoryTable(orders) {
        const tableBody = $('#orderHistoryTableBody');
        tableBody.empty();

        if (orders.length === 0) {
            tableBody.append('<tr><td colspan="8" class="text-center">No Orders found.</td></tr>');
            return;
        }

        orders.forEach((order, index) => {
            // Calculate the correct index based on current page and order index
            const serialNumber = (currentOrderHistoryPage - 1) * orderPageHistorySize + (index + 1);
            const row = '<tr>' +
                '<td>' + serialNumber + '</td>' +
                '<td>' + order.orderId + '</td>' +
                '<td>' + order.productName + '</td>' +
                '<td>' + order.orderQuantity + '</td>' +
                '<td>' + order.orderDate + '</td>' +
                '<td>' + (order.deliveryDate || 'N/A') + '</td>' +
                '<td>' + order.orderStatus + '</td>' +
                '<td>' +
                '<button class="btn btn-info view-order" data-id="' + order.orderId + '">' +
                '<i class="fas fa-eye"></i> View</button>' +
                '</td>' +
                '</tr>';
            tableBody.append(row);
        });

        // Attach click event handler for the view-order buttons
        $('.view-order').click(function() {
            const orderId = $(this).data('id');
            viewOrder(orderId);
        });
    }

    function updateOrderHistoryPagination(totalPages, currentPage) {
        const pagination = $('#orderPaginationHistory');
        pagination.empty();

        if (totalPages <= 1) return;

        pagination.append('<li class="page-item ' + (currentPage === 1 ? 'disabled' : '') + '">' +
            '<a class="page-link" href="#" onclick="prevPageOrdersHistory()">Previous</a>' +
            '</li>');

        for (let i = 1; i <= totalPages; i++) {
            const activeClass = (i === currentPage) ? 'active' : '';
            pagination.append('<li class="page-item ' + activeClass + '">' +
                '<a class="page-link" href="#" onclick="goToOrderHistoryPage(' + i + ')">' + i + '</a>' +
                '</li>');
        }

        pagination.append('<li class="page-item ' + (currentPage === totalPages ? 'disabled' : '') + '">' +
            '<a class="page-link" href="#" onclick="nextPageOrdersHistory()">Next</a>' +
            '</li>');
    }


    // Pagination Controls
    function prevPageOrdersHistory() {
        if (currentOrderHistoryPage > 1) {
            currentOrderHistoryPage--;
            fetchOrderHistory(currentOrderHistoryPage);
        }
    }

    function nextPageOrdersHistory() {
        const totalPages = $('#orderPaginationHistory .page-item').length - 2; // Exclude previous and next buttons
        if (currentOrderHistoryPage < totalPages) {
            currentOrderHistoryPage++;
            fetchOrderHistory(currentOrderHistoryPage);
        }
    }

    function goToOrderHistoryPage(page) {
        currentOrderHistoryPage = page;
        fetchOrderHistory(currentOrderHistoryPage);
    }

    // Initial fetch
    $(document).ready(function() {
        fetchOrderHistory(currentOrderHistoryPage);
    });
</script>

	<script>
let currentPaymentSummaryPage = 1;
const paymentPageSize = 10;

function fetchPaymentSummary(page) {
    const searchQuery = $('#paymentSummarySearch').val();
    const vendorId = '${sessionScope.loggedInUserId}'; // Vendor ID from session

    $.ajax({
        url: 'getAllPaymentSummaryByVendorId', // Replace with your payment summary endpoint
        type: 'GET',
        data: {
            page: page,
            size: paymentPageSize,
            query: searchQuery,
            vendorId: vendorId
        },
        dataType: 'json',
        success: function (response) {
            populatePaymentSummaryTable(response.payments);
            updatePaymentSummaryPagination(response.totalPages, page);
        },
        error: function (xhr) {
            console.error('Error fetching payments:', xhr);
        }
    });
}

function populatePaymentSummaryTable(payments) {
    const tableBody = $('#paymentSummaryTableBody');
    tableBody.empty();

    if (payments.length === 0) {
        tableBody.append('<tr><td colspan="7" class="text-center">No Payments found.</td></tr>');
        return;
    }

    payments.forEach((payment, index) => {
        // Calculate the correct index based on current page and payment index
        const serialNumber = (currentPaymentSummaryPage - 1) * paymentPageSize + (index + 1);
        const row = '<tr>' +
                        '<td>' + serialNumber + '</td>' +
                        '<td>' + payment.paymentId + '</td>' +
                        '<td>' + payment.orderId + '</td>' +
                        '<td>' + payment.orderAmount + '</td>' +
                        '<td>' + payment.paymentDate + '</td>' +
                        '<td>' + payment.paymentStatus + '</td>' +
                        '<td>' +
                            '<button class="btn btn-outline-info view-invoice" data-id="' + payment.paymentInvoicePath + '">' +
                                '<i class="fas fa-file-invoice"></i> View Invoice' +
                            '</button>' +
                        '</td>' +
                    '</tr>';
        tableBody.append(row);
    });


    // Attach click event handler for the view-invoice buttons
    $('.view-invoice').click(function() {
        const invoicePath = $(this).data('id');
        viewInvoice(invoicePath); // Define viewInvoice to handle invoice viewing logic
    });
}

function updatePaymentSummaryPagination(totalPages, currentPage) {
    const pagination = $('#paymentPaginationSummary');
    pagination.empty();

    if (totalPages <= 1) return;

    pagination.append('<li class="page-item ' + (currentPage === 1 ? 'disabled' : '') + '">' +
            '<a class="page-link" href="#" onclick="prevPagePaymentSummary()">Previous</a>' +
        '</li>');

    for (let i = 1; i <= totalPages; i++) {
        const activeClass = (i === currentPage) ? 'active' : '';
        pagination.append('<li class="page-item ' + activeClass + '">' +
                '<a class="page-link" href="#" onclick="goToPaymentSummaryPage(' + i + ')">' + i + '</a>' +
            '</li>');
    }

    pagination.append('<li class="page-item ' + (currentPage === totalPages ? 'disabled' : '') + '">' +
            '<a class="page-link" href="#" onclick="nextPagePaymentSummary()">Next</a>' +
        '</li>');
}


// Pagination Controls
function prevPagePaymentSummary() {
    if (currentPaymentSummaryPage > 1) {
        currentPaymentSummaryPage--;
        fetchPaymentSummary(currentPaymentSummaryPage);
    }
}

function nextPagePaymentSummary() {
    const totalPages = $('#paymentPaginationSummary .page-item').length - 2; // Exclude previous and next buttons
    if (currentPaymentSummaryPage < totalPages) {
        currentPaymentSummaryPage++;
        fetchPaymentSummary(currentPaymentSummaryPage);
    }
}

function goToPaymentSummaryPage(page) {
    currentPaymentSummaryPage = page;
    fetchPaymentSummary(currentPaymentSummaryPage);
}

function viewInvoice(invoicePath) {
    if (invoicePath) {
        const url = 'displayInvoice?filePath=' + encodeURIComponent(invoicePath);
        window.open(url, '_blank');
    } else {
        alert('No invoice available.');
    }
}




</script>
	<script>
function onName() {
	var userName = document.getElementById("ownerName").value.trim();

	var isValidLength = userName.replace(/\s+/g, '').length >= 3;

	var isValidCharacters = /^[A-Za-z\s]+$/.test(userName);

	if (isValidLength && isValidCharacters) {
		document.getElementById("errorownerName").innerHTML = "";
		document.getElementById("button").disabled = false;
	} else {
		document.getElementById("errorownerName").innerHTML = "Username must be at least 3 alphabetic characters";
		document.getElementById("button").disabled = true;
	}
}
// Function to validate vedor name
function onVendorName() {
	var userName = document.getElementById("vendorName").value.trim();

	var isValidLength = userName.replace(/\s+/g, '').length >= 3;

	var isValidCharacters = /^[A-Za-z\s]+$/.test(userName);

	if (isValidLength && isValidCharacters) {
		document.getElementById("errorVendorName").innerHTML = "";
		document.getElementById("button").disabled = false;
	} else {
		document.getElementById("errorVendorName").innerHTML = "VendorName must be at least 3 alphabetic characters";
		document.getElementById("button").disabled = true;
	}
}

// Function to validate alternate contact number
function validateAltContactNumber() {
	var number = document.getElementById("contactNumber").value;
	var altNumber = document.getElementById("altContactNumber").value;
	var numberRegex = /^[0-9]{10}$/;
	if (numberRegex.test(altNumber) && number !== altNumber) {
		document.getElementById("erroraltContactNumber").innerHTML = "";
		document.getElementById("button").disabled = false;
	} else {
		document.getElementById("erroraltContactNumber").innerHTML = number === altNumber ? "Contact and alternate number cannot be same"
				: "Enter 10 digits number";
		document.getElementById("button").disabled = true;
	}
}

// Function to validate pincode
function validatePincode() {
	var pincode = document.getElementById("pincode").value;
	var pincodeRegex = /^\d{6}$/;
	if (pincodeRegex.test(pincode)) {
		document.getElementById("errorpincode").innerHTML = "";
		document.getElementById("button").disabled = false;
	} else {
		document.getElementById("errorpincode").innerHTML = "Pincode must be 6 digits";
		document.getElementById("button").disabled = true;
	}
}

function onGSTNumber() {
    var gstInput = document.getElementById('gstNumber');
    var gstValue = gstInput.value.trim();
    var gstRegex = /^[A-Za-z0-9]{15}$/;

    // Check if the GST number matches the required format
    if (gstRegex.test(gstValue)) {
        document.getElementById("errorGSTNumber").innerText = "";
        document.getElementById("submitBtn").disabled = false;
    } else {
        // Display error if the format is incorrect
        document.getElementById("errorGSTNumber").innerText = "GST number should contain 15 alphanumeric characters";
        document.getElementById("submitBtn").disabled = true;
    }
}
function onWebsite() {
    var websiteInput = document.getElementById('website');
    var websiteValue = websiteInput.value.trim();
    var websiteRegex = /^(http(s)?:\/\/)?(www\.)?[a-zA-Z0-9-]+\.[a-zA-Z]{2,}(\.[a-zA-Z]{2,})?$/;

    // Check if the website matches the required format
    if (websiteRegex.test(websiteValue)) {
        document.getElementById("errorWebsite").innerText = "";
        document.getElementById("submitBtn").disabled = false;
    } else {
        // Display error if the format is incorrect
        document.getElementById("errorWebsite").innerText = "Invalid website format";
        document.getElementById("submitBtn").disabled = true;
    }
}

function validateContactNumber() {
    var contactNumber = document.getElementById("contactNumber").value;

    // Check if the contact number is a valid 10-digit number
    if (/^\d{10}$/.test(contactNumber)) {
        document.getElementById("errorContactNumber").innerHTML = "";
        document.getElementById("submitBtn").disabled = false;
    } else {
        // Display error if the format is incorrect
        document.getElementById("errorContactNumber").innerText = "Contact number should be a valid 10-digit number";
        document.getElementById("submitBtn").disabled = true;
    }
}


</script>
	<script
		src="https://cdn.jsdelivr.net/npm/sockjs-client@1.4.0/dist/sockjs.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>
	<script>
    let stompClient = null;
    let userId = '${sessionScope.loggedInUserId}'; 
    let userChatImage='${sessionScope.userProfileImage}';
    function connect() {
       const socket = new SockJS('/VendoraX/chat-websocket');
        stompClient = Stomp.over(socket);
        stompClient.connect({}, function (frame) {
            console.log('Connected: ' + frame);
            stompClient.subscribe('/topic/messages', function (messageOutput) {
                const message = JSON.parse(messageOutput.body);
                if (message.toUser === userId || message.fromUser === userId) {
                	
                	  const timestamp = new Date(message.timestamp); // This is the ISO string from the backend
                     
                    displayMessage(message.message, message.fromUser === 'admin' ? 'admin' : 'user',timestamp);
                }
            });
            loadChatHistory();
        });
    }
function sendMessage() {
	  const messageInput = document.getElementById('chatMessage');
	    const message = messageInput.value.trim(); // Trim any whitespace
	    if (message === '') {
	        
	        return; 
	    }
    
    const chatMessage = {
        fromUser: userId,  
        toUser: "admin",   
        message: message
    };

    stompClient.send("/sendMessage", {}, JSON.stringify(chatMessage));
  
    document.getElementById('chatMessage').value = '';  // Clear the input field
    console.log('Message sent:', chatMessage); // Log for confirmation
}

//Object to store messages by date
const messagesByDate = {};

function displayMessage(message, sender, timestamp) {
    const chatBox = document.getElementById('chat-box');

    // Get the formatted date based on the timestamp
    const { date } = formatTimestampForDisplay(timestamp);

    // Check if the date header already exists in messagesByDate
    if (!messagesByDate[date]) {
        messagesByDate[date] = []; // Initialize the array if it doesn't exist
    }

    // Add the new message to the appropriate date array
    messagesByDate[date].push({ message, sender, timestamp });

    // Clear the chat box to display all messages
    chatBox.innerHTML = '';

    // Loop through the messages by date to render them
    for (const msgDate in messagesByDate) {
        // Create a date header element
        const dateHeader = document.createElement('div');
        dateHeader.classList.add('date-header');
        dateHeader.innerText = msgDate; // Set the date header text
        dateHeader.style.textAlign = 'center'; // Center align
        dateHeader.style.fontWeight = 'bold'; // Bold font for the header
        dateHeader.style.margin = '10px 0'; // Margin for spacing
        chatBox.appendChild(dateHeader); // Append header to chat box

        // Loop through messages for this date
        messagesByDate[msgDate].forEach(msg => {
            // Create message container
            const messageElement = document.createElement('div');
            messageElement.classList.add('message');
            messageElement.classList.add(msg.sender === 'admin' ? 'admin-message' : 'user-message');

            // Create avatar container
            const avatarElement = document.createElement('div');
            avatarElement.classList.add('avatar');

            // Check if sender is admin or user and set respective avatar image
            if (msg.sender === 'admin') {
            	 avatarElement.innerHTML = '<img src="res/images/vendor comapany logo.webp" alt="Admin">';
            } else {
                // Assuming user image comes from session or backend (replace with actual session value)
                avatarElement.innerHTML = '<img src="display?imagePath=' + userChatImage + '" alt="User">';
            }

            // Create message content container
            const messageContentElement = document.createElement('div');
            messageContentElement.classList.add('message-content'); // Add a class for styling the content

            // Get formatted time string based on the timestamp
            const { time } = formatTimestampForDisplay(msg.timestamp); // Extract only the time

            // Create time element
            const timeElement = document.createElement('span');
            timeElement.classList.add('text-muted', 'message-time');
            timeElement.style.fontSize = '12px'; // Small text
            timeElement.innerText = time; // Set the time text

            // Create a div for the message text that contains the time element
            const messageTextContainer = document.createElement('div');
            messageTextContainer.style.display = 'flex'; // Use flex to align items
            messageTextContainer.style.justifyContent = 'space-between'; // Space between to align message and time
            messageTextContainer.style.alignItems = 'center'; // Align items vertically in the center

            // Append the message text to the messageTextContainer
            messageTextContainer.innerText = msg.message; // Add message text
            messageTextContainer.appendChild(timeElement); // Add time element

            // Append message text container to message content element
            messageContentElement.appendChild(messageTextContainer); // Add the message text container

            // Append avatar and message content to message element
            messageElement.appendChild(avatarElement);
            messageElement.appendChild(messageContentElement);

            // Append message element to chat box
            chatBox.appendChild(messageElement);
        });
    }

    // Scroll chat to the bottom
    chatBox.scrollTop = chatBox.scrollHeight;
}

// Helper function to format the timestamp for display
function formatTimestampForDisplay(timestampArray) {
    
    let messageDate;
    if (timestampArray instanceof Date) {
        messageDate = timestampArray;
    } else {
        messageDate = new Date(
            timestampArray[0], // Year
            timestampArray[1] - 1, // Month (subtract 1 because JS months are zero-indexed)
            timestampArray[2], // Day
            timestampArray[3], // Hour
            timestampArray[4], // Minute
            timestampArray[5] // Second
        );
    }

    const now = new Date();
    const timeOptions = { hour: 'numeric', minute: 'numeric', hour12: true };

    // Check if the message was sent today
    const isToday = now.toDateString() === messageDate.toDateString();

    // Check if the message was sent yesterday
    const isYesterday = new Date(now.setDate(now.getDate() - 1)).toDateString() === messageDate.toDateString();

    let formattedDate, formattedTime;

    if (isToday) {
        formattedDate = 'Today';
    } else if (isYesterday) {
        formattedDate = 'Yesterday';
    } else {
        const dateOptions = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
        formattedDate = messageDate.toLocaleDateString('en-IN', dateOptions);
    }

    formattedTime = messageDate.toLocaleTimeString('en-IN', timeOptions);

    return {
        date: formattedDate,
        time: formattedTime
    };
}

    // Load chat history using AJAX
 function loadChatHistory() {
    $.ajax({
        url: 'messageHistory/' + userId, // Added missing '/'
        method: 'GET',
        dataType: 'json',
        success: function(messages) {
            const chatBox = $('#chat-box');
            chatBox.empty();  // Clear chatbox
            messages.forEach(msg => {
            	displayMessage(msg.message, msg.fromUser === 'admin' ? 'admin' : 'user',msg.timestamp);
            });
        },
        error: function(xhr, status, error) {
            
            const chatBox = $('#chat-box');
            chatBox.html('<div class="error-message">Error loading chat history. Please try again later.</div>');
        }
    });
}



    $(document).ready(function () {
        connect();
    });
</script>
	<script type="text/javascript">
let currentUserId = '${sessionScope.loggedInUserId}'; 
function fetchNotifications(currentUserId) {
	console.log(currentUserId);
    $.ajax({
        url: 'notifications/' + currentUserId,
        method: 'GET',
        dataType: 'json',
        success: function(notifications) {
            renderNotifications(notifications);
        },
        error: function(xhr, status, error) {
            renderNotifications([]); // Show no notifications on error
        }
    });
}

//Render the notifications in the dropdown menu
function renderNotifications(notifications) {
    // Select the notification dropdown menu specifically
    const dropdownMenu = $('#notificationContainer .dropdown-menu');
    dropdownMenu.empty(); // Clear previous notifications

    if (notifications.length === 0) {
        dropdownMenu.html('<li><a class="dropdown-item" href="#">No notifications</a></li>');
    } else {
        // Add "Mark all as read" button at the top of the dropdown
        dropdownMenu.append('<li><a class="dropdown-item text-center text-primary" href="#" onclick="markAllAsRead()">Mark all as read</a></li>');
        dropdownMenu.append('<li><hr class="dropdown-divider"></li>'); // Divider

        // Sort notifications by timestamp (most recent first)
        notifications.sort((a, b) => new Date(...b.timestamp) - new Date(...a.timestamp));

        notifications.forEach(function(notification) {
            // Convert the timestamp to "Saturday, July 13 11:28 AM" format
            const formattedTimestamp = formatDateFromArray(notification.timestamp);

            // Construct each notification item using string concatenation, adding border, shadow, margin styles, and word wrapping
            const notificationItemHtml = 
                '<li style="margin-bottom: 10px;">' + 
                    '<a class="dropdown-item" href="#" onclick="markAsRead(' + notification.id + ')" style="border: 1px solid #e3e3e3; border-radius: 5px; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); padding: 10px;  word-wrap: break-word;">' + 
                        '<div>' + 
                            '<strong>' + notification.type + '</strong><br>' + // Adding the notification type
                            '<span style="white-space: normal; display: inline-block; max-width: 100%;">' + notification.message + '</span><br>' + // The message content (break long words)
                            '<span class="text-muted" style="font-size: 12px;">' + formattedTimestamp + '</span>' + // The formatted timestamp
                        '</div>' + 
                    '</a>' + 
                '</li>';

            // Convert the HTML string into a jQuery object and append it to the dropdown menu
            const notificationItem = $(notificationItemHtml);
            dropdownMenu.append(notificationItem);
        });
    }

    // Update the badge count
    $('#notificationDropdown .badge').text(notifications.length);
}



function formatDateFromArray(timestampArray) {
    // Destructure the array to get year, month, day, etc.
    const [year, month, day, hour, minute, second, millisecond] = timestampArray;

    // Correct the millisecond part by limiting it to three digits
    const validMillisecond = Math.floor(millisecond / 1_000_000);

    // Create a new Date object (Note: Subtract 1 from the month since JavaScript months are zero-indexed)
    const date = new Date(year, month - 1, day, hour, minute, second, validMillisecond);

    // Check if the date is valid
    if (isNaN(date.getTime())) {
        return 'Invalid Date'; // Return a fallback string if the date is invalid
    }

    // Formatting options for the desired output: "Thursday, 10 October 2024 at 06:03 PM"
    const options = {
        weekday: 'long',  // e.g., "Thursday"
        year: 'numeric',  // e.g., "2024"
        month: 'long',    // e.g., "October"
        day: 'numeric',   // e.g., "10"
        hour: 'numeric',  // e.g., "06"
        minute: 'numeric', // e.g., "03"
        second: undefined, // You can omit seconds if not needed
        hour12: true      // 12-hour format with AM/PM
    };

    // Return the formatted date string using the 'en-IN' locale for Indian date format
    return date.toLocaleString('en-IN', options);
}

// Mark notification as read
function markAsRead(notificationId) {
    $.ajax({
        url: 'notificationsRead/' + notificationId + '?userId=' + currentUserId,
        method: 'PUT',
        success: function() {
            // Fetch updated notifications after marking as read
            fetchNotifications(currentUserId); // Ensure to define currentUserId based on your context
        },
        error: function(xhr, status, error) {
          
        }
    });
}


function markAllAsRead() {
    $.ajax({
        url: 'markAllAsRead/' + currentUserId, // Updated to match your controller's endpoint
        method: 'PUT',
        success: function(response) {
            fetchNotifications(currentUserId); // Fetch updated notifications after marking all as read
        },
        error: function(xhr, status, error) {
        }
    });
}



// Call this function to load notifications when needed
// For example, you might call this after user login or at regular intervals
function loadNotifications() {
    fetchNotifications(currentUserId);
}

// Example: Load notifications when the page is ready
$(document).ready(function() {
    loadNotifications(); // Call to fetch notifications when the page loads
    setInterval(loadNotifications, 5000);
});

</script>

</body>

</html>

