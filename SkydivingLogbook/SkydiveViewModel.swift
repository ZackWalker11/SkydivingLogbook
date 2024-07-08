import Foundation

// Database functions
class SkydiveViewModel: ObservableObject {
    //List of skydives
    @Published var skydives: [Skydive] = []
    //Night mode
    @Published var isNightMode = false
    
    init() {
        load()
    }
    
//Add Skydives
    func addSkydive(_ skydive: Skydive) {
        skydives.append(skydive)
        save()
    }
    
//Deletes Skydvies
    func deleteSkydive(at offsets: IndexSet) {
        skydives.remove(atOffsets: offsets)
        save()
    }

//Edit Skydive
    func updateSkydive(_ skydive: Skydive) {
        if let index = skydives.firstIndex(where: { $0.id == skydive.id }) {
            skydives[index] = skydive
            save()
        }
    }
    
//Save Skydive
    private func save() {
        if let encoded = try? JSONEncoder().encode(skydives) {
            UserDefaults.standard.set(encoded, forKey: "skydives")
        }
    }
    
//Load List
    private func load() {
        if let savedData = UserDefaults.standard.data(forKey: "skydives"),
           let decodedData = try? JSONDecoder().decode([Skydive].self, from: savedData) {
            skydives = decodedData
        }
    }
}
