# Converting string Date and DateTime to object Time.
module Crymon::Tools::Time
  # Converting string Date to object Time.
  # <br>
  # _**Formats:** dd-mm-yyyy | dd/mm/yyyy | dd.mm.yyyy |
  # yyyy-mm-dd | yyyy/mm/dd | yyyy.mm.dd_
  def date_parse(date : String) : Time
    md = date.match(/^(?P<y>[0-9]{4})[-\/\.](?P<m>[0-9]{2})[-\/\.](?P<d>[0-9]{2})$/) ||
         date.match(/^(?P<d>[0-9]{2})[-\/\.](?P<m>[0-9]{2})[-\/\.](?P<y>[0-9]{4})$/)
    raise "Invalid date." if md.nil?
    Time.parse_utc("#{md["y"]}-#{md["m"]}-#{md["d"]}", "%F")
  end

  # Converting string DateTime to object Time.
  # <br>
  # _**Formats:** dd-mm-yyyy hh:mm | dd/mm/yyyy hh:mm | dd.mm.yyyy hh:mm |
  # dd-mm-yyyyThh:mm | dd/mm/yyyyThh:mm | dd.mm.yyyyThh:mm |
  # yyyy-mm-dd hh:mm | yyyy/mm/dd hh:mm | yyyy.mm.dd hh:mm |
  # yyyy-mm-ddThh:mm | yyyy/mm/ddThh:mm | yyyy.mm.ddThh:mm_
  def datetime_parse(datetime : String) : Time
    md = datetime.match(/^(?P<y>[0-9]{4})[-\/\.](?P<m>[0-9]{2})[-\/\.](?P<d>[0-9]{2})(?:T|\s)(?<t>[0-9]{2}:[0-9]{2})$/) ||
         datetime.match(/^(?P<d>[0-9]{2})[-\/\.](?P<m>[0-9]{2})[-\/\.](?P<y>[0-9]{4})(?:T|\s)(?<t>[0-9]{2}:[0-9]{2})$/)
    raise "Invalid date." if md.nil?
    Time.parse_utc("#{md["y"]}-#{md["m"]}-#{md["d"]} #{md["t"]}", "%F %H:%M")
  end
end
