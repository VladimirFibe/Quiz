import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var questions: [Question]
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(questions, id: \.title) { question in
                    Text(question.title)
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
//        .onAppear(perform: fetchQuestions)
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
