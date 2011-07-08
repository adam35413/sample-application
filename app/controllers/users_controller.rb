class UsersController < ApplicationController
    before_filter :authenticate, :except => [:show, :new, :create, :destroy]
    before_filter :correct_user, :only => [:edit, :update] 
    before_filter :admin_user, :only => :destroy

    def index
      @title = "All users"
      @users = User.paginate(:page => params[:page])
    end
    def show
      @user = User.find(params[:id])
      @microposts = @user.microposts.paginate(:page => params[:page])
      @title = @user.name
    end

    def new
      if current_user.nil?
        @title = "Sign up"
        @user = User.new
      else
        redirect_to(root_path)
      end
    end

    def create
      if current_user.nil?
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
      else
        redirect_to(root_path)
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
      @user = User.find(params[:id])
      if !@user.admin?
        @user.destroy
        flash[:success] = "Successfully deleted."
        redirect_to users_path
      else
        flash[:error] = "You are an admin; you can't delete yourself!"
        redirect_to users_path
      end
    end

    def following
      @title = "Following"
      @user = User.find(params[:id])
      @users = @user.following.paginate(:page => params[:page])
      render 'show_follow'
    end

    def followers
      @title = "Followers"
      @user = User.find(params[:id])
      @users = @user.followers.paginate(:page => params[:page])
      render 'show_follow'
    end

  
    private
      
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
