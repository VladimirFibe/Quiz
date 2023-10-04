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
}
