require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET #index' do

    context "when api data isn't available" do

      before do
        allow_any_instance_of(QuotesApiWrapper).to receive(:get_rates).and_return(nil)
      end

      it 'responds with success code' do
        get :index
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it 'responds with an error message' do
        get :index
        expect(assigns(:messages)).to have_key(:errors)
      end

      it 'renders index view' do
        get :index
        expect(response).to render_template("index")
      end
    end

    context 'when it gets api data' do
      before do
        allow_any_instance_of(Exchanger).to receive(:get_quotes)
          .and_return({ AUD: { '2017-05-24': 3.4 }})
      end

      it 'populates and loads hash with quotes' do
        get :index

        expect(assigns(:quotes)).to have_key(:AUD)
        expect(assigns(:quotes)[:AUD]).to include({ '2017-05-24': 3.4 })
      end

      it 'responds with success code' do
        get :index
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it 'renders index view' do
        get :index
        expect(response).to render_template("index")
      end
    end
  end

end
