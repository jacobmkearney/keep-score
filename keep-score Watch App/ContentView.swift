//
//  ContentView.swift
//  keep-score Watch App
//
//  Created by Jacob Kearney on 12/06/2025.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("yourTeamScore") private var yourTeamScore = 0
    @AppStorage("theirTeamScore") private var theirTeamScore = 0
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                VStack {
                    Text("Your Team")
                        .font(.caption)
                    Text("\(yourTeamScore)")
                        .font(.title)
                    Button("➕") {
                        yourTeamScore += 1
                    }
                }

                Spacer()

                VStack {
                    Text("Their Team")
                        .font(.caption)
                    Text("\(theirTeamScore)")
                        .font(.title)
                    Button("➕") {
                        theirTeamScore += 1
                    }
                }
            }
            .padding(.horizontal)

            Button("Reset Scores") {
                yourTeamScore = 0
                theirTeamScore = 0
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
