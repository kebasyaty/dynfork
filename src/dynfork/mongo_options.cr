# Mongo Driver Options.
module DynFork::MongoOptions
  extend self

  alias RawMongoDriverOptions = NamedTuple(
    uri: String,
    options: NamedTuple(
      appname: String?,
      auth_mechanism: String?,
      auth_mechanism_properties: String?,
      auth_source: String?,
      compressors: String?,
      connect_timeout: String?, # Time::Span?, # 10.seconds
      direct_connection: Bool?,
      heartbeat_frequency: String, # Time::Span,
      journal: Bool?,
      local_threshold: String, # Time::Span,
      max_idle_time: String?,  # Time::Span?,
      max_pool_size: Int32,
      max_staleness_seconds: Int32?,
      min_pool_size: Int32,
      read_concern_level: String?,
      read_preference: String?,
      read_preference_tags: Array(String),
      replica_set: String?,
      retry_reads: Bool?,
      retry_writes: Bool?,
      server_selection_timeout: String, # Time::Span,
      server_selection_try_once: Bool,
      socket_timeout: String?, # Time::Span?,
      ssl: Bool?,
      tls: Bool?,
      tls_allow_invalid_certificates: Bool?,
      tls_allow_invalid_hostnames: Bool?,
      tls_ca_file: String?,
      tls_certificate_key_file: String?,
      tls_certificate_key_file_password: String?,
      tls_disable_certificate_revocation_check: Bool?,
      tls_disable_ocsp_endpoint_check: Bool?,
      tls_insecure: Bool?,
      w: (Int32 | String)?,
      wait_queue_timeout: String?, # Time::Span?,
      w_timeout: String?,          # Time::Span?,
      zlib_compression_level: Int32?,
    ))

  # Generate driver options.
  def generate_options : NamedTuple(uri: String, options: Mongo::Options)
    yaml : String = File.read("config/mongo/options.yml")
    raw_options = RawMongoDriverOptions.from_yaml(yaml)

    {
      uri:     raw_options[:uri],
      options: Mongo::Options.new(
        appname: raw_options[:options][:appname],
        auth_mechanism: raw_options[:options][:auth_mechanism],
        auth_mechanism_properties: raw_options[:options][:auth_mechanism_properties],
        auth_source: raw_options[:options][:auth_source],
        compressors: raw_options[:options][:compressors],
        connect_timeout: to_span?(raw_options[:options][:connect_timeout]),
        direct_connection: raw_options[:options][:direct_connection],
        heartbeat_frequency: to_span(raw_options[:options][:heartbeat_frequency]),
        journal: raw_options[:options][:journal],
        local_threshold: to_span(raw_options[:options][:local_threshold]),
        max_idle_time: to_span?(raw_options[:options][:max_idle_time]),
        max_pool_size: raw_options[:options][:max_pool_size],
        max_staleness_seconds: raw_options[:options][:max_staleness_seconds],
        min_pool_size: raw_options[:options][:min_pool_size],
        read_concern_level: raw_options[:options][:read_concern_level],
        read_preference: raw_options[:options][:read_preference],
        read_preference_tags: raw_options[:options][:read_preference_tags],
        replica_set: raw_options[:options][:replica_set],
        retry_reads: raw_options[:options][:retry_reads],
        retry_writes: raw_options[:options][:retry_writes],
        server_selection_timeout: to_span(raw_options[:options][:server_selection_timeout]),
        server_selection_try_once: raw_options[:options][:server_selection_try_once],
        socket_timeout: to_span?(raw_options[:options][:socket_timeout]),
        ssl: raw_options[:options][:ssl],
        tls: raw_options[:options][:tls],
        tls_allow_invalid_certificates: raw_options[:options][:tls_allow_invalid_certificates],
        tls_allow_invalid_hostnames: raw_options[:options][:tls_allow_invalid_hostnames],
        tls_ca_file: raw_options[:options][:tls_ca_file],
        tls_certificate_key_file: raw_options[:options][:tls_certificate_key_file],
        tls_certificate_key_file_password: raw_options[:options][:tls_certificate_key_file_password],
        tls_disable_certificate_revocation_check: raw_options[:options][:tls_disable_certificate_revocation_check],
        tls_disable_ocsp_endpoint_check: raw_options[:options][:tls_disable_ocsp_endpoint_check],
        tls_insecure: raw_options[:options][:tls_insecure],
        w: raw_options[:options][:w],
        wait_queue_timeout: to_span?(raw_options[:options][:wait_queue_timeout]),
        w_timeout: to_span?(raw_options[:options][:w_timeout]),
        zlib_compression_level: raw_options[:options][:zlib_compression_level],
      ),
    }
  end

  private def to_span(value : String) : Time::Span
    arr = value.split(".")
    arr_to_span(arr).not_nil!
  end

  private def to_span?(value : String?) : Time::Span?
    unless value.nil?
      arr = value.split(".")
      arr_to_span arr
    end
  end

  private def arr_to_span(arr : Array(String)) : Time::Span?
    case arr[1]
    when "days"         then Time::Span.new(days: arr[0].to_i)
    when "hours"        then Time::Span.new(hours: arr[0].to_i)
    when "minutes"      then Time::Span.new(minutes: arr[0].to_i)
    when "seconds"      then Time::Span.new(seconds: arr[0].to_i)
    when "milliseconds" then Time::Span.new(nanoseconds: arr[0].to_i * 1_000_000)
    when "nanoseconds"  then Time::Span.new(nanoseconds: arr[0].to_i)
    end
  end
end
