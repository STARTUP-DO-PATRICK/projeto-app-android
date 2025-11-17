# Projeto Android — Scaffold

This repository currently holds a static dashboard (`index.html`) describing the project and a small Android scaffold `app/` to jumpstart development.

## Quick setup (Android Studio)
1. Open Android Studio.
2. File > Open > select the project root (this repo). Android Studio will prompt to sync Gradle.
3. Optionally, install a compatible Android SDK and set the Android SDK path in SDK Manager.

## Build locally (PowerShell on Windows)
- Import the project in Android Studio and press Run. If you prefer the CLI, install Gradle and run:

gradle assembleDebug
```powershell
# If you don't have the Gradle wrapper, generate it locally:
gradle wrapper --gradle-version 8.2.1

# Then run the wrapper to build (preferred):
.\gradlew assembleDebug

# Or with a local Gradle installation (not recommended):
gradle assembleDebug
```

> Note: This scaffold doesn't include the Gradle wrapper by default; Android Studio will handle Gradle sync.

## Project layout
- `index.html` — static dashboard in Portuguese. Keep this as the project's public landing page.
 - `app/` — minimal Android app module using Jetpack Compose
  - `app/src/main/java/.../MainActivity.kt` — Kotlin entrypoint
  - `app/src/main/res/layout/activity_main.xml` — simple layout (no longer used by Compose scaffold)
  - `app/src/main/AndroidManifest.xml` — minimal manifest
  - `app/build.gradle` — module Gradle config

## CI
- `.github/workflows/android-ci.yml` — now uses the Gradle wrapper and fails the CI if the wrapper isn't present in the repo so PRs always compile.
  - Add the wrapper locally with `gradle wrapper --gradle-version 8.2.1` and commit the generated wrapper files (`gradlew`, `gradlew.bat`, `gradle/wrapper/gradle-wrapper.jar`, `gradle/wrapper/gradle-wrapper.properties`) so CI can build.

## Contributing
- Follow Portuguese for UI text and `index.html` changes unless localization is added.
- If you add secrets or API keys, add `.env.example` and reference them via CI secrets rather than committing.
