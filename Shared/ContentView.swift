
import SwiftUI

struct ContentView: View {
    
    // cmd + ctrl + space
    @State private var moves = ["✊", "✋", "✌️"]
    @State private var computerChoice = Int.random(in: 0...2)
    @State private var shouldWin = true
    @State private var score = 0
    @State private var questionCount = 1
    @State private var showingResults = false
    @State private var pageOne = true

    
    var body: some View {
        
        NavigationView {
        
            if pageOne {
        
        VStack {
            Spacer()
            Text("Computer has played...")
                .font(.headline)
            Text(moves[computerChoice])
                .font(.system(size: 200))
            if shouldWin {
                    Text("Which one wins?")
                        .foregroundColor(.green)
                        .font(.title)
                } else {
                    Text("Which one loses?")
                        .foregroundColor(.red)
                        .font(.title)
                }
            HStack{
               
                ForEach(0..<3) { number in
                    Button {
                        play(choice: number)
                        showingResults = true
                    } label: {
                        Text(moves[number])
                            .font(.system(size: 80))
                    }
                }
            }
            Spacer()
            
            Text("Score: \(score)")
                .font(.system(size: 40))
            Text("Question Number : \(questionCount)")
            
            Spacer()
        }
        .alert(questionCount == 10 ? "Game Over": "New Question", isPresented: $showingResults) {
            Button {
                reset()
                if questionCount == 10 {
                    pageOne = false
                }
                else {
                   questionCount += 1
                }
            } label: {
                Text(questionCount == 10 ? "Done": "Continue")
                }
            }
        }
            else {
                // pageTwo
                VStack {
                Text("Game Over!")
                    .font(.system(size: 30))
                Text("Your score: \(score)")
                    .font(.system(size: 15))
                    Button {
                        pageOne = true
                        score = 0
                        questionCount = 1
                        reset()
                    } label: {
                        Text("Play Again!")
                            .padding()
                    }

                }
                
            }
        }
 
    }
    // - MARK: Functions
    
    func play(choice: Int) {
        
        let winningMoves = [1, 2, 0]
        let losingMoves = [2, 0, 1]
        let didWin: Bool // Kullanıcı score kazandı mı
        
        if shouldWin {
            didWin = choice == winningMoves[computerChoice]
            if didWin {
                score += 1
            }
            else {
                score -= 1
            }
        }
        else {
            // shouldWin = false
            didWin = choice == losingMoves[computerChoice]
            if didWin {
                score += 1
            }
            else {
                score -= 1
            }
        }
    }
    
    func reset() {
            computerChoice = Int.random(in: 0...2)
            shouldWin.toggle()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

