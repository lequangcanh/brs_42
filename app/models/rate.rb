class Rate < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :user_id, presence: true
  validates :user_id, presence: true
  validates :number_rates, presence: true, inclusion: 1..5,
    numericality: {only_integer: true}

  scope :user_ids_by_book, -> book_id do
    where(book_id: book_id).pluck :user_id
  end

  scope :average_for_book, -> book_id do
    where(book_id: book_id).average :number_rates
  end
end
