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

