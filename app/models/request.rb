class Request < ApplicationRecord
  belongs_to :user

  enum status: [:processing, :rejected, :accepted]
  scope :order_created_at, ->{order created_at: :desc}
  scope :order_updated_at, ->{order updated_at: :desc}
  
  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |request|
        csv << request.attributes.values_at(*column_names)
      end
    end
  end
end
