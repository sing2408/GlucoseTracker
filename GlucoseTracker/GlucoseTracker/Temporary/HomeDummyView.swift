////
////  HomeDummyView.swift
////  GlucoseTracker
////
////  Created by Singgih Tulus Makmud on 10/07/24.
////
//
//import SwiftUI
//import SwiftData
//
//struct HomeDummyView: View {
//    @State private var isShowingSheet = false
//    @Query var glucoseDatas: [GlucoseData]
//    
//    var body: some View {
//        NavigationStack {
//            List {
//                ForEach(glucoseDatas) { data in
//                    DataCell(glucoseData: data)
//                }
//            }
//            .navigationTitle("Home View")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button("Add") {
//                        isShowingSheet.toggle()
//                    }
//                }
//            }
//            .sheet(isPresented: $isShowingSheet) {
//                AddDummyView()
//            }
//        }
//        
//        NavigationStack{
//            
//        }
//    }
//}
//
//
//
//struct DataCell: View {
//    let glucoseData: GlucoseData
//    var body: some View {
//        HStack{
//            Text(glucoseData.date, format: .dateTime.month())
//            Text(glucoseData.date, format: .dateTime.hour().minute())
//            Text(glucoseData.type)
//            Text(glucoseData.amount, format: .number)
//            Text(glucoseData.notes)
//        }
//    }
//}
//
//#Preview {
//    HomeDummyView()
//        .modelContainer(for: GlucoseData.self)
//    
//}
//
