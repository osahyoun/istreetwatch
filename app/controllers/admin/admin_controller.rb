class Admin::AdminController < ApplicationController
  if Rails.env.production?
    http_basic_authenticate_with name: "admin", password: ENV['PASSWORD']
  end

  layout 'admin'

end