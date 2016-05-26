require "mp3info"

class ItemUploader < Shrine
  MAX_SIZE_MB = 100

  Attacher.validate do
    validate_max_size MAX_SIZE_MB*1024*1024
  end

  def extract_metadata(io, context)
    metadata = super
    duration = extract_duration io
    metadata['duration'] = duration if duration
    metadata
  end

  def extract_duration io
    duration =
      begin
        Mp3Info.open io.to_io do |mp3|
          mp3.length.to_i
        end
      rescue Mp3InfoError => e
      end

    io.rewind
    duration
  end
end
