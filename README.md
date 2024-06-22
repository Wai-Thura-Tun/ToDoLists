# ToDo Master App

## Table of Contents
1. [Introduction](#introduction)
2. [Features](#features)
3. [Screenshots](#screenshots)
4. [Installation](#installation)
5. [Usage](#usage)

## Introduction
This project is a ToDo Master application for practicing my ios development skill developed using Swift, adhering to the MVVM (Model-View-ViewModel) design pattern. It incorporates third-party library called Realm to store and manipulate ToDo Lists dataand uses Swift Package Manager for dependency management, local notifications to 
notify whenever each ToDo is due.

## Features
- **Create Tasks**: Easily add new tasks with titles, descriptions, due dates, and sub-tasks.
- **Manage Tasks**: Edit, delete, mark as complete.
- **Sub-tasks**: Break down larger tasks into smaller, manageable sub-tasks for better organization.
- **Search and Filter**: Quickly find tasks using search bar.

## Screenshots

<style>
  .screenshot {
    border: 2px solid #ccc;
    border-radius: 10px;
    margin: 10px;
    padding: 5px;
  }
  .screenshot-container {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
  }
  .screenshot-item {
    margin: 10px;
  }
</style>

<div class="screenshot-container">
  <div class="screenshot-item">
    <img src="https://github.com/Wai-Thura-Tun/ToDoLists/assets/103933946/4725d434-432a-47b8-a364-03dace5ba814" alt="Simulator Screenshot - iPhone 15 Pro - 2024-06-22 at 14 55 10" width="375" height="812" class="screenshot">
  </div>
  <div class="screenshot-item">
    <img src="https://github.com/Wai-Thura-Tun/ToDoLists/assets/103933946/7765cbae-b820-4cf4-89ab-13aa8c5f9428" alt="Simulator Screenshot - iPhone 15 Pro - 2024-06-22 at 14 55 50" width="375" height="812" class="screenshot">
  </div>
  <div class="screenshot-item">
    <img src="https://github.com/Wai-Thura-Tun/ToDoLists/assets/103933946/211820fd-3e9e-42e2-87cb-c3db14625520" alt="Simulator Screenshot - iPhone 15 Pro - 2024-06-22 at 14 56 44" width="375" height="812" class="screenshot">
  </div>
  <div class="screenshot-item">
    <img src="https://github.com/Wai-Thura-Tun/ToDoLists/assets/103933946/90489b47-6790-45fe-8e63-63192a554440" alt="Simulator Screenshot - iPhone 15 Pro - 2024-06-22 at 14 56 48" width="375" height="812" class="screenshot">
  </div>
  <div class="screenshot-item">
    <img src="https://github.com/Wai-Thura-Tun/ToDoLists/assets/103933946/e6ba8cfc-241d-4380-9600-b5c4f8d3a028" alt="Simulator Screenshot - iPhone 15 Pro - 2024-06-22 at 14 58 01" width="375" height="812" class="screenshot">
  </div>
</div>

## Installation
1. Clone the repository to your local machine.
2. Open the project in Xcode.
3. Build and run the app on your iOS device or simulator.

## Usage
1. Launch the app on your device.
2. Create a new task by tapping the "+" button.
3. Fill in the task details such as title, description, due date, and sub-tasks.
4. Save the task and manage it from the main task list.
5. Mark tasks as complete, edit or delete them as needed.
