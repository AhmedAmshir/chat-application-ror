require 'rails_helper'

RSpec.describe Application, :type => :model do

    subject { described_class.new(name: "Test App", token: Application.new.create_token) }

    it "checks that application can not be created without a name param" do
        subject.name = nil
        expect(subject).to_not be_valid
    end

    it "checks that application can be created successfully" do
        expect(subject).to be_valid
    end

    it "checks that application can be created and return token" do
        token = Application.new.create_token
        application = Application.create(:name => "Smile App", :token => token)
        expect(application.token).to eq token
    end

end

RSpec.describe Application, type: :request do

    describe 'GET /api/applications' do
        before do
          FactoryBot.create_list(:application, 2)
          get '/api/applications'
        end
        
        it 'returns all applications' do
          expect(json.size).to eq(2)
        end
    
        it 'returns status code 200' do
          expect(response).to have_http_status(:success)
        end
    end

    describe 'POST /api/applications/create' do
        context 'with valid parameter name' do
            let!(:my_application) { FactoryBot.create(:application) }
            let(:valid_attributes) { { name: "App name" } }

            before { post '/api/applications/create', params: valid_attributes }
        
            it 'returns create status' do
                expect(response).to have_http_status(:created)
            end
        end
    
        context 'with invalid name parameter' do
            let(:invalid_attributes) { { name: "" } }
            before { post '/api/applications/create', params: invalid_attributes }
    
            it 'returns an unprocessable entity status' do
                expect(response).to have_http_status(:unprocessable_entity)
            end
        end

        describe "DELETE /api/applications/:token/delete" do
            let!(:my_application) { FactoryBot.create(:application) }
        
            before { delete "/api/applications/#{my_application.token}/delete" }
        
            it 'returns status code 200' do
              expect(response).to have_http_status(:ok)
            end
        end

    end
end