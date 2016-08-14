class WeekView
  def initialize(date)
    date = date.present? ? Date.parse(date) : Date.today
    @start_date = date - date.cwday
  end

  def sunday
    @start_date.strftime("%A %m/%d")
  end

  def monday
    (@start_date+1).strftime("%A %m/%d")
  end

  def tuesday
    (@start_date+2).strftime("%A %m/%d")
  end

  def wednesday
    (@start_date+3).strftime("%A %m/%d")
  end

  def thursday
    (@start_date+4).strftime("%A %m/%d")
  end

  def friday
    (@start_date+5).strftime("%A %m/%d")
  end

  def saturday
    (@start_date+6).strftime("%A %m/%d")
  end

  def between
    (@start_date..@start_date+6)
  end

end
