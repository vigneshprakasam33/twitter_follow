#Delayed::Job.destroy_failed_jobs = false
# config/initializers/delayed_job_config.rb
Delayed::Worker.destroy_failed_jobs = false
silence_warnings do
  Delayed::Worker.logger = Logger.new(File.join(Rails.root, 'log', 'dj.log'))
  Delayed::Job.const_set("MAX_ATTEMPTS", 3)
end

#3.times do |n|
#  worker = Delayed::Worker.new
#  worker.name = 'worker-' + n.to_s
#  worker.start
#end