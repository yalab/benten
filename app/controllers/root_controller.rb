class RootController < ApplicationController
  def index
    @comment = Comment.new
    @comments = Comment.order('created_at DESC').all
  end
end
