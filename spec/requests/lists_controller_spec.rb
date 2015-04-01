require 'spec_helper'
require 'pry'
describe Api::ListsController do

  let(:user) { create(:user) }
  let(:list) { create(:list, user: user) }
  let(:valid_params) { attributes_with_foreign_keys(:list, user: user) }

  describe "GET request for index" do
    context "as signed in user" do

      before do
        login_as(user, scope: :user)
        create_list(:list, 10, user: user)
      end

      context "as an owner" do
        it "gets all the lists" do
          get '/api/lists'
          expect(response.status).to eq(200)
          json = JSON.parse(response.body)
          expect(json.length).to eq(10)
        end
      end
    end

    context "as not signed user" do
      it "doesn't get the list" do
        get '/api/lists'
        expect(response.status).to eq(401)
      end
    end
  end

  describe "GET request for show" do
    context "as signed user" do

      before do
        login_as(user, scope: :user)
      end

      context "as an owner" do
        it "gets the list" do
          get "/api/lists/#{list.slug}"
          expect(response.status).to eq(200)
          json = JSON.parse(response.body)
          expect(json['title']).to eq(list.title)
        end
      end

      context "as not an owner" do
        it "doesn't get the list" do
          list = create(:list)
          get "/api/lists/#{list.slug}"
          expect(response.status).to eq(404)
        end
      end
    end

    context "as not signed user" do
      it "does't get the list" do
        get "/api/lists/#{list.slug}"
        expect(response.status).to eq(401)
      end
    end
  end

  describe "POST request for create" do
    context "as signed in user" do

      before do
        login_as(user, scope: :user)
      end

      it "creates the list" do
        expect{ post "/api/lists", list: valid_params }.to change{ List.count }.by(1)
        expect(response.status).to eq(200)
        json = JSON.parse(response.body)
        expect(json['title']).to eq(valid_params['title'])
      end
    end

    context "as not signed user" do
      it "doesn't create the list" do
        expect{ post "/api/lists", list: valid_params }.not_to change{ List.count }
        expect(response.status).to eq(401)
      end
    end
  end

  describe "PUT request for update" do
    context "as signed in user" do

      before do
        login_as(user, scope: :user)
      end

      context "as an owner" do
        it "updates the list" do
          put "/api/lists/#{list.slug}", list: { title: 'Changed' }
          expect(response.status).to eq(200)
          json = JSON.parse(response.body)
          expect(json['title']).to eq('Changed')
        end
      end

      context "as not an owner" do
        it "doesn't update the list" do
          list = create(:list)
          expect{ put "/api/lists/#{list.slug}", list: { title: 'Changed' } }.not_to change{ list.title }
          expect(response.status).to eq(404)
        end
      end
    end

    context "as not signed user" do
      it "doesn't update the list" do
        expect{ put "/api/lists/#{list.slug}", list: { title: 'Changed'} }.not_to change{ list. title }
        expect(response.status).to eq(401)
      end
    end
  end

  describe "DELETE request for destroy" do

    context "as signed in user" do

      before do
        login_as(user, scope: :user)
        @list = create(:list, user: user)
      end

      context "as an owner" do
        it "deletes the list" do
          expect{ delete "/api/lists/#{@list.slug}"}.to change{ List.count }.by(-1)
          expect(response.status).to eq(200)
        end
      end

      context "as not an owner" do
        it "doesn't delete the list" do
          list = create(:list)
          expect{ delete "/api/lists/#{list.slug}" }.not_to change{ List.count}
          expect(response.status).to eq(404)
        end
      end
    end
  end
end


