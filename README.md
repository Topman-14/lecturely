<p align="center">
   <img src="https://github.com/Topman-14/lecturely/assets/98329531/d91ce51d-2e71-4428-8cdd-feb3b67aec22" alt="Lecturely logo"  />
</p>

# Lecturely: A Lecturer Management System
[![Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)](https://github.com/Topman-14/lecturely)
[![CSS3](https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=css3&logoColor=white)](https://github.com/Topman-14/lecturely)
[![MySQL](https://img.shields.io/badge/MySQL-005C84?style=for-the-badge&logo=mysql&logoColor=white)](https://github.com/Topman-14/lecturely)

Lecturely is a web-based application I developed as part of an academic project. This innovative platform is dedicated to efficiently handling lecturers and their pertinent information. Leveraging Java Server Pages (JSP) as its core technology, Lecturely boasts a seamless and visually appealing user interface, making it an ideal solution for academic institutions seeking streamlined lecturer management.

## Screenshots

<p align="center">
   
### Landing
   ![scrnli_1_26_2024_8-58-48 PM](https://github.com/Topman-14/lecturely/assets/98329531/fd354d86-0eb7-4cd0-8049-9e9b8bb2a3eb)

### Dashboard
   ![scrnli_1_26_2024_9-22-22 PM](https://github.com/Topman-14/lecturely/assets/98329531/a8008367-49d7-49e5-a3da-ea8949a3b350)

### View Lecturers
   ![scrnli_1_26_2024_9-22-48 PM](https://github.com/Topman-14/lecturely/assets/98329531/80d0428e-f378-4552-8e3d-afd4ee286612)

</p>

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

7. **Run the Application**: Start the Apache Tomcat server. Once the server is running, you can access the Lecturely application by navigating to `http://localhost:8080/lecturely_prod` in your web browser.

## Usage

1. **Signup**: Access the administrator signup page at `http://localhost:8080/lecturely_prod/admin-signup.jsp` and create an account.
   
2. **Login**: Use your admin credentials to log in to the application.

3. **Manage Lecturers**: As an Admin, You can add, update, or delete lecturers by navigating to the "View All Lecturers" section in the application.

4. **Logout**: You can log out of the application by clicking on the "Logout" button in the bottom left corner of the application.
