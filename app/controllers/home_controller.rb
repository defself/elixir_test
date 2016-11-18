class HomeController < ApplicationController
  skip_before_action :require_login

  def index
    render text: "Welcome home, %username%!", layout: true
  end
end
