class UsersController < ApplicationController
	  before_action :authenticate_user, except: :create
	  before_action :find_user, except: %i[create index]

	  # GET /users
	  def index
	    @users = User.all
	    render json: @users
	  end


	  # GET /users/{username}
	  def show
	    render json: @user
	  end


	  # POST /users
	  def create
	    @user = User.new(user_params)
	    if @user.save
	      render json: @user, status: :created
	    else
	      render json: { errors: @user.errors.full_messages },
	             status: :unprocessable_entity
	    end
	  end


	  # PUT /users/{username}
	  def update
	  	# byebug
	    unless @user.update(update_params)
	      render json: { errors: @user.errors.full_messages },
	             status: :unprocessable_entity
	      else
	      	render json: @user, status: :created
	    end
	  end


	  # DELETE /users/{username}
	  def destroy
	    if @user.destroy
	 	 	render json: {meta: "user deleted"}
       else
			render json: {errors: "user not deleted"}
		 end
	  end


	  private


	  def user_params
	    params.permit(:name, :user_name, :email, :password)
	  end
	
	 	def update_params
	   	params.require(:user).permit(:name, :password)
	   end

	   # def delete_params
	   # 	params.require(:user).permit(:name)
	   # end

	  def find_user
	    @user = User.find_by_id(params[:id])
	  end
end
