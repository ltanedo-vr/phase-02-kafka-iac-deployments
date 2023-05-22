# phase-02-kafka-iac-deployments
My solution to the kafaka-cluster deployment goal in phase 2 of the VR accelerator program

## CFN Thoughts
- how to make "user-data" script outside of CFN-tempalte
- in CFN, need to fix SSH problem, to use termianl (like Christina)
- in terraform, need to hide env vars, and not hard-code values (put in seperate file)
- in terraform, "cloudformation" tutorial suggests baking in CFN template as JSON (this can't be correct, and there must be a different way)
- CDK, very straightforard (need to be careful deleting stacks in gui-console, deleting CDK-tools makes the actual instance, un-deletable)

##Takeaways
- CDK is very straightforward, pythonic (class-wise) and is probably the future (I've heard in VR)
- Terraform is ugly b/c of json, but is probably powerful for cross-cloud (like aws -> azure)
- I don't like terraform but we probably have to know it
- We probably have to know CFN enough (so that we know what the CDK will compile down to)  

- Lloyd
