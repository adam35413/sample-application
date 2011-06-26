class UsersController < ApplicationController
    before_filter :authenticate, :only => [:index, :edit, :update]
    before_filter :correct_user, :only => [:edit, :update] 
    before_filter :admin_user, :only => :destroy

    def index
      @title = "All users"
      @users = User.paginate(:page => params[:page])
    end
    def show
      @user = User.find(params[:id])
      @title = @user.name
    end

    def new
      @title = "Sign up"
      @user = User.new
    end

    def create
      @user = User.new(params[:user])
      if @user.save
        flash[:success] = "Welcome to the Sample App!"
        sign_in @user
        redirect_to @user
      else
        @title = "Sign up"
        @user.password = ""
        @user.password_confirmation = ""
        render 'new'
      end
    end

    def edit
      @title = "Edit user"
    end

    def update
      if @user.update_attributes(params[:user])
        flash[:success] = "Profile updated"
        redirect_to @user
      else
        flash[:error] = "Unable to update settings"
        @title = "Edit user"
        render 'edit'
      end
    end
  
    def destroy
      User.find(params[:id]).destroy
      flash[:success] = "Successfully deleted."
      redirect_to users_path
    end
  
    private
      
      def authenticate
        deny_access unless signed_in?
      end

      def correct_user
        @user = User.find(params[:id])
        redirect_to(root_path) unless current_user?(@user)
      end

      def admin_user
        if current_user.nil? == false
          redirect_to(root_path) unless current_user.admin?
        else
          redirect_to(root_path)
        end
      end
end
