class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :check_in, presence: true
  validates :check_out, presence: true
  validates :people, presence: true, numericality: {greater_than_or_equal_to: 1}
  validate :check_in_cannot_be_in_the_past
  validate :check_out_must_be_after_check_in

  def check_in_cannot_be_in_the_past
    return if check_in.blank?
    
    if check_in < Date.today
      errors.add(:check_in, "は今日以降にしてください")
    end
  end

  def check_out_must_be_after_check_in
    return if check_in.blank? || check_out.blank?

    if check_out <= check_in
      errors.add(:check_out, "はチェックインより後の日付にしてください")
    end
  end

  def total_price
    days = (check_out - check_in).to_i
    room.price * days * people
  end
end
