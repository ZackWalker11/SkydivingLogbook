import SwiftUI
import AVFoundation // Import AVFoundation

// Page for creating and editing skydives.
struct CreateSkydiveView: View {
    @ObservedObject var viewModel: SkydiveViewModel
    @Environment(\.presentationMode) var presentationMode
    //Variables
    @State private var jumpNumber = ""
    @State private var jumpElevation = ""
    @State private var jumpPartners = ""
    @State private var location = ""
    @State private var details = ""
    
    @Binding var showCreateSkydiveView: Bool
    //Edit Skydive
    var skydiveToEdit: Skydive?
    
    var body: some View {
        NavigationView {
            Form {
                //Fields to enter data
                Section(header: Text("Jump Details")) {
                    TextField("Jump Number", text: $jumpNumber)
                        .keyboardType(.numberPad)
                    TextField("Jump Elevation", text: $jumpElevation)
                        .keyboardType(.numberPad)
                    TextField("Jump Partners", text: $jumpPartners)
                    TextField("Location", text: $location)
                    TextField("Details", text: $details)
                }
                
                Button("Save") {
                    // Save or update the skydive based on whether it is a new or existing skydive
                    if let skydiveToEdit = skydiveToEdit {
                        var updatedSkydive = skydiveToEdit
                        updatedSkydive.jumpNumber = Int(jumpNumber) ?? 0
                        updatedSkydive.jumpElevation = Int(jumpElevation) ?? 0
                        updatedSkydive.jumpPartners = jumpPartners
                        updatedSkydive.location = location
                        updatedSkydive.details = details
                        viewModel.updateSkydive(updatedSkydive)
                        
                    } else {
                        let skydive = Skydive(jumpNumber: Int(jumpNumber) ?? 0,
                                              jumpElevation: Int(jumpElevation) ?? 0,
                                              jumpPartners: jumpPartners,
                                              location: location,
                                              details: details)
                        viewModel.addSkydive(skydive)
                    }

                    // Play sound when saving a skydive
                    SoundManager.shared.playSound(named: "save_sound.mp3")

                    withAnimation(.interpolatingSpring(stiffness: 50, damping: 5)) {
                        showCreateSkydiveView = false
                    }
                }
            }
            .navigationTitle(skydiveToEdit == nil ? "New Skydive" : "Edit Skydive")
            .navigationBarItems(leading: skydiveToEdit == nil ? Button("Back") {
                withAnimation(.interpolatingSpring(stiffness: 50, damping: 5)) {
                    showCreateSkydiveView = false
                }
            } : nil)
            .onAppear {
                // Populate fields if editing an existing skydive
                if let skydiveToEdit = skydiveToEdit {
                    jumpNumber = String(skydiveToEdit.jumpNumber)
                    jumpElevation = String(skydiveToEdit.jumpElevation)
                    jumpPartners = skydiveToEdit.jumpPartners
                    location = skydiveToEdit.location
                    details = skydiveToEdit.details
                } else {
                    //Automatically adds jump number
                    jumpNumber = String((viewModel.skydives.max(by: { $0.jumpNumber < $1.jumpNumber })?.jumpNumber ?? 0) + 1)
                }
            }
        }
    }
}
