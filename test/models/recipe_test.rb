require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
    
   def setup
       @chef = Chef.create!(chefname: "derek", email: "derek@example.com",
                            password: "password", password_confirmation: "password")
      @recipe = @chef.recipes.build(name: "Derek's cookie recipe", description: "Best recipe ever") 
   end
   
   test "recipe without chef should be invalid" do
       @recipe.chef_id = nil
       assert_not @recipe.valid?
       
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