# GTORoll 🎲

A simple Apple Watch app for poker players using GTO (Game Theory Optimal) strategy.

## Features

- **Current Time** - Always visible at the top
- **Stopwatch Timer** - Tap screen to start/stop (useful for timing your decisions)
- **Random Number (0-99)** - Updates every second for GTO mixing decisions

## Screenshot

```
    23:45:12      ← Current time
    00:15.3       ← Stopwatch (tap to start/stop)
      42          ← Random number (0-99)
```

## Requirements

- watchOS 10.0+
- Xcode 15.0+

## Installation

1. Clone this repo
2. Open `GTORoll.xcodeproj` in Xcode
3. Select your development team in Signing & Capabilities
4. Build and run on your Apple Watch

## Usage

1. Open the app on your watch before playing
2. Keep the app running (works with Always-On Display on supported models)
3. Glance at your watch when you need a random number for GTO decisions
4. Tap the screen to start/stop the timer if needed

## Why?

GTO poker strategy often requires making randomized decisions (e.g., "bet 70% of the time"). This app gives you a clean, always-updating random number to help implement mixed strategies without giving away tells.

## License

MIT License - see [LICENSE](LICENSE) for details.

## Author

Built by [@poshboytl](https://github.com/poshboytl) with help from [Fiona](https://github.com/openclaw/openclaw) 🦊
