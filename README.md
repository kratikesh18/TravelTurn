# TravelTurn

A web-based Travel Management System built using **Java Servlets**, **JSP**, **JDBC**, and **MySQL**.  
This system allows users to manage bookings, itineraries, and user accounts for travel services.

---

## ✨ Features

- User registration and login
- Create, view, edit, and delete travel bookings
- Add, update, and delete itineraries per booking
- Session management with user roles
- JSP-based UI with JSTL support

---

## 🛠️ Technologies Used

- Java 8+
- Java Servlets, JSP, JSTL
- JDBC + MySQL
- Apache Tomcat 9.x
- Maven (optional, if using dependency management)

---

## ⚙️ Setup Instructions

1. **Clone the repository**


2. **Configure Database**

- Create a MySQL database:

  ```sql
  CREATE DATABASE travel_management;
  ```

- Run the provided `schema.sql` (if available) or manually create tables for:
  - `users`
  - `bookings`
  - `itineraries`

- Update database credentials in your `DBConnection.java` or config file.

3. **Set up dependencies**

If using Maven:
- Make sure `pom.xml` includes:
  ```xml
  javax.servlet-api
  javax.servlet.jsp-api
  javax.servlet.jsp.jstl-api
  taglibs standard
  mysql-connector-java
  ```

If not using Maven:
- Download JARs and place in `WEB-INF/lib`.

4. **Configure Tomcat**

- Use **Apache Tomcat 9.x**.
- Set the project as a WAR or deploy from IntelliJ IDEA.
- Make sure `web.xml` is correctly set.

---

## 🚀 Run the Project

1. Build the project in IntelliJ.
2. Deploy to Tomcat (`localhost:8080/travel-management`).
3. Access in browser:

---

## 📖 Author

- **Kartikesh**
---

## 💬 Notes

- Use **Tomcat 9.x** for compatibility with `javax.*` packages.
- If using Tomcat 10+, update all imports to `jakarta.*`.
- Use JSTL and standard taglibs for JSP views.

---

## 📝 License

This project is licensed under the MIT License.
