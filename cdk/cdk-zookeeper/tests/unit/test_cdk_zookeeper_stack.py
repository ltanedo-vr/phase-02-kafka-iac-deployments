import aws_cdk as core
import aws_cdk.assertions as assertions

from cdk_zookeeper.cdk_zookeeper_stack import CdkZookeeperStack

# example tests. To run these tests, uncomment this file along with the example
# resource in cdk_zookeeper/cdk_zookeeper_stack.py
def test_sqs_queue_created():
    app = core.App()
    stack = CdkZookeeperStack(app, "cdk-zookeeper")
    template = assertions.Template.from_stack(stack)

#     template.has_resource_properties("AWS::SQS::Queue", {
#         "VisibilityTimeout": 300
#     })
