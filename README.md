# Boufin Personas: Terraform

These repositories as a collection served to show a live demo of my software architecture working.
The implementation was made on a hurry in everyone of this repositories, which made me fail on publish one of them as it had some conflicts. However, I'll upload the missing service when I refactor it to work properly again.

How to make this work? First fork every repo, and clone this one to your local. Then change the variables of this configuration to match your ownership, e.g. I have these repos owned by the @Axomic-dev organization, so I put that name onto `REPO_OWNER`, then, you must provide the variables required for this configuration. Most importantly, your copies of the \<secret> API, and a matching API_KEY for it.

Next up, you must have a GCP project, from which borrow the name to add it onto the variables. That GCP project must have permissions for Cloud Run, and Cloud Functions to continuous deployment. And of course, you may need an authentication method to make changes on that project, such a key on a JSON file, or similar.

After everything is set, then you run the following commands:

```
terraform init

terraform plan

# Check that everything is ready to upload

terraform apply
```

And now you are all set, if you look at your Cloud Run instance, you should find the report-manager instance, which is your endpoint to connect with.

Now, via cURL, postman or even on your frontend you can request the creation of a new report with a POST request on `/create`, and check for its completion, or recover the report when it's done with a GET request on `/report/<POST_OUTPUT>`.
