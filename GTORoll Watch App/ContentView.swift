import SwiftUI

struct ContentView: View {
    // Current time
    @State private var currentTime = Date()
    
    // Timer state
    @State private var isTimerRunning = false
    @State private var elapsedTime: TimeInterval = 0
    @State private var timerStartDate: Date?
    
    // Random number (0-99)
    @State private var randomNumber = Int.random(in: 0...99)
    
    // Timers
    @State private var clockTimer: Timer?
    @State private var rngTimer: Timer?
    
    var body: some View {
        VStack(spacing: 8) {
            // Row 1: Current Time
            Text(timeString(from: currentTime))
                .font(.system(size: 24, weight: .light, design: .monospaced))
                .foregroundColor(.white)
            
            // Row 2: Stopwatch Timer
            Text(timerString(from: elapsedTime))
                .font(.system(size: 28, weight: .medium, design: .monospaced))
                .foregroundColor(isTimerRunning ? .green : .yellow)
            
            // Row 3: Random Number
            Text(String(format: "%02d", randomNumber))
                .font(.system(size: 64, weight: .bold, design: .monospaced))
                .foregroundColor(.cyan)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .onAppear {
            startClockAndRNG()
        }
        .onDisappear {
            stopAllTimers()
        }
        // Digital Crown press to start/stop timer
        .focusable(true)
        .digitalCrownRotation($elapsedTime, from: 0, through: 0, sensitivity: .low, isContinuous: false, isHapticFeedbackEnabled: false)
        .onTapGesture {
            toggleTimer()
        }
    }
    
    // MARK: - Time Formatting
    
    private func timeString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: date)
    }
    
    private func timerString(from interval: TimeInterval) -> String {
        let minutes = Int(interval) / 60
        let seconds = Int(interval) % 60
        let tenths = Int((interval.truncatingRemainder(dividingBy: 1)) * 10)
        return String(format: "%02d:%02d.%d", minutes, seconds, tenths)
    }
    
    // MARK: - Timer Controls
    
    private func startClockAndRNG() {
        // Update clock every second
        clockTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            currentTime = Date()
            randomNumber = Int.random(in: 0...99)
            
            // Update elapsed time if timer is running
            if isTimerRunning, let startDate = timerStartDate {
                elapsedTime = Date().timeIntervalSince(startDate)
            }
        }
    }
    
    private func stopAllTimers() {
        clockTimer?.invalidate()
        rngTimer?.invalidate()
    }
    
    private func toggleTimer() {
        if isTimerRunning {
            // Stop timer
            isTimerRunning = false
            if let startDate = timerStartDate {
                elapsedTime = Date().timeIntervalSince(startDate)
            }
            timerStartDate = nil
        } else {
            // Start timer (reset if was stopped)
            if elapsedTime > 0 {
                // Resume from where we left off
                timerStartDate = Date().addingTimeInterval(-elapsedTime)
            } else {
                // Fresh start
                timerStartDate = Date()
                elapsedTime = 0
            }
            isTimerRunning = true
        }
    }
}

#Preview {
    ContentView()
}
