class StoriesController < ApplicationController

  only_admins( :new, :create, :edit, :update, :destroy)

  def index
    if params[:draft]
      unless current_user
        redirect_to login_path
        return
      end
      return forbidden unless current_user.admin?
      flash[:notice] = I18n.t("stories.drafts.notice")
      dataset = Story.draft
    else
      dataset = Story.visible
    end

    if o = params[:section]
      section = Story::Section.find(o)
      dataset = dataset.where(["section_id = ?", section.id])
      @section_selected = 0
    end

    if o = params[:tag]
      dataset = dataset.tagged_with(o)
      @tag_selected = o
    end

    @stories = dataset.paginate(:page => params[:page], :per_page => 5)

  end

  def show
    begin
      @story = Story.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      return not_found
    end

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

  def destroy
    begin
      @story = Story.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      return not_found
    end
    @story.deleted_at = Time.zone.now

    if @story.save
      flash[:notice] = I18n.t("stories.notice_deleted") 
      redirect_to stories_path
    else
      render :action => "show", :id => @story
    end
  end


end
