//
//  ContentView.swift
//  TestW04
//
//  Created by Christian on 06/10/23.
//

import SwiftUI

struct ContentView: View {
    var asean = ["Indonesia", "Singapore", "Malaysia", "Laos", "Philipines", "Cambodia", "Myanmar", "Thailand", "Brunei", "Vietnam"]
    @State private var correctAnswerIndex = Int.random(in: 0...9)
    @State private var countriesShown = [Int]()
    @State private var correctAnswers = 0
    @State private var wrongAnswers = 0
    @State private var round = 0
    @State private var isGameOver = false

    var body: some View {
        ZStack {
            Color.mint
                .ignoresSafeArea()

            VStack {
                VStack {
                    Text("Pilih Bendera dari Negara : ")
                        .foregroundColor(.black)
                        .font(.title)
                    Text(asean[correctAnswerIndex])
                        .foregroundColor(.black)
                        .font(.system(size: 30))
                    Text("Games Ke: \(round + 1)")
                        .foregroundColor(.black)
                        .font(.system(size: 30))
                    Text("Benar: \(correctAnswers) | Salah: \(wrongAnswers)")
                        .foregroundColor(.black)
                        .font(.system(size: 30))
                }
                .padding(.top, 100)
                Spacer()
                HStack {
                    Spacer()
                    VStack {
                        ForEach(0..<5) { number in
                            Button {
                                checkAnswer(selectedIndex: number)
                            } label: {
                                Image(asean[number])
                                    .resizable()
                                    .frame(width: 105, height: 65)
                            }
                        }
                    }
                    .padding(.bottom, 70)
                    VStack {
                        ForEach(5..<10) { number in
                            Button {
                                checkAnswer(selectedIndex: number)
                            } label: {
                                Image(asean[number])
                                    .resizable()
                                    .frame(width: 105, height: 65)
                            }
                        }
                    }
                    .padding(.bottom, 70)
                    Spacer()
                }
            }
            .onAppear {
                startNewRound()
            }
            .alert(isPresented: .constant(isGameOver)) {
                Alert(
                    title: Text("Game Over"),
                    message: Text("Skor Benar: \(correctAnswers) | Skor Salah: \(wrongAnswers)"),
                    dismissButton: .default(Text("Reset Games"), action: {
                                resetGame()
                            })
                )
            }
        }
    }

    func checkAnswer(selectedIndex: Int) {
        if selectedIndex == correctAnswerIndex {
            print("Correct!")
            correctAnswers += 1
        } else {
            print("Wrong answer!")
            wrongAnswers += 1
        }

        getNextRound()
    }

    func getNextRound() {
        countriesShown.append(correctAnswerIndex)
        round += 1

        if round < 10 {
            startNewRound()
        } else {
            isGameOver = true
            print("Game Over")
            
        }
    }
    
    func startNewRound() {
        guard countriesShown.count < asean.count else {
            isGameOver = true
            print("Game Over")
            return
        }
        var newIndex = Int.random(in: 0..<asean.count)
        
        while countriesShown.contains(newIndex) {
            newIndex = Int.random(in: 0..<asean.count)
        }
        
        correctAnswerIndex = newIndex
    }
    func resetGame() {
        correctAnswers = 0
        wrongAnswers = 0
        round = 0
        isGameOver = false
        countriesShown.removeAll()
        startNewRound()
    }
}
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }

