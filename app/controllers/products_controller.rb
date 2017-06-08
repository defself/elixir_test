class ProductsController < ApplicationController
  skip_before_action :require_login, only: [:index]
  load_and_authorize_resource

  def index
    @products = params[:updated_by_employee_last_week] ? Product.updated_by_employee_last_week
                                                       : Product.all.order(:updated_at)
  end

  def archive
    @product.active? ? @product.archived!
                     : @product.active!
    redirect_back(fallback_location: root_path, notice: "Product archived successfully")
  end
end
