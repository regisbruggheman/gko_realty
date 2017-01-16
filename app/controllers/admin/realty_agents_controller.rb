class Admin::RealtyAgentsController < Admin::ResourcesController
  belongs_to :site
  respond_to :html, :js
end
