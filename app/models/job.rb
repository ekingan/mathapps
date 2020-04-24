class Job < ApplicationRecord
  belongs_to :client
  belongs_to :user
  # has_many :payments
  enum status: [:todo, :in_progress, :need_info, :review, :need_signatures, :ready, :filed, :extended, :accepted, :rejected, :done]
  enum job_type: [:tax_return, :bookkeeping, :consulting, :referral, :teaching]
  validates_presence_of :status
end
