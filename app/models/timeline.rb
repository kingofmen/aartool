class Timeline < ActiveRecord::Base
  has_many :timeline_entries, dependent: :destroy
end
