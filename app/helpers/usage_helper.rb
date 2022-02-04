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
    # NOTE: use the configured time zone and ignore the actual date and use only times...
    #  this gem seems to have an issue with computing sunrise/set times that span
    #  the date when coverting back from UTC, so we need to ignore the day itself and just use local times
    sun_rise = sun_times.rise(Date.today, Settings.latitude, Settings.longitude).in_time_zone(Settings.time_zone)
    sun_set = sun_times.set(Date.today, Settings.latitude, Settings.longitude).in_time_zone(Settings.time_zone)
    current_time = Time.now.utc.in_time_zone(Settings.time_zone)

    sun_rise_today = Time.parse("#{Date.today} #{sun_rise.strftime("%H:%M:%S %z")}")
    sun_set_today = Time.parse("#{Date.today} #{(sun_set+1.hour).strftime("%H:%M:%S %z")}")
    current_time > sun_rise_today && current_time < sun_set_today
  end

end
