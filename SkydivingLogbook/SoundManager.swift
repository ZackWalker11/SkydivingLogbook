import AVFoundation

class SoundManager {
    static var shared = SoundManager()
    private var audioPlayer: AVAudioPlayer?

    private init() {}

    func playSound(named soundName: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: nil) else {
            print("Sound file not found.")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
}
