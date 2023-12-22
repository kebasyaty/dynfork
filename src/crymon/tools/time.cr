# Converting string Date and DateTime to object Time.
module Crymon::Tools::Time
  # Converting string Date to object Time.
  # <br>
  # _**Formats:** dd-mm-yyyy | dd/mm/yyyy | dd.mm.yyyy |
  # yyyy-mm-dd | yyyy/mm/dd | yyyy.mm.dd_
  def date_parse(date : String) : Time
    if md : Regex::MatchData? = date.match(/^([0-9]{4})[-\/\.]([0-9]{2})[-\/\.]([0-9]{2})$/)
      date = "#{md[1]}-#{md[2]}-#{md[3]}"
    elsif md2 : Regex::MatchData? = date.match(/^([0-9]{2})[-\/\.]([0-9]{2})[-\/\.]([0-9]{4})$/)
      date = "#{md2[3]}-#{md2[2]}-#{md2[1]}"
    else
      raise "Invalid date."
    end
    Time.parse_utc(date, "%F")
  end

  # Converting string DateTime to object Time.
  # <br>
  # _**Formats:** dd-mm-yyyy hh:mm | dd/mm/yyyy hh:mm | dd.mm.yyyy hh:mm |
  # yyyy-mm-dd hh:mm | yyyy/mm/dd hh:mm | yyyy.mm.dd hh:mm_
  def datetime_parse(datetime : String) : Time
    if md : Regex::MatchData? = datetime.match(/^([0-9]{4})[-\/\.]([0-9]{2})[-\/\.]([0-9]{2})/)
      datetime = "#{md[1]}-#{md[2]}-#{md[3]}#{datetime[10..]}"
    elsif md2 : Regex::MatchData? = datetime.match(/^([0-9]{2})[-\/\.]([0-9]{2})[-\/\.]([0-9]{4})/)
      datetime = "#{md2[3]}-#{md2[2]}-#{md2[1]}#{datetime[10..]}"
    else
      raise "Invalid date."
    end
    Time.parse_utc(datetime, "%F %H:%M")
  end
end
