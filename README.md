# Flutter Story Generator App

A **Flutter** application that generates creative stories based on user prompts using **OpenAI's GPT-3.5-turbo API**. The app allows users to input custom prompts, generate dynamic stories with titles, and even narrate the story using **text-to-speech (TTS)** functionality.

## Features

- Generate stories based on user input prompts.
- Story titles and content are dynamically generated using the GPT API.
- **Narrate Story**: Stories can be read aloud with text-to-speech (FlutterTTS).
- Manage stories with a user-friendly sidebar that displays generated stories.
- Easy-to-use UI with prompt input and story viewing capabilities.

## Screenshots

![app 1](https://github.com/user-attachments/assets/66bcdf97-83b0-4190-a79f-169bbcb73659)
![app 2](https://github.com/user-attachments/assets/b9d94f4b-3b91-4fa8-b990-afcdcef4c1ab)


## Installation

To run this project locally, follow these steps:

1. Clone the repository:
    ```bash
    git clone https://github.com/your-username/flutter-story-generator.git
    ```
2. Navigate to the project directory:
    ```bash
    cd flutter-story-generator
    ```
3. Install dependencies:
    ```bash
    flutter pub get
    ```
4. Add your OpenAI API Key:
   - In `lib/services/openai_service.dart`, replace `'your-api-key-here'` with your actual OpenAI API key.

5. Run the app:
    ```bash
    flutter run
    ```

## Usage

1. Launch the app and enter a prompt for story generation.
2. Press the **Generate Story** button to generate a new story with a title.
3. Browse previously generated stories from the sidebar.
4. Use the **Narrate Story** button to listen to the generated story with text-to-speech.

## Dependencies

- [Flutter](https://flutter.dev/)
- [GetX](https://pub.dev/packages/get) for state management
- [chat_gpt_sdk](https://pub.dev/packages/chat_gpt_sdk) for OpenAI API integration
- [flutter_tts](https://pub.dev/packages/flutter_tts) for text-to-speech functionality
- [http](https://pub.dev/packages/http) for API requests

## API Integration

The app uses OpenAI's GPT-3.5-turbo model to generate stories. Make sure to add your API key in `openai_service.dart`. You can obtain an API key by signing up for an account on [OpenAI](https://platform.openai.com/).

## Contributing

Contributions are welcome! Please follow these steps to contribute:

1. Fork the repository.
2. Create a new branch: `git checkout -b feature-branch-name`.
3. Make your changes and commit them: `git commit -m 'Add some feature'`.
4. Push to the branch: `git push origin feature-branch-name`.
5. Open a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---
