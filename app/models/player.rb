class Player < ActiveRecord::Base
  set_table_name 'lb-players'
  set_primary_key 'playerid'

  has_many :block_changes, :foreign_key => 'playerid'
end
