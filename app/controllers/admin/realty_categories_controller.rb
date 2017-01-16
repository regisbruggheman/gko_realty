class Admin::RealtyCategoriesController < Admin::ResourcesController
  nested_belongs_to :site, :section
  respond_to :html, :js
  custom_actions :collection => [:selected]
  #cache_sweeper CategorySweeper, :only => [:create, :update, :destroy]

  def restructure
    node_id = params[:node_id].to_i
    parent_id = params[:parent_id].to_i
    prev_id = params[:prev_id].to_i
    next_id = params[:next_id].to_i

    render :text => "Do nothing" and return if parent_id.zero? && prev_id.zero? && next_id.zero?

    @realty_category ||= parent.realty_categories.find(node_id)

    if prev_id.zero? && next_id.zero?
      @realty_category.move_to_child_of parent.realty_categories.find(parent_id)
    elsif !prev_id.zero?
      @realty_category.move_to_right_of parent.realty_categories.find(prev_id)
    elsif !next_id.zero?
      @realty_category.move_to_left_of parent.realty_categories.find(next_id)
    end
  end

  protected
  
  def collection
    @timestamp = "#{Globalize.locale}-#{Digest::MD5.hexdigest ["admin-realty-categories", current_site, parent].join('/')}"
    Rails.cache.fetch(@timestamp) do
      @realty_category ||= parent.realty_categories.includes(:translations).arrange
    end
  end
end
