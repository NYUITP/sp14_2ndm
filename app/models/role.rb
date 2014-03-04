class Role < ActiveRecord::Base
  belongs_to :resource, :polymorphic => true
  
  scopify
end
