class CalendarsController < ApplicationController
  require 'date'

  def index
    get_Week
    @plan = Plan.new
  end



  def create
    Plan.create(plan_params)
    # binding.pry
    redirect_to action: :index
  end

  private

  def plan_params
    params.require(:plan).permit(:date, :plan)
  end

  def get_Week

    wdays = ["日", "月", "火", "水", "木", "金", "土" ]



    @todays_date = Date.today

    

    @week_days = []

    @plans = Plan.where(date: @todays_date..@todays_date + 7)

    7.times do |x|
      plans = []
      plan = @plans.map do |plan|
        plans.push(plan.plan) if plan.date == @todays_date + x
      end

      days = { month: (@todays_date + x).month, date: (@todays_date+x).day, plans: plans, w_days: wdays[(@todays_date + x).wday]}

      @week_days.push(days)
    end

  end
end
