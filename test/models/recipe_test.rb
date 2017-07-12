require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
    
   def setup
      @recipe = Recipe.new(name: "Derek's cookie recipe", description: "Best recipe ever") 
   end
   
   test "Recipe should be valid" do
       assert @recipe.valid?
  
   end
   
   test "Name should be present" do
      @recipe.name = ""
      assert_not @recipe.valid?
   end
   
    test "Description should be present" do
      @recipe.description = ""
      assert_not @recipe.valid?
   end
   
   test "Description should not be less than 5 char" do
       @recipe.description = "a" * 3
       assert_not @recipe.valid?
   end
   
   test "Description should not be more than 500 char" do
       @recipe.description = "a" * 501
   end
   
   
end