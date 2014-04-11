class FinancesController < ApplicationController
  layout "authorized_application"
  before_filter :authenticate_user!
#def index
  #@user = current_user
  #if [52, 53, 60].include? @user.state_id
   # flash.now[:notice] = "User is from one of the accepted regions"
  #else
   # flash.now[:notice] = "User is NOT from one of the accepted regions"
  #end
#end
  
end