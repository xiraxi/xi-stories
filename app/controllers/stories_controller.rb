class StoriesController < ApplicationController

  only_admins( :new, :create, :edit, :update )

  def index
  end

  def show
    @story = Story.find(params[:id])

    if current_user and not current_user.admin? and @story.draft?
      return not_found
    end
  end

  def new
    @story = Story.new
  end

  def create
    @story = Story.new(params[:story])
    @story.user = current_user

    if @story.save
      flash[:notice] = I18n.t("stories.notice_saved") 
      redirect_to story_path(@story)
    else
      render :action => "new"
    end
  end

  def edit
    begin
      @story = Story.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      return not_found
    end
  end

  def update
    begin
      @story = Story.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      return not_found
    end
    @story.update_attributes(params[:story])

    if @story.save
      flash[:notice] = I18n.t("stories.notice_saved") 
      redirect_to story_path(@story)
    else
      render :action => "edit"
    end
  end


end
