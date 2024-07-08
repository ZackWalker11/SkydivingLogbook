import SwiftUI

/// Home Page
struct ContentView: View {
    // Database for skydives
    @StateObject var viewModel = SkydiveViewModel()
    //Make the Create/Edit screen and List Screen "hidden"
    @State private var showCreateSkydiveView = false
    @State private var showSkydiveListView = false 
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    // Button for Skydive List with pressing animation
                    Button(action: {
                        withAnimation(.interpolatingSpring(stiffness: 50, damping: 5)) {
                            showSkydiveListView = true
                        }
                    }) {
                        Text("View Skydives")
                            .font(.title)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                    
                    // Button for Crete Skyddive with pressing animation
                    Button(action: {
                        withAnimation(.interpolatingSpring(stiffness: 50, damping: 5)) {
                            showCreateSkydiveView = true
                        }
                    }) {
                        Text("Add Skydive")
                            .font(.title)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                    
                    Spacer()
                    
                    // Button for Night Mode.
                    Button(action: {
                        withAnimation {
                            viewModel.isNightMode.toggle()
                        }
                    }) {
                        Image(systemName: viewModel.isNightMode ? "sun.max.fill" : "moon.fill")
                            .font(.largeTitle)
                            .padding()
                    }
                    .background(Color.gray.opacity(0.5))
                    .clipShape(Circle())
                    .padding()
                }
                
                // Exaggerated rotation transitions to show requirement completion.
                if showCreateSkydiveView {
                    CreateSkydiveView(viewModel: viewModel, showCreateSkydiveView: $showCreateSkydiveView)
                        .transition(.rotateAndFade)
                }
                
                if showSkydiveListView {
                    SkydiveListView(viewModel: viewModel, showSkydiveListView: $showSkydiveListView)
                        .transition(.rotateAndFade)
                }
            }
            .navigationTitle("Skydive Logbook")
            //Nightmode
            .preferredColorScheme(viewModel.isNightMode ? .dark : .light)
        }
    }
}

/// Preview provider for SwiftUI previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
