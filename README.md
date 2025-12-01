# 📌 **Smart To-Do App (Flutter + GetX + Modular Architecture)**

## 🧩 Overview

Smart To-Do App is a modular, rule-based productivity application built with **Flutter** and **GetX**, following a clean and scalable architecture.
Users can manage tasks, track completion, and view automatically suggested tasks for the day based on customizable rules.

---

## 🚀 Features

### ✅ **Task Management**

* Add new tasks
  * Title
  * Priority (High / Medium / Low)
  * Category (Work / Personal / Health)
  * Estimated Time (in minutes)
* View all tasks
* Mark tasks as completed

### 🎯 **Smart Suggestions Engine**

Automatically selects tasks for “Today” section using the following rules (all rules are toggle-based):

1. Total estimated time must **not exceed 240 minutes**
2. Sort tasks by **priority**
3. Within same priority, prefer **shorter tasks**
4. Include tasks from at least **two different categories**
5. If any high-priority task is skipped due to time limit → **show warning**

### ⚙️ **Rule Customization**

* Settings screen allows enabling/disabling each rule
* Rules are stored locally using Hive for persistence

---

## 🏗️ Project Structure (Clean Architecture + GetX)

```
lib/
│
├── core/
│   ├── bindings/
│   │   └── app_bindings.dart
│   ├── routes/
│   │   ├── app_pages.dart
│   │   └── app_routes.dart
│   └── services/
│       ├── storage_service.dart
│
├── features/
│   └── todo/
│       ├── controllers/
│       ├── presentation/
│       │   ├── pages/
│       │   └── widgets/
│       └── models/
│
└── main.dart
```

---

## 🛠️ Tech Stack

| Tool                     | Usage                         |
| ------------------------ | ----------------------------- |
| **Flutter (Latest)**     | UI framework                  |
| **GetX**                 | State management, routing, DI |
| **Hive**                 | Local storage                 |


---

## ✨ Highlights of My Work

* Fully modular folder structure
* Clean, reusable widgets
* Rule-based task suggestion logic
* GetX controllers with reactive state
* Hive service abstraction
* Easy to scale and maintain
