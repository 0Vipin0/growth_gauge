**Application Architecture** :-
Architecture should be like that so that it contains following capabilities as given in the flutter docs.

- Maintainability - App architecture makes it easier to modify, update, and fix issues over time.
- Scalability - A well thought out application allows more people to contribute to the same codebase concurrently, with minimal code conflicts.
- Testability - Applications with intentional architecture generally have simpler classes with well-defined inputs and outputs, which makes them easier to mock and test.
- A better user experience - Features can ship faster and with fewer bugs.
- Separation of concerns with Layered Architecture  
    *   **UI Layer**: When state changes, your app should trigger a rebuild of the UI that depends on that state.
    *   **Business Logic Layer**:  Implements core business logic, and facilitates interaction between the data and UI layer
    *  **Data Layer**: Used as a Repository for Single Source of Truth (SSOT) responsible for representing local or remote state and If the data can be modified in the app, the SSOT class should be the only class that can do so.
- Unidirectional data flow - 
    *  **UI layer** - An event occurs due to user interaction, such as a button being clicked. The widget's event handler callback invokes a method exposed by a class in the logic layer.
    *  **Business Logic layer** - The logic class calls methods exposed by a repository that know how to mutate the data.
    *  **Data layer** - The repository updates data (if necessary) and then provides the new data to the logic class.
    *  **Business Logic layer** - The logic class saves its new state, which it sends to the UI.
    *  **UI layer** - The UI displays the new state of the view model.
- State Management - Provider, ChangeNotifier
- Application Directory Structure :-
    * ui/core - contains app theme, shared widgets, navigation and routing, global constants etc.
    * ui/_specific-feature_/provider - provider specific files
    * ui/_specific-feature_/widgets - feature specific screen files
    * data/models - model classes for the data
    * data/repositories - database connectivity holding the data
    * data/services - non-database non-state application services like notification, authentication etc.    