class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
    
  def self.find_in_tmdb(search_terms)
    Tmdb::Api.key("f4702b08c0ac6ea5b51425788bb26562")
    begin
     movies_search = Tmdb::Movie.find(search_terms)
   # if(movies_search.empty? or movies_search.nil?)
     #  return Array([])
  #  else
      # return movies_search
   # end 
    rescue ArgumentError => tmdb_error
      
    rescue RuntimeError => tmdb_error
      
    rescue NoMethodError => e

    end
  end
  
  def self.create_from_tmdb(id)
      movie_details = Tmdb::Movie.detail(id)
  end
  
end
