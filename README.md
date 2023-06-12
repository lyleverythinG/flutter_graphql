# Flutter GRAPHQL - Book App
_BookApp is a mobile application demo built with Flutter that allow users to add, update, and delete a book and its information. Users can also search for books by author name, title, or year. API Link: https://books-demo-apollo-server.herokuapp.com/_
# NOTE
- I do not own the API source, I just found it from a youtube and made use of it for making this flutter app demo with GraphQL.
- This is my first time using GraphQL and currently practicing on how to use it in my mobile apps.
# Other Features includes:
- Displays the list of books from the API.
- Viewing book information
- Local Data Persistence using HIVE.
- Widget Tested.

# STATE MANAGEMENT 
_The app uses the Bloc state management pattern to manage its state, which helps keep the code organized and maintanable as the app grows._

# ARCHITECTURE
_The app uses a combination of Flutter Bloc Architecture and Clean Architecture which helps to keep the code organized and maintenable as the app grows._

# How to Setup the Project

## Installing Flutter on windows

Follow guide from the official documentation if needed [official guide](https://docs.flutter.dev/get-started/install/windows).

## Install FVM
In order to run the project, you need to install FVM (Flutter Version Management).
Follow guide from the official documentation if needed [official guide](https://fvm.app/docs/getting_started/installation/).

## Install the Flutter Version (3.7.7)

using command: `fvm install 3.7.7`. 

## Run the command to use the Flutter Version.

`fvm use 3.7.7`

## Run the command to update packages.

`fvm flutter pub get`
## Run the Command For HIVE Setup
`flutter packages pub run build_runner build`

## Run the app using the command `fvm flutter run`
