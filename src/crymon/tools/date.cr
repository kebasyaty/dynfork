# Converting string Date and DateTime to object Time.
module Crymon::Tools::Date
  extend self

  # Converting string Date to object Time.
  # <br>
  # _**Formats:** dd-mm-yyyy | dd/mm/yyyy | dd.mm.yyyy |
  # yyyy-mm-dd | yyyy/mm/dd | yyyy.mm.dd_
  # <br>
  # WARNING: Unsupported formats:
  # <br>USA - M/D/YYYY
  # <br>Kazakhstan, Latvia - YYYY.DD.MM
  # <br>PRC - YYYY-M-D
  # <br>Hong Kong, Taiwan - YYYY/M/D
  # <br>Finland, Czech Republic - D.M.YYYY
  # <br>Netherlands - D-M-YYYY
  # <br>Brazil, Greece, Thailand - D/M/YYYY
  def date_parse(date : String) : Time
    md = Crymon::Globals.cache_regex[:date_parse].match(date) ||
         Crymon::Globals.cache_regex[:date_parse_reverse].match(date)
    raise Crymon::Errors::Date::InvalidDate.new if md.nil?
    Time.parse_utc("#{md["y"]}-#{md["m"]}-#{md["d"]}", "%F")
  end

  # Converting string DateTime to object Time.
  # <br>
  # _**Formats:** dd-mm-yyyy hh:mm:ss | dd/mm/yyyy hh:mm:ss | dd.mm.yyyy hh:mm:ss |
  # dd-mm-yyyyThh:mm:ss | dd/mm/yyyyThh:mm:ss | dd.mm.yyyyThh:mm:ss |
  # yyyy-mm-dd hh:mm:ss | yyyy/mm/dd hh:mm:ss | yyyy.mm.dd hh:mm:ss |
  # yyyy-mm-ddThh:mm:ss | yyyy/mm/ddThh:mm:ss | yyyy.mm.ddThh:mm:ss_
  # <br>
  # WARNING: Unsupported date formats:
  # <br>USA - M/D/YYYY
  # <br>Kazakhstan, Latvia - YYYY.DD.MM
  # <br>PRC - YYYY-M-D
  # <br>Hong Kong, Taiwan - YYYY/M/D
  # <br>Finland, Czech Republic - D.M.YYYY
  # <br>Netherlands - D-M-YYYY
  # <br>Brazil, Greece, Thailand - D/M/YYYY
  def datetime_parse(datetime : String) : Time
    md = Crymon::Globals.cache_regex[:datetime_parse].match(datetime) ||
         Crymon::Globals.cache_regex[:datetime_parse_reverse].match(datetime)
    raise Crymon::Errors::Date::InvalidDateTime.new if md.nil?
    Time.parse_utc("#{md["y"]}-#{md["m"]}-#{md["d"]} #{md["t"]}", "%F %H:%M:%S")
  end
end
