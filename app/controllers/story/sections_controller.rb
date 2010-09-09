class Story::SectionsController < ApplicationController
  
  admin_section

  include BasicCrud::Controller

  def model
    Story::Section
  end

  def valid_actions
      [:list, :new, :edit, :destroy]
  end

  def columns
    [
      { :name => :name },
      { :name => :position}
    ]
  end

end
