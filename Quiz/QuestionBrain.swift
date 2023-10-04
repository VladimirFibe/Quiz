import Foundation

enum Answer {
    case correct
    case wrong
    case unknown
}

struct QuestionBrain {

    let questions: [Question]
    var index = 0
    var rightAnswers = 0
    var answer: String = ""
    var title: String {
        questions[index].title
    }

    var answers: [String] {
        let answers = [questions[index].correctAnswer] + questions[index].wrongAnswers
        return answers.shuffled()
    }

    init(questions: [Question]) {
        guard !questions.isEmpty else { fatalError("Список пуст") }
        self.questions = questions
    }
    
    mutating func setAnswer(_ answer: String) {
        self.answer = answer
    }

    func checkAnswer(_ answer: String) -> Answer {
        if self.answer.isEmpty {
            return .unknown
        } else {
            return answer == questions[index].correctAnswer ? .correct : .wrong
        }
    }

    mutating func nextQuestion() {
        if index + 1 < questions.count {
            index += 1
            answer = ""
        }
    }
}
