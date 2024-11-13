<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>vendorX-Admin Login</title>
<link rel="shortcut icon" href="res/images/vendor comapany logo.webp"
	type="image/x-icon">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
	<link rel="stylesheet" href="res/css/adminlogin.css">
</head>
<body>

	<div class="centered">
		<div class="container custom-form">
			<img src="res/images/vendor comapany logo.webp" alt="Company Logo"
				class="logo">
			<h2>VendorX Admin</h2>

			<h3 id="errorMessage" style="color: red">${error}</h3>

			<a href="homePage" class="btn btn-home btn-block"><i
				class="fas fa-home"></i> Home</a>

			<form id="forgotPasswordForm" action="adminLogin" method="post">
				<div class="form-group" id="emailSection">
					<input type="email" id="email" name="email" class="form-control"
						placeholder="Enter Admin Email" required>
					<h6 id="emailError"></h6>
					<button type="button" class="btn btn-custom btn-block mt-3"
						id="checkEmail">Generate OTP</button>
				</div>
				<div class="form-group mt-3" id="otpSection">
					<h6 id="emailSuccess"></h6>
					<input type="text" class="form-control" id="otp" name="otp"
						placeholder="Enter OTP" required>
					<h6 id="otpError"></h6>
					<button type="button" class="btn btn-custom btn-block mt-3"
						id="validateOTP">Validate OTP</button>
				</div>
				<div class="form-group mt-3" id="newPasswordSection">
					<h6 id="otpsucess"></h6>
					<input type="password" class="form-control" id="newPassword"
						name="password" placeholder="Enter Admin Password" required>
					<h6 id="errorPassword"></h6>

					<input type="checkbox" id="showPasswordCheckbox"
						onchange="togglePasswordVisibility()"> <label
						for="showPasswordCheckbox">Show Password</label>
						
					<button type="submit" class="btn btn-block mt-3"
						id="button" disabled>Submit</button>
				</div>
			
			</form>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

	<script>
		function togglePasswordVisibility() {
			var passwordInput = document.getElementById("newPassword");
			passwordInput.type = document
					.getElementById("showPasswordCheckbox").checked ? "text"
					: "password";
		}

		document.getElementById('checkEmail').addEventListener('click',
				function() {
					validateEmail();
				});

		document.getElementById('validateOTP').addEventListener('click',
				function() {
					validateOTP();
				});

		document.getElementById('newPassword').addEventListener('blur',
				function() {
					validatePassword();
				});

		function validateEmail() {
			var userEmail = document.getElementById('email').value;
			$
					.ajax({
						url : 'email/check?email=' + userEmail,
						type : 'GET',
						success : function(response) {
							if (response.trim() === 'email_exists') {
								document.getElementById('emailError').innerHTML = '';
								document.getElementById('emailSuccess').innerHTML = 'OTP sent to email.';
								document.getElementById('emailSection').style.display = 'none';
								document.getElementById('otpSection').style.display = 'block';
							} else {
								document.getElementById('emailError').innerHTML = 'Email is not registered.';
							}
						},
						error : function() {
							console.error('Error occurred.');
						}
					});
		}

		function validateOTP() {
			var otpValue = document.getElementById('otp').value;
			var userEmail = document.getElementById('email').value;

			if (otpValue) {
				$
						.ajax({
							url : 'otp/validate',
							type : 'POST',
							data : {
								otp : otpValue,
								email : userEmail
							},
							success : function(response) {
								if (response.trim() === 'otp_valid') {
									document.getElementById('otpError').innerHTML = '';
									document.getElementById('otpsucess').innerHTML = 'OTP validated.';
									document.getElementById('otpSection').style.display = 'none';
									document
											.getElementById('newPasswordSection').style.display = 'block';
								} else {
									document.getElementById('otpError').innerHTML = 'Invalid OTP.';
								}
							},
							error : function() {
								console
										.error('Error occurred during OTP validation.');
							}
						});
			} else {
				document.getElementById('otpError').innerHTML = 'Please enter a valid OTP.';
			}
		}

		function validatePassword() {
			var newPassword = document.getElementById("newPassword").value;
			var passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$%^&+=!])(?=.*[a-zA-Z]).{8,20}$/;

			if (!passwordRegex.test(newPassword)) {
				document.getElementById("errorPassword").innerHTML = "Password must be strong.";
				document.getElementById("button").disabled = true;
			} else {
				document.getElementById("errorPassword").innerHTML = '';
				document.getElementById("button").disabled = false;
			}
		}
	</script>
</body>
</html>
