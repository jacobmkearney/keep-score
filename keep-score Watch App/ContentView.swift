import SwiftUI
import WatchKit

enum Team {
    case your, their
}

struct ContentView: View {
    
    @AppStorage("yourTeamScore") private var yourTeamScore = 0
    @AppStorage("theirTeamScore") private var theirTeamScore = 0
    @State private var lastScoredTeam: Team? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                ScoreView(label: "You", score: $yourTeamScore) {
                    lastScoredTeam = .your
                }

                Spacer(minLength: 12)

                ScoreView(label: "Them", score: $theirTeamScore) {
                    lastScoredTeam = .their
                }
            }
            .padding(.top, 4) // gentle space from system time
            .padding(.bottom, 8) // reduce gap before Undo button

            Button("Undo last score") {
                switch lastScoredTeam {
                case .your where yourTeamScore > 0:
                    yourTeamScore -= 1
                case .their where theirTeamScore > 0:
                    theirTeamScore -= 1
                default:
                    break
                }
                lastScoredTeam = nil
                WKInterfaceDevice.current().play(.start)
            }
            .buttonStyle(.bordered)
            .tint(.gray)
            .padding(.bottom, 4)

            Button("Reset Scores") {
                yourTeamScore = 0
                theirTeamScore = 0
                lastScoredTeam = nil
                WKInterfaceDevice.current().play(.failure)
            }
            .foregroundColor(.red)
            .padding(.bottom, 4)

            Spacer(minLength: 0) // leave minimal push for edge breathing
        }
        .padding(.horizontal, 8)
        .frame(maxHeight: .infinity, alignment: .top) // pin to top of screen
    }

}

struct ScoreView: View {
    let label: String
    @Binding var score: Int
    let onScore: () -> Void
    
    var body: some View {
        VStack(spacing: 2) {
            Text(label)
                .font(.caption)
            Text("\(score)")
                .font(.title2)
            Button(action: {
                score += 1
                onScore()
                WKInterfaceDevice.current().play(.click)
            }) {
                Image(systemName: "plus")
                    .font(.title3)
                    .foregroundColor(.white)
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
