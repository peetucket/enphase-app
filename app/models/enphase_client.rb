class EnphaseClient
  def self.conn
    @client ||= Enphase::Client.new(
     api_key: Settings.enphase.api_key,
     user_id: Settings.enphase.user_id)
 end
end
