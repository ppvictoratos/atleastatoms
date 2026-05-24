import AVFoundation
import Accelerate

class AudioEngineManager: ObservableObject {
    @Published var distortion = DistortionParameters()

    private var audioEngine: AVAudioEngine
    private var inputNode: AVAudioInputNode
    private var outputNode: AVAudioOutputNode
    private var mixer: AVAudioMixerNode

    // Audio format
    private let sampleRate: Double = 48000.0
    private let bufferSize: AVAudioFrameCount = 512

    init() {
        audioEngine = AVAudioEngine()
        inputNode = audioEngine.inputNode
        outputNode = audioEngine.outputNode
        mixer = AVAudioMixerNode()

        setupAudioSession()
        setupAudioEngine()
    }

    private func setupAudioSession() {
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker, .allowBluetooth])
            try audioSession.setPreferredSampleRate(sampleRate)
            try audioSession.setPreferredIOBufferDuration(Double(bufferSize) / sampleRate)
            try audioSession.setActive(true)
        } catch {
            print("Failed to setup audio session: \(error)")
        }
    }

    private func setupAudioEngine() {
        // Attach mixer node
        audioEngine.attach(mixer)

        // Get the input format
        let inputFormat = inputNode.outputFormat(forBus: 0)

        // Create our processing format (mono for guitar)
        guard let processingFormat = AVAudioFormat(
            commonFormat: .pcmFormatFloat32,
            sampleRate: sampleRate,
            channels: 1,
            interleaved: false
        ) else {
            print("Failed to create processing format")
            return
        }

        // Connect input to mixer with format conversion
        audioEngine.connect(inputNode, to: mixer, format: inputFormat)

        // Install tap on mixer to process audio
        mixer.installTap(onBus: 0, bufferSize: bufferSize, format: processingFormat) { [weak self] buffer, time in
            self?.processAudioBuffer(buffer)
        }

        // Connect mixer to output
        audioEngine.connect(mixer, to: outputNode, format: processingFormat)

        // Prepare the engine
        audioEngine.prepare()
    }

    private func processAudioBuffer(_ buffer: AVAudioPCMBuffer) {
        guard let channelData = buffer.floatChannelData else { return }

        let frameCount = Int(buffer.frameLength)
        let channel = channelData[0]

        // Apply distortion effect
        applyDistortion(to: channel, frameCount: frameCount)
    }

    private func applyDistortion(to samples: UnsafeMutablePointer<Float>, frameCount: Int) {
        // Create a mutable pointer for processing
        var inputSamples = [Float](repeating: 0, count: frameCount)
        var outputSamples = [Float](repeating: 0, count: frameCount)

        // Copy input samples
        for i in 0..<frameCount {
            inputSamples[i] = samples[i]
        }

        // Apply distortion algorithm
        let drive = distortion.drive * 50.0 + 1.0 // Range: 1-51
        let tone = distortion.tone
        let mix = distortion.mix

        for i in 0..<frameCount {
            var sample = inputSamples[i]

            // Pre-gain
            sample *= drive

            // Soft clipping (tanh approximation for smoother distortion)
            sample = tanhApprox(sample)

            // Simple tone control (low-pass filter)
            if i > 0 {
                sample = sample * tone + outputSamples[i-1] * (1.0 - tone)
            }

            // Mix dry/wet signal
            outputSamples[i] = sample * mix + inputSamples[i] * (1.0 - mix)

            // Post-gain compensation
            outputSamples[i] *= 0.5
        }

        // Copy processed samples back
        for i in 0..<frameCount {
            samples[i] = outputSamples[i]
        }
    }

    // Fast tanh approximation for soft clipping
    private func tanhApprox(_ x: Float) -> Float {
        if x < -3.0 { return -1.0 }
        if x > 3.0 { return 1.0 }
        let x2 = x * x
        return x * (27.0 + x2) / (27.0 + 9.0 * x2)
    }

    func updateDistortionParameters() {
        // Parameters are already updated via @Published
        // This method can be used for any additional processing needed
    }

    func start() throws {
        if !audioEngine.isRunning {
            try audioEngine.start()
        }
    }

    func stop() {
        if audioEngine.isRunning {
            audioEngine.stop()
        }
    }
}

struct DistortionParameters {
    var drive: Float = 0.5      // 0.0 to 1.0
    var tone: Float = 0.7       // 0.0 (dark) to 1.0 (bright)
    var mix: Float = 0.8        // 0.0 (dry) to 1.0 (wet)
}
