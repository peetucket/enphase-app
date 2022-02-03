module UsageHelper

  def to_kw(input)
    (input/1000.0).round(1)
  end

  def display_date(input) # Monday, January 1 - 2:43 pm
    input.strftime("%A, %B %e - %l:%M %p")
  end

  def status_class(status)
    status == 'normal' ? 'success' : 'danger'
  end

  # we don't need to bother auto refreshing the page before sun rise or 1 hour after sunset
  def auto_refresh?
    sun_times = SunTimes.new
    # NOTE: this gem seems to have an issue with the sun rise/set days being wrong if the UTC
    #  times span the current day for the time zone you are in ...
    #  my kludgy fix for PST is just to ask for yesterday's sun rise and tomorrow's sunset
    #  (though this would break things in other timezones)
    sun_rise = sun_times.rise(Date.yesterday, Settings.latitude, Settings.longitude)
    sun_set = sun_times.set(Date.tomorrow, Settings.latitude, Settings.longitude)
    Time.zone.now > sun_rise && Time.zone.now < sun_set+1.hour
  end

end
