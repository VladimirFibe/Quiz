import SwiftUI

struct QuestionView: View {
    @ObservedObject var viewModel: QuestionViewModel
    var body: some View {
        VStack {
            if viewModel.gameOver {
                Text("Game Over")
            } else {
                content
            }
        }
    }
    var content: some View {
        VStack {
            Text("Вопросов: \(viewModel.count)")
            Text("Текущий вопрос: \(viewModel.index)")
            Text("Правильных ответов: \(viewModel.rightAnswers)")
            Text(viewModel.title)
                .padding(.bottom, 50)
            ForEach(viewModel.answers, id: \.self) { answer in
                Button(action: {
                    viewModel.setAnswer(answer)
                }) {
                    Text(answer)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(viewModel.getColor(answer))
                        )
                }
            }
            Spacer()

        }
    }
//    let question: Question
//    var answers: [String] {
//        let answers = [question.correctAnswer] + question.wrongAnswers
//        return answers.shuffled()
//    }
//    @Binding var count: Int
//    @Binding var index: Int
//    var body: some View {
//        VStack {
//            Text("Правильных ответов: \(count)/\(index)")
//            Text(question.title)

//        }
//    }
//
//    func checkAnswer(_ answer: String) {
//        if answer == question.correctAnswer {
//            count += 1
//        }
//        if index < 15 {
//            index += 1
//        }
//    }
}
