module BlockChangesHelper
  def calculate_xray(stats)
    return -1 if stats[1].to_i == 0
    valuable_points = 1 + stats[56].to_i*33 + stats[14].to_i*16 + stats[15].to_i*3
    return -1 if valuable_points < 100
    (valuable_points / stats[1].to_f * 100).to_i
  end
end
