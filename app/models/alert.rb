class Alert < ActiveRecord::Base
  attr_protected nil
  belongs_to :user
end
