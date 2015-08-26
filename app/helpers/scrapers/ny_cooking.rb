require "wombat"

class NYCookingScraper
  include Wombat::Crawler

  def scrape(url_path)
    return Wombat.crawl do
      base_url "http://cooking.nytimes.com"
      path url_path

      title css: ".recipe-title"
      ingredients({ css: ".recipe-ingredients li[itemprop='ingredients']" }, :list)
      instructions({ css: ".recipe-steps li" }, :list)

      author css: ".recipe-subhead span[itemprop='author']"
      serves css: ".recipe-time-yield span[itemprop='recipeYield']"
      notes css: ".recipe-note-description"
    end
  end
end
