#HelloWorld Workflow Starter

require 'aws/decider'
require_relative 'utils'
require_relative 'hello_workflow'

#Get workflow client

my_workflow_client = AWS::Flow.workflow_client(@swf.client, @domain) {
	{ :from_class => "HelloWorldWorkflow" }
}

#Start workflow!

puts "Starting workflow client...:)"
e = my_workflow_client.start_execution("AWS Flow Framework for Ruby")
