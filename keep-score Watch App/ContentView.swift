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
        VStack(spacing: 2) {
            Spacer(minLength: 25)
            HStack {
                ScoreView(label: "Home", score: $yourTeamScore) {
                    lastScoredTeam = .your
                }
                Spacer()
                ScoreView(label: "Away", score: $theirTeamScore) {
                    lastScoredTeam = .their
                }
            }

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

            Button("Reset Scores") {
                yourTeamScore = 0
                theirTeamScore = 0
                lastScoredTeam = nil
                WKInterfaceDevice.current().play(.failure)
            }
            .foregroundColor(.red)

            Spacer()
        }
        .padding()
    }
}

struct ScoreView: View {
    let label: String
    @Binding var score: Int
    let onScore: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Text(label)
                .font(.caption)
                .padding(.bottom, 2)
            Text("\(score)")
                .font(.title2)
                .padding(.bottom, 4)
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
