//
//  Alphabetizer.swift
//  Alphabetizer
//
//  Created by 태원진 on 4/18/26.
//

import Foundation

@Observable
class Alphabetizer {
    private let tileCount = 4
    private var vocab: Vocabulary
    
    var tiles = [Tile]()
    var score = 0
    var message: Message = .instructions
        
    init(vocab: Vocabulary = .landAnimals) {
        self.vocab = vocab
        startNewGame()
    }
    
    /// Checks if tiles are in alphabetical order
    func submit() {
        // Check if the tiles are alphabetized
        let userSortedTiles = tiles.sorted {
            $0.position.x < $1.position.x
        }
        let alphabeticallySortedTiles = tiles.sorted {
            $0.word.lexicographicallyPrecedes($1.word)
        }
        let isAlphabetized = userSortedTiles == alphabeticallySortedTiles
        // If alphabetaized, increment the score
        if isAlphabetized {
            score += 1
        }
        
        // Update the message to win or lose
        message = isAlphabetized ? .youWin : .tryAgain
        
        // Flip over correcr tiles
        for (tile, correctTile) in zip(userSortedTiles, alphabeticallySortedTiles) {
            // TODO: Check if this is in the correct position
            let tileIsAlphabetized = tile == correctTile
            tile.flipped = tileIsAlphabetized
        }
        
        Task { @MainActor in
            // Delay 2 seconds
            try await Task.sleep(for: .seconds(2))
            
            // If alphabetized, generate new tiles
            if isAlphabetized {
                
                startNewGame()
            }
            // Flip tiles back to words
            for tile in tiles {
                tile.flipped = false
            }
            // Display instructons
            message = .instructions
        }
    }
    
    // Mark: private implementation
    
    /// Updates 'tiles' with a new set of unalphabetized words
    private func startNewGame() {
        let newWords = vocab.selectRandomWords(count: tileCount)
        if tiles.isEmpty {
            for word in newWords {
                tiles.append(Tile(word: word))
            }
        } else {
            for (tile, word) in zip(tiles, newWords) {
                tile.word = word
            }
        }
    }
}
