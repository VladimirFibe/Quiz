import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var questions: [Question]
    var currentQuestions: [Question] {
        questions.filter { $0.level == currentIndex }
    }
    var question: Question? {
        currentQuestions.randomElement()
    }

    @State private var currentIndex = 1
    @State private var correctAnswers = 0
    var body: some View {
        VStack {
            if let question {
                QuestionView(
                    viewModel: QuestionViewModel(questions: questions)
                )
            } else {
                Text("Вопросы закончились")
            }

        }
        .padding()
        .onAppear(perform: fetchQuestions)
    }

    private func fetchQuestions() {
        if questions.isEmpty {
            let response: [QuestionResponse] = Bundle.main.decode([QuestionResponse].self, from: "questions.json")
            response.forEach {
                let question = Question(response: $0)
                modelContext.insert(question)
            }
        }
    }

    private func addItem() {
        withAnimation {
            let question = Question(level: 1, title: "Вопрос", correctAnswer: "Правильный ответ", wrongAnswers: ["Не правильный ответ", "Еще один ответ"])
            modelContext.insert(question)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(questions[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Question.self, inMemory: true)
}
