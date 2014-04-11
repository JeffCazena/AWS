#HelloWorld Activity

require_relative 'utils'

class HelloWorldActivity
	extend AWS::Flow::Activities

#Creating activity instance, passing the activity method name and providing vals

	activity(:hello_activity) do |opts|
		opts.default_task_list = $TASK_LIST
		opts.default_task_schedule_to_start_timeout = 30
		opts.default_task_start_to_close_timeout = 30 
		opts.version = "v3"
	end

#Defining activity that was passed to the AWS::Flow::Activities activity method

	def hello_activity(name)
		puts "Hello, #(name)!"
	end
end

#Creating activity worker that can start the activity 
activity_worker = AWS::Flow::ActivityWorker.new(
	@swf.client, @domain, $TASK_LIST, HelloWorldActivity)

#Start activity worker if this file is run directly like:
#ruby hello_activity.rb &

activity_worker.start if __FILE__ == $0
