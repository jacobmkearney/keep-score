import SwiftUI
import WatchKit

struct ContentView: View {
    
    @AppStorage("yourTeamScore") private var yourTeamScore = 0
    @AppStorage("theirTeamScore") private var theirTeamScore = 0
    @State private var lastScoredTeam: String? = nil

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                VStack {
                    Text("Your Team")
                        .font(.caption2)
                    Text("\(yourTeamScore)")
                        .font(.title)
                    Button(action: {
                        yourTeamScore += 1
                        lastScoredTeam = "your"
                        WKInterfaceDevice.current().play(.click)
                    }) {
                        Image(systemName: "plus")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                }

                Spacer()

                VStack {
                    Text("Their Team")
                        .font(.caption2)
                    Text("\(theirTeamScore)")
                        .font(.title)
                    Button(action: {
                        theirTeamScore += 1
                        lastScoredTeam = "their"
                        WKInterfaceDevice.current().play(.click)
                    }) {
                        Image(systemName: "plus")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                }
            }
            .padding(.horizontal)

            Button("Undo") {
                if lastScoredTeam == "your", yourTeamScore > 0 {
                    yourTeamScore -= 1
                } else if lastScoredTeam == "their", theirTeamScore > 0 {
                    theirTeamScore -= 1
                }
                lastScoredTeam = nil
                WKInterfaceDevice.current().play(.start)
            }
            .buttonStyle(.bordered)
            .tint(.gray)

            Button("Reset Scores") {
                yourTeamScore = 0
                theirTeamScore = 0
                lastScoredTeam = nil
                WKInterfaceDevice.current().play(.failure)
            }
            .foregroundColor(.red)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
