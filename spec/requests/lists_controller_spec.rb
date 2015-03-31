require 'spec_helper'
require 'pry'
describe Api::ListsController do
  describe "GET request for index" do

    context "as signed in user" do

      let(:user1) { create(:user) }
      let(:user2)  { create(:user) }
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

  describe "GET request for show" do

    context "as signed in user" do

      let(:user1) { create(:user) }
      let(:user2) { create(:user) }
      let(:list1) { create(:list, user: user1) }
      let(:list2) { create(:list, user: user2) }

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

  describe "POST request for create" do
    context "as signed in user" do
      let(:user) { create(:user) }
      let(:valid_params)  { { title: 'Title', user_id: user.to_param } }

      before do
        login_as(user, :scope => :user)
      end

      context "with valid params" do
        it "creates new list" do
          post '/api/lists', list: valid_params, format: :json
          json = JSON.parse(response.body)
          expect(json['title']).to eq('Title')
          expect(response.status).to eq(200)
          expect{ post '/api/lists', list: valid_params }.to change{ List.count }.by(1)
        end
      end
    end

    context "as not signed user" do
      context "with valid params" do
        let(:valid_params) { { title: 'Title', user_id: 'mail@gmail' } }
        it "renders unauthorized" do
          post '/api/lists', list: valid_params, format: :json
          expect(response.status).to eq(401)
        end
        it { expect{ post '/api/lists', list: valid_params }.not_to change{ List.count} }
      end
    end
  end

  describe "PUT update" do
    context "as signed in user" do
      let(:user1) { create(:user) }
      let(:user2) { create(:user) }
      let!(:list1) { create(:list, user: user1) }
      let!(:list2) { create(:list, user: user2) }
      let(:valid_params) { { title: 'ChangedTitle'} }

      before do
        login_as(user1, scope: :user)
      end

      context "as as signed in user" do
        context "as an owner" do
          it "updates the list" do
            put "/api/lists/#{list1.slug}", list: valid_params, format: :json
            json = JSON.parse(response.body)
            expect(json['title']).to eq('ChangedTitle')
            expect(response.status).to eq(200)
          end
        end
        context "as not an owner" do
          it "doesn't update the list" do
            put "/api/lists/#{list2.slug}", list: valid_params, format: :json
            expect(response.status).to eq(401)
            expect{ put "/api/lists/#{list2.slug}", list: valid_params }.not_to change{ list2.title }
          end
        end
      end
    end

    context "as not signed user" do
      let(:user) { create(:user) }
      let(:list1) { create(:list, user: user) }
      let(:valid_params) { { title: 'ChangedTitle'} }

      it "doesn't update the list" do
        put "/api/lists/#{list1.slug}", list: valid_params, format: :json
        expect(response.status).to eq(401)
        expect{ put "/api/lists/#{list1.slug}", list: valid_params }.not_to change{ list1.title }
      end
    end
  end

  describe "DELETE destroy" do
    context "as a signed in user" do

      let(:user1) { create(:user) }
      let(:user2) { create(:user) }
      let!(:list1) { create(:list, user: user1) }
      let!(:list2) { create(:list, user: user2) }

      before do
        login_as(user1, scope: :user)
      end

      context "as an owner" do
        it "deletes the requested list" do
          expect{ delete "/api/lists/#{list1.slug}", format: :json }.to change{ List.count }.by(-1)
          expect(response.status).to eq(200)
        end
      end

      context "as not an owner" do
        it "doesn't delete the list" do
          expect{ delete "/api/lists/#{list2.slug}", format: :json }.not_to change{ List.count }
          expect(response.status).to eq(401)
        end
      end
    end

    context "as not a signed user" do
      let(:user) { create(:user) }
      let!(:list) { create(:list, user: user) }
      it "doesn't delete the list" do
        expect{ delete "/api/lists/#{list.slug}", format: :json }.not_to change{ List.count }
        expect(response.status).to eq(401)
      end
    end
   end
end
