require 'spec_helper'
require 'pry'
describe Api::TasksController do

	let(:user) { create(:user) }
	let(:list) { create(:list, user: user) }
	let(:task) { create(:task, list: list) }

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
end
