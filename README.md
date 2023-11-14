# f_authenticator

## Features

### Easy Configuration
- Configure TOTP generation parameters such as algorithm, interval, key length, and more.
- Automatic secret generation if not provided, ensuring convenience and security.

### TOTP Generation
- Generate TOTP codes in both integer and string formats.
- Retrieve a URL link for the authenticator, simplifying integration into authenticator apps.

### Stream-Based Functionality
- Continuously receive updated TOTP codes through a stream-based approach.
- Stream TOTP codes in both integer and string formats for real-time usage.



## Usage
The `FAuthenticator` class provides functionalities to generate and manage TOTP codes for 2FA. Here's a basic example:

import the library in your Dart code:

```dart
import 'package:f_authenticator/f_authenticator.dart';
```

```dart

void main() {
  // Initialize the authenticator
  FAuthenticator authenticator = FAuthenticator(
    appName: 'YourAppName',
    username: 'user@example.com',
  );

  // Get the TOTP link for setup
  String totpLink = authenticator.getLink;

  // Generate a random secret
  String randomSecret = authenticator.getRandomSecret;

  // Get the current TOTP code as a string
  String currentCodeString = authenticator.getCurrentStringCode;

  // Get the current TOTP code as an integer
  int currentCode = authenticator.getCurrentCode;

  // Access the TOTP code as a stream
  Stream<int> codeStream = authenticator.getCodeStream();
  // Stream<String> stringCodeStream = authenticator.getStringCodeStream();

  // Subscribe to the stream for real-time code updates
  codeStream.listen((code) {
    print('Current code: $code');
    // Perform actions with the updated code
  });
}
```

#### Methods

- `getLink`: Generates a TOTP URL link for the authenticator.
- `getRandomSecret`: Retrieves a randomly generated secret.
- `getCurrentSecret`: Retrieves the current secret used for generating TOTP codes.
- `getCurrentStringCode`: Generates the current TOTP code as a string.
- `getCurrentCode`: Generates the current TOTP code as an integer.
- `getCodeStream`: Provides a stream of updated TOTP codes.
- `getStringCodeStream`: Provides a stream of updated TOTP codes as strings.



## Contributing
Contributions are welcome! If you find any issues or have suggestions for improvements, feel free to open an issue or submit a pull request.

## License
This library is licensed under the MIT License. See the [LICENSE](https://github.com/Odinachi/f_autheticator/blob/d149e6c6898d8bd2e08b1602ea331fd76f776481/LICENSE) file for details.
