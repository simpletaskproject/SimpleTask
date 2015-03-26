require 'spec_helper'
require 'pry'
describe Api::ListsController do
	describe "get request for index" do

		context "as signed in user" do

			let(:user1) { create(:user) }
			let(:user2)	{ create(:user) }
			let(:list_attributes) { { title: 'MyTitle' } }

			before do
        login_as(user1, :scope => :user)
				5.times { user1.lists.create(list_attributes) }
      end

      context "as an owner" do
				it "gets all lists" do
					get '/api/lists', format: :json
					json = JSON.parse(response.body)
					expect(json.length).to eq(5)
					expect(response.status).to eq(200)
				end
			end
		end

		context "as a not signed user" do
			it "renders 401 status" do
				get  '/api/lists', format: :json
				expect(response.status).to eq(401)
			end
		end
	end

	describe "get request for show" do

		context "as signed in user" do

			let(:user1) { create(:user) }
			let(:user2) { create(:user) }
			let(:list1) { create(:list, user: user1) }
			let(:list2) { create(:list, title: 'SecondTitle', user: user2) }

			before do
				login_as(user1, :scope => :user)
			end

			context "as an owner" do
				it "gets the list" do
					get "/api/lists/#{list1.slug}", format: :json
					json = JSON.parse(response.body)
					expect(response.status).to eq(200)
					expect(json['title']).to eq(list1.title)
				end
			end

			context "as not an owner" do
				it "renders unauthorized" do
					get "/api/lists/#{list2.slug}", format: :json
					expect(response.status).to eq(401)
				end
			end
		end

		context "as not signed user" do
			let(:list) { create(:list, user_id: 1) }
			it "renders unauthorized" do
				get "/api/lists/#{list.slug}", format: :json
				expect(response.status).to eq(401)
			end
		end
	end

end
