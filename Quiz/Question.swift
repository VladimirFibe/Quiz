import Foundation
import SwiftData

@Model
final class Question {
    var level: Int
    var title: String
    var correctAnswer: String
    var wrongAnswers: [String]

    init(level: Int, title: String, correctAnswer: String, wrongAnswers: [String]) {
        self.level = level
        self.title = title
        self.correctAnswer = correctAnswer
        self.wrongAnswers = wrongAnswers
    }

    init(response: QuestionResponse) {
        self.level = response.level
        self.title = response.title
        self.correctAnswer = response.correctAnswer
        self.wrongAnswers = response.wrongAnswers
    }
}

struct QuestionResponse: Decodable {
    var level: Int
    var title: String
    var correctAnswer: String
    var wrongAnswers: [String]
}
