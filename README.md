# Lecturely: A Lecturer Management System

Lecturely is a web-based application for managing lecturers and their courses. It is built using Java Server Pages (JSP) and provides an easy-to-use interface for administrators to manage lecturers and courses.

## Getting Started

To run Lecturely locally, follow these steps:

1. **Prerequisites**: Ensure that you have the following software installed on your system:
   - Java Development Kit (JDK) 8 or later
   - Apache Tomcat 9 or later
   - An Integrated Development Environment (IDE) like Eclipse or NetBeans

2. **Clone the Repository**: Clone the Lecturely repository to your local machine using the following command:
  ```
     git clone https://github.com/Topman-14/lecturely.git
  ```

3. **Import the Project**: Import the cloned repository as a project in your IDE.

4. **Configure the Database**: Lecturely uses a MySQL database. Create a new MySQL database and user for Lecturely. Update the `db.properties` file in the `src/main/resources` directory with the appropriate database credentials.

5. **Build the Project**: Build the project using your IDE or by running the following command in the project directory:
   ```
   mvn clean install
   ```

6. **Deploy the Application**: Deploy the generated WAR file (`target/lecturely.war`) to your Apache Tomcat server.

7. **Run the Application**: Start the Apache Tomcat server. Once the server is running, you can access the Lecturely application by navigating to `http://localhost:8080/lecturely` in your web browser.

## Usage

1. **Login**: Use the default admin credentials (username: `admin`, password: `admin`) to log in to the application.

2. **Manage Lecturers**: As an Admin, You can add, edit, or delete lecturers by navigating to the "View All Lecturers" section in the application.

3. **Logout**: You can log out of the application by clicking on the "Logout" button in the top right corner of the application.
