# Copilot instructions for Projeto Android

Purpose: Help AI coding agents be productive by documenting the repository state, typical tasks to perform, and patterns you can follow in this codebase.

1. Project overview
   - This repository currently contains a single static dashboard `index.html` (Portuguese). It lists goals and steps for an Android app but does not include Android source code.
   - Treat this repo as a planning/landing page currently — major components (Kotlin/Java app, backend) are not present yet.

2. Immediate tasks where AI can help
   - Implement a README: document repo goals, desired Android module names, and backend expectations.
   - Scaffold an Android project: a minimal `app/` module has been added using Jetpack Compose; it includes `AndroidManifest.xml`, `MainActivity.kt` (Compose), and `app/build.gradle` with Compose dependencies.
   - Add CI basics: create `build.yml` (GitHub Actions) for Android or simple HTML repo checks.
   - Expand dashboard: convert `index.html` into a project tracker with links to `app/` when created.

3. Repo-specific conventions and observations
   - Language: Portuguese is used in `index.html`. Keep localization in mind when adding user-facing text.
   - File layout: single page with inline styles. If adding Android or backend code, keep `index.html` only for project info and add directories such as `app/`, `backend/`, `docs/`.
   - Code style: No linters are present. Add `ktlint`, `detekt`, or `eslint` for consistency if scaffolding a frontend/backend.

4. Key files to reference when making changes
   - `index.html` — the dashboard, source of project goals and status.
   - `.github/` — CI configs and AI agent guidance. See `.github/workflows/android-ci.yml` for a simple HTML check and an optional Gradle build step.
   - `app/` — the scaffolded Android module (Kotlin) with an example `MainActivity` and layout. Import into Android Studio to run.
   - `settings.gradle`, `build.gradle` — project-level Gradle files for the scaffold.

5. Build/test/debug workflows
    - The repository now includes a minimal Android scaffold but does not include the Gradle wrapper by default. To build locally:
       - Import the project in Android Studio (recommended) and click Run.
       - Or install Gradle and run (PowerShell):
          `gradle assembleDebug`
      - Once present, `./gradlew assembleDebug` is preferred; CI in `.github/workflows/android-ci.yml` now uses the Gradle wrapper and will fail if the wrapper is missing. Add the wrapper locally with `gradle wrapper --gradle-version 8.2.1` and commit the wrapper files (`gradlew`, `gradlew.bat`, and `gradle/wrapper/*`).
     - For a simple HTML check, use `htmlhint` or run a `link-checker` action.

6. When to ask for clarification
   - If tasked with creating Android modules: ask about minimum SDK, Kotlin or Java preference, intended API endpoints.
   - For backend integration: ask whether to use REST, GraphQL, or Firebase.

7. Safety and scope
   - Do not assume sensitive credentials or API keys; add `.env.example` if needed and use environment variables in CI.

Examples — `MainActivity` scaffold in repo

- Compose example in `app/src/main/java/.../MainActivity.kt` uses `setContent { }` and Compose `@Composable` functions. Use `androidx.activity:activity-compose` and `androidx.compose.*` dependencies in `app/build.gradle`.
- Update `index.html` to link to `app/` status sections.

If you need further scaffolding (Gradle wrapper, tests, Kotlin multiplatform, or sample backend), tell me which piece to add and I will scaffold it and add detailed TODOs.
