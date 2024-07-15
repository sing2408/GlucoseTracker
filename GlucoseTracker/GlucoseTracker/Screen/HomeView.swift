import SwiftUI
import SwiftData

struct HomeView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel: GlutenDataViewModel
    @StateObject var homeViewModel = HomeViewModel()
    @State var isShowingSheet = false
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                LinearGradient(
                    gradient: colorScheme == .dark ? Gradient(colors: [.blue, .black]) : Gradient(colors: [.blue, .white]),
                    startPoint: .topLeading,
                    endPoint: UnitPoint(x: 0.5, y: 0.35)
                )
                
                VStack {
                    Spacer()
                    
                    Text("Summary")
                        .font(.appLargeTitle)
                        .padding([.top], 15)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                    
                    Text("\(homeViewModel.startDateString) - now")
                        .font(.appBody)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                    
                    VStack {
                        Text("Average Sugar Level")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        
                        HStack(alignment: .firstTextBaseline) {
                            Text("\(viewModel.avgOverall)")
                                .font(.appAverageText)
                            Text("mg/dL")
                                .font(.appTitle2)
                        }
                        .foregroundColor(.blue)
                        
                        if viewModel.avgOverall > 140 {
                            Text("I think you should stop eating sweet ☹️")
                                .font(Font.appBody)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        } else if viewModel.avgOverall > 200 {
                            Text("NO! ARE YOU GOOD? GO VISIT DOCTOR PLEASE!")
                                .font(Font.appBody)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        } else {
                            Text("You're doing great!")
                                .font(Font.appBody)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        }
                    }
                    .padding()
                    .padding([.bottom], 25)
                                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Chart & Records")
                                .font(.appTitle2)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                            
                            Spacer()
                            
                            NavigationLink(destination: ChartHistoryView(modelContext: viewModel.modelContext)) {
                                HStack(spacing: 0) {
                                    Text("See More")
//                                    Image(systemName: "greaterthan")
//                                        .font(.appBody)
                                }
                                .font(.appBody)
                                //.opacity(0.65)
                            }
                        }
                        .padding()
                        
                        RecentCheckCard(modelContext: viewModel.modelContext)
                        
                    }
                    
                    Button {
                        
                        isShowingSheet.toggle()
                        
                    } label: {
                        Rectangle()
                            .frame(width: 342, height: 64)
                            .foregroundColor(.blue)
                            .cornerRadius(12)
                            .overlay {
                                Text("Add New Record")
                                    .font(.appTitle2)
                                    .foregroundColor(.white)
                            }
                    }
                    .padding()
                    
                    Spacer()
                    
                }
                .offset(y: 25)
                .padding()
            }
            .ignoresSafeArea()
        }
        .sheet(isPresented: $isShowingSheet) {
            AddRecordView(viewModel: viewModel)
                .presentationDetents([.height(650)])
        }
    }
    
    init(modelContext: ModelContext) {
        _viewModel = ObservedObject(wrappedValue: GlutenDataViewModel(modelContext: modelContext))
    }
}
