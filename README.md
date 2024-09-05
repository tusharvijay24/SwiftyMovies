# SwiftyMovies

SwiftyMovies is an iOS application that provides users with information about movies, including movie details, ratings, and search functionality.

## Features

- **Movie Search**: Search for movies based on user input.
- **Movie Details**: Display detailed information about selected movies, including ratings and reviews.
- **Splash Screen**: Initial splash screen upon app launch.
- **Movie List**: View a list of movies, with movie posters and relevant details.
- **Movie Ratings**: See ratings of movies fetched from a remote server.

## Project Structure

### Controllers
- **VcMain.swift**: The main view controller that displays a list of movies.
- **VcDetail.swift**: View controller responsible for displaying the details of a selected movie.
- **VcSplash.swift**: Splash screen view controller shown at the app's launch.
  
### Cells
- **MovieListCell.swift**: Custom table view cell used in `VcMain` to display movie information.

### Models
- **MovieListModel.swift**: Data model representing a list of movies.
- **MovieDetailModel.swift**: Data model representing detailed information about a specific movie.
- **MovieRatingModel.swift**: Data model representing ratings for a movie.
- **MovieSearchModel.swift**: Data model for handling movie search functionality.

### Helpers
- **WebServiceHelper.swift**: Responsible for managing network requests to fetch movie data.
- **NetworkManager.swift**: Handles network connectivity and error checking.
- **UserDefaultManager.swift**: Utility for managing app user settings and preferences.

### UI Helpers
- **UIActivityIndicator.swift**: Custom UI activity indicator.
- **UIAlert.swift**: Utility for displaying alerts to users.

### Views
- **LaunchScreen.storyboard**: The launch screen storyboard.
- **Main.storyboard**: The main storyboard for the app.
- **Splash.storyboard**: Storyboard for the splash screen.

## Dependencies

This project uses CocoaPods to manage dependencies. Key dependencies include:

- **SDWebImage**: For downloading and caching images.
  
To install the required dependencies, run:

```bash
pod install
```

## Getting Started

### Prerequisites

- Xcode 12.0 or later
- iOS 14.0 or later
- CocoaPods

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/SwiftyMovies.git
   ```

2. Navigate to the project directory and install dependencies:
   ```bash
   cd SwiftyMovies
   pod install
   ```

3. Open the `.xcworkspace` file in Xcode:
   ```bash
   open SwiftyMovies.xcworkspace
   ```

4. Build and run the project on a simulator or device.

## Unit Tests

The project includes basic unit tests in the `SwiftyMoviesTests` directory. To run the tests:

1. Open the project in Xcode.
2. Select the `Product` menu.
3. Choose `Test` (or press `Cmd+U`).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
