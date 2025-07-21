import SwiftUI

struct FilterView: View {
    @Binding var selectedStatus: FilterEnums.StatusFilter
    @Binding var selectedGender: FilterEnums.GenderFilter
    @Binding var isShowingFilterView: Bool

    var body: some View {
        VStack(spacing: 0) {
            ScreenHeader(
                title: "Фильтры",
                trailingButtons: [
                    AnyView(
                        Button {
                            selectedStatus = .all
                            selectedGender = .all
                        } label: {
                            Image(systemName: "trash")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white)
                        }
                    ),
                    AnyView(
                        Button {
                            isShowingFilterView = false
                        } label: {
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white)
                        }
                    )
                ]
            )

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
            .scrollContentBackground(.hidden)
            .background(.bg)
        }
        .background(.bg)
    }
}
