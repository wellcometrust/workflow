# Digital Workflow

The infrastructure for the Wellcome Collection digital workflow services.

## Working in AWS via Azure AD sign-in

In order to work with Wellcome Azure AD to sign into the Workflow AWS account you will need these URLS.

To request a new account contact Wellcome devs in Slack in #wc-platform.

### Reset Password

https://passwordresest.microsoftonline.com/

### AWS CLI Credentials

To sign in to the AWS CLI (visit and click on AWS - Digital Platform)

http://wellcomecloud.org/

To assume roles in the console:

https://chrome.google.com/webstore/detail/aws-extend-switch-roles/jpmkfafbacpgapdghgdpembnojdlgkdl

With configuration:

```
[workflow-read_only]
role_arn = arn:aws:iam::299497370133:role/workflow-read_only
region = eu-west-1
color = 00ACB6

[workflow-support]
role_arn = arn:aws:iam::299497370133:role/workflow-support
region = eu-west-1
color = 00ACB6

[workflow-developer]
role_arn = arn:aws:iam::299497370133:role/workflow-developer
region = eu-west-1
color = 00ACB6

[workflow-admin]
role_arn = arn:aws:iam::299497370133:role/workflow-admin
region = eu-west-1
color = 0000ff
```

### CLI Credentials

To gather CLI credentials use:

https://www.npmjs.com/package/aws-azure-login
