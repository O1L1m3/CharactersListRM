//  Created by Emilio

import SwiftUI

struct FilterView: View {
    @Binding var selectedStatus: FilterEnums.StatusFilter
    @Binding var selectedGender: FilterEnums.GenderFilter
    @Binding var isShowingFilterView: Bool

    var body: some View {
        NavigationStack {
            Form {
                Section("STATUS") {
                    Picker("Select Status", selection: $selectedStatus) {
                        ForEach(FilterEnums.StatusFilter.allCases) { status in
                            Text(status.rawValue).tag(status)
                        }
                    }
                    .pickerStyle(.menu)
                }

                Section("GENDER") {
                    Picker("Select Gender", selection: $selectedGender) {
                        ForEach(FilterEnums.GenderFilter.allCases) { gender in
                            Text(gender.rawValue).tag(gender)
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

