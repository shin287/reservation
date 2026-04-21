class RoomsController < ApplicationController
  before_action :require_login, except: [:index, :show]

  def index
    @rooms = Room.all

    if params[:area].present?
      @rooms = @rooms.where("address LIKE ?", "%#{params[:area]}%")
    end

    if params[:keyword].present?
      @rooms = @rooms.where(
        "name LIKE ? OR introduction LIKE ? OR address LIKE ?", 
        "%#{params[:keyword]}%", 
        "%#{params[:keyword]}%",
        "%#{params[:keyword]}%"
        )
    end
  end

  def my_rooms
    @rooms = current_user.rooms
  end

  def new
    @room = Room.new
  end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      redirect_to rooms_path, notice: "施設情報を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @room = Room.find(params[:id])
  end

  def edit
    @room = current_user.rooms.find(params[:id])
  end

  def update
    @room = current_user.rooms.find(params[:id])
    if @room.update(room_params)
      redirect_to room_path(@room), notice: "施設情報を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @room = current_user.rooms.find(params[:id])
    @room.destroy
    redirect_to rooms_path, notice: "削除しました"
  end

  private

  def room_params
    params.require(:room).permit(:name, :introduction, :price, :address, :image)
  end

end
