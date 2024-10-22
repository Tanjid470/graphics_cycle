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
 
  
## Dependencies
  ```bash
   dependencies:
     flutter:
       sdk: flutter
     http: ^0.13.4                     # For making API requests
     image_cropper: ^2.0.1             # For image cropping and rotation
     gallery_saver: ^2.2.1              # For saving images to the gallery
     # Add other dependencies as needed


