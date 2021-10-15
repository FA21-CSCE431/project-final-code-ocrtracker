class PermissionsController < ApplicationController
  before_action :require_admin

  def index
    @users = User.all
  end

  def edit
    @users = User.find_by(params[:uid])
  end

  def update
    @users = User.find_by(params[:uid])
    # if @users.update_attributes(user_params)
    if @users.update(user_params)
      flash[:notice] = "Successfully updated users."
      redirect_to permissions_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    User.destroy(params[:uid])
    flash[:notice] = "Successfully deleted user"
    redirect_to permissions_url
  end

  def complete
    submitted_hash = params[:user]

    respond_to do |format|
      if User.update(submitted_hash.keys, submitted_hash.values.map { |x| { is_admin: x[:is_admin] } })
        format.html { redirect_to permissions_url, notice: 'Users successfully updated' }
      else
        format.html { redirect_to permissions_url, notice: 'Failure' }
      end
    end
  end

  def user_params
    params.require(:user).permit(:is_admin)
  end
end
