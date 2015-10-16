# Completed step definitions for basic features: AddMovie, ViewDetails, EditMovie 

Given /^I am on the RottenPotatoes home page$/ do
  visit movies_path
 end


 When /^I have added a movie with title "(.*?)" and rating "(.*?)"$/ do |title, rating|
  visit new_movie_path
  fill_in 'Title', :with => title
  select rating, :from => 'Rating'
  click_button 'Save Changes'
 end

 Then /^I should see a movie list entry with title "(.*?)" and rating "(.*?)"$/ do |title, rating| 
   result=false
   all("tr").each do |tr|
     if tr.has_content?(title) && tr.has_content?(rating)
       result = true
       break
     end
   end  
  expect(result).to be_truthy
 end

 When /^I have visited the Details about "(.*?)" page$/ do |title|
   visit movies_path
   click_on "More about #{title}"
 end

 Then /^(?:|I )should see "([^"]*)"$/ do |text|
    expect(page).to have_content(text)
 end

 When /^I have edited the movie "(.*?)" to change the rating to "(.*?)"$/ do |movie, rating|
  click_on "Edit"
  select rating, :from => 'Rating'
  click_button 'Update Movie Info'
 end

# New step definitions to be completed for HW5. 
# Note that you may need to add additional step definitions beyond these


# Add a declarative step here for populating the DB with movies.

Given /the following movies have been added to RottenPotatoes:/ do |movies_table|

  movies_table.hashes.each do |movie|
    
    Movie.create(movie)
    
  end
end

When /^I have opted to see movies rated: "(.*?)"$/ do |arg1|
  
  ratings = Movie.all_ratings
  
  ratings.each do |rating|
    if arg1.split(', ').include?(rating)
        check("ratings_"+rating)
    else
        uncheck("ratings_"+rating)
    end
  end
  
  click_on("ratings_submit")
  
end

Then /^I should see only movies rated: "(.*?)"$/ do |arg1|
 
  ratings_shown = page.all('table#movies tr > td:nth-child(2)').map(&:text).uniq
  ratings_shown.sort.should == arg1.split(', ').sort
end

Then /^I should see all of the movies$/ do
  rows = page.all('#movies tr').size - 1
  rows.should == Movie.count()
end


When(/^I have sorted movies alphabetically$/) do
  
  #click link to sort
  click_link('title_header')
  
  
end

Then /^I should see "(.*)" before "(.*)"$/ do |arg1, arg2|
 
  #grab movies into array
  movies_list = page.all('table#movies tr > td:nth-child(1)').map(&:text)
  
  #Put args in alphabetical order
  args_list = [arg1,arg2]

  #compare index of args
  movies_list.find_index(args_list[0]).should < movies_list.find_index(args_list[1])
  
  
end

When(/^I have sorted movies by release date$/) do
  #click link to sort
  click_link('release_date_header')
end



