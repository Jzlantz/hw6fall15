class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
    
  def self.find_in_tmdb(search_terms)
    Tmdb::Api.key("f4702b08c0ac6ea5b51425788bb26562")
    begin
      Tmdb::Movie.find(search_terms)
    rescue ArgumentError => tmdb_error
      
    rescue RuntimeError => tmdb_error
      
    rescue NoMethodError => e

    end
  end
  
  
end
