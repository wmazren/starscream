class AccountsController < ApplicationController
  def edit
    @account = Account.find(params[:id])
  end

  def update
    @account = Account.find(params[:id])
    if @account.update_attributes(params[:account])
      flash[:notice] = "Successfully updated account."
      redirect_to dashboards_path
    else
      render :action => 'edit'
    end
  end
end
