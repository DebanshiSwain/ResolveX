# ResolveX  
### Smart Complaint Management & Escalation System

<div align="center">

![Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=java&logoColor=white)
![JSP](https://img.shields.io/badge/JSP-007396?style=for-the-badge&logo=java&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![HTML](https://img.shields.io/badge/HTML-E34F26?style=for-the-badge&logo=html5&logoColor=white)
![CSS](https://img.shields.io/badge/CSS-1572B6?style=for-the-badge&logo=css3&logoColor=white)

*A structured system to simplify complaint registration, tracking, and resolution with transparent escalation flow.*

</div>

---

## 📌 About the Project

ResolveX is a web-based complaint management system developed as part of our **Internet & Web Technology Lab Project**.

The main idea behind this project was to replace traditional, unorganized complaint handling (manual follow-ups, confusion in status tracking, and delayed responses) with a **centralized digital system**.

It allows users to raise complaints and track them in real time, while administrators can manage, assign, and resolve them efficiently through a dedicated dashboard.

---

## 🎯 Objectives

- Digitize the complaint registration process  
- Provide real-time tracking of complaints  
- Introduce structured escalation between departments  
- Enable smooth admin-level management and control  
- Improve transparency in complaint resolution  

---

## ✨ Key Features

### 👤 User Module
- Easy complaint registration
- Real-time complaint status tracking
- View submitted complaints history
- Secure login system
- Forgot password support

### 🛠️ Admin Module
- Secure admin login
- Central dashboard for all complaints
- Update complaint status
- Assign complaints to departments
- Delete or manage records

### ⚙️ System Features
- Structured escalation workflow
- Department-based routing
- PostgreSQL database integration
- JSP-based dynamic pages
- Session-based authentication

---

## 🧰 Tech Stack

| Layer | Technology |
|------|------------|
| Frontend | HTML, CSS |
| Backend | Java, JSP |
| Database | PostgreSQL |
| Tools | Eclipse IDE, PGAdmin 4 |

---

## 📂 Project Structure
ResolveX/
│
├── database/
│   ├── admins.sql
│   ├── complaints.sql
│   ├── departments.sql
│   └── updates.sql
│
├── documentation/
│   ├── images/
│   │   └── background.png
│
├── jsp-files/
│   ├── index.jsp
│   ├── adminLogin.jsp
│   ├── adminDashboard.jsp
│   ├── dashboard.jsp
│   ├── raiseComplaint.jsp
│   ├── trackComplaint.jsp
│   ├── updateStatus.jsp
│   ├── deleteComplaint.jsp
│   ├── forgotPassword.jsp
│   ├── logout.jsp
│   ├── assignSlot.jsp
│   └── saveSlot.jsp
│
├── screenshots/
│   ├── 1.png
│   ├── 2.png
│   ├── 3.png
│   ├── 4.png
│   ├── 5.png
│   ├── 6.png
│   └── 7.png
│
└── README.md

---

## 🗄️ Database Design

The system uses **PostgreSQL** as the backend database.

Main tables include:
- Users / Complaints
- Admins
- Departments

These tables handle complaint lifecycle, authentication, and workflow management.

---

## 🔄 How It Works
User submits complaint
        ↓
Complaint stored in database
        ↓
Admin reviews from dashboard
        ↓
Assigned to department
        ↓
Status updated (Pending → In Progress → Resolved)
        ↓
User tracks progress in real time

---

## 📈 What I Learned

- Building dynamic web applications using JSP  
- Working with backend databases (PostgreSQL)  
- Designing role-based systems (User/Admin)  
- Handling session management and authentication  
- Structuring a full-stack mini project  

---

## 🚀 Future Improvements

- Email notifications for status updates  
- Better UI/UX with modern frontend design  
- Deployment on cloud platform  
- Role-based access control improvements  
- Analytics dashboard for admin insights  

---

## 👨‍💻 Developer

This project was built as part of an academic lab submission to demonstrate full-stack web development fundamentals using Java-based technologies.

---

⭐ *ResolveX focuses on simplicity, structure, and transparency in complaint management.*
