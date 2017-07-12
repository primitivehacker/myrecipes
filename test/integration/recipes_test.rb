require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "Derek", email: "derek@example.com")
    @recipe = Recipe.create(name: "Cookies", description: "eggs, milk, and the goods", chef: @chef)
    @recipe2 = @chef.recipes.build(name: "soup", description: "Fish in soup")
    @recipe2.save
  end
  
  test "should get recipe index" do
    get recipes_path
    assert_response :success
  end
  
  test "should get recipes listing" do
    get recipes_path
    assert_template 'recipes/index'
    assert_match @recipe.name, response.body
    assert_match @recipe2.name, response.body
  end
  
  
end
