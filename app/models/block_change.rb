class BlockChange < ActiveRecord::Base
  set_table_name 'lb-world6'
  set_inheritance_column 'inheritance_type'

  WORLDS = %w|world6 mine5 mine6 skyworld nether|

  belongs_to :player, :foreign_key => 'playerid'

  scope :timeframe, lambda {|time| where('date > ?', Time.now - time) }

  scope :max_y, lambda {|y| where('y <= ?', y) if y.present? }

  def self.for_world(world)
    world = WORLDS.first unless WORLDS.include?(world)
    Object::const_get("#{world.to_s.classify}BlockChange")
  end

  def self.xray_stats
    res = {}
    self.select('playername, replaced, type, count(*) as destroyed').where(:type => [0, 50]).group("`#{table_name}`.playerid", :replaced).joins(:player).each do |m|
      res[m.playername] ||= {}
      if m.type == 50
        res[m.playername][-50] = m.destroyed
      else
        res[m.playername][m.replaced] = m.destroyed
        res[m.playername][:all] = res[m.playername][:all].to_i + m.destroyed
      end
    end
    res.each do |player, stats|
      valuable_points = (stats[56].to_i*127 + stats[14].to_i*79 + stats[15].to_i*12) / 3.0
      valuable_points -= (stats[-50].to_i - (stats[50].to_i / 2)) * 4
      stats[:xray] = valuable_points < 100 ? -1 : ((valuable_points) / stats[1] * 100).to_i
    end
    res
  end
end

BlockChange::WORLDS.each do |world|
  eval <<-END
    class #{world.classify}BlockChange < BlockChange
      set_table_name "lb-#{world}"
    end
  END
end
