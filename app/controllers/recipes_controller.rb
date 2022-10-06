class RecipesController < ApplicationController
    before_action :authenticate

    def index
        recipes = Recipe.all
        render json: recipes, status: :ok
    end

    def create
        recipe = Recipe.create(recipe_params)
        if recipe.valid?
            render json: recipe, status: :created
        else 
            render json: { errors: recipe.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private

    def authenticate
        return render json: { error: "Not authorized" }, status: :unauthorized unless session.include? :user_id
    end

    def recipe_params
        params.permit(:title, :minutes_to_complete, :instructions, :user_id)
    end

end
