class Story::SectionsController < ApplicationController
  
  only_admins

  # GET /story/sections
  # GET /story/sections.xml
  def index
    @story_sections = Story::Section.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @story_sections }
    end
  end

  # GET /story/sections/1
  # GET /story/sections/1.xml
  def show
    @story_section = Story::Section.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @story_section }
    end
  end

  # GET /story/sections/new
  # GET /story/sections/new.xml
  def new
    @story_section = Story::Section.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @story_section }
    end
  end

  # GET /story/sections/1/edit
  def edit
    @story_section = Story::Section.find(params[:id])
  end

  # POST /story/sections
  # POST /story/sections.xml
  def create
    @story_section = Story::Section.new(params[:story_section])

    respond_to do |format|
      if @story_section.save
        format.html { redirect_to(@story_section, :notice => 'Section was successfully created.') }
        format.xml  { render :xml => @story_section, :status => :created, :location => @story_section }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @story_section.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /story/sections/1
  # PUT /story/sections/1.xml
  def update
    @story_section = Story::Section.find(params[:id])

    respond_to do |format|
      if @story_section.update_attributes(params[:story_section])
        format.html { redirect_to(@story_section, :notice => 'Section was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @story_section.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /story/sections/1
  # DELETE /story/sections/1.xml
  def destroy
    @story_section = Story::Section.find(params[:id])
    @story_section.deleted_at = Time.zone.now
    @story_section.save

    respond_to do |format|
      format.html { redirect_to(story_sections_url) }
      format.xml  { head :ok }
    end
  end
end
