//  Created by Emilio

import SwiftUI

struct FilterView: View {
    @Binding var selectedStatus: String
    @Binding var selectedGender: String
    @Binding var isShowingFilterView: Bool

    let statuses = ["All", "Alive", "Dead", "unknown"]
    let genders = ["All", "Male", "Female", "Genderless", "unknown"]

    var body: some View {
        NavigationStack {
            Form {
                Section("STATUS") {
                    Picker("Select Status", selection: $selectedStatus) {
                        ForEach(statuses, id: \.self) { status in
                            Text(status).tag(status)
                        }
                    }
                    .pickerStyle(.menu)
                }

                Section("GENDER") {
                    Picker("Select Gender", selection: $selectedGender) {
                        ForEach(genders, id: \.self) { gender in
                            Text(gender).tag(gender)
                        }
                    }
                    .pickerStyle(.menu)
                }
            }
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Apply") {
                        isShowingFilterView = false
                    }
                }
            }
        }
    }
}
