class ReservationsController < ApplicationController
  before_action :require_login
  before_action :set_room, only: [:new, :confirm, :create]

  def new
    @room = Room.find(params[:room_id])
    @reservation = Reservation.new
  end

  def confirm

    @reservation = current_user.reservations.build(reservation_params)
    @reservation.room = @room

    if @reservation.invalid?
      render :new, status: :unprocessable_entity
    else
      @nights = (@reservation.check_out - @reservation.check_in).to_i
      @total_price = @room.price * @reservation.people * @nights
    end
  end

  def create
    @room = Room.find(params[:room_id])
    @reservation = current_user.reservations.build(reservation_params)
    @reservation.room = @room

    if @reservation.save
      redirect_to user_path(current_user), notice: "予約しました"
    else
      puts @reservation.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :people)
  end


end
