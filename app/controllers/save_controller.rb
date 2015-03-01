class SaveController < ApplicationController
  include SaveHelper

  def save
    if params[:url] && params[:url].length > 10
      if user_signed_in?
        recipe_data = scrape_for_schema_data(params[:url])
        recipe_data["source"] = params[:url]
        create_recipe(recipe_data, params[:url], "We've saved #{recipe_data['title']} from #{find_host(params[:url])}.")
      else
        flash[:info] = "Hey! You'll need an account in Noodles."
        redirect_to root_url
      end
    else
      render text: "Hmm, you didn't provide the recipe link."
    end
  end
end
