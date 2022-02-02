class UsageController < ApplicationController

  def index
    @result = EnphaseClient.conn.summary(system_id: Settings.enphase.system_id)
    inverters = EnphaseClient.conn.inverters(site_id: Settings.enphase.system_id)
    @active_inverters = inverters[0]['micro_inverters'].reject {|inverter| inverter["status"] == 'retired'}
    @inverter_status = @active_inverters.all? {|inverter| inverter['status'] == 'normal'} ? 'normal' : 'alert'
    @inverter_production = @active_inverters.sum {|inverter| inverter['power_produced']}
    @status = @result["status"]
  end

end
