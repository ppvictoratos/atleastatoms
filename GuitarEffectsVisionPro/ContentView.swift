import SwiftUI
import RealityKit

struct ContentView: View {
    @EnvironmentObject var audioEngine: AudioEngineManager
    @State private var isProcessing = false

    var body: some View {
        VStack(spacing: 30) {
            Text("Guitar Effects Pedal")
                .font(.system(size: 48, weight: .bold))
                .padding(.top, 50)

            // Visual feedback
            ZStack {
                Circle()
                    .fill(isProcessing ? Color.green.opacity(0.3) : Color.gray.opacity(0.3))
                    .frame(width: 200, height: 200)

                Image(systemName: isProcessing ? "waveform.circle.fill" : "waveform.circle")
                    .font(.system(size: 80))
                    .foregroundColor(isProcessing ? .green : .gray)
            }
            .padding(.vertical, 30)

            // Effect controls
            VStack(spacing: 25) {
                Text("Distortion Controls")
                    .font(.headline)

                // Drive control
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Drive")
                            .font(.subheadline)
                        Spacer()
                        Text("\(Int(audioEngine.distortion.drive * 100))%")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Slider(value: $audioEngine.distortion.drive, in: 0...1)
                        .onChange(of: audioEngine.distortion.drive) { _, newValue in
                            audioEngine.updateDistortionParameters()
                        }
                }

                // Tone control
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Tone")
                            .font(.subheadline)
                        Spacer()
                        Text("\(Int(audioEngine.distortion.tone * 100))%")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Slider(value: $audioEngine.distortion.tone, in: 0...1)
                        .onChange(of: audioEngine.distortion.tone) { _, newValue in
                            audioEngine.updateDistortionParameters()
                        }
                }

                // Mix control
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Mix")
                            .font(.subheadline)
                        Spacer()
                        Text("\(Int(audioEngine.distortion.mix * 100))%")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Slider(value: $audioEngine.distortion.mix, in: 0...1)
                        .onChange(of: audioEngine.distortion.mix) { _, newValue in
                            audioEngine.updateDistortionParameters()
                        }
                }
            }
            .padding(.horizontal, 40)
            .frame(maxWidth: 600)

            // Start/Stop button
            Button(action: {
                if isProcessing {
                    audioEngine.stop()
                    isProcessing = false
                } else {
                    do {
                        try audioEngine.start()
                        isProcessing = true
                    } catch {
                        print("Error starting audio engine: \(error)")
                    }
                }
            }) {
                Text(isProcessing ? "Stop" : "Start")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 60)
                    .background(isProcessing ? Color.red : Color.blue)
                    .cornerRadius(30)
            }
            .padding(.top, 20)

            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .environmentObject(AudioEngineManager())
}
