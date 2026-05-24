//
//  InstrumentPickerView.swift
//  ATUNER8R
//

import SwiftUI

struct InstrumentPickerView: View {
    @Binding var selectedInstrument: Instrument
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            List {
                ForEach(Instruments.all) { instrument in
                    Button {
                        selectedInstrument = instrument
                        dismiss()
                    } label: {
                        HStack(spacing: 16) {
                            // Instrument icon
                            Image(systemName: instrument.icon)
                                .font(.title2)
                                .frame(width: 40)
                                .foregroundColor(.blue)

                            VStack(alignment: .leading, spacing: 4) {
                                // Instrument name
                                Text(instrument.name)
                                    .font(.headline)
                                    .foregroundColor(.primary)

                                // Tuning notes
                                Text(instrument.noteNames)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }

                            Spacer()

                            // Checkmark for selected
                            if selectedInstrument.name == instrument.name {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                                    .fontWeight(.semibold)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .navigationTitle("Select Instrument")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    InstrumentPickerView(selectedInstrument: .constant(Instruments.guitarStandard))
}
