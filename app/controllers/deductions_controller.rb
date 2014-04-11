class DeductionsController < ApplicationController
   layout "authorized_application"
    before_filter :authenticate_user!
    before_filter :require_record, :only => :show
    before_filter :require_no_record, :only => :new

    def new
      @deduction = Deduction.new
    end

    def edit
      @deduction = Deduction.find(params[:id])
      authorize @deduction, :update?
    end

    def update
      @deduction = Deduction.find(params[:id])
      authorize @deduction
      @deduction.update(secure_params)
        redirect_to show_deduction_path(current_user.deduction)
    end

    def show
      @user = current_user
      @deduction = Deduction.find(params[:id])
      authorize @deduction
    end

    def create
      @deduction = Deduction.new(secure_params)
      @deduction.user = User.find(current_user.id)
      if @deduction.save
      redirect_to show_deduction_path(current_user.deduction)
    else
      render :new
    end
    end

    private
    
      def require_no_record
        if Deduction.where(:user_id => current_user.id).blank?

        else
          redirect_to show_deduction_path(current_user.deduction)
        end
      end

      def require_record
        if Deduction.where(:user_id => current_user.id).exists?

        else
          redirect_to :new_deduction
        end
      end

    def secure_params
      params.required(:deduction).permit(:flexible_home_sqf, :flexible_business_sqf, :flexible_monthly_expenses, :flexible_business_kilometers, :flexible_start_kilometers, :flexible_vehicle_expenses, :flexible_short_flight, :flexible_short_meal, :flexible_short_entertainment, :flexible_short_lodging, :flexible_long_flight, :flexible_long_meal, :flexible_long_entertainment, :flexible_long_lodging)
    end

  end