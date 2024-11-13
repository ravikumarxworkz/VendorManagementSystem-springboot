<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>VendoraX LogIn page</title>
<link rel="shortcut icon" href="res/images/vendor comapany logo.webp"
	type="image/x-icon">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
	integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.3.1/css/all.css"
	integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<link rel="stylesheet" href="res/css/login.css" >
   <style>
      
    </style>
<body>
  <div class="d-flex justify-content-center align-items-center vh-100">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card shadow-lg rounded">
                        <div class="text-center mt-4">
                            <img src="res/images/vendor comapany logo.webp" alt="Company Logo"
                                style="width: 120px; height: auto; border-radius: 50%;">
                        </div>
                        <div class="card-header text-center">
                            <h3 class="font-weight-bold">Vendor Login</h3>
                        </div>

                        <!-- Card Body -->
                        <div class="card-body p-4">
                            <form id="loginForm" action="logInProfile" method="post">
                                <!-- Email Input -->
                                <div class="form-group mb-3">
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                                        <input type="text" class="form-control" id="email" name="email"
                                            placeholder="Email" onchange="onEmail()" required>
                                    </div>
                                    <small id="errorEmail" class="text-danger"></small>
                                    <small id="emailSuccess" class="text-success"></small>
                                </div>

                                <!-- Send OTP Button -->
                                <div class="form-group text-center mb-3">
                                    <button type="button" class="btn btn-primary btn-block" id="sendOTPButton"
                                        onclick="sendOTP()" disabled>Send OTP</button>
                                </div>

                                <!-- OTP Input Section (Initially Hidden) -->
                                <div id="otpSection">
                                    <div class="form-group mb-3">
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fas fa-key"></i></span>
                                            <input type="text" class="form-control" id="otp" name="OTP"
                                                placeholder="Enter OTP" required>
                                        </div>
                                    </div>
                                </div>

                                <!-- Error Message -->
                               <div class="d-flex justify-content-center">
									<%
									String errorMessage = (String) session.getAttribute("errorMessage");
									if (errorMessage != null) {
									%>
									<p class="text-danger"><%=errorMessage%></p>
									<%
									}
									session.removeAttribute("errorMessage");
									%>
								</div>
                                <!-- Login Button -->
                                <div class="form-group text-center mb-3">
                                    <button type="submit" class="btn btn-success btn-block" id="loginButton" disabled>
                                        Login
                                    </button>
                                </div>
                            </form>

                            <!-- Home and Register Links -->
                            <div class="text-center mt-3">
                                <a href="homePage" class="btn btn-info btn-home mx-2"><i class="fas fa-home"></i> Home</a>
                                <a href="registerPage" class="btn btn-info btn-register mx-2"><i class="fas fa-user-plus"></i>
                                    Register</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
	<script>
		function onEmail() {
			var emailInput = document.getElementById('email');

			var emailValue = emailInput ? emailInput.value.trim() : '';

			var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
			console.log(emailInput);

			if (emailRegex.test(emailValue)) {
				const xhttp = new XMLHttpRequest();
				xhttp.open("GET", "checkEmailExistence/"
						+ encodeURIComponent(emailValue));
				xhttp.send();

				xhttp.onload = function() {
					if (xhttp.status === 200) {
						var exists = this.responseText === "EmailIDexists";
						if (exists) {
							document.getElementById("errorEmail").innerText = "";
							document.getElementById("sendOTPButton").disabled = false;
							document.getElementById("loginButton").disabled = false;
						} else {
							document.getElementById("errorEmail").innerText = "Emailid is not exists";
							document.getElementById("sendOTPButton").disabled = true;
						}
					} else {
						console.error('Error fetching email existence:',
								xhttp.status);
					}
				};
			} else {
				document.getElementById("errorEmail").innerText = "Please enter a valid email address";
				document.getElementById("sendOTPButton").disabled = true;
			}
		}

		function sendOTP() {
			var userEmail = document.getElementById('email').value;

			$
					.ajax({
						url : 'genrateLoginOTPAndSave?email='
								+ userEmail,
						type : 'GET',
						success : function(response) {
							if (response.trim() === 'OPTSentSuccessfully') {
								document.getElementById('errorEmail').innerText = ' ';
								document.getElementById('emailSuccess').innerText = 'OTP sent to email. The OTP will expire in 2 minutes.';
								document.getElementById("sendOTPButton").disabled = true;
								startCountdown(120);
							} else {
								document.getElementById('errorEmail').innerText = 'otp is not genrated.';
							}
						},
						error : function(jqXHR, textStatus, errorThrown) {
							console.error('Error:', textStatus, errorThrown);
						}
					});
		}
		
		function startCountdown(duration) {
			let timer = duration, minutes, seconds;
			const emailSuccessElement = document.getElementById('emailSuccess');
			const interval = setInterval(
					function() {
						minutes = parseInt(timer / 60, 10);
						seconds = parseInt(timer % 60, 10);

						minutes = minutes < 10 ? "0" + minutes : minutes;
						seconds = seconds < 10 ? "0" + seconds : seconds;

						if (timer <= 15) {
							emailSuccessElement.style.color = 'red';
						} else {
							emailSuccessElement.style.color = ''; // Reset to default color
						}

						emailSuccessElement.textContent = "OTP sent to email. The OTP will expire in "
								+ minutes + ":" + seconds + ".";

						if (--timer < 0) {
							clearInterval(interval);
							emailSuccessElement.textContent = "OTP has expired.";
							emailSuccessElement.style.color = ''; // Reset to default color
							document.getElementById("sendOTPButton").disabled = false; // Optionally re-enable the button
						}
					}, 1000);
		}
	</script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>
</body>

</html>
