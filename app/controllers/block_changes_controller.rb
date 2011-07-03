class BlockChangesController < ApplicationController
  def index
    @world = params[:world] || 'world6'
    @timeframe = params[:timeframe] || 24
    @block_changes = BlockChange.for_world(@world).timeframe(@timeframe.to_i.hours).max_y(params[:max_y]).xray_stats.sort{|a,b| b[1][:xray] <=> a[1][:xray]  }
  end
end
