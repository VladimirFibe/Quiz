import SwiftUI

final class QuestionViewModel: ObservableObject {
    @Published var brain: QuestionBrain
    @Published var gameOver = false
    init(questions: [Question]) {
        brain = QuestionBrain(questions: questions)
    }
    var count: String {
        String(brain.questions.count)
    }
    
    var title: String {
        brain.title
    }

    var index: Int {
        brain.index + 1
    }

    var answers: [String] {
        brain.answers
    }

    var rightAnswers: Int {
        brain.rightAnswers
    }

    func getColor(_ answer: String) -> Color {
        let answer = brain.checkAnswer(answer)
        switch answer {
        case .correct: return .green
        case .wrong: return .red
        case .unknown: return .gray
        }
    }

    func setAnswer(_ answer: String) {
        brain.setAnswer(answer)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.brain.nextQuestion()
        }
    }
}
