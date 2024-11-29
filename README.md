# f_common_package_1

Flutter common packages:

- flutter_svg
- cached_network_image
- chopper
- json_serializable
- shared_preferences
- flutter_launcher_icons
- firebase_analytics
- firebase_messaging

Remember adding Firebase secret to `.gitignore`:

```
**/firebase_options.dart
**/google-services.json
**/GoogleService-Info.plist
```

[Revoke then generate new keys](https://console.cloud.google.com/apis/credentials) in case
accidentally commited above files.

Steps to remove commited files after adding to `.gitignore`:

```shell
git rm -rf --cached .
git add .
```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
