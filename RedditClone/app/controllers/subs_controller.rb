class SubsController < ApplicationController
    before_action :ensure_moderator, only: [:create, :edit, :update]

    def index
        @subs = Sub.all
        render :index
    end

    def new
        @sub = Sub.new
        render :new
    end

    def ensure_moderator
        current_user.id == self.moderator_id
    end

    def create
        @sub = Sub.new(sub_params)
        if @sub.save
            redirect_to sub_url(@sub)
        else
            flash.now[:errors] = ['Failed to create sub']
            render :new
        end
    end

    def edit
        @sub = Sub.find(params[:id])
        render :edit
    end

    def update
        @sub = Sub.find(params[:id])
        if @sub.update(sub_params)
            redirect_to sub_url(@sub)
        else
            flash.now[:errors] = ['Failed to update']
            render :edit
        end
    end

    def show
        @sub = Sub.find(params[:id])
        render :show
    end

    def sub_params
        params.require(:sub).permit(:title, :description, :moderator_id)
    end
end
