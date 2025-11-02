
# 📝 To Do List App

The **To Do List** project is a cross-platform mobile application built with **Flutter** and **Dart**.  
It helps users manage their daily tasks efficiently and is compatible with both **Android** and **iOS** devices.

---

## ⚙️ Architecture

This project follows the **BLoC (Business Logic Component)** architecture pattern.  
Each screen has its own dedicated **BLoC**, ensuring a clear separation between **UI** and **business logic**, which makes the app more modular, scalable, and easy to maintain.

---

## 🗂️ Data Layer Structure

The data layer is organized with a **three-layer architecture**:

1. **Repository Layer** – Acts as a bridge between the BLoC and the data source.
2. **Data Source Layer** – Supplies data to the repository and can work with multiple data sources.
3. Currently, the app uses **Hive** as a **local database** for offline data storage.

Although data is currently stored locally, the project is structured in a way that allows easy future integration with a **remote (global) database**.

---

## 📱 App Screens

### 🏠 Home Screen
- Displays a list of all task lists.
- Each task can be **pinned** or **unpinned** for quick access.
- Users can **mark tasks as done** or **delete** them directly from this screen.
- Managed by its own **HomeScreenBloc**.

### ✏️ Add / Edit Task Screen
- Allows users to **create a new task list** or **edit an existing one**.
- Each task list can contain multiple tasks.
- Managed by its own **AddEditTaskBloc**.

### 🚀 Onboarding Screen
- Shown when the app is opened for the first time.
- Helps introduce the app to new users.
- Visibility is controlled using **SharedPreferences** so it only appears once.

---

## ✨ Animations

The app includes **smooth UI animations** to enhance the user experience.  
Animations are used for:
- **Floating action buttons**
- **Task item transitions** (checking off or deleting tasks)
- **Onboarding screens and page transitions**

These animations make the app interactive and visually appealing while keeping the interface intuitive.

---

## 🎨 UI Design

The app’s user interface is based on a Figma community design, available here:  
👉 [**Figma Design Link**](https://www.figma.com/design/O2wSSeTDg7Ej9ZAgvoA2cH/To-do-List-Mobile-App--Community-?node-id=0-1&p=f)

---

## 🧰 Technologies Used

- **Flutter** – Cross-platform UI framework
- **Dart** – Programming language
- **flutter_bloc** – State management
- **equatable** – Simplifies state comparison
- **Hive** – Local NoSQL database for data persistence
- **SharedPreferences** – Persistent key-value storage (for onboarding state)
- **uuid** – Generates unique random IDs for tasks and lists

---

## 🎥 App Preview

<p align="center">
  <img src="assets/app_demo/To_do_list_Preview.gif" width="300" alt="App Demo">
</p>

![To-do-list_Preview](https://github.com/user-attachments/assets/3a4bc3a8-2358-4ad8-a690-e569e0806c3f)
