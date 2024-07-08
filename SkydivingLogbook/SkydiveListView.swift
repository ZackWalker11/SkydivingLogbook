import SwiftUI

/// Skydive Kist Page
struct SkydiveListView: View {
    //Database
    @ObservedObject var viewModel: SkydiveViewModel
    //Show/Hide boolean
    @Binding var showSkydiveListView: Bool
    //Delete mode
    @State private var isEditing = false
    
    var body: some View {
        NavigationView {
            List {
                //Get skydivess from DB and loop through and posts them next to labels
                ForEach(viewModel.skydives) { skydive in
                    NavigationLink(destination: CreateSkydiveView(viewModel: viewModel, showCreateSkydiveView: .constant(false), skydiveToEdit: skydive)) {
                        VStack(alignment: .leading) {
                            Text("Jump Number: \(skydive.jumpNumber)")
                                .font(.headline)
                            Text("Elevation: \(skydive.jumpElevation) ft")
                            Text("Partners: \(skydive.jumpPartners)")
                            Text("Location: \(skydive.location)")
                            Text("Details: \(skydive.details)")
                        }
                    }
                }
                //Deletes chosen skydive
                .onDelete(perform: viewModel.deleteSkydive)
            }
            .navigationTitle("Skydive History")
                        .navigationBarItems(
                            leading: Button("Close") {
                                withAnimation(.interpolatingSpring(stiffness: 50, damping: 5)) {
                                    showSkydiveListView = false
                                }
                            },
                            trailing: Button(action: {
                                withAnimation {
                                    isEditing.toggle()
                                }
                            }) {
                                Text(isEditing ? "Done" : "Delete")
                            }
                        )
                        .environment(\.editMode, .constant(isEditing ? .active : .inactive))
                    }
                }
            }
