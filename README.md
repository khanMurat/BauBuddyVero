# BauBuddyVero

## Features
- Fetch and display a list of tasks from a remote API.
- Offline access to tasks using a local SQL database.
- Search functionality to find tasks quickly.
- QR-Code scanning to set search queries.
- Pull-to-refresh to update task list in real-time.

## Technical Specifications
- **Networking**: API calls are made using `Alamofire` for clean and efficient networking.
- **Persistence**: Local storage is implemented using `SQLite` for SQL-backed persistence.
- **Architecture**: The app follows the MVVM (Model-View-ViewModel) architecture with Repository pattern to keep the business logic separate from UI code.
- **Reactive Programming**: `RxSwift` is used to bind the UI components to the ViewModel layer, allowing for reactive and responsive user interfaces.
