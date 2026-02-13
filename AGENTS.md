# AGENTS.md

## Project Overview

GTORoll is an Apple Watch app for poker players using GTO (Game Theory Optimal) strategy. It displays a stopwatch timer and a continuously updating random number (0-99) to help players make randomized decisions without behavioral tells.

## Build & Test Commands

The project uses **XcodeGen** to generate the Xcode project from `project.yml`.

```bash
# Regenerate Xcode project after modifying project.yml
xcodegen generate

# Build via command line
xcodebuild -project GTORoll.xcodeproj -scheme "GTORoll Watch App" -destination 'platform=watchOS Simulator,name=Apple Watch Series 9 (45mm)'
```

There are no tests, no linter, and no external dependencies.

## Architecture Notes

Single-view watchOS app with a minimal iOS companion (required for watchOS deployment).

- **`GTORoll Watch App/ContentView.swift`** — All watch UI and logic. Uses `@State` properties with a 1-second `Timer` that updates both the random number and stopwatch elapsed time.
- **`GTORoll Watch App/GTORollApp.swift`** — SwiftUI app entry point.
- **`GTORoll/GTORollApp.swift`** — iOS companion app placeholder (shows "use on Apple Watch" message).
- **`project.yml`** — XcodeGen config defining both targets (iOS `com.poshboy.gtoroll`, watchOS `com.poshboy.gtoroll.watchkitapp`).

## Key Behaviors

- Tap screen toggles stopwatch start/stop; tapping again after stop resumes from where it left off
- Random number regenerates every second via `Int.random(in: 0...99)`
- Black background optimized for OLED always-on display
- All state is ephemeral — no persistence or network calls
