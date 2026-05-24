//
//  Instrument.swift
//  ATUNER8R
//

import Foundation

struct TuningNote: Identifiable {
    let id = UUID()
    let name: String
    let frequency: Double
    let octave: Int

    var displayName: String {
        "\(name)\(octave)"
    }
}

struct Instrument: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let notes: [TuningNote]

    var noteNames: String {
        notes.map { $0.name }.joined(separator: " ")
    }
}

// Standard tuning frequencies (A4 = 440Hz reference)
enum Instruments {

    // MARK: - 1. Guitar Standard (E A D G B E)
    static let guitarStandard = Instrument(
        name: "Guitar (Standard)",
        icon: "guitars",
        notes: [
            TuningNote(name: "E", frequency: 82.41, octave: 2),
            TuningNote(name: "A", frequency: 110.00, octave: 2),
            TuningNote(name: "D", frequency: 146.83, octave: 3),
            TuningNote(name: "G", frequency: 196.00, octave: 3),
            TuningNote(name: "B", frequency: 246.94, octave: 3),
            TuningNote(name: "E", frequency: 329.63, octave: 4)
        ]
    )

    // MARK: - 2. Guitar Drop D (D A D G B E)
    static let guitarDropD = Instrument(
        name: "Guitar (Drop D)",
        icon: "guitars",
        notes: [
            TuningNote(name: "D", frequency: 73.42, octave: 2),
            TuningNote(name: "A", frequency: 110.00, octave: 2),
            TuningNote(name: "D", frequency: 146.83, octave: 3),
            TuningNote(name: "G", frequency: 196.00, octave: 3),
            TuningNote(name: "B", frequency: 246.94, octave: 3),
            TuningNote(name: "E", frequency: 329.63, octave: 4)
        ]
    )

    // MARK: - 3. Guitar DADGAD
    static let guitarDADGAD = Instrument(
        name: "Guitar (DADGAD)",
        icon: "guitars",
        notes: [
            TuningNote(name: "D", frequency: 73.42, octave: 2),
            TuningNote(name: "A", frequency: 110.00, octave: 2),
            TuningNote(name: "D", frequency: 146.83, octave: 3),
            TuningNote(name: "G", frequency: 196.00, octave: 3),
            TuningNote(name: "A", frequency: 220.00, octave: 3),
            TuningNote(name: "D", frequency: 293.66, octave: 4)
        ]
    )

    // MARK: - 4. Bass Guitar (E A D G)
    static let bassGuitar = Instrument(
        name: "Bass Guitar",
        icon: "guitars.fill",
        notes: [
            TuningNote(name: "E", frequency: 41.20, octave: 1),
            TuningNote(name: "A", frequency: 55.00, octave: 1),
            TuningNote(name: "D", frequency: 73.42, octave: 2),
            TuningNote(name: "G", frequency: 98.00, octave: 2)
        ]
    )

    // MARK: - 5. Voice (Chromatic - wide range)
    static let voice = Instrument(
        name: "Voice",
        icon: "mic.fill",
        notes: [
            // Common vocal reference pitches
            TuningNote(name: "C", frequency: 130.81, octave: 3),
            TuningNote(name: "E", frequency: 164.81, octave: 3),
            TuningNote(name: "G", frequency: 196.00, octave: 3),
            TuningNote(name: "A", frequency: 220.00, octave: 3),
            TuningNote(name: "C", frequency: 261.63, octave: 4),
            TuningNote(name: "E", frequency: 329.63, octave: 4),
            TuningNote(name: "G", frequency: 392.00, octave: 4),
            TuningNote(name: "A", frequency: 440.00, octave: 4)
        ]
    )

    // MARK: - 6. Greek Baglamas (D D A A D D)
    static let baglamas = Instrument(
        name: "Baglamas",
        icon: "music.note",
        notes: [
            TuningNote(name: "D", frequency: 293.66, octave: 4),
            TuningNote(name: "D", frequency: 293.66, octave: 4),
            TuningNote(name: "A", frequency: 220.00, octave: 3),
            TuningNote(name: "A", frequency: 220.00, octave: 3),
            TuningNote(name: "D", frequency: 146.83, octave: 3),
            TuningNote(name: "D", frequency: 146.83, octave: 3)
        ]
    )

    // MARK: - 7. Greek Bouzouki (C F A D - Tetrachordo)
    static let bouzouki = Instrument(
        name: "Bouzouki",
        icon: "music.note.list",
        notes: [
            TuningNote(name: "C", frequency: 130.81, octave: 3),
            TuningNote(name: "F", frequency: 174.61, octave: 3),
            TuningNote(name: "A", frequency: 220.00, octave: 3),
            TuningNote(name: "D", frequency: 293.66, octave: 4)
        ]
    )

    // MARK: - 8. Fiddle/Violin (G D A E)
    static let fiddle = Instrument(
        name: "Fiddle",
        icon: "waveform.path",
        notes: [
            TuningNote(name: "G", frequency: 196.00, octave: 3),
            TuningNote(name: "D", frequency: 293.66, octave: 4),
            TuningNote(name: "A", frequency: 440.00, octave: 4),
            TuningNote(name: "E", frequency: 659.25, octave: 5)
        ]
    )

    // MARK: - All Instruments
    static let all: [Instrument] = [
        guitarStandard,
        guitarDropD,
        guitarDADGAD,
        bassGuitar,
        voice,
        baglamas,
        bouzouki,
        fiddle
    ]
}
