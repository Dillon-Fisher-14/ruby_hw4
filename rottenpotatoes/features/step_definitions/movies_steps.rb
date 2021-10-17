
Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create movie
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  expect(page.body.index(e1) < page.body.index(e2))
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(', ').each do |rating|
    step %{I #{uncheck.nil? ? '' : 'un'}check "ratings_#{rating}"}
  end
end



Then /(.*) seed movies should exist/ do | n_seeds |
  expect(Movie.count).to eq n_seeds.to_i
end

Then(/^the director of "([^"]*)" should be "([^"]*)"$/) do |movie_title, movie_director|
  # Write code here that turns the phrase above into concrete actions
  expect(Movie.find_by_title(movie_title).director == movie_director)
end


Then /I should only see all movies with ratings: (.*)/ do |ratings|
  
  ratings_vec = ratings.split(", ")
  
  Movie.all.each do |movie|
    
    if ratings_vec.include? movie.rating
    
      if page.respond_to? :should
        expect(page).to have_content(movie.title)
      else
        assert page.has_content?(movie.title)
      end
      
    else
      
      if page.respond_to? :should
        expect(page).to have_no_content(movie.title)
      else
        assert page.has_no_content?(movie.title)
      end
      
    end
    
  end
end

Then /I should see all the movies/ do
  Movie.all.each do |movie|
    
    if page.respond_to? :should
      expect(page).to have_content(movie.title)
    else
      assert page.has_content?(movie.title)
    end
      
  end
  
end