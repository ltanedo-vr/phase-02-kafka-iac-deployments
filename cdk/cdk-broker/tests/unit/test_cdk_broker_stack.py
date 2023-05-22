import aws_cdk as core
import aws_cdk.assertions as assertions

from cdk_broker.cdk_broker_stack import CdkBrokerStack

# example tests. To run these tests, uncomment this file along with the example
# resource in cdk_broker/cdk_broker_stack.py
def test_sqs_queue_created():
    app = core.App()
    stack = CdkBrokerStack(app, "cdk-broker")
    template = assertions.Template.from_stack(stack)

#     template.has_resource_properties("AWS::SQS::Queue", {
#         "VisibilityTimeout": 300
#     })
