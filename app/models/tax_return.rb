class TaxReturn < ApplicationRecord
  belongs_to :job
  enum fed_form: [:Individual_1040, :S_Corp_1120S, :Partnership_1065, :C_Corp_1120, :Non_Profit_990, :Trust_1041, :Estate_706, :Amendment_1040X, :other]
  validates_presence_of :fed_form, :tax_year
  after_initialize :set_tax_year

  private

  def set_tax_year
    self.tax_year ||= Date.current.year - 1
  end
end
