module ExploreHelper
  include ScrapingHelper

  def find_explore_results(src, q)
    query = q.to_s.squish
    case src
    when 'nyt'
      load 'explore/nyt.rb'
      results = NYTSearchScraper.new.scrape(query)
    when 'epicurious'
      load 'explore/epicurious.rb'
      results = EpicuriousSearchScraper.new.scrape(query)
    when 'allrecipes'
      load 'explore/allrecipes.rb'
      results = AllrecipesSearchScraper.new.scrape(query)
    end
    results
  end

  def prepare_explore_preview(recipe_data)
    Recipe.new do |r|
      r.title = recipe_data['title']
      r.description = recipe_data['description'].to_s.squish
      r.ingredients = write_ingredients_to_list(recipe_data['ingredients'])
      r.instructions = form_markdown_for_instructions(recipe_data['instructions'])
      r.source = recipe_data['source'].to_s
      r.author = recipe_data['author'].to_s
      r.serves = recipe_data['serves'].to_s
      r.notes = recipe_data['notes'].to_s
    end
  end
end
