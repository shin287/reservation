class ReservationsController < ApplicationController
  before_action :require_login

  def new
    @room = Room.find(params[:room_id])
    @reservation = Reservation.new
  end

  def create
    @room = Room.find(params[:room_id])
    @reservation = current_user.reservations.build(reservation_params)
    @reservation.room = @room

    if @reservation.save
      redirect_to user_path(current_user), notice: "予約しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :people)
  end



end
