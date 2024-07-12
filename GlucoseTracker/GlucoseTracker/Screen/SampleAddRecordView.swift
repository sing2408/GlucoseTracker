//
//  SampleAddRecordVie.swift
//  GlucoseTracker
//
//  Created by tandyys on 12/07/24.
//

import SwiftUI
import SwiftData

struct SampleAddRecordView: View {
    @State var viewModel:GlutenDataViewModel
    
    @State private var inputAmount:Int = 0
    @State private var selectedType:String = "Before eat"
    @State private var inputDate:Date = .now
    @State private var inputNotes: String = ""
    
    var body: some View {
        VStack {
            DatePicker("Date :", selection: $inputDate, displayedComponents: .date)
                .datePickerStyle(CompactDatePickerStyle())
                .accentColor(.green)
            HStack {
                Text("Gluten Levels :")
                TextField("Input here. . .", value: $inputAmount, format: .number)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                Text("mg/dL")
            }
            Picker("Select Option", selection: $selectedType) {
                Text("Before eat").tag("Before eat")
                Text("After eat").tag("After eat")
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Button(action: {
                viewModel.addItem(inputDate, inputAmount, selectedType, inputNotes)
                inputAmount = 0
                selectedType = "Before eat"
                hideKeyboard()
            }) {
                Text("Add")
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .padding([.top, .bottom], 10)
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding()
            
            Spacer()
            
//            List {
//                ForEach(viewModel.items.reversed()) { item in
//                    HStack {
//                        Text(dateFormatter.string(from: item.date))
//                        Divider()
//                        VStack {
//                            Text("\(String(item.amount)) mg/dL")
//                            Text("\(String(item.mmolAmount)) mmol/L")
//                        }
//                        Divider()
//                        Text(item.type)
//                    }
//                    .padding()
//                }
//                .onDelete { indexes in
//                    for index in indexes {
//                        let originIndex = viewModel.items.count - 1 - index
//                        viewModel.removeItem(viewModel.items[originIndex])
//                    }
//                }
//            }
            
            NavigationLink(destination: ChartHistoryView(modelContext: viewModel.modelContext)) {
                Text("Go to Chart & History")
                    .font(.appTitle1)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .bold()
            }
            .padding()
        }
        .padding()
    }
    
    init(modelContext: ModelContext) {
        let viewModel = GlutenDataViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
}

//#Preview {
//    SampleAddRecordView()
//}
