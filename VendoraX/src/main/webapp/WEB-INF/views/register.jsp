<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Sign Up</title>
  <link rel="shortcut icon" href="res/images/vendor comapany logo.webp" type="image/x-icon">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
        integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/simple-line-icons/2.4.1/css/simple-line-icons.min.css" />
   
   <link rel="stylesheet" href="res/css/register.css">
</head>

<body>
    <!-- -----------------------  Email verification HTML code  ------------------------>
    <div class="emailVerify-container d-flex justify-content-center align-items-center"  >
        <div class="emailVerify-container mt-5 p-4 shadow-sm rounded" id="emailVerify">
            <!-- Company Logo -->
            <div class="text-center mb-4">
                <img src="res/images/vendor comapany logo.webp" alt="Company Logo"
                    style="width: 150px; height: auto; border-radius: 50%;">
                <!-- Buttons for Home and Login Pages -->
                <div class="row">
                    <div class="col-md-6">
                        <a href="homePage" id="homePageButton" class="btn btn-info"><i class="fas fa-home"></i> Home</a>
                    </div>
                    <div class="col-md-6">
                        <a href="logInPage" id="logInPageButton" class="btn btn-info"><i class="fas fa-sign-in-alt"></i>
                            Login</a>
                    </div>
                </div>
            </div>
            <form action="#" method="post">
                <h4 class="text-center mb-4" style="font-weight: bold; color: #333;">Email Confirmation</h4>

                <!-- Email Input Field -->
                <div class="form-group position-relative">
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                        <input type="email" id="email" name="email" class="form-control" onchange="onEmail()"
                            placeholder="Enter your email" required>
                    </div>
                    <small id="emailError" class="text-danger"></small>
                    <small id="emailSuccess" class="text-success"></small>
                </div>

                <!-- Generate OTP Button -->
                <div class="d-grid justify-content-center gap-2 mt-3">
                    <button type="button" class="btn btn-primary" id="checkEmail" disabled>Generate OTP</button>
                </div>

                <!-- OTP Input Field (Initially Hidden) -->
                <div class="form-group mt-4" id="otpSection" style="display: none;">
                    <label for="otp" class="form-label">Enter OTP:</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-key"></i></span>
                        <input type="text" id="otp" name="otp" class="form-control" placeholder="Enter OTP" required>
                    </div>
                    <small id="otpError" class="text-danger"></small>

                    <!-- Validate OTP Button -->
                    <div class="d-grid justify-content-center gap-2 mt-3">
                        <button type="button" class="btn btn-success" id="validateOTP">Validate OTP</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!-- -----------------------  SignUP FROM HTML code  ------------------------>
    <div class="container" id="signupForm" style="display: none;">
        <div class="text-center mb-4">
            <img src="res/images/vendor comapany logo.webp" alt="Company Logo"
                style="width: 150px; height: auto; border-radius: 50%;">
            <!-- Buttons for Home and Login Pages -->
            <div class="row">
                <div class="col-md-6">
                    <a href="homePage" id="homePageButton" class="btn btn-info"><i class="fas fa-home"></i> Home</a>
                </div>
                <div class="col-md-6">
                    <a href="logInPage" id="logInPageButton" class="btn btn-info"><i class="fas fa-sign-in-alt"></i>
                        Login</a>
                </div>
            </div>
        </div>
         <form id="registerForm">
            <h2>Register Form</h2>
            <div id="verificationSuccessMessage" style="display: none;" class="alert alert-success" role="alert">Your
                email has been
                verified successfully. Please fill out all fields to create your
                account.</div>
            <fieldset>
                <h5>Personal Details</h5>
                <div class="mb-3">
                    <div class="row">
                        <div class="col">
                            <div class="input-container">
                                <input type="text" class="form-control" id="ownerName" name="ownerName"
                                    onchange="onName()" required> <label for="ownerName">Owner Name</label> <span
                                    id="errorownerName" class="validError"></span>
                            </div>
                        </div>
                        <div class="col">
                            <div class="input-container">
                                <input type="email" class="form-control" id="signupEmail" name="emailId"
                                    readonly="readonly"> <label for="email">Email</label>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <div class="input-container">
                                <input type="tel" class="form-control" id="contactNumber" name="contactNumber" required
                                    onchange="validateContactNumber()"> <label for="contactNumber">contact Number
                                </label> <span id="errorContactNumber" class="validError"></span>
                            </div>
                        </div>
                        <div class="col">
                            <div class="input-container">
                                <input type="tel" class="form-control" id="altContactNumber" name="altContactNumber"
                                    required onchange="validateAltContactNumber()"> <label
                                    for="AltPhoneNumber">Alt-Phone Number</label> <span id="erroraltContactNumber"
                                    class="validError"></span>
                            </div>
                        </div>
                    </div>
                </div>
            </fieldset>
            <br>
            <fieldset>
                <div class="mb-3">
                    <h5>Business Details</h5>
                    <div class="row">
                        <div class="col">
                            <div class="input-container">
                                <input type="text" class="form-control" id="vendorName" name="vendorName" required
                                    onchange="onVendorName()"> <label for="vendorName">Vendor Name</label> <span
                                    id="errorVendorName" class="validError"></span>
                            </div>
                        </div>
                        <div class="col">
                            <div class="input-container">
                                <input type="text" class="form-control" id="gstNumber" name="GSTNumber" required
                                    onchange="onGSTNumber()"> <label for="gstNumber">GST Number</label> <span
                                    id="errorGSTNumber" class="validError"></span>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <div class="input-container">
                                <input type="date" class="form-control" id="startDate" name="startDate" required> <label
                                    for="startDate">Business
                                    Start Date</label>
                            </div>
                        </div>
                        <div class="col">
                            <div class="input-container">
                                <input type="text" class="form-control" id="website" name="website" required
                                    onchange="onWebsite()"> <label for="website">WebSite</label> <span id="errorWebsite"
                                    class="validError"></span>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <div class="input-container">
                                <input type="text" class="form-control" id="address" name="address" required> <label
                                    for="address">Address</label>
                            </div>
                        </div>
                        <div class="col">
                            <div class="input-container">
                                <input type="text" class="form-control" id="pincode" name="pincode" required
                                    onchange="validatePincode()" /> <label for="address">PinCode</label> <span
                                    id="errorpincode" class="validError"></span>
                            </div>
                        </div>
                    </div>
                </div>
            </fieldset>
              <button id="submitBtn" type="submit" class="btn btn-primary d-block mx-auto" disabled>Register</button>
            <!-- <button id="button" type="submit" class="btn btn-primary d-block mx-auto" disabled>Register</button> -->
           
        </form>
    </div>
     <div class="modal fade" id="successModal" tabindex="-1" role="dialog"
		aria-labelledby="successModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-sm"
			role="document">
			<div class="modal-content success-modal-content">
				<div class="modal-body text-center">
					<h5 class="modal-title mb-3">Success</h5>
					<p>User registered successfully.</p>
				</div>
			</div>
		</div>
	</div>

	<!-- Error Modal -->
	<div class="modal fade" id="errorModal" tabindex="-1" role="dialog"
		aria-labelledby="errorModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-sm"
			role="document">
			<div class="modal-content error-modal-content">
				<div class="modal-body text-center">
					<h5 class="modal-title mb-3">Error</h5>
					<p id="errorMessage"></p>
				</div>
			</div>
		</div>
	</div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
        crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"></script>
    <!-- -----------------------  Email verification Start ------------------------>
    <script>
        function onEmail() {
            var emailInput = document.getElementById('email');

            // Check if emailInput is not null before accessing its value
            var emailValue = emailInput ? emailInput.value.trim() : '';

            var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
           

            if (emailRegex.test(emailValue)) {
                const xhttp = new XMLHttpRequest();
              
                xhttp.open("GET",
                    "/VendoraX/checkEmailExistence/"
                    + encodeURIComponent(emailValue));
                xhttp.send();

                xhttp.onload = function () {
                    if (xhttp.status === 200) {
                        var exists = this.responseText === "EmailIDexists";
                        if (exists) {
                            document.getElementById("emailError").innerHTML = "Email already exists";
                            document.getElementById("checkEmail").disabled = true;
                        } else {
                            document.getElementById("emailError").innerHTML = "";
                            document.getElementById("checkEmail").disabled = false;
                        }
                    } else {
                        console.error('Error fetching email existence:',
                            xhttp.status);
                    }
                };
            } else {
                document.getElementById("emailError").innerText = "Please enter a valid email address";
                document.getElementById("checkEmail").disabled = true;
            }
        }
        document.getElementById('checkEmail').addEventListener('click',
            function () {
                validateEmail();
            });

        function validateEmail() {
            var userEmail = document.getElementById('email').value;

            $
                .ajax({
                    url: '/VendoraX/genrateOTPAndSave?email='
                        + userEmail,
                    type: 'GET',
                    success: function (response) {
                        if (response.trim() === 'Exists') {
                            document.getElementById('emailError').innerHTML = ' ';
                            document.getElementById('emailSuccess').innerHTML = 'OTP sent to email.';
                            document.getElementById('otpSection').style.display = 'block';
                            document.getElementById('checkEmail').style.disabled = true;
                        } else {
                            document.getElementById('emailError').innerHTML = 'otp is not genrated.';
                            document.getElementById('checkEmail').style.disabled = false;
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.error('Error:', textStatus, errorThrown);
                    }
                });
        }
        document.getElementById('validateOTP').addEventListener('click',
            function () {
                validateOTP();
            });
        function validateOTP() {
            var otpValue = document.getElementById('otp').value;
            var userEmail = document.getElementById('email').value;

            if (otpValue != null && otpValue != "") {
                $
                    .ajax({
                        url: '/VendoraX/validateEmailVerificationOTP',
                        type: 'POST',
                        data: {
                            otp: otpValue,
                            email: userEmail
                        },
                        success: function (response) {
                            if (response.trim() === 'valid') {
                                document
                                    .getElementById('verificationSuccessMessage').style.display = 'block';
                                document.getElementById('emailVerify').style.display = 'none';
                                document.getElementById('signupForm').style.display = 'block';
                                document.getElementById('signupEmail').value = userEmail;
                            } else {
                                document.getElementById('otpError').innerHTML = 'Invalid OTP.';
                                document.getElementById("submitBtn").disabled = false;
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console
                                .error('Error:', textStatus,
                                    errorThrown);
                        }
                    });
            } else {
                document.getElementById('otpError').innerHTML = 'Please enter a valid OTP.';
                document.getElementById("submitBtn").disabled = false;
            }
        }
    </script>
    <!---------------------------Check ContactNumber / Website / GSTNumber EXIT In DataBase-->
    <script>
        // Function to validate and check existence of contact number in database
        function validateContactNumber() {
            var contactNumber = document.getElementById("contactNumber").value;
            if (/^\d{10}$/.test(contactNumber)) {
                const xhttp = new XMLHttpRequest();

                xhttp.open("GET",
                    "/VendoraX/checkContactNumberExistence/"
                    + encodeURIComponent(contactNumber));
                xhttp.send();

                xhttp.onload = function () {
                    var exists = this.responseText === "contactNumberexists";
                    if (exists) {
                        document.getElementById("errorContactNumber").innerHTML = "Contact number already exists";
                        document.getElementById("submitBtn").disabled = true;
                    } else {
                        document.getElementById("errorContactNumber").innerHTML = "";
                        document.getElementById("submitBtn").disabled = false;
                    }
                };
            } else {
                document.getElementById("errorContactNumber").innerText = "Contact number should be a valid 10-digit number";
                document.getElementById("submitBtn").disabled = true;
            }
        }
        // Function to validate and check existence of GSTNumber in database
        function onGSTNumber() {
            var gstInput = document.getElementById('gstNumber');
            var gstValue = gstInput.value.trim();
            var gstRegex = /^[A-Za-z0-9]{15}$/;

            if (gstRegex.test(gstValue)) {
                const xhttp = new XMLHttpRequest();
              

                xhttp.open("GET",
                    "/VendoraX/checkGSTNumberExistence/"
                    + encodeURIComponent(gstValue));
                xhttp.send();

                xhttp.onload = function () {
                    var exists = this.responseText === "GSTNumberExist";
                    if (exists) {
                        document.getElementById("errorGSTNumber").innerText = "GST number already exists";
                        document.getElementById("submitBtn").disabled = true;
                    } else {
                        document.getElementById("errorGSTNumber").innerText = "";
                        document.getElementById("submitBtn").disabled = false;
                    }
                };
            } else {
                document.getElementById("errorGSTNumber").innerText = "GST number should contain 15 alphanumeric characters";
                document.getElementById("submitBtn").disabled = true;
            }
        }
        // Function to validate and check existence of Website in database
        function onWebsite() {
            var websiteInput = document.getElementById('website');
            var websiteValue = websiteInput.value.trim();
            var websiteRegex = /^(http(s)?:\/\/)?(www\.)?[a-zA-Z0-9-]+\.[a-zA-Z]{2,}(\.[a-zA-Z]{2,})?$/;

            if (websiteRegex.test(websiteValue)) {
                const xhttp = new XMLHttpRequest();

                xhttp.open("GET",
                    "/VendoraX/checkWebsiteExistence/"
                    + encodeURIComponent(websiteValue));
                xhttp.send();

                xhttp.onload = function () {
                    var exists = this.responseText === "websiteExists";
                    if (exists) {
                        document.getElementById("errorWebsite").innerText = "Website already exists in the database";
                        document.getElementById("submitBtn").disabled = true;
                    } else {
                        document.getElementById("errorWebsite").innerText = "";
                        document.getElementById("submitBtn").disabled = false;
                    }
                };
            } else {
                document.getElementById("errorWebsite").innerText = "Invalid website format";
                document.getElementById("submitBtn").disabled = true;
            }
        }
    </script>
    <!-- -----------------------  SignUP FROM EACH FILED VALIDATION CODE  ------------------------>
    <script>
        function onName() {
            var userName = document.getElementById("ownerName").value.trim();

            var isValidLength = userName.replace(/\s+/g, '').length >= 3;

            var isValidCharacters = /^[A-Za-z\s]+$/.test(userName);

            if (isValidLength && isValidCharacters) {
                document.getElementById("errorownerName").innerHTML = "";
                document.getElementById("submitBtn").disabled = false;
            } else {
                document.getElementById("errorownerName").innerHTML = "Username must be at least 3 alphabetic characters";
                document.getElementById("submitBtn").disabled = true;
            }
        }
        // Function to validate vedor name
        function onVendorName() {
            var userName = document.getElementById("vendorName").value.trim();

            var isValidLength = userName.replace(/\s+/g, '').length >= 3;

            var isValidCharacters = /^[A-Za-z\s]+$/.test(userName);

            if (isValidLength && isValidCharacters) {
                document.getElementById("errorVendorName").innerHTML = "";
                document.getElementById("submitBtn").disabled = false;
            } else {
                document.getElementById("errorVendorName").innerHTML = "VendorName must be at least 3 alphabetic characters";
                document.getElementById("submitBtn").disabled = true;
            }
        }

        // Function to validate alternate contact number
        function validateAltContactNumber() {
            var number = document.getElementById("contactNumber").value;
            var altNumber = document.getElementById("altContactNumber").value;
            var numberRegex = /^[0-9]{10}$/;
            if (numberRegex.test(altNumber) && number !== altNumber) {
                document.getElementById("erroraltContactNumber").innerHTML = "";
                document.getElementById("submitBtn").disabled = false;
            } else {
                document.getElementById("erroraltContactNumber").innerHTML = number === altNumber ? "Contact and alternate number cannot be same"
                    : "Enter 10 digits number";
                document.getElementById("submitBtn").disabled = true;
            }
        }

        // Function to validate pincode
        function validatePincode() {
            var pincode = document.getElementById("pincode").value;
            var pincodeRegex = /^\d{6}$/;
            if (pincodeRegex.test(pincode)) {
                document.getElementById("errorpincode").innerHTML = "";
                document.getElementById("submitBtn").disabled = false;
            } else {
                document.getElementById("errorpincode").innerHTML = "Pincode must be 6 digits";
                document.getElementById("submitBtn").disabled = true;
            }
        }
    </script>
    
    <script>
    $(document).ready(function() {
        // Prevent default form submission
        $('#registerForm').submit(function(event) {
            event.preventDefault(); // Prevent page refresh

            // Get form data
            var formData = $(this).serialize();
            console.log(formData);

            // Perform AJAX request
            $.ajax({
                url: '/VendoraX/vendorRegister', // URL to send data to the controller
                type: 'POST',
                data: formData,
                success: function(response) {
                	 $('#successModal').modal('show');
 		            setTimeout(function() {
 		                $('#successModal').modal('hide');
 		            }, 3000);
 		           document.getElementById('registerForm').reset();
                },
                error: function(xhr, status, error) {
                	 $('#errorMessage')
                     .text(error);
                	$('#errorModal').modal('show');
	                setTimeout(function() {
	                    $('#errorModal').modal('hide');
	                }, 3000);
                  
                }
            });
        });

        // Function to show modal
        function showModal(message, alertClass) {
            $('#resultMessage').removeClass('alert-success alert-danger').addClass(alertClass).text(message);
            $('#resultModal').modal('show');

            // Hide modal after 3 seconds
            setTimeout(function() {
                $('#resultModal').modal('hide');
            }, 3000);
        }
    });
</script>

</body>

</html>


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 