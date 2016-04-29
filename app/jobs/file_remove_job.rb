class FileRemoveJob < ActiveJob::Base
  queue_as :default

  def perform path
    FileUtils.rm path if File.exist? path
  end
end
