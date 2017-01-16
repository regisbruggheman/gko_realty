class Admin::AreasController < Admin::ResourcesController
  nested_belongs_to :city
  respond_to :json
  def index
    respond_with(collection)
  end
      
end
