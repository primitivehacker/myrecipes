class CommentsController < ApplicationController
   before_action :require_user
    
   def create
      @recipe = Recipe.find[:recipe_id] 
      @comment = @recipe.comments.build(comment_params)
      @comment.chef = current_chef
      if @comment.save
         flash[:sucess] = "Comment was sucessfully created"
         redirect_to recipe_path(@recipe)
      else
         flash[:danger] = "Comment was not created"
         redirect_to :back
      end
   end
   
   
   private
   
   def comment_params
      params.require(:comment).permit(:description)
   end
end