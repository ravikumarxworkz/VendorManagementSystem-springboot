# Vendor Management System

The **Vendor Management System** is a full-stack application developed using **Spring Boot**, **MySQL**, **HTML**, **CSS**, and **JavaScript**. This platform is designed to facilitate seamless interactions between vendors and administrators, covering the end-to-end process from vendor registration to order tracking, messaging, and payment processing.

## Features

### 1. Vendor Registration and Login
- **Vendor Registration**: Vendors can register by providing required details. Upon registration, an email notification is sent with login credentials and instructions.
- **Login with OTP**: Vendors can log in using an OTP (valid for 2 minutes) sent via email for enhanced security.
- **Admin Login**: Admins have the option to log in using both OTP and password.

### 2. Vendor Dashboard
- **Profile Management**: Vendors can view and update their profile details.
- **Product Management**: Vendors can add, update, and manage products available in their inventory.
- **Order Management**: Vendors can view and process orders received, update order status, and track payment information.
- **Order History**: Vendors have access to a record of all past orders with relevant details.
- **Messaging with Admin**: Vendors can chat with the admin in a live chat format similar to WhatsApp.
- **Notifications**: Vendors receive notifications on new orders, messages, and other important updates.

### 3. Admin Dashboard
- **Vendor Approval**: Admins can review and approve vendor registrations.
- **Product and Order Management**: Admins can view and manage all products listed by vendors, handle order statuses, and review order history.
- **Messaging with Vendors**: Admins can engage in real-time chat with vendors, providing support and guidance as needed.
- **Order Tracking**: Admins can monitor the status of all orders placed, similar to platforms like Amazon and Flipkart, ensuring smooth tracking from order placement to delivery.
- **Notification System**: Admins receive alerts on new vendor registrations, order updates, and other significant events.

## Functional Modules

- **Vendor Registration/Login**: Secure vendor registration with email OTP verification for login.
- **Product Module**: Vendors can manage their products, including adding, updating, and viewing product details.
- **Order Module**: Features for creating orders, updating order status, and viewing order history.
- **Payment Module**: Integrated payment options with secure processing for each transaction.
- **Messaging System**: Real-time chat functionality between vendors and admins.
- **Order Tracking**: Allows both vendors and admins to view and track order progress and delivery status.

## Technologies Used

- **Backend**: Spring Boot, Java, MySQL
- **Frontend**: HTML, CSS, JavaScript
- **Security**: Email-based OTP authentication for secure login
- **Database**: MySQL for persistent data storage
- **Messaging**: Real-time chat functionality

## Installation

1. **Clone the repository**:
   ```bash
   git clone [https://github.com/ravikumarxworkz/VendorManagementSystem-springboot.git]
   ```
2. **Configure the database**:
   - Set up a MySQL database and update the application properties with your database details.
   
3. **Run the application**:
   - Use your IDE or execute the following command:
     ```bash
     ./mvnw spring-boot:run
     ```
   
4. **Access the Application**:
   - Open your browser and navigate to `http://localhost:8080`.

## Usage

1. **Vendor Registration**: Go to the registration page, complete the form, and verify registration through email.
2. **Login**: Vendors and admins can log in using the OTP feature for added security.
3. **Admin Approvals**: Admins can review and approve or reject vendor registrations from their dashboard.
4. **Order Tracking**: Both vendors and admins can track orders and update statuses as they progress.
5. **Messaging**: Access the chat interface to communicate in real-time between admins and vendors.

## Project Structure

- **Controllers**: Manages routing and HTTP request handling.
- **Services**: Business logic and data processing.
- **Repositories**: Manages data access to the MySQL database.
- **Models**: Defines the application’s data structure.
- **Frontend**: HTML, CSS, and JavaScript files for the user interface.

## Future Enhancements

- **Enhanced Analytics**: Integrate dashboards to provide vendors and admins with insights into sales and performance metrics.
- **Mobile Responsiveness**: Improve UI for better accessibility on mobile devices.
- **Additional Payment Gateways**: Support multiple payment options for wider accessibility.

## License

This project is licensed under the MIT License. Feel free to use and modify as per your needs.


