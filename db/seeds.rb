# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
User.create(name: 'Luke', password: '12345678', password_confirmation: '12345678')
User.create(name: 'Ejik', password: '12345678', password_confirmation: '12345678')
User.create(name: 'Potato', password: '12345678', password_confirmation: '12345678')
User.create(name: 'Sansoli', password: '12345678', password_confirmation: '12345678')
User.create(name: 'kkcopc', password: '12345678', password_confirmation: '12345678')
Project.create(name: 'project1', user_id: User.first.id)
Project.create(name: 'project2', user_id: User.first.id)
Task.create(name: 'task1', project_id: Project.first.id, user_id: User.first.id)
Task.create(name: 'task2', project_id: Project.first.id, user_id: User.first.id)
Task.create(name: 'task3', project_id: Project.first.id, user_id: User.first.id)
Comment.create(content: 'testcomment1', task_id: Task.first.id, project_id: Project.first.id,
               user_id: User.first.id)
Comment.create(content: 'testcomment2', task_id: Task.first.id, project_id: Project.first.id,
               user_id: User.first.id)
Comment.create(content: 'testcomment3', task_id: Task.first.id, project_id: Project.first.id,
               user_id: User.first.id)
