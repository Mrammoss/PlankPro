class ApplicationController < ActionController::Base
  include Pundit
  skip_forgery_protection
end
