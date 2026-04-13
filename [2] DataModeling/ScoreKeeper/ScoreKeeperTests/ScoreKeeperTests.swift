//
//  ScoreKeeperTests.swift
//  ScoreKeeperTests
//
//  Created by 태원진 on 4/7/26.
//

import Testing
@testable import ScoreKeeper

struct ScoreKeeperTests {

    @Test("Reset player scores", arguments: [0, 10, 20])
    func resetScores(to newValue: Int) async throws {
        var scoreboard = Scoreboard(players: [
            Player(name: "Luke", score: 0),
            Player(name: "Elina", score: 5),
        ])
        scoreboard.resetScores(to: 0)
        
        for player in scoreboard.players {
            #expect(player.score == 0)
        }
    }
    
    @Test("Highest score wins")
    func highestScoreWins() {
        let scoreboard = Scoreboard(
            players: [
                Player(name: "Luke", score: 0),
                Player(name: "Elina", score: 4),
            ],
            state: .gameOver,
            doesHighestScoreWin: true
        )
        let winners = scoreboard.winners
        #expect(winners == [Player(name: "Elina", score: 4)])
    }
    
    @Test("Lowest score wins")
    func lowestScoreWins() {
        let scoreboard = Scoreboard(
            players: [
                Player(name: "Luke", score: 0),
                Player(name: "Elina", score: 4),
            ],
            state: .gameOver,
            doesHighestScoreWin: false
        )
        let winners = scoreboard.winners
        #expect(winners == [Player(name: "Luke", score: 0)])
        
    }

}
