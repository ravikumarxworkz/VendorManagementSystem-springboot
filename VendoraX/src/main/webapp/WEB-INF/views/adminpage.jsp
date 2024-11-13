<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<c:if
	test="${empty sessionScope.loggedInAdminEmail || empty sessionScope.loggedInAdminId}">
	<c:redirect url="homePage" />
</c:if>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>vendoraX-admin Menu 👤</title>
<link rel="shortcut icon" href="res/images/vendor comapany logo.webp"
	type="image/x-icon">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<script src="res/validation.js"></script>
<link rel="stylesheet" href="res/css/adminpage.css">
<style>
.sidebar-header img {
	width: 100px;
}

#sidebar.active {
	transform: translateX(0); /* Slide in when active */
}

/* Close Button Styling */
.btn.close-btn {
	position: absolute;
	top: 10px;
	right: 20px;
	font-size: 24px;
	border: none;
	background: none;
}
</style>
</head>
<body>
	<button class="btn btn-primary d-md-none" id="sidebarToggle"
		onclick="toggleSidebar()">
		<i class="fas fa-bars"></i> Menu
	</button>
	<div class="container-fluid">

		<div class="row">
			<!-- Sidebar -->

			<div class="col-md-2 sidebar d-none d-md-block" id="sidebar">
				<div class="sidebar-header text-center">
					<button id="closeSidebar" class="btn btn-light ms-auto"
						onclick="toggleSidebar()">X</button>
					<!-- Close Button -->
					<img src="res/images/vendor comapany logo.webp" alt="Company Logo">
					<h3 class="mt-3">VendorX</h3>
				</div>
				<ul class="nav flex-column">
					<li class="nav-item"><a class="nav-link active" href="#"
						onclick="showSection('dashboard')"> <i
							class="fas fa-tachometer-alt"></i> DashBoard
					</a></li>
					<li class="nav-item"><a class="nav-link" href="#"
						onclick="showSection('vendors')"> <i class="fas fa-store"></i>
							Vendors
					</a></li>
					<li class="nav-item"><a class="nav-link" href="#"
						onclick="showSection('products')"> <i class="fas fa-box"></i>
							Products
					</a></li>
					<li class="nav-item"><a class="nav-link" href="#"
						onclick="showSection('orders')"> <i
							class="fas fa-clipboard-list"></i> Orders
					</a></li>
					<li class="nav-item"><a class="nav-link" href="#"
						onclick="showSection('orderStatus')"> <i
							class="fas fa-clipboard-list"></i> Order Status
					</a></li>
					<li class="nav-item"><a class="nav-link" href="#"
						onclick="showSection('history')"> <i class="fas fa-history"></i>
							Order History
					</a></li>
					<li class="nav-item"><a class="nav-link" href="#"
						onclick="showSection('orderTrack')"> <i class="fas fa-truck"></i>
							Order Tracking
					</a></li>
					<li class="nav-item"><a class="nav-link" href="#"
						onclick="showSection('payment')"> <i
							class="fas fa-credit-card"></i> Payments
					</a></li>
					<li class="nav-item"><a class="nav-link" href="#"
						onclick="showSection('messages')"> <i class="fas fa-envelope"></i>
							Messages
					</a></li>
					<li class="nav-item"><a class="nav-link" href="#"
						onclick="showSection('announcement')"> <i
							class="fas fa-bullhorn"></i> Announcement
					</a></li>
				</ul>
			</div>
			<!-- 	<div class="col-md-2 sidebar">
				<div class="sidebar-header text-center">
					<img src="res/images/vendor comapany logo.webp" alt="Company Logo">
					<h3 class="mt-3">VendorX</h3>
				</div>
				<ul class="nav flex-column">
					<li class="nav-item"><a class="nav-link active" href="#"
						onclick="showSection('dashboard')"><i
							class="fas fa-tachometer-alt"></i> DashBoard</a></li>
					<li class="nav-item"><a class="nav-link " href="#"
						onclick="showSection('vendors')"><i class="fas fa-store"></i>Vendors</a></li>
					<li class="nav-item"><a class="nav-link" href="#"
						onclick="showSection('products')"><i class="fas fa-box"></i>
							Products</a></li>
					<li class="nav-item"><a class="nav-link" href="#"
						onclick="showSection('orders')"><i
							class="fas fa-clipboard-list"></i> Orders</a></li>
					<li class="nav-item"><a class="nav-link" href="#"
						onclick="showSection('orderStatus')"> <i
							class="fas fa-clipboard-list"></i> Order Status
					</a></li>
					<li class="nav-item"><a class="nav-link" href="#"
						onclick="showSection('history')"><i class="fas fa-history"></i>
							Order History</a></li>
					<li class="nav-item"><a class="nav-link" href="#"
						onclick="showSection('orderTrack')"> <i class="fas fa-truck"></i>
							Order Tracking
					</a></li>
					<li class="nav-item"><a class="nav-link" href="#"
						onclick="showSection('payment')"><i class="fas fa-credit-card"></i>
							Payments</a></li>
					<li class="nav-item"><a class="nav-link" href="#"
						onclick="showSection('messages')"><i class="fas fa-envelope"></i>
							Messages</a></li>
					<li class="nav-item"><a class="nav-link" href="#"
						onclick="showSection('announcement')"><i
							class="fas fa-bullhorn"></i> Announcement</a></li>
				</ul>
			</div> -->

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
							<ul class="dropdown-menu" aria-labelledby="notificationDropdown">
								<li><a class="dropdown-item" href="#">No notifications</a></li>
							</ul>
						</div>

						<!-- Profile Dropdown -->
						<div class="dropdown" id="profileContainer">
							<button class="btn btn-outline-info dropdown-toggle"
								type="button" id="profileDropdown" data-bs-toggle="dropdown"
								aria-expanded="false">
								<img src="res/images/vendor comapany logo.webp"
									style="width: 30px; height: 30px;" alt="Profile Picture"
									class="rounded-circle"> <span id="userName"></span>
							</button>
							<ul class="dropdown-menu" aria-labelledby="profileDropdown">
								<li><a class="dropdown-item" href="adminLogout">Logout</a></li>
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
									<h5 class="card-title">Total Vendors</h5>
									<div class="display-4" id="totalVendorCount"></div>
									<!-- Updated with id -->
								</div>
							</div>
						</div>
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
						<div class="col-md-3">
							<div class="card bg-light">
								<div class="card-body">
									<h5 class="card-title">Received Orders</h5>
									<div class="display-4" id="receivedOrders"></div>
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
								<div class="col-md-4">
									<div class="card bg-light">
										<div class="card-body">
											<h5 class="card-title">Total Amount To Pay</h5>
											<div class="display-4" id="totalAmountToPay"></div>
											<!-- Updated with id -->
										</div>
									</div>
								</div>
								<div class="col-md-4">
									<div class="card bg-light">
										<div class="card-body">
											<h5 class="card-title">Amount Paid</h5>
											<div class="display-4" id="amountPaid"></div>
											<!-- Updated with id -->
										</div>
									</div>
								</div>
								<div class="col-md-4">
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
				<div id="vendors" class="section">
					<div class="row mt-4">
						<div class="col-md-12">
							<div class="card bg-light text-dark">
								<div class="card-body">

									<!-- Search Bar -->
									<input type="text"
										class="form-control mt-2 search-vendor-input"
										placeholder="Search Vendors by email" id="vendorSearch"
										onkeyup="fetchVendors(1)">

									<!-- Vendors Table -->
									<div class="table-responsive">
										<table id="viewAllVendorsTable"
											class="table table-striped mt-2">
											<thead class="table-info">
												<tr>
													<th>#</th>
													<th>Vendor ID</th>
													<th>Name</th>
													<th>Email</th>
													<th>Contact Number</th>
													<th>Alt Contact Number</th>
													<th>Status</th>
													<th>View</th>
													<!-- <th>Order</th> -->
												</tr>
											</thead>
											<tbody id="viewAllVendorTableBody"></tbody>
										</table>
									</div>

									<!-- Pagination -->
									<nav aria-label="Page navigation">
										<ul class="pagination justify-content-center"
											id="vendorPagination">
											<li class="page-item"><a class="page-link" href="#"
												onclick="prevPageVendors()">Previous</a></li>
											<li class="page-item"><a class="page-link" href="#"
												onclick="nextPageVendors()">Next</a></li>
										</ul>
									</nav>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div id="products" class="section">
					<div class="row mt-4">
						<div class="col-md-12">
							<div class="card bg-light text-dark">
								<div class="card-body">

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
													<th>view</th>
													<th>order</th>
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
													<th>Cancel</th>
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
				<div id="orderStatus" class="section">
					<div class="row mt-4">
						<div class="col-md-12">
							<div class="card bg-light text-dark">
								<div class="card-body">
									<!-- Search Bar -->
									<input type="text" class="form-control mt-2 search-order-input"
										placeholder="Search Orders by Product Name"
										id="orderStatusSearch" onkeyup="fetchOrderStatus(1)">

									<!-- Orders Table -->
									<div class="table-responsive">
										<table id="viewAllOrdersStatusTable"
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
											<tbody id="viewAllOrdersStatusTableBody"></tbody>
										</table>
									</div>

									<nav aria-label="Page navigation">
										<ul class="pagination justify-content-center"
											id="orderStatusPagination">
											<li class="page-item"><a class="page-link" href="#"
												onclick="prevPageOrderStatus()">Previous</a></li>
											<li class="page-item"><a class="page-link" href="#"
												onclick="nextPageOrderStatus()">Next</a></li>
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
				<div id="orderTrack" class="section">
					<h1 class="text-center">Order Tracking</h1>
					<div class="form-group row justify-content-center">
						<div class="col-sm-6">
							<input type="number" class="form-control" id="orderId"
								placeholder="Enter Order ID">
						</div>
						<div class="col-sm-2">
							<button id="trackOrderBtn" class="btn btn-primary">Track
								Order</button>
							<button id="clearResultBtn" class="btn btn-secondary ml-2">Clear</button>
						</div>
					</div>
					<div id="trackingResult" class="mt-4 track-container"></div>
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
				<div id="announcement" class="section">
					<button id="addAnnouncementBtn" class="btn btn-primary mb-4"
						data-bs-toggle="modal" data-bs-target="#announcementModal">
						<i class="fas fa-plus"></i> Add Announcement
					</button>
					<div class="col-lg-12 mt-3">
						<div class="table-responsive">
							<table class="table table-striped mt-2">
								<thead class="table-info">
									<tr>
										<th scope="col">ID</th>
										<th scope="col">Title</th>
										<th scope="col">Message</th>
										<th scope="col">Actions</th>
									</tr>
								</thead>
								<tbody id="AnnouncementDetailsTable">
									<!-- Data will be displayed here -->
								</tbody>
							</table>

						</div>
					</div>
				</div>
				<div id="messages" class="section">
					<div id="chat-container">
						<!-- Chat List (Users on the left) -->
						<div id="chat-list">
							<!-- Admin profile at the top -->
							<div id="admin-profile">
								<img src="res/images/vendor comapany logo.webp" alt="Admin">
								<h5>Admin</h5>
							</div>

							<!-- Search bar -->
							<input type="text" id="user-search" placeholder="Search users"
								onkeyup="filterUsers()">
							<div id="user-list"></div>
							<!-- User list will be rendered here -->
						</div>

						<!-- Chat Box -->
						<div id="chat-box">
							<div id="chat-header">
								<img src="https://via.placeholder.com/150" alt="Admin">
								<h4>
									<span id="current-user"></span>
								</h4>
							</div>

							<!-- Chat Box content -->
							<div id="chat-box-content"></div>
							<!-- Chat history will be rendered here -->

							<!-- Chat Input -->
							<div id="chat-input">
								<input type="text" id="message-input"
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
									<img id="userPhoto" src="" width="200px" height="200px"
										class="rounded-circle big-image img-fluid shadow"
										alt="User Profile Image">
									<h5 class="mt-3" id="ownerNameDisplay"></h5>
									<p class="text-muted" id="emailDisplay"></p>
								</div>

								<div class="col-md-8">
									<div class="row mb-3">
										<input type="hidden" id="vendorId">
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

									<div class="form-group text-center">
										<label for="vendorStatus">Select Vendor Status:</label> <select
											class="form-control" id="vendorStatus"
											style="width: 200px; display: inline-block;">
											<option value="approved">Approved</option>
											<option value="pending">Not Approved</option>
										</select>
									</div>

									<div class="text-center btn-group">
										<button type="button" class="btn btn-success"
											id="updateStatusBtn">Update Status</button>
										<button type="button" class="btn btn-danger" id="cancelBtn">Cancel</button>
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
					<input type="hidden" id="hiddenOrderId" name="orderId">
					<div class="row">
						<div class="col-md-6">
							<strong><i class="fas fa-info-circle"></i> Order Status:</strong>
							<select id="orderStatusSelect" class="form-control">
								<option value="">Select option</option>
								<option value="received">Received</option>
								<option value="not_received">Not Received</option>

								<!-- Add other statuses as needed -->
							</select>
						</div>
						<div class="col-md-6">
							<strong><i class="fas fa-money-check"></i> Payment:</strong> <select
								id="paymentStatusSelect" class="form-control">
								<option value="">Select option</option>
								<option value="paid">Paid</option>
								<option value="unpaid">Not Paid</option>
							</select> <br>
							<div id="uploadPaymentInvoiceSection" style="display: none;">
								<label for="fileInput" class="btn btn-info"> <span
									id="fileLabel"><i class="far fa-receipt"></i>Upload Bill
										Receipt</span> <input type="file" class="form-control-fil"
									id="fileInput" name="file" accept=".pdf">
								</label> <br>
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
						<!-- <button id="downloadPDFBtn" type="button"
							class="btn btn-outline-success" onclick="downloadPDF()">Download
							PDF</button> -->
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Close</button>
						<button type="button" class="btn btn-primary"
							id="sumbitOrderStatusBtn" onclick="submitOrder()">Submit</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Order Modal -->
	<div class="modal fade" id="orderProductModal" tabindex="-1"
		aria-labelledby="orderProductModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="orderProductModalLabel">
						<i class="fas fa-shopping-cart"></i> Order Product
					</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form id="orderProductForm">
						<input type="hidden" id="orderProductId" name="productId">
						<div class="row">
							<div class="col md-6">
								<label for="orderProductName" class="form-label"><i
									class="fas fa-cube"></i> Product Name</label>
								<p id="orderProductName" class="form-control-static"></p>
							</div>
							<div class="col md-6">
								<button type="button" class="btn btn-info ms-2"
									id="viewOrderProductBtn">
									<i class="fas fa-eye"></i> View Product
								</button>
							</div>
						</div>
						<!-- Quantity -->
						<div class="mb-3">
							<label for="orderQuantity" class="form-label"> <i
								class="fas fa-sort-numeric-up-alt"></i> Quantity
							</label> <input type="number" class="form-control" id="orderQuantity"
								name="orderQuantity" min="1" required>
						</div>

						<!-- Delivery Date -->
						<div class="mb-3">
							<label for="deliveryDate" class="form-label"> <i
								class="fas fa-calendar-alt"></i> Delivery Date
							</label> <input type="date" class="form-control" id="deliveryDate"
								name="deliveryDate" required>
						</div>

						<!-- Delivery Address -->
						<div class="mb-3">
							<label for="orderAddress" class="form-label"> <i
								class="fas fa-map-marker-alt"></i> Delivery Address
							</label>
							<textarea class="form-control" id="orderAddress"
								name="orderAddress" rows="3" required></textarea>
						</div>

						<!-- Message -->
						<div class="mb-3">
							<label for="orderMessage" class="form-label"> <i
								class="fas fa-envelope"></i> Message (Optional)
							</label>
							<textarea class="form-control" id="orderMessage"
								name="orderMessage" rows="3"
								placeholder="Any specific instructions or requests..."></textarea>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary" id="submitOrderBtn">
						<i class="fas fa-check"></i> Place Order
					</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="viewProductModal" tabindex="-1"
		aria-labelledby="viewProductModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="viewProductModalLabel">
						<i class="fas fa-eye"></i> View Product
					</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col">
							<div class="mb-3">
								<label for="viewCategory" class="form-label"><i
									class="fas fa-tags"></i> Category</label>
								<p id="viewCategory" class="form-control-static"></p>
							</div>
						</div>
						<div class="col">
							<div class="mb-3">
								<label for="viewProductName" class="form-label"><i
									class="fas fa-cube"></i> Product Name</label>
								<p id="viewProductName" class="form-control-static"></p>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col">
							<div class="mb-3">
								<label for="viewProductPrice" class="form-label"><i
									class="fas fa-dollar-sign"></i> Product Price (per item)</label>
								<p id="viewProductPrice" class="form-control-static"></p>
							</div>
						</div>
						<div class="col">
							<div class="mb-3">
								<label for="viewDeliveryCharge" class="form-label"><i
									class="fas fa-truck"></i> Delivery Charge</label>
								<p id="viewDeliveryCharge" class="form-control-static"></p>
							</div>
						</div>
					</div>
					<div class="mb-3">
						<label for="viewAvailable" class="form-label"><i
							class="fas fa-check-circle"></i> Available</label>
						<p id="viewAvailable" class="form-control-static"></p>
					</div>
					<div class="mb-3">
						<label for="viewDescriptionAboutProduct" class="form-label"><i
							class="fas fa-info-circle"></i> Description About Product</label>
						<p id="viewDescriptionAboutProduct" class="form-control-static"></p>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="announcementModal" tabindex="-1"
		aria-labelledby="announcementModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header border-0">
					<h5 class="modal-title" id="announcementModalLabel">Add
						Announcement</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form id="announcementForm" method="post">
						<div class="mb-3">
							<label for="title" class="form-label">Title</label>
							<div class="input-group">
								<span class="input-group-text"><i class="fas fa-heading"></i></span>
								<input type="text" class="form-control" id="title" name="title"
									required>
							</div>
						</div>
						<div class="mb-3">
							<label for="message" class="form-label">Description</label>
							<div class="input-group">
								<span class="input-group-text"><i
									class="fas fa-align-left"></i></span>
								<textarea class="form-control" id="message" name="message"
									rows="4" required></textarea>
							</div>
						</div>
						<button type="submit" class="btn btn-primary w-100">
							<i class="fas fa-save"></i> Save Announcement
						</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="deleteConfirmationModal" tabindex="-1"
		role="dialog" aria-labelledby="deleteConfirmationModalLabel"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header bg-danger text-white">
					<h5 class="modal-title" id="deleteConfirmationModalLabel">
						<i class="fas fa-exclamation-triangle"></i> Confirm Deletion
					</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body text-center">
					<i class="fas fa-trash-alt fa-3x text-danger mb-3"></i>
					<p class="lead">Are you sure you want to delete this
						announcement?</p>
					<input type="hidden" id="announcementID">
				</div>
				<div class="modal-footer justify-content-center">
					<button type="button" class="btn btn-outline-secondary"
						data-bs-dismiss="modal">
						<i class="fas fa-times"></i> Cancel
					</button>
					<button id="confirmDeleteBtn" type="button" class="btn btn-danger"
						onclick="deleteAnnouncement()">
						<i class="fas fa-trash"></i> Delete
					</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Cancel Order Modal -->
	<div class="modal fade" id="cancelOrderModal" tabindex="-1"
		aria-labelledby="cancelOrderModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="cancelOrderModalLabel">
						<i class="fas fa-times-circle"></i> Cancel Order
					</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p>Are you sure you want to cancel this order?</p>
					<p>
						<strong>Product Name:</strong> <span id="cancelProductName"></span>
					</p>
					<p>
						<strong>Order ID:</strong> <span id="cancelOrderId"></span>
					</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">
						<i class="fas fa-times"></i> Close
					</button>
					<button type="button" class="btn btn-danger"
						id="confirmCancelOrder">
						<i class="fas fa-check-circle"></i> Yes, Cancel Order
					</button>
				</div>
			</div>
		</div>
	</div>


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
	<script src="https://kit.fontawesome.com/a076d05399.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/sockjs-client@1.4.0/dist/sockjs.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>
	<script>
	/*====================== this code is part of sidebar naigation =================*/
     function toggleSidebar() {
        const sidebar = document.getElementById('sidebar');
        sidebar.classList.toggle('active'); // Show or hide sidebar
    }

	
	
  function showSection(section) {
    // Hide all sections
    document.querySelectorAll('.section').forEach(sec => {
        sec.classList.remove('active');
    });

    // Show the selected section
    document.getElementById(section).classList.add('active');

    // Update the section title
    document.getElementById('section-title').innerText = section.charAt(0).toUpperCase() + section.slice(1);

    // Other section fetching logic
    if (section === 'vendors') {
        fetchVendors(1);
    }

    if (section === 'products') {
        fetchProducts(1);
    }
    if (section === 'orders') {
        fetchOrders(1);
    }
    if (section === 'orderStatus') {
        fetchOrderStatus(1);
    }
    if (section === 'history') {
        fetchOrderHistory(1);
    }
    if (section === 'payment') {
        fetchPaymentSummary(1);
    } 
    if (section === 'announcement') {
        loadAnnouncements();
    }
}


    /*====================== this code is part of Order Chart =================*/   
    </script>
	<script type="text/javascript">
    $(document).ready(function() {
        function fetchDataAndUpdateCharts() {
            $.ajax({
                url: 'overview', 
                type: 'GET',
                success: function(response) {
                	var totalVendorCounts = response.totalVendorCount;
                    var orderStatistics = response.orderStatistics;
                    var paymentSummary = response.paymentSummary;

                    // Update dashboard values
                    $('#totalVendorCount').text(totalVendorCounts || 0);
                    $('#totalProducts').text(orderStatistics.totalProducts || 0);
                    $('#totalOrders').text(orderStatistics.totalOrders || 0);
                    $('#deliveredOrders').text(orderStatistics.deliveredCount || 0);
                    $('#pendingOrders').text(orderStatistics.pendingOrders || 0);
                    $('#receivedOrders').text(orderStatistics.receivedOrders || 0);

                    $('#totalAmountToPay').text(paymentSummary.totalAmountToPay || 0);
                    $('#amountPaid').text(paymentSummary.amountPaid || 0);
                    $('#remainingBalance').text(paymentSummary.remainingBalance || 0);

                    // Update Order Chart
                    var ctx = document.getElementById('orderChart').getContext('2d');
                    var orderChart = new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: ['Orders','Pending', 'Delivered', 'Received'],
                            datasets: [{
                                label: 'Order Count',
                                data: [
                                    orderStatistics.totalOrders || 0,
                                    orderStatistics.pendingOrders || 0,
                                    orderStatistics.deliveredCount || 0,
                                    orderStatistics.receivedOrders || 0 // Assuming you have this value in your backend
                                ],
                                backgroundColor: ['#28a745', '#ffc107', '#dc3545' , '#17a2b8'],
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
                }
            });
        }

        fetchDataAndUpdateCharts();
        setInterval(fetchDataAndUpdateCharts, 60000);
    });

    
    
    </script>

	<script>
	 /*====================== this code is part of to disply venodr name =================*/
		document.addEventListener("DOMContentLoaded", function() {
			var email = "${sessionScope.loggedInAdminEmail}";
			var userName = email.substring(0, email.indexOf('@'));
			document.getElementById("userName").textContent = userName;
		});
	</script>

	<script>
	  /*====================== this code is part of to disply venodr profile and update code =================*/
	 // Fetch vendors data with pagination and search
let vendorCurrentPage = 1;  // Current page for vendor listing
const vendorPageSize = 10;  // Page size for the vendor listing (number of vendors per page)

function fetchVendors(page) {
    const searchQuery = $('#vendorSearch').val();

    $.ajax({
        url: 'getAllVendorsByAdmin',  // Assuming this is the correct endpoint
        type: 'GET',
        data: {
            page: page,             // Pass the current page
            size: vendorPageSize,    // Pass the page size
            query: searchQuery       // Search query
        },
        dataType: 'json',
        success: function (response) {
            populateVendorTable(response.vendors);    // Populate table with vendor data
            updatePagination(response.totalPages, page);  // Update pagination controls
        },
        error: function (xhr) {
            console.error('Error fetching vendors:', xhr);
        }
    });
}

function populateVendorTable(vendors) {
    const tableBody = $('#viewAllVendorTableBody');
    tableBody.empty();

    if (vendors.length === 0) {
        tableBody.append('<tr><td colspan="8" class="text-center">No Vendors found.</td></tr>');
        return;
    }

    vendors.forEach((vendor, index) => {
        var row = '<tr>' +
            '<td>' + (index + 1) + '</td>' +  // Show the index (1-based)
            '<td>' + vendor.id + '</td>' +
            '<td>' + vendor.ownerName + '</td>' +
            '<td>' + vendor.emailId + '</td>' +
            '<td>' + vendor.contactNumber + '</td>' +
            '<td>' + vendor.altContactNumber + '</td>' +
            '<td>' + vendor.status + '</td>' +
            '<td>' +
            '<button class="btn btn-info view-vendor" data-id="' + vendor.id + '"><i class="fas fa-eye"></i> View</button>' +
            '</td>' +
            '</tr>';
        tableBody.append(row);
        
        // Attach click event handler to each "View" button
        $('.view-vendor').last().click(function() {
            const vendorId = $(this).data('id');
            viewProfile(vendorId);  // Call function to view vendor profile
        });
    });
}

function updatePagination(totalPages, vendorCurrentPage) {
    const pagination = $('#vendorPagination');
    pagination.empty();

    if (totalPages <= 1) return;  // No pagination needed if only one page

    pagination.append(`<li class="page-item"><a class="page-link" href="#" onclick="prevPageVendors()">Previous</a></li>`);

    for (let i = 1; i <= totalPages; i++) {
        const activeClass = (i === vendorCurrentPage) ? 'active' : '';
        pagination.append('<li class="page-item ' + activeClass + '"><a class="page-link" href="#" onclick="goToPage(' + i + ')">' + i + '</a></li>');
    }

    pagination.append(`<li class="page-item"><a class="page-link" href="#" onclick="nextPageVendors()">Next</a></li>`);
}

// Pagination controls
function prevPageVendors() {
    if (vendorCurrentPage > 1) {
        vendorCurrentPage--;
        fetchVendors(vendorCurrentPage);
    }
}

function nextPageVendors() {
    const totalPages = $('#vendorPagination li').length - 2;  // Ignore 'Previous' and 'Next' buttons
    if (vendorCurrentPage < totalPages) {
        vendorCurrentPage++;
        fetchVendors(vendorCurrentPage);
    }
}

function goToPage(page) {
    vendorCurrentPage = page;
    fetchVendors(vendorCurrentPage);
}


 function viewProfile(vendorId) {
	    $.ajax({
	        url: 'getVendorById',
	        method: 'GET',
	        data: { vendorId: vendorId },
	        success: function(vendor) {
	            if (!vendor || typeof vendor !== 'object') {
	                $('#errorMessage').text('Invalid vendor data received.');
	                $('#errorModal').modal('show');
	                return;
	            }

	            // Populate the form fields with vendor data
	            $('#ownerName').val(vendor.ownerName);
	            $('#vendorId').val(vendor.id);
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
	            $('#vendorStatus').val(vendor.status);

	            // Update profile photo
	            $('#userPhoto').attr('src', 'display?imagePath=' + vendor.imagePath);
	            $('#userDetailsModal').modal('show');
	        },
	        error: function(err) {
	            $('#errorMessage').text('Error fetching vendor details.');
	            $('#errorModal').modal('show');
	        }
	    });
	}
	
 $(document).ready(function () {
	    $('#updateStatusBtn').click(function () {
	        const selectedStatus = $('#vendorStatus').val();
	        updateVendorStatus(selectedStatus);
	    });

	    function updateVendorStatus(status) {
	    	const vendorId = document.getElementById("vendorId").value;

	        if (!vendorId) {
	            alert("Please select a vendor.");
	            return;
	        }

	        $.ajax({
	            url: 'updateVendorStatus',  // Your backend endpoint for updating vendor status
	            type: 'POST',
	            data: {
	                vendorId: vendorId,
	                status: status
	            },
	            success: function (response) {
	                if (response.success) {
	                	$('#userDetailsModal').modal('hide');
		                $('#successMessage').text( 'Update vendor status successfully.');
		                $('#successModal').modal('show');
	                    // Optionally, refresh the table or update the vendor status in the UI
	                    fetchVendors(currentPage);  // Refresh vendor list
	                } else {
	                    $('#errorMessage').html('Failed to update vendor status.');
		            	$('#errorModal').modal('show');
	                }
	            },
	            error: function (xhr, status, error) {
	            	  $('#errorMessage').html('An error occurred while updating vendor status.');
		            	$('#errorModal').modal('show');
	            }
	        });
	    }
	});

	  
 
	</script>

	<script type="text/javascript">
	let currentPage = 1;
	const pageSize = 10;
	function fetchProducts(page) {
	    const searchQuery = $('#productSearch').val();
	   
	    $.ajax({
	        url: 'getAllProductsByAdmin',
	        type: 'GET',
	        data: {
	            page: page,
	            size: pageSize,
	            query: searchQuery
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
	
	function populateProductTable(products, currentPage) {
	    const tableBody = $('#viewAllProductTableBody');
	    tableBody.empty(); // Clear the table before populating

	    // Check if there are any products to display
	    if (products.length === 0) {
	        tableBody.append('<tr><td colspan="7" class="text-center">No Products found.</td></tr>');
	        return;
	    }

	    // Loop through each product and add rows to the table
	      currentPage = 1;
	    products.forEach((product, index) => {
	        const row = '<tr>' +
	            '<td>' + ((currentPage - 1) * 10 + index + 1) + '</td>' + // Adjust index for pagination
	            '<td>' + product.id + '</td>' +
	            '<td>' + product.category + '</td>' +
	            '<td>' + product.productName + '</td>' +
	            '<td>₹' + product.productPrice + '</td>' +
	            '<td>' + (product.available ? 'In Stock' : 'Out of Stock') + '</td>' +
	            '<td>' +
	            '<button class="btn btn-info view-products" data-id="' + product.id + '"><i class="fas fa-eye"></i> View</button> ' + '</td>' +
	            '<td>' +
	            '<button class="btn btn-success order-product" data-id="' + product.id + '" data-name="' + product.productName + '"><i class="fas fa-shopping-cart"></i> Order</button>' +

	            '</td>' +
	            '</tr>';
	        tableBody.append(row); // Append the row to the table body
	    });

	    // Attach event handlers for the view buttons
	    $('.view-products').off('click').on('click', function() { // Use .off('click') to prevent duplicate event binding
	        const productId = $(this).data('id');
	        viewProducts(productId); // Call the function to view the product details
	    });

	 // Attach event handlers for the order buttons
	    $('.order-product').off('click').on('click', function() {
	        const productId = $(this).data('id');
	        const productName = $(this).data('name'); // Get the product name
	        resetModalForNewOrder();
	        // Show the order modal
	        $('#orderProductModal').modal('show');

	        // Set the product ID and product name in the modal
	        $('#orderProductId').val(productId);       // Use .val() for hidden or input fields
	        $('#orderProductName').text(productName);   // Use .val() for input fields

	        // Attach click event for "View Product" button
	        $('#viewOrderProductBtn').off('click').on('click', function() {
	            viewProducts(productId); // Call the function to view the product details	
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
	    $.ajax({
	        url: 'getProductById',  
	        method: 'GET',
	        data: { productId: productId },
	        success: function(product) {

	            if (!product || typeof product !== 'object') {
	                return;
	            }
	            $('#viewCategory').text(product.category);
	            $('#viewProductName').text(product.productName);
	            $('#viewProductPrice').text('₹' + product.productPrice);
	            $('#viewDeliveryCharge').text('₹' + product.deliveryCharge);
	            $('#viewAvailable').text(product.available ? 'Stock In' : 'Out of Stock');
	            $('#viewDescriptionAboutProduct').text(product.descriptionAboutProduct);

	            // Show the modal
	            $('#viewProductModal').modal('show');
	           

	        },
	        error: function(err) {
	            $('#errorMessage').text('Error fetching product details.');
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

	    $.ajax({
	        url: 'getAllOrdersByAdmin',
	        type: 'GET',
	        data: {
	            page: page,
	            size: orderPageSize,
	            query: searchQuery
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
	    const tableBody = $('#viewAllOrdersTableBody');
	    tableBody.empty();

	    if (orders.length === 0) {
	        tableBody.append('<tr><td colspan="8" class="text-center">No Orders found.</td></tr>');
	        return;
	    }

	    orders.forEach((order, index) => {
	        const row = '<tr>' +
	            '<td>' + (index + 1) + '</td>' +  // Serial number starting from 1
	            '<td>' + order.orderId + '</td>' +
	            '<td>' + order.productName + '</td>' +
	            '<td>' + order.orderQuantity + '</td>' +
	            '<td>' + order.orderDate + '</td>' +
	            '<td>' + (order.deliveryDate || 'N/A') + '</td>' +
	            '<td>' + order.orderStatus + '</td>' +
	            '<td>' +
	            '<button class="btn btn-primary edit-order" data-id="' + order.productId + '" data-name="' + order.productName + '" data-order-id="' + order.orderId + '">' +
	            '<i class="fas fa-edit"></i> Edit Order</button>' +
	            '</td>' +
	            '<td>' +
	            '<button class="btn btn-danger cancel-order" data-id="' + order.productId + '" data-name="' + order.productName + '" data-order-id="' + order.orderId + '">' +
	            '<i class="fas fa-times-circle"></i> Cancel Order</button>' +
	            '</td>' +
	            '</tr>';
	        tableBody.append(row);
	    });


	    $('.edit-order').off('click').on('click', function() {
	        const productId = $(this).data('id');
	        const productName = $(this).data('name'); // Get the product name
	        const orderId = $(this).data('order-id'); // Get the order ID

	        if (orderId) {
	            editOrder(orderId); // Call the edit function
	        }

	        // Show the order modal
	        $('#orderProductId').val(productId); // Set the hidden input for product ID
	        $('#orderProductName').val(productName); // Use .val() for input fields

	        // Attach click event for "View Product" button
	        $('#viewOrderProductBtn').off('click').on('click', function() {
	            viewProducts(productId); // Call the function to view the product details	
	        });
	    });
	    
	    $('.cancel-order').off('click').on('click', function() {
	        const orderId = $(this).data('order-id');
	        const productName = $(this).data('name');

	        // Set the order details in the modal
	        $('#cancelOrderId').text(orderId);
	        $('#cancelProductName').text(productName);

	        // Show the modal using Bootstrap's modal method
	        $('#cancelOrderModal').modal('show');
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
            $('#editOrderModal #hiddenOrderId').val(order.orderId);
            $('#editOrderModal #productName').text(order.productName);
            $('#editOrderModal #orderQuantity').text(order.orderQuantity);
            $('#editOrderModal #orderDate').text(order.orderDate);
            $('#editOrderModal #deliveryDate').text(order.deliveryDate);
            $('#editOrderModal #deliveryAddress').text(order.deliveryAddress);
            $('#editOrderModal #message').text(order.message || 'No message available');
            $('#editOrderModal #orderPaymentStatus').text(order.paymentStatus || 'NA');
            $('#editOrderModal #orderStatus').text(order.orderStatus);
            
            // Store order ID for future reference
            orderProductID = order.orderId;

            // Hide the invoice upload section initially
            document.getElementById('uploadPaymentInvoiceSection').style.display = 'none';
            document.getElementById("sumbitOrderStatusBtn").disabled = false;

            // Store invoice file paths
           // Using logical OR to handle null or undefined values
            orderInvoiceFile = order.orderInvoicePath || ''; 
            paymentInvoiceFile = order.paymentInvoicePath || '';

         // Check if the order status is "order_cancel" or "can't_delivered"
            if (order.orderStatus.toLowerCase() === 'order cancelled' || 
                order.orderStatus.toLowerCase() === "can't_delivered" || order.orderStatus.toLowerCase() === "notReceived") {
                $('#orderStatusSelect').hide(); // Hide the select dropdown
                $('#paymentStatusSelect').hide(); // Hide the select dropdown
                document.getElementById('uploadPaymentInvoiceSection').style.display = 'none'; // Hide invoice section
                document.getElementById("sumbitOrderStatusBtn").disabled = true;
            }
            // Check if the order status is "received" and the payment status is "paid"
            else if (order.orderStatus.toLowerCase() === "received" &&
                     order.paymentStatus && order.paymentStatus.toLowerCase() === 'paid') {
                $('#orderStatusSelect').hide(); // Hide the select dropdown
                $('#paymentStatusSelect').hide(); // Hide the select dropdown
                document.getElementById('uploadPaymentInvoiceSection').style.display = 'none'; // Hide invoice section
                document.getElementById("sumbitOrderStatusBtn").disabled = true;
            } else {
                $('#orderStatusSelect').show(); // Show the select dropdown
                $('#paymentStatusSelect').show(); // Hide the select dropdown
                $('#orderStatusSelect').val(order.orderStatus); // Set the value if needed
            }


            // Handle payment status logic
            $('#paymentStatusSelect').val(order.paymentStatus || ''); // Set the payment status select value
            $('#paymentStatusSelect').on('change', function () {
                const paymentStatus = $(this).val();
                if (paymentStatus === 'paid') {
                	document.getElementById('uploadPaymentInvoiceSection').style.display = 'block';
                    $('#fileInput').attr('required', true); // Make file input mandatory
                } else {
                	document.getElementById('uploadPaymentInvoiceSection').style.display = 'none';
                    $('#fileInput').removeAttr('required'); // Remove mandatory requirement
                }
            }).trigger('change'); // Trigger change event to set initial state
  
            if (orderInvoiceFile) {
                $('#editOrderModal #viewOrderInvoice').show();
            } else {
                $('#editOrderModal #viewOrderInvoice').hide();
            }

            if (paymentInvoiceFile) {
            	document.getElementById('uploadPaymentInvoiceSection').style.display = 'none';
                $('#editOrderModal #viewPaymentInvoice').show();
            } else {
                $('#editOrderModal #viewPaymentInvoice').hide();
            }

            $('#editOrderModal').modal('show');
        },
        error: function(err) {
            $('#errorMessage').text('Error fetching order details.');
            $('#errorModal').modal('show');
        }
    });
}

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

    function submitOrder() {
        const orderStatus = $('#orderStatusSelect').val();
        const paymentStatus = $('#paymentStatusSelect').val();
        const orderId = $('#hiddenOrderId').val();
        const fileInput = $('#fileInput')[0].files[0];
        if (paymentStatus === 'paid' && !fileInput) {
            alert('Please upload an invoice before submitting the status as "Paid".');
            return; // Stop submission if no file is uploaded
        }
     
        if(orderStatus==null){
        	alert('Please select order status before submitting order the status.');
        	return;
        }

        const formData = new FormData();
        formData.append('orderStatus', orderStatus);
        formData.append('paymentStatus', paymentStatus);
        formData.append('orderId', orderId);
        if (fileInput) {
            formData.append('file', fileInput); // Attach the invoice file if uploaded
        }

        $.ajax({
            url: 'submitOrderStatusByAdmin', // Your endpoint URL
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
	<script>
function editOrder(orderId) {
    $.ajax({
        url: 'getOrderById', // Replace with your actual endpoint
        method: 'GET',
        data: { orderId: orderId },
        success: function(order) {

            if (!order || typeof order !== 'object') {
                return;
            }

            // Update modal for editing order
            $('#orderProductModalLabel').html('<i class="fas fa-edit"></i> Edit Order');
            $('#submitOrderBtn').html('<i class="fas fa-check"></i> Update Order');
            $('#submitOrderBtn').data('order-id', order.orderId); // Set orderId for submit logic

            // Populate the modal with order details
            $('#orderProductModal #orderProductId').val(order.productId); // Product ID (hidden field)
            $('#orderProductModal #orderProductName').text(order.productName); // Product name (static text)
            $('#orderProductModal #orderQuantity').val(order.orderQuantity); // Set order quantity
            $('#orderProductModal #deliveryDate').val(order.deliveryDate); // Set delivery date
            $('#orderProductModal #orderAddress').val(order.deliveryAddress); // Set delivery address
            $('#orderProductModal #orderMessage').val(order.message || ''); // Set message if available
            
            // Show the modal
            $('#orderProductModal').modal('show');
        },
        error: function(err) {
            console.error('Error fetching order details:', err);
            $('#errorMessage').text('Error fetching order details.');
            $('#errorModal').modal('show');
        }
    });
}

function resetModalForNewOrder() {
    // Reset modal for new order
    $('#orderProductModalLabel').html('<i class="fas fa-shopping-cart"></i> New Order');
    $('#submitOrderBtn').html('<i class="fas fa-check"></i> Place Order');
    $('#submitOrderBtn').removeData('order-id'); // Remove any previously set order ID

    // Clear the form fields
    $('#orderProductModal #orderProductId').val('');
    $('#orderProductModal #orderProductName').text(''); // Assuming this is a static text
    $('#orderProductModal #orderQuantity').val('');
    $('#orderProductModal #deliveryDate').val('');
    $('#orderProductModal #orderAddress').val('');
    $('#orderProductModal #orderMessage').val('');

    // Show the modal
    $('#orderProductModal').modal('show');
}

$('#submitOrderBtn').off('click').on('click', function() {
    const orderId = $(this).data('order-id'); // Check if orderId exists (edit mode)
    const url = orderId ? 'updateOrder' : 'saveOrder'; // Decide between saving or updating
    const method = orderId ? 'PUT' : 'POST'; // Use PUT for updating, POST for saving

    const orderData = {
        productId: $('#orderProductModal #orderProductId').val(),
        orderQuantity: $('#orderProductModal #orderQuantity').val(),
        deliveryDate: $('#orderProductModal #deliveryDate').val(),
        deliveryAddress: $('#orderProductModal #orderAddress').val(),
        message: $('#orderProductModal #orderMessage').val()
    };

    if (orderId) {
        orderData.orderId = orderId; // Include orderId if editing
    }

    $.ajax({
        url: url,
        method: method,
        contentType: 'application/json',
        data: JSON.stringify(orderData),
        success: function(response) {

            // Close the modal after successful save/update
            $('#orderProductModal').modal('hide');
            $('#successMessage').text(response);
            $('#successModal').modal('show');

            fetchOrders(1);
        },
        error: function(err) {
            console.error('Error saving/updating order:', err);
            $('#errorMessage').text('Error saving/updating order.');
            $('#errorModal').modal('show');
            fetchOrders(1);
        }
    });
});

$('#confirmCancelOrder').on('click', function() {
    const orderId = $('#cancelOrderId').text();
    $.ajax({
        url: 'cancelOrder', 
        type: 'POST', 
        data: { orderId: orderId },
        success: function(response) {
        	fetchOrders(1);
            $('#cancelOrderModal').modal('hide');
            $('#successMessage').text(response);
            $('#successModal').modal('show');
           
            
        },
        error: function(error) {
        	 $('#cancelOrderModal').modal('hide');
             $('#errorMessage').text(response);
             $('#errorModal').modal('show');
             fetchOrders(1);
        }
    });

   
});





</script>

	<script>
	let orderStatusCurrentPage = 1;  // Current page for order status listing
	const orderStatusPageSize = 10;   // Page size for order status listing (number of orders per page)

	function fetchOrderStatus(page) {
	    const searchQuery = $('#orderStatusSearch').val(); // Get search query from the input field

	    $.ajax({
	        url: 'getAllOrdersStatusByAdmin',  // Assuming this is the correct endpoint
	        type: 'GET',
	        data: {
	            page: page,             // Pass the current page
	            size: orderStatusPageSize,  // Pass the page size
	            query: searchQuery       // Search query
	        },
	        dataType: 'json',
	        success: function (response) {
	            populateOrderStatusTable(response.orders);    // Populate table with order status data
	            updateOrderStatusPagination(response.totalPages, page);  // Update pagination controls
	        },
	        error: function (xhr) {
	            console.error('Error fetching order status:', xhr);
	        }
	    });
	}

	function populateOrderStatusTable(orders) {
	    const tableBody = $('#viewAllOrdersStatusTableBody');
	    tableBody.empty();

	    if (orders.length === 0) {
	        tableBody.append('<tr><td colspan="8" class="text-center">No Orders found.</td></tr>');
	        return;
	    }

	    orders.forEach((order, index) => {
	        const row = '<tr>' +
	            '<td>' + (index + 1) + '</td>' +  // Show the index (1-based)
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
	        
	        // Attach click event handler to each "View" button
	        $('.view-order').last().click(function() {
	            const orderId = $(this).data('id');
	            viewOrder(orderId);  // Call function to view order details
	        });
	    });
	}

	function updateOrderStatusPagination(totalPages, currentPage) {
	    const pagination = $('#orderStatusPagination');
	    pagination.empty();

	    if (totalPages <= 1) return;  // No pagination needed if only one page

	    pagination.append(`<li class="page-item"><a class="page-link" href="#" onclick="prevPageOrderStatus()">Previous</a></li>`);

	    for (let i = 1; i <= totalPages; i++) {
	        const activeClass = (i === currentPage) ? 'active' : '';
	        pagination.append('<li class="page-item ' + activeClass + '"><a class="page-link" href="#" onclick="goToOrderStatusPage(' + i + ')">' + i + '</a></li>');
	    }

	    pagination.append(`<li class="page-item"><a class="page-link" href="#" onclick="nextPageOrderStatus()">Next</a></li>`);
	}

	// Pagination controls
	function prevPageOrderStatus() {
	    if (orderStatusCurrentPage > 1) {
	        orderStatusCurrentPage--;
	        fetchOrderStatus(orderStatusCurrentPage);
	    }
	}

	function nextPageOrderStatus() {
	    const totalPages = $('#orderStatusPagination li').length - 2;  // Ignore 'Previous' and 'Next' buttons
	    if (orderStatusCurrentPage < totalPages) {
	        orderStatusCurrentPage++;
	        fetchOrderStatus(orderStatusCurrentPage);
	    }
	}

	// Function to go to a specific page
	function goToOrderStatusPage(page) {
	    orderStatusCurrentPage = page;
	    fetchOrderStatus(orderStatusCurrentPage);
	}


	</script>

	<script>
	let currentOrderHistoryPage = 1;
	const orderPageHistorySize = 10;

	function fetchOrderHistory(page) {
	    const searchQuery = $('#orderHistorySearch').val();

	    $.ajax({
	        url: 'getAllOrderHistoryByAdmin',
	        type: 'GET',
	        data: {
	            page: page,
	            size: orderPageHistorySize,
	            query: searchQuery
	        },
	        dataType: 'json',
	        success: function (response) {
	            populateOrderHistoryTable(response.orders);
	            updateOrderHistoryPagination(response.totalPages, page);
	        },
	        error: function (xhr) {
	            // Log the status and response text for better debugging
	            console.error('Error fetching orders:', xhr.status, xhr.responseText);
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

  
</script>
	<script>
let currentPaymentSummaryPage = 1;
const paymentPageSize = 10;

function fetchPaymentSummary(page) {
    const searchQuery = $('#paymentSummarySearch').val();

    $.ajax({
        url: 'getAllPaymentSummaryByAdmin', 
        type: 'GET',
        data: {
            page: page,
            size: paymentPageSize,
            query: searchQuery
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

    $('.view-invoice').click(function() {
        const invoicePath = $(this).data('id');
        viewInvoice(invoicePath); 
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
	$("#announcementForm").submit(function(event) {
	    event.preventDefault();
	    $.ajax({
	        type: "POST",
	        url: "saveAnnouncement",
	        contentType: "application/json",
	        data: JSON.stringify({
	            title: $("input[name='title']").val(),
	            message: $("textarea[name='message']").val()
	        }),
	        success: function(response) {
	            if (response.includes("Announcement saved successfully")) {
	                $('#announcementModal').modal('hide');
	                $('#successMessage').text('Announcement saved successfully!');
	                $('#successModal').modal('show');

	                $('#successModal').on('hidden.bs.modal', function () {
	                    $('body').removeClass('modal-open'); // Remove the modal-open class
	                    $('.modal-backdrop').remove(); // Remove the backdrop
	                    loadAnnouncements(); // Ensure announcements are refreshed
	                });
	            } else {
	                $('#errorMessage').text('Error occurred during saving announcement.');
	                $('#errorModal').modal('show');
	            }
	        },

	        error: function() {
	            $('#announcementModal').modal('hide');
	            $('#errorMessage').text('Error occurred during saving announcement.');
	            $('#errorModal').modal('show');
	        }
	    });
	});

	function deleteAnnouncement() {
	    const id = document.getElementById('announcementID').value;
	    $.ajax({
	        type: "POST",
	        url: "deleteAnnouncement?id=" + id, 
	        success: function(response) {
	            if (response.includes("Announcement deleted successfully")) {
	                $('#deleteConfirmationModal').modal('hide')
                     $('#successMessage').text('Announcement deleted successfully!');
	                $('#successModal').modal('show');
	               
	                loadAnnouncements(); // Refresh announcements
	            } else {
	                $('#errorMessage').text('Error occurred during deleting announcement.');
	                $('#errorModal').modal('show');
	            }
	        },
	        error: function() {
	            $('#errorMessage').text('Error occurred during deleting announcement.');
	            $('#errorModal').modal('show');
	        }
	    });
	}

function loadAnnouncements() {
    $.ajax({
        type: "GET",
        url: "getAnnouncements",
        dataType: "json",
        success: function(announcements) {
            populateAnnouncementTable(announcements);
        },
        error: function() {
            alert("Failed to fetch announcements.");
        }
    });
}
function populateAnnouncementTable(announcements) {
    const tableBody = $("#AnnouncementDetailsTable"); // Target the tbody directly
    tableBody.empty(); // Clear previous rows

    if (!announcements || announcements.length === 0) {
        tableBody.append('<tr><td colspan="4" class="text-center">No Announcements found.</td></tr>');
        return;
    }

    announcements.forEach((announcement) => {
        const row = 
            "<tr>" +
                "<td class='announcement-id'>" + announcement.id + "</td>" +
                "<td>" + announcement.title + "</td>" +
                "<td>" + announcement.message + "</td>" +
                "<td>" +
                '<button class="btn btn-danger delete-announcement" data-id="' + announcement.id + '">' +
                '<i class="fas fa-times"></i>Delete</button>' +
                 
                "</td>" +
            "</tr>";
        
        tableBody.append(row);
    });
    $('.delete-announcement').click(function() {
        const announcementId= $(this).data('id');
        $('#announcementID').val(announcementId);
        $('#deleteConfirmationModal').modal('show');
        
    });
}
</script>
	<script>
    let stompClient;
    let currentUser = ''; 
    let allUsers = [];
    
    function connect() {
        const socket = new SockJS('/VendoraX/chat-websocket');
        stompClient = Stomp.over(socket);
        stompClient.connect({}, function(frame) {
            stompClient.subscribe('/topic/messages', function(chatMessage) {
            	const messageData = JSON.parse(chatMessage.body);
            	  const timestamp = new Date(messageData.timestamp);
            	  if (messageData.toUser === currentUser || messageData.fromUser === currentUser) {
                      displayMessage(messageData.message, messageData.fromUser, timestamp);
                  }
            });
        });
    }

    function loadAllUsers() {
        $.ajax({
            url: 'getAllChatUsers', 
            method: 'GET',
            dataType: 'json',
            success: function(users) {
                allUsers = users; 
                renderUsers(users); 
            },
            error: function(xhr, status, error) {
            	renderUsers([]);
            }
        });
    }

   function filterUsers() {
    const searchTerm = $('#user-search').val().trim().toLowerCase();
    
    if (searchTerm) {
        const filteredUsers = allUsers.filter(user => user.userName.toLowerCase().includes(searchTerm));
        renderUsers(filteredUsers); 
    } else {
        renderUsers(allUsers); 
    }
}

 // Function to render users with their image and name
 function renderUsers(users) {
    const userListDiv = document.getElementById('user-list');
    userListDiv.innerHTML = ''; 

    users.forEach(user => {
        const userDiv = document.createElement('div');
        userDiv.classList.add('user-item');
        userDiv.setAttribute('data-user-id', user.userID);
        userDiv.onclick = () => selectUser(user.userID);
     
        let lastMessage = user.lastMessage || 'No messages yet';
        let truncatedMessage = lastMessage.length > 15 ? lastMessage.substring(0, 15) + '...' : lastMessage;
        userDiv.innerHTML = 
            '<img src="display?imagePath=' + user.userProfileImagePath + '" alt="' + user.userName + '">' +
            '<div>' +
                '<div class="user-name">' + user.userName + '</div>' + 
                '<div class="user-last-message">' + truncatedMessage + '</div>' + 
            '</div>';

        userListDiv.appendChild(userDiv);
    });
}



 // Function to handle user selection and load chat history
 function selectUser(userID) {
    currentUser = userID;
    const selectedUser = allUsers.find(user => user.userID === userID);
    document.getElementById('current-user').textContent = selectedUser.userName;
    const userImageElement = document.querySelector('#chat-header img');
    userImageElement.src = 'display?imagePath=' + selectedUser.userProfileImagePath;
    userImageElement.alt = selectedUser.userName;
    document.getElementById('chat-box-content').innerHTML = ''; 
    loadChatHistory(userID);
    const userListDiv = document.getElementById('user-list');
    const userItems = userListDiv.querySelectorAll('.user-item');
    userItems.forEach(function(item) {
        item.classList.remove('chat-user-active'); 
    });
   
    const selectedUserDiv = userListDiv.querySelector('.user-item[data-user-id="' + userID + '"]');
    if (selectedUserDiv) {
        selectedUserDiv.classList.add('chat-user-active'); 
    }
    
     
}

    // Function to load chat history for the selected user
   function loadChatHistory(userID) {
    $.ajax({
        url: 'messageHistory/' + userID, 
        method: 'GET',
        dataType: 'json',
        success: function(chatHistory) {
            const chatBoxContent = document.getElementById('chat-box-content');
            chatBoxContent.innerHTML = ''; 
            
            chatHistory.forEach(message => {
            	displayMessage(message.message, message.fromUser ,message.timestamp);
            });
        },
        error: function(xhr, status, error) {
            const chatBoxContent = document.getElementById('chat-box-content');
            
        }
    });
}

// Variable to track the last displayed date
   let lastDisplayedDate = '';

   function displayMessage(message, sender, timestamp) {
       const chatBoxContent = document.getElementById('chat-box-content');

       // Get the formatted date based on the timestamp
       const { date, time } = formatTimestampForDisplay(timestamp);

       // Create a date header only if it is different from the last displayed date
       if (lastDisplayedDate !== date) {
           const dateHeader = document.createElement('div');
           dateHeader.classList.add('date-header');
           dateHeader.innerText = date; // Set the date header text
           dateHeader.style.textAlign = 'center'; // Center align
           dateHeader.style.fontWeight = 'bold'; // Bold font for the header
           dateHeader.style.margin = '10px 0'; // Margin for spacing
           chatBoxContent.appendChild(dateHeader); // Append header to chat box

           // Update lastDisplayedDate
           lastDisplayedDate = date;
       }

       // Create message container
       const messageElement = document.createElement('div');
       messageElement.classList.add('eachMessage');
       messageElement.classList.add(sender === 'admin' ? 'admin-message' : 'user-message');

       // Set text color based on sender
       messageElement.style.color = 'black'; // Set text color to black for both admin and user messages

       // Create avatar container
       const avatarElement = document.createElement('div');
       avatarElement.classList.add('messageAvatar');

       // Set avatar based on sender
       if (sender === 'admin') {
           avatarElement.innerHTML = '<img src="res/images/vendor comapany logo.webp" alt="Admin">';
       } else {
           const user = allUsers.find(user => user.userID === sender);
           if (user) {
	            // Set the user's profile image path if found
	            avatarElement.innerHTML = '<img src="display?imagePath=' + user.userProfileImagePath + '" alt="' + user.userName + '">';
	        } else {
	            // Fallback if user not found
	            const defaultUserImage="defaultUserImage.png";
	            avatarElement.innerHTML = '<img src="display?imagePath='+defaultUserImage+'" alt="User">'; // Use a default image
	        }
       }

       // Create message content container
       const messageContentElement = document.createElement('div');
       messageContentElement.classList.add('message-content');
       messageContentElement.innerText = message;

       // Create time element
       const timeElement = document.createElement('span');
       timeElement.classList.add('message-time');
       timeElement.innerText = time; // Set the time text

       // Append message content and time to message element
       messageElement.appendChild(avatarElement);
       messageElement.appendChild(messageContentElement);
       messageElement.appendChild(timeElement); // Append time element here

       // Append message element to chat box
       chatBoxContent.appendChild(messageElement);

       // Scroll chat to the bottom
       chatBoxContent.scrollTop = chatBoxContent.scrollHeight;
   }

   
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

   
   
   function updateLastMessageAndMoveToTop(userID, message) {
	    
	
	    // Find the user in the allUsers array
	    const userIndex = allUsers.findIndex(user => user.userID === userID);
	    
	    if (userIndex !== -1) {
	        // Update the user's last message
	        allUsers[userIndex].lastMessage = message;

	        // Move the user to the top of the list
	        const [user] = allUsers.splice(userIndex, 1); // Remove the user from their current position
	        allUsers.unshift(user); 
	        renderUsers(allUsers);
	    } else {
	        console.error(`User with ID ${userID} not found in allUsers.`);
	    }
	}

  
    // Function to send a message
    function sendMessage() {
        const messageInput = document.getElementById('message-input');
        const message = messageInput.value;
        if (message && currentUser) {
            const chatMessage = {
               fromUser: 'admin', // You can adjust this to dynamic sender if needed
               toUser: currentUser,
                message: message
            };
            stompClient.send("/sendMessage", {}, JSON.stringify(chatMessage));
    	    updateLastMessageAndMoveToTop(currentUser, message);  // Update user list dynamically
            messageInput.value = ''; // Clear input after sending
        }
    }

    // Initial call to load users when the page is ready
    $(document).ready(function() {
        loadAllUsers();
        connect(); // Connect to WebSocket on page load
    });
</script>
	<script type="text/javascript">
let currentUserId = 'admin'; 
function fetchNotifications(currentUserId) {

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

            // Construct each notification item using string concatenation, adding border, shadow, and margin styles
            const notificationItemHtml = 
                '<li style="margin-bottom: 10px;">' + 
                    '<a class="dropdown-item" href="#" onclick="markAsRead(' + notification.id + ')" style="border: 1px solid #e3e3e3; border-radius: 5px; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); padding: 10px;">' + 
                        '<div>' + 
                            '<strong>' + notification.type + '</strong><br>' + // Adding the notification type
                            '<span>' + notification.message + '</span><br>' + // The message content
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
    return date.toLocaleString('en-IN', options);
}

// Mark notification as read
function markAsRead(notificationId) {
    $.ajax({
        url: 'notificationsRead/' + notificationId,
        method: 'PUT',
        success: function() {
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
	<script>
	$(document).ready(function () {
	    $('#trackOrderBtn').click(function () {
	        const orderId = $('#orderId').val();
	        if (orderId) {
	            $.ajax({
	                url: 'ordertrack?orderId=' + orderId,
	                method: 'GET',
	                success: function (data) {
	                    displayTrackingInfo(data);
	                },
	                error: function (error) {
	                    alert('Error retrieving order tracking details.');
	                }
	            });
	        } else {
	            alert('Please enter a valid order ID.');
	        }
	    });

	    function displayTrackingInfo(orderTracking) {
	        const trackingContainer = $('#trackingResult');
	        trackingContainer.empty(); // Clear previous results

	        // Display Order Details
	        if (orderTracking.length > 0) {
	            const orderDetails = orderTracking[0].orderDTO;

	            // Create a centered container for order details
	            let orderDetailsContent =
	                '<div class="order-details  mt-4">' +
	                    '<h3 class="text-center"><i class="fas fa-info-circle"></i> Order Details</h3>' +
	                    '<div class="row justify-content-center">' +
	                        // First column with left side details
	                        '<div class="col-md-6 text-left">' +
	                            '<p><i class="fas fa-barcode"></i> <strong>Order ID:</strong> ' + orderDetails.orderId + '</p>' +
	                            '<p><i class="fas fa-box"></i> <strong>Product Name:</strong> ' + orderDetails.productName + '</p>' +
	                            '<p><i class="fas fa-cube"></i> <strong>Quantity:</strong> ' + orderDetails.orderQuantity + '</p>' +
	                            '<p><i class="fas fa-tags"></i> <strong>Product Price:</strong> ₹' + orderDetails.productPrice + '</p>' +
	                        '</div>' +
	                        // Second column with right side details
	                        '<div class="col-md-6 text-left">' +
	                            '<p><i class="fas fa-wallet"></i> <strong>Total Amount:</strong> ₹' + orderDetails.orderAmount + '</p>' +
	                            '<p><i class="fas fa-map-marker-alt"></i> <strong>Delivery Address:</strong> ' + orderDetails.deliveryAddress + '</p>' +
	                            '<p><i class="fas fa-shipping-fast"></i> <strong>Order Status:</strong> ' + orderDetails.orderStatus + '</p>' +
	                            '<p><i class="fas fa-money-check-alt"></i> <strong>Payment Status:</strong> ' + orderDetails.paymentStatus + '</p>' +
	                        '</div>' +
	                    '</div>' +
	                    '<p><i class="fas fa-calendar-alt"></i> <strong>Delivery Date:</strong> ' + orderDetails.deliveryDate + '</p>' +
	                '</div>';

	            trackingContainer.append(orderDetailsContent);

	            // Define the statuses in the order of progression
	            const statuses = [
	                { label: 'Order Placed', icon: 'fas fa-check-circle' },
	                { label: 'Confirmed', icon: 'fas fa-check-circle' },
	                { label: 'Delivered', icon: 'fas fa-check-circle' },
	                { label: 'Received', icon: 'fas fa-check-circle' },
	                { label: 'Payment Received', icon: 'fas fa-check-circle' },
	                { label: 'Payment Not Received', icon: 'fas fa-times-circle', color: 'red' },
	                { label: 'Cannot Deliver', icon: 'fas fa-exclamation-circle', color: 'red' },
	                { label: 'Order Cancelled', icon: 'fas fa-times-circle', color: 'red' }
	            ];

	            // Show the status progress line
	            let htmlContent = '<div class="order-tracking text-center mt-4">';
	            htmlContent += '<h4><i class="fas fa-shipping-fast"></i> Order Track</h4>';
	            htmlContent += '<div class="d-flex justify-content-between align-items-center tracking-line">';

	            orderTracking.forEach((track, index) => {
	                const statusIndex = ['order', 'confirmed', 'delivered', 'received', 'paid', 'notreceived', "can't_delivered", 'order cancelled'].indexOf(track.orderStatus.toLowerCase());

	                if (statusIndex !== -1) {
	                    // Add the status with corresponding icon and color
	                    htmlContent += 
	                        '<div class="status-item">' +
	                            '<div class="status-box ' + (track.isCompleted ? 'completed' : '') + '">' +
	                                '<i class="' + statuses[statusIndex].icon + '" style="color: ' + (statuses[statusIndex].color || '#007bff') + ';"></i>' +
	                                '<p>' + statuses[statusIndex].label + '</p>' +
	                                '<p class="small"><em>' + track.upDateStatus + '</em></p>' +
	                            '</div>' +
	                        '</div>';

	                    // Add connecting line between steps, but only if not the last step
	                    if (index < orderTracking.length - 1) {
	                        htmlContent += '<div class="status-line"></div>';
	                    }
	                }
	            });

	            htmlContent += '</div></div>';
	            trackingContainer.append(htmlContent);
	        } else {
	            trackingContainer.append('<p>No tracking information found for this order.</p>');
	        }
	    }
	});

	 document.getElementById("clearResultBtn").addEventListener("click", function() {
	        document.getElementById("trackingResult").innerHTML = ""; // Clear the trackingResult content
	        document.getElementById("orderId").value = ""; // Optional: Clear the input field as well
	    });
</script>


</body>

</html>

