//  Created by Emilio

import SwiftUI

struct FilterView: View {
    @Binding var selectedStatus: FilterEnums.StatusFilter
    @Binding var selectedGender: FilterEnums.GenderFilter
    @Binding var isShowingFilterView: Bool

    var body: some View {
        NavigationStack {
            Form {
                Section("СТАТУС") {
                    Picker("Выберите статус", selection: $selectedStatus) {
                        ForEach(FilterEnums.StatusFilter.allCases) { status in
                            Text(status.rawValue).tag(status)
                        }
                    }
                    .pickerStyle(.menu)
                }

                Section("ГЕНДЕР") {
                    Picker("Выберите гендер", selection: $selectedGender) {
                        ForEach(FilterEnums.GenderFilter.allCases) { gender in
                            Text(gender.rawValue).tag(gender)
                        }
                    }
                    .pickerStyle(.menu)
                }
            }
            .navigationTitle("Фильтры")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Очистить") {
                        selectedStatus = .all
                        selectedGender = .all
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Применить") {
                        isShowingFilterView = false
                    }
                }
            }
        }
    }
}
