# Flutter Meme App

## Description

This Flutter application fetches a list of popular memes from the Imgflip API ([Imgflip API](https://api.imgflip.com/get_memes)), displays them with their names and images, and allows for searching, detailed views, image editing (crop, rotate), and saving to the gallery.

## Key Features

- **Clean and Efficient Code**: Utilizing best practices, code architecture, and design patterns for maintainability, readability, and scalability.
- **Modular Structure**: Separating logic and UI components for better organization and reusability.
- **Local Search**: Implementing a search bar to filter memes by name conveniently.
- **Detailed View**: Displaying complete information and enabling image editing on a dedicated screen.
- **Image Editing**: Cropping and rotating images using the `image_cropper` package.
- **Gallery Saving**: Saving edited images to the device's gallery using the `gallery_saver` package.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/flutter_meme_app.git
```bash
lib/
├── main.dart                          # App entry point
├── models/
│   └── meme.dart                     # Meme data model class
├── services/
│   └── meme_api_service.dart         # Service for fetching memes from API
├── ui/
│   ├── app_bar.dart                  # Reusable app bar component
│   ├── home_screen.dart              # Home screen with meme list and search
│   ├── meme_details_screen.dart       # Screen for detailed meme view and editing
│   └── widgets/
│       ├── meme_card.dart             # Reusable meme card widget
│       └── search_bar.dart            # Search bar widget
├── pubspec.yaml                       # Project configuration and dependencies
└── README.md                          # This file (instructions and usage guide)

