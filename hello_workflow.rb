#HelloWorld Workflow

require_relative 'utils'
require_relative './hello_activity'

class HelloWorldWorkflow
	extend AWS::Flow::Workflows

#Creating workflow instance, passing workflow method name and providing opt vals

	workflow(:hello_workflow) do |opts|
		opts.version = "1"
		opts.task_list = $TASK_LIST
		opts.execution_start_to_close_timeout = 3600
	end

#Define workflow passed to AWS::Flow::Workflows#workflow method

	def hello_workflow(name)
		activity.hello_activity(name)
	end

#Create an activity client	
	activity_client(:activity) {
		{ :from_class => "HelloWorldActivity" }
	}
end

#Create a workflow worker that can start the workflow

workflow_worker = AWS::Flow::WorkflowWorker.new(
	@swf.client, @domain, $TASK_LIST, HelloWorldWorkflow)

#Start workflow worker

workflow_worker.start if __FILE__ == $0

