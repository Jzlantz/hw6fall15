module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  def get_rating(movie_id)
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
