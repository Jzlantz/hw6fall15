class Movie < ActiveRecord::Base
  include MoviesHelper
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
      #Tmdb::Api.key("f4702b08c0ac6ea5b51425788bb26562")
      begin
        movie_details = Tmdb::Movie.detail(id)
        title = movie_details["original_title"]
        rating = Movie.get_rating(id)
        if(rating == "N/A")
            rating = self.all_ratings.sample
        end
        description = movie_details["overview"]
        release_date = movie_details["release_date"]
        movie_params = {"title" => title, "rating" => rating, "description" => description, "release_date" => release_date}
        Movie.create(movie_params)
      end
  end
  
  def self.get_rating(movie_id)
    rating =Tmdb::Movie.releases(movie_id)["countries"]
    if rating.nil?
      return "N/A"
    else
      rating = rating.select{ |e| e['iso_3166_1']=='US'}
      if rating.nil?
        return "N/A"
      else
          if !rating[0].nil?
            rating = rating[0]["certification"]
            if rating != ""
              return rating
            else
              return "N/A"
            end
          else
            return "N/A"
          end
      end
    end
  end
  
end
