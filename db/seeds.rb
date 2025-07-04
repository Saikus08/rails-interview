puts "🌱 Creating seed data..."

TodoList.destroy_all

todo_list = TodoList.create!(
  name: "Interview Preparation",
  description: "Tasks to complete before the Rails interview",
  status: :incomplete,
  due_date: 3.days.from_now
)

todo_list.todo_items.create!([
  {
    title: "Review Hotwire (Turbo + Stimulus)",
    description: "Understand Turbo Frames and Streams",
    status: :done,
    due_date: 1.day.from_now
  },
  {
    title: "Implement Turbo Stream for bulk completion",
    status: :in_progress,
    due_date: 2.days.from_now
  },
  {
    title: "Test Stimulus interactions",
    status: :to_do
  },
  {
    title: "Write README with endpoints and features",
    status: :to_do
  }
])

puts "✅ Seed complete. Created 1 TodoList with #{todo_list.todo_items.count} items."
