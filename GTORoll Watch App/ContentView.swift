import SwiftUI

struct ContentView: View {
    // Timer state
    @State private var isTimerRunning = false
    @State private var elapsedTime: TimeInterval = 0
    @State private var timerStartDate: Date?
    
    // Random number (0-99)
    @State private var randomNumber = Int.random(in: 0...99)
    
    // Timer
    @State private var updateTimer: Timer?
    
    var body: some View {
        VStack(spacing: 12) {
            // Row 1: Stopwatch Timer (MMM:SS format, supports up to 999 minutes)
            Text(timerString(from: elapsedTime))
                .font(.system(size: 36, weight: .medium, design: .monospaced))
                .foregroundColor(isTimerRunning ? .green : .yellow)
            
            // Row 2: Random Number
            Text(String(format: "%02d", randomNumber))
                .font(.system(size: 72, weight: .bold, design: .monospaced))
                .foregroundColor(.cyan)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .onAppear {
            startUpdateTimer()
        }
        .onDisappear {
            stopTimer()
        }
        .focusable(true)
        .onTapGesture {
            toggleTimer()
        }
    }
    
    // MARK: - Time Formatting
    
    private func timerString(from interval: TimeInterval) -> String {
        let totalSeconds = Int(interval)
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        // Support up to 999 minutes
        return String(format: "%03d:%02d", min(minutes, 999), seconds)
    }
    
    // MARK: - Timer Controls
    
    private func startUpdateTimer() {
        updateTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            // Update random number every second
            randomNumber = Int.random(in: 0...99)
            
            // Update elapsed time if timer is running
            if isTimerRunning, let startDate = timerStartDate {
                elapsedTime = Date().timeIntervalSince(startDate)
            }
        }
    }
    
    private func stopTimer() {
        updateTimer?.invalidate()
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
            // Start timer
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
