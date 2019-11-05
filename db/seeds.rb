# frozen_string_literal: true

def create_project
  Project.create(name: 'project name', user_id: User.first.id)
end

def create_task
  Task.create(name: 'task name', project_id: Project.first.id)
end

def create_comment
  Comment.create(body: 'comment name', task_id: Task.first.id)
end

User.create(email: 'alex@alex.com', password: 'password', password_confirmation: 'password')

1.times { create_project }
1.times { create_task }
1.times { create_comment }
