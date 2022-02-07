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

  # we don't need to bother auto refreshing the page before sun rise or after sunset
  def daytime?
    # NOTE: use the configured time zone
    #  this gem seems to have an issue with computing sunrise/set times that span
    #  the date when coverting back from UTC, so we need to ignore the day itself and just use local times
    current_time = Time.now.utc.in_time_zone(Settings.time_zone)
    current_time > sunrise && current_time < sunset
  end

  def sun_times
    @sun_times ||= SunTimes.new
  end

  def sunrise
    rise_time = sun_times.rise(Date.today, Settings.latitude, Settings.longitude).in_time_zone(Settings.time_zone)
    Time.parse("#{Date.today} #{rise_time.strftime("%H:%M:%S %z")}")
  end

  def sunset
    set_time = sun_times.set(Date.today, Settings.latitude, Settings.longitude).in_time_zone(Settings.time_zone)
    Time.parse("#{Date.today} #{set_time.strftime("%H:%M:%S %z")}")
  end

  # refresh_internal in milliseconds if one is configured
  def refresh_interval
    # refresh interval is the configured number of minutes during the day or until next sunrise at night
    return unless Settings.auto_refresh_mins

    # preset refresh during the day; after sunset, a long interval until approximately sunrise the next morning
    daytime? ? (Settings.auto_refresh_mins * 1000.0 * 60) : (24 - sunset.hour + sunrise.hour) * 1000.0 * 60 * 60
  end
end
