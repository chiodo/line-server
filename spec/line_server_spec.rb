require 'spec_helper'

RSpec.describe LineServer do
  def app
    LineServer # this defines the active application for this test
  end

  describe 'GET contexts' do
    context 'root' do
      it 'returns 200' do
        get '/'
        expect(last_response.body).to eq('Hi!')
        expect(last_response.status).to eq 200
      end
    end

    context 'lines' do
      before do
        #setup the lines txt
      end

      it 'returns the correct line of the file' do
        get '/lines/1'

        expect(last_response.body).to eq "This is the second line\n"
        expect(last_response.status).to eq 200
      end

      it 'returns 413 for a line that doesnt exist' do
        get '/lines/20'

        expect(last_response.status).to eq 413
      end
    end
  end
end