require 'spec_helper'


describe HomeController do

	describe 'GET index' do
		
		it 'should be succesful' do
			get 'index'
			response.should be_success
		end
	
	end
end
