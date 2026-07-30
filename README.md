# 🌱 Kisan Agritec - Premium Plants E-Commerce Platform

[![Java](https://img.shields.io/badge/Java-17-blue.svg)](https://www.oracle.com/java/)
[![JSP](https://img.shields.io/badge/JSP-3.1-orange.svg)](https://www.oracle.com/java/)
[![Servlet](https://img.shields.io/badge/Servlet-4.0-red.svg)](https://www.oracle.com/java/)
[![MySQL](https://img.shields.io/badge/MySQL-8.0-blue.svg)](https://www.mysql.com/)
[![Tomcat](https://img.shields.io/badge/Tomcat-9.0-green.svg)](https://tomcat.apache.org/)

---

## 📖 Overview

**Kisan Agritec** is a full-stack web application designed to connect farmers with premium quality tissue culture plants. The platform allows users to browse products, place orders, and manage their purchases seamlessly. It includes an admin panel for managing products, orders, and users.

---

## ✨ Features

### 👤 User Features
- User Registration & Login
- Product Catalog (Teak, Mahogany, Sandalwood, Lemon, Mango, Pomegranate, etc.)
- Shopping Cart
- Order Management
- Contact Form

### 🔐 Admin Features
- Admin Dashboard
- Product Management (Add/Delete)
- Order Management (Update Status)
- User Management
- Contact Management

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|------------|
| Frontend | HTML5, CSS3, JavaScript, JSP |
| Backend | Java 17, Servlet 4.0, JDBC |
| Database | MySQL 8.0 |
| Server | Apache Tomcat 9.0 |
| IDE | Eclipse IDE |
| Version Control | Git & GitHub |

---

## 📁 Project Structure

```
KisanAgritec/
│
├── src/
│   └── main/
│       ├── java/
│       │   └── com/
│       │       └── kisanagritec/
│       │           ├── dao/          # Data Access Objects
│       │           ├── model/        # POJO Classes
│       │           ├── servlet/      # All Servlets
│       │           └── utils/        # Database Connection
│       │
│       └── webapp/
│           ├── admin/                # Admin JSP Pages
│           ├── css/                  # Stylesheets
│           ├── WEB-INF/              # Configuration Files
│           ├── index.jsp             # Homepage
│           ├── products.jsp          # Product Listing
│           ├── register.jsp          # Registration Page
│           ├── login.jsp             # Login Page
│           ├── cart.jsp              # Shopping Cart
│           ├── checkout.jsp          # Checkout Page
│           ├── orders.jsp            # Order History
│           └── contact.jsp           # Contact Form
│
├── .gitignore
└── README.md
```

---

## ⚙️ Installation & Setup

### Prerequisites
- Java 17 or higher
- Eclipse IDE for Enterprise Java and Web Developers
- Apache Tomcat 9.0
- MySQL 8.0
- MySQL Connector/J

### Steps

**1. Clone the Repository**
```bash
git clone https://github.com/VJ-Shukla/KisanAgritec.git
```

**2. Open in Eclipse**
- File → Import → Existing Projects into Workspace
- Select the cloned folder → Finish

**3. Add JDBC Driver**
- Right-click project → Build Path → Configure Build Path
- Libraries → Add External JARs
- Select `mysql-connector-j-9.7.0.jar` → Apply and Close

**4. Configure Tomcat**
- Window → Show View → Servers
- New → Server → Tomcat v9.0 Server
- Browse to Tomcat folder → Finish

---

## 🗄️ Database Setup

**1. Create Database**
```sql
CREATE DATABASE kisanagritec;
USE kisanagritec;
```

**2. Create Tables**
```sql
CREATE TABLE users(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(255),
    mobile VARCHAR(20),
    address TEXT,
    role VARCHAR(20) DEFAULT 'customer',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200),
    category VARCHAR(100),
    description TEXT,
    price DECIMAL(10,2),
    image_url VARCHAR(255),
    stock INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE orders(
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2),
    status VARCHAR(50) DEFAULT 'pending',
    shipping_address TEXT,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE order_items(
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE contacts(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    message TEXT,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

**3. Insert Admin User**
```sql
INSERT INTO users (name, email, password, role) 
VALUES ('Admin', 'admin@Vijay.com', 'Vijay123', 'admin');
```

**4. Insert Sample Products**
```sql
INSERT INTO products (name, category, description, price, stock) VALUES
('Teak Plant - Tissue Culture', 'Teak', 'High quality tissue culture teak plant.', 150.00, 100),
('Mahogany Plant', 'Mahogany', 'Premium mahogany plant with excellent wood quality.', 200.00, 80),
('Sandalwood Plant', 'Sandalwood', 'Indian sandalwood with high aromatic oil content.', 500.00, 50),
('Seedless Thai Lemon', 'Lemon', 'High yielding seedless Thai lemon plant.', 120.00, 200),
('Custard Apple', 'Fruits', 'Sweet and delicious custard apple plant.', 180.00, 60),
('Mango - Dasheri', 'Fruits', 'Premium Dasheri mango plant.', 250.00, 40),
('Apple Ber', 'Fruits', 'Hybrid apple ber with high yield.', 220.00, 75),
('Pomegranate - Bhagwa', 'Fruits', 'Premium Bhagwa pomegranate plant.', 300.00, 50);
```

**5. Update Database Credentials**
Open `DBConnection.java` and update:
```java
private static final String PASSWORD = "your_mysql_password";
```

---

## 🚀 Running the Application

1. Right-click project → Run As → Run on Server
2. Select Tomcat v9.0 Server → Finish
3. Open browser: `http://localhost:8080/KisanAgritec/`

---

## 🔐 Admin Panel

| Credential | Value |
|------------|-------|
| Email | `admin@Vijay.com` |
| Password | `Vijay123` |

**Admin Features:**
- Add/Delete Products
- Manage Orders (Pending → Shipped → Delivered)
- View Users
- View Contact Messages

---

## 🤝 Contributing

1. Fork the repository
2. Create a new branch: `git checkout -b feature/YourFeature`
3. Commit: `git commit -m 'Add some feature'`
4. Push: `git push origin feature/YourFeature`
5. Open a Pull Request

---

## 📄 License

This project is open-source and available under the MIT License.

---

## 📞 Contact

**Kisan Agritec**  
📍 At. MUMBAI, Tq. VASAI, Dist. PALGHAR  
📞 9373569939, 8828272664  

**Developer:** VJ-Shukla  
🔗 [GitHub](https://github.com/VJ-Shukla)

---

## ⭐ Show Your Support

If you found this project helpful, please give it a **⭐ Star** on GitHub!

---

**Happy Farming! 🌾🌱**
