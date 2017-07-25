require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "Derek", email: "derek@example.com", password: "password", password_confirmation: "password")
    @chef2 = Chef.create!(chefname: "Fred", email: "fred@example.com", password: "password", password_confirmation: "password")
    @admin_user = Chef.create!(chefname: "Fred", email: "fred@example.com", password: "password", password_confirmation: "password", admin: true)
  end
  
  test "reject invalid edit" do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template "chefs/edit"
    patch chef_path(@chef), params: { chef: { chefname: "", email: "derek@example.com" } }
    assert_template "chefs/edit"
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  test "accept valid edit" do 
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template "chefs/edit"
    patch chef_path(@chef), params: { chef: { chefname: "derek1", email: "derek1@example.com" } }
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "derek1", @chef.chefname
    assert_match "derek1@example.com", @chef.email
  end
  
  test "accept edit attempt from admin user" do
    sign_in_as(@admin_user, "password")
    get edit_chef_path(@chef)
    assert_template "chefs/edit"
    patch chef_path(@chef), params: { chef: { chefname: "derek3", email: "derek3@example.com" } }
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "derek3", @chef.chefname
    assert_match "derek3@example.com", @chef.email
  end
  
  test "redirect edit attempt from non-admin user" do
    sign_in_as(@chef2, "password")
    get edit_chef_path(@chef)
    assert_template "chefs/edit"
    patch chef_path(@chef), params: { chef: { chefname: "derek1", email: "derek1@example.com" } }
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "derek1", @chef.chefname
    assert_match "derek1@example.com", @chef.email
  end
end
