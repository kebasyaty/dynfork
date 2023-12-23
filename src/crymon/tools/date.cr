# Converting string Date and DateTime to object Time.
module Crymon::Tools::Date
  # Converting string Date to object Time.
  # <br>
  # _**Formats:** dd-mm-yyyy | dd/mm/yyyy | dd.mm.yyyy |
  # yyyy-mm-dd | yyyy/mm/dd | yyyy.mm.dd_
  def date_parse(date : String) : Time
    md = Crymon::Globals.cache_regex[:date_parse].match(date) ||
         Crymon::Globals.cache_regex[:date_parse_reverse].match(date)
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
    md = Crymon::Globals.cache_regex[:datetime_parse].match(datetime) ||
         Crymon::Globals.cache_regex[:datetime_parse_reverse].match(datetime)
    raise "Invalid date." if md.nil?
    Time.parse_utc("#{md["y"]}-#{md["m"]}-#{md["d"]} #{md["t"]}", "%F %H:%M")
  end
end
