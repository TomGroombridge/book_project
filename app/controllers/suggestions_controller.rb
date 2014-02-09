class SuggestionsController < ApplicationController

  def index
    @suggestions = Suggestion.where('title ILIKE ?', params[:term] + '%').limit(8).map do |suggestion|
      "#{suggestion.title} by #{suggestion.author}"
    end
    render json: @suggestions
  end

end
