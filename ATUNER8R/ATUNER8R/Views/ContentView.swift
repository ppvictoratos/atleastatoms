//
//  ContentView.swift
//  ATUNER8R
//

import SwiftUI

struct ContentView: View {
    @StateObject private var pitchDetector = PitchDetector()
    @State private var selectedInstrument: Instrument = Instruments.guitarStandard
    @State private var showingInstrumentPicker = false

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [Color(.systemBackground), Color(.systemGray6)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 24) {
                // Header with instrument selector
                headerView

                Spacer()

                // Main tuner display
                tunerDisplayView

                Spacer()

                // String/note buttons for the selected instrument
                stringButtonsView

                Spacer()

                // Listen button
                listenButtonView

                Spacer()
            }
            .padding()
        }
        .sheet(isPresented: $showingInstrumentPicker) {
            InstrumentPickerView(selectedInstrument: $selectedInstrument)
        }
    }

    // MARK: - Header
    private var headerView: some View {
        Button {
            showingInstrumentPicker = true
        } label: {
            HStack {
                Image(systemName: selectedInstrument.icon)
                    .font(.title2)
                Text(selectedInstrument.name)
                    .font(.title2.bold())
                Image(systemName: "chevron.down")
                    .font(.caption)
            }
            .foregroundColor(.primary)
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(Color(.systemGray5))
            .cornerRadius(12)
        }
    }

    // MARK: - Tuner Display
    private var tunerDisplayView: some View {
        VStack(spacing: 16) {
            // Detected note (large)
            Text(pitchDetector.detectedNote)
                .font(.system(size: 100, weight: .bold, design: .rounded))
                .foregroundColor(colorForCents(pitchDetector.centsOffset))

            // Frequency
            Text(pitchDetector.detectedFrequency > 0 ?
                 String(format: "%.1f Hz", pitchDetector.detectedFrequency) : "-- Hz")
                .font(.title3.monospacedDigit())
                .foregroundColor(.secondary)

            // Tuning needle indicator
            TuningNeedleView(cents: pitchDetector.centsOffset)
                .frame(height: 60)
                .padding(.horizontal)

            // Cents offset
            Text(pitchDetector.centsOffset != 0 ?
                 String(format: "%+.0f cents", pitchDetector.centsOffset) : "-- cents")
                .font(.headline.monospacedDigit())
                .foregroundColor(colorForCents(pitchDetector.centsOffset))
        }
    }

    // MARK: - String Buttons
    private var stringButtonsView: some View {
        VStack(spacing: 8) {
            Text("Strings")
                .font(.caption)
                .foregroundColor(.secondary)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(selectedInstrument.notes) { note in
                        StringButtonView(
                            note: note,
                            isActive: isNoteMatch(note),
                            centsOffset: pitchDetector.centsOffsetFor(targetFrequency: note.frequency)
                        )
                    }
                }
                .padding(.horizontal)
            }
        }
    }

    // MARK: - Listen Button
    private var listenButtonView: some View {
        Button {
            if pitchDetector.isListening {
                pitchDetector.stopListening()
            } else {
                pitchDetector.startListening()
            }
        } label: {
            HStack {
                Image(systemName: pitchDetector.isListening ? "stop.fill" : "mic.fill")
                Text(pitchDetector.isListening ? "Stop" : "Listen")
            }
            .font(.title2.bold())
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(pitchDetector.isListening ? Color.red : Color.blue)
            .cornerRadius(16)
        }
        .padding(.horizontal, 40)
    }

    // MARK: - Helpers
    private func colorForCents(_ cents: Double) -> Color {
        let absCents = abs(cents)
        if absCents <= 5 {
            return .green
        } else if absCents <= 15 {
            return .yellow
        } else {
            return .red
        }
    }

    private func isNoteMatch(_ note: TuningNote) -> Bool {
        guard pitchDetector.detectedFrequency > 0 else { return false }
        let cents = abs(pitchDetector.centsOffsetFor(targetFrequency: note.frequency))
        return cents < 50
    }
}

// MARK: - Tuning Needle View
struct TuningNeedleView: View {
    let cents: Double

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let center = width / 2

            // Clamp cents to -50...50 for display
            let clampedCents = CGFloat(max(-50, min(50, cents)))
            let needlePosition = center + (clampedCents / 50) * (width / 2 - 20)

            ZStack {
                // Background track
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color(.systemGray4))
                    .frame(height: 8)

                // Center marker
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 4, height: 24)
                    .position(x: center, y: geometry.size.height / 2)

                // Needle
                Circle()
                    .fill(colorForCents(cents))
                    .frame(width: 20, height: 20)
                    .shadow(radius: 2)
                    .position(x: needlePosition, y: geometry.size.height / 2)
            }
        }
    }

    private func colorForCents(_ cents: Double) -> Color {
        let absCents = abs(cents)
        if absCents <= 5 {
            return .green
        } else if absCents <= 15 {
            return .yellow
        } else {
            return .red
        }
    }
}

// MARK: - String Button View
struct StringButtonView: View {
    let note: TuningNote
    let isActive: Bool
    let centsOffset: Double

    var body: some View {
        VStack(spacing: 4) {
            Text(note.name)
                .font(.title.bold())
            Text(String(format: "%.0f", note.frequency))
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .frame(width: 50, height: 60)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(isActive ? colorForCents(centsOffset).opacity(0.3) : Color(.systemGray5))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(isActive ? colorForCents(centsOffset) : Color.clear, lineWidth: 2)
        )
    }

    private func colorForCents(_ cents: Double) -> Color {
        let absCents = abs(cents)
        if absCents <= 5 {
            return .green
        } else if absCents <= 15 {
            return .yellow
        } else {
            return .red
        }
    }
}

#Preview {
    ContentView()
}
