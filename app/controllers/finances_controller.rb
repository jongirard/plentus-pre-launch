class FinancesController < ApplicationController
  layout "authorized_application"
  before_filter :authenticate_user!
def index
end
  
end