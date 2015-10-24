require 'rails_helper'
require 'spec_helper'

RSpec.describe MoviesController, type: :controller do
  describe 'searching TMDb' do
    before :each do
      @fake_results = [double('movie1'), double('movie2')]
    end
    it 'should call the model method that performs TMDb search' do
      Movie.should_receive(:find_in_tmdb).with('Ted').and_return(@fake_results)
      post :search_tmdb, {:search_terms => 'Ted' }
    end
    describe 'after valid search' do
      before :each do
        Movie.stub(:find_in_tmdb).and_return(@fake_results)
        post :search_tmdb, { :search_terms => 'Ted' }
      end
      it 'should select the Search Results template for rendering' do
        response.should render_template('search_tmdb')
      end
      it 'should make the TMDb search results available to that template' do
        assigns(:matching_movies).should == @fake_results
      end
     describe "after unsuccesful search"
      it 'should show no results found if there are no movies rendered' do
        Movie.should_receive(:find_in_tmdb).with('').and_return([])
        post :search_tmdb, {:search_terms => '' }
        expect(flash[:notice]).to be_present
      end
    end
    describe 'selecting add a movie' do
     before :each do
        @fake_results = [double('movie1'), double('movie2')]
     end
     it 'should call the model method that performs create_from_tmdb' do
        Movie.should_receive(:create_from_tmdb).with('72105')
        get :add_tmdb, {"utf8"=>"✓", "checked_movie_ids"=>["72105"], "commit"=>"Add Selected Movies", "controller"=>"movies", "action"=>"add_tmdb"}
        expect(flash[:notice]).to be_present
     end
     it 'should respond with a flash message when added' do
        #Movie.should_receive(:create_from_tmdb).with()
        get :add_tmdb, {"utf8"=>"✓", "checked_movie_ids"=> nil,"commit"=>"Add Selected Movies", "controller"=>"movies", "action"=>"add_tmdb"}
        expect(flash[:notice]).to be_present
     end
    end
  end
end
