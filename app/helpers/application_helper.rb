module ApplicationHelper

  def to_kw(input)
    (input/1000.0).round(1)
  end

  def display_date(input) # Monday, January 1 - 2:43 pm
    input.strftime("%A, %B %e - %l:%M %p")
  end

  def status_class(status)
    ['normal', true].include?(status) ? 'success' : 'danger'
  end
end
