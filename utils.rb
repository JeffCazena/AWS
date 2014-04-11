#Set up Amazon Simple Workflow

require 'aws/decider'

#Values needed
$DOMAIN_NAME = "HelloWorld"
$TASK_LIST = "hello_world_task_list"

#Get user's AWS access info
config_file = File.open('aws-config.txt') { |f| f.read }
AWS.config(YAML.load(config_file))

#Get an SWF instance
@swf = AWS::SimpleWorkflow.new

#Set domain
begin
	@domain = @swf.domains[$DOMAIN_NAME]
	@domain.status
rescue AWS::SimpleWorkflow::Errors::UnknownResourceFault => e
	@domain = @swf.domains.create($DOMAIN_NAME, "10")
end
