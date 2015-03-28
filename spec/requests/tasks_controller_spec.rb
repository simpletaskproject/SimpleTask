require 'spec_helper'
require 'pry'
describe Api::TasksController do

	let(:user) { create(:user) }
	let(:list) { create(:list, user: user) }
	let(:task) { create(:task, list: list) }
	let(:valid_attributes) { { title: 'Title', list_id: list.to_param } }

	describe "GET reuqest for index" do
		context "as signed in user" do

			before do
				login_as(user, scope: :user)
				create_list(:task, 10, list: list)
			end

			context "as an owner" do
				it "gets all the tasks" do
					get '/api/tasks', format: :json
					expect(response.status).to eq(200)
					json = JSON.parse(response.body)
					expect(json.length).to eq(10)
				end
			end
		end

		context "as not signed in user" do
			it "renders status 401" do
				get 'api/tasks', format: :json
				expect(response.status).to eq(401)
			end
		end
	end

	describe "POST request for create" do
		context "as signed in user" do
			before do
				login_as(user, scope: :user)
			end

			it "creates new task" do
				expect{ post "/api/lists/#{list.slug}/tasks", task: valid_attributes, format: :json}
				.to change{ Task.count }.by(1)
				json = JSON.parse(response.body)
				expect(json['title']).to eq('Title')
				expect(response.status).to eq(200)
			end
		end
	end

		context "as not signed user" do
			it "doesn't create new task" do
				expect{ post "/api/lists/#{list.slug}/tasks", task: valid_attributes, format: :json}
				.not_to change{ Task.count }
				expect(response.status).to eq(401)
			end
		end

		describe "PUT request for update" do
			context "as signed in user" do
				before do
					login_as(user, scope: :user)
				end
				context "as an owner" do
					it "updates the task" do
						put "/api/lists/#{list.slug}/tasks/#{task.to_param}", task: { title: 'Changed' }
						json = JSON.parse(response.body)
						expect(json['title']).to eq('Changed')
						expect(response.status).to eq(200)
					end
				end

				context "as not an owner" do
					it "doesn't update the task" do
						list = create(:list)
						task = Task.create!(title: 'title', list: list)
						put "/api/lists/#{list.slug}/tasks/#{task.to_param}", task: { title: 'Changed' }
						expect(response.status).to eq(401)
					end
				end
			end

			context "user is not signed in" do
				it "doesn't update the list" do
					expect{ put "/api/lists/#{list.slug}/tasks/#{task.to_param}", task: { title: 'Changed' }, format: :json }
					.not_to change{ list.title }
					expect(response.status).to eq(401)
				end
			end
		end

		describe "DELETE request for destroy" do
			context "as signed in user" do

				before do
					login_as(user, scope: :user)
				end

			 	context "as an owner" do
			 		it "destroys the task" do
			 			task = Task.create!(title: 'Title', list: list)
						expect{ delete "/api/lists/#{list.slug}/tasks/#{task.to_param}", format: :json }
						.to change{ Task.count }.by(-1)
				 		expect(response.status).to eq(200)
			 		end
			 	end

			 	context "as not an owner" do
			 		it "doesn't destroy the task" do
			 			list = create(:list)
			 			task = Task.create!(title: 'Title', list: list)
			 			expect{ delete "/api/lists/#{list.slug}/tasks/#{task.to_param}", format: :json }.
			 			not_to change{ Task.count }
			 			expect(response.status).to eq(401)
			 		end
			 	end
			end
		end

		context "as not signed user" do
			it "doesnt't destroy the task" do
				task = Task.create!(title: 'Title', list: list)
				expect{ delete "/api/lists/#{list.slug}/tasks/#{task.to_param}", format: :json }
				.not_to change{ Task.count }
				expect(response.status).to eq(401)
			end
		end

end
