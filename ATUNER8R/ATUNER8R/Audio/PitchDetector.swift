//
//  PitchDetector.swift
//  ATUNER8R
//

import AVFoundation
import Accelerate

class PitchDetector: ObservableObject {

    private var audioEngine: AVAudioEngine?
    private var inputNode: AVAudioInputNode?

    @Published var detectedFrequency: Double = 0.0
    @Published var detectedNote: String = "-"
    @Published var centsOffset: Double = 0.0
    @Published var isListening: Bool = false
    @Published var amplitude: Float = 0.0

    private let sampleRate: Double = 44100.0
    private let bufferSize: AVAudioFrameCount = 4096

    // All note frequencies for chromatic detection
    private let noteFrequencies: [(name: String, frequency: Double)] = {
        let noteNames = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]
        var notes: [(String, Double)] = []

        // Generate notes from C0 to B8
        for octave in 0...8 {
            for (index, name) in noteNames.enumerated() {
                // A4 = 440Hz, calculate all other notes
                let semitonesFromA4 = (octave - 4) * 12 + (index - 9)
                let frequency = 440.0 * pow(2.0, Double(semitonesFromA4) / 12.0)
                notes.append(("\(name)\(octave)", frequency))
            }
        }
        return notes
    }()

    init() {
        setupAudioSession()
    }

    private func setupAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .measurement, options: [.defaultToSpeaker, .allowBluetooth])
            try audioSession.setActive(true)
        } catch {
            print("Failed to set up audio session: \(error)")
        }
    }

    func startListening() {
        guard !isListening else { return }

        audioEngine = AVAudioEngine()
        guard let audioEngine = audioEngine else { return }

        inputNode = audioEngine.inputNode
        guard let inputNode = inputNode else { return }

        let format = inputNode.outputFormat(forBus: 0)

        inputNode.installTap(onBus: 0, bufferSize: bufferSize, format: format) { [weak self] buffer, _ in
            self?.processAudioBuffer(buffer)
        }

        do {
            try audioEngine.start()
            DispatchQueue.main.async {
                self.isListening = true
            }
        } catch {
            print("Failed to start audio engine: \(error)")
        }
    }

    func stopListening() {
        inputNode?.removeTap(onBus: 0)
        audioEngine?.stop()
        audioEngine = nil
        inputNode = nil

        DispatchQueue.main.async {
            self.isListening = false
            self.detectedFrequency = 0.0
            self.detectedNote = "-"
            self.centsOffset = 0.0
            self.amplitude = 0.0
        }
    }

    private func processAudioBuffer(_ buffer: AVAudioPCMBuffer) {
        guard let channelData = buffer.floatChannelData?[0] else { return }
        let frameLength = Int(buffer.frameLength)

        // Calculate amplitude (RMS)
        var rms: Float = 0
        vDSP_measqv(channelData, 1, &rms, vDSP_Length(frameLength))
        rms = sqrt(rms)

        DispatchQueue.main.async {
            self.amplitude = rms
        }

        // Only process if signal is strong enough
        guard rms > 0.01 else {
            DispatchQueue.main.async {
                self.detectedNote = "-"
                self.detectedFrequency = 0.0
                self.centsOffset = 0.0
            }
            return
        }

        // Autocorrelation for pitch detection
        let frequency = detectPitchAutocorrelation(channelData, frameLength: frameLength)

        guard frequency > 20 && frequency < 5000 else { return }

        // Find closest note
        let (noteName, targetFrequency) = findClosestNote(frequency)
        let cents = calculateCents(detected: frequency, target: targetFrequency)

        DispatchQueue.main.async {
            self.detectedFrequency = frequency
            self.detectedNote = noteName
            self.centsOffset = cents
        }
    }

    private func detectPitchAutocorrelation(_ data: UnsafeMutablePointer<Float>, frameLength: Int) -> Double {
        // Simple autocorrelation-based pitch detection
        let minPeriod = Int(sampleRate / 5000) // Max freq ~5000 Hz
        let maxPeriod = Int(sampleRate / 20)   // Min freq ~20 Hz

        var bestCorrelation: Float = 0
        var bestPeriod = 0

        for period in minPeriod..<min(maxPeriod, frameLength / 2) {
            var correlation: Float = 0

            for i in 0..<(frameLength - period) {
                correlation += data[i] * data[i + period]
            }

            if correlation > bestCorrelation {
                bestCorrelation = correlation
                bestPeriod = period
            }
        }

        guard bestPeriod > 0 else { return 0 }

        return sampleRate / Double(bestPeriod)
    }

    private func findClosestNote(_ frequency: Double) -> (name: String, frequency: Double) {
        var closestNote = noteFrequencies[0]
        var minDiff = Double.infinity

        for note in noteFrequencies {
            let diff = abs(frequency - note.frequency)
            if diff < minDiff {
                minDiff = diff
                closestNote = note
            }
        }

        return closestNote
    }

    private func calculateCents(detected: Double, target: Double) -> Double {
        guard target > 0 else { return 0 }
        return 1200 * log2(detected / target)
    }

    func centsOffsetFor(targetFrequency: Double) -> Double {
        guard detectedFrequency > 0, targetFrequency > 0 else { return 0 }
        return 1200 * log2(detectedFrequency / targetFrequency)
    }
}
