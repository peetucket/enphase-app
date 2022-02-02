class UsageController < ApplicationController

  def index
    @result = EnphaseClient.conn.summary(system_id: Settings.enphase.system_id)
    inverters = EnphaseClient.conn.inverters(site_id: Settings.enphase.system_id)
    @active_inverters = inverters[0]['micro_inverters'].reject {|inverter| inverter["status"] == 'retired'}
    @inverters_ok = @active_inverters.all? {|inverter| inverter['status'] == 'normal'}
    @status = @result["status"]
  end

end
