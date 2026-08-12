# LinkedIn Posts: Cloud Engineering Accelerator, Lab 01

Three posts, meant to go out as a short series. Attach the architecture and comparison chart (Static_Website_Architecture_and_Domain_Comparison.png) to Post 1.

No em dashes anywhere below, by request. Copy and paste as-is.

---

## Post 1: The Announcement

Deployed my first fully serverless website this week. No virtual machine. No web server software. No patching, ever.

Just Azure Blob Storage, configured to serve HTML directly to the public internet, HTTPS included by default.

The build:
- Storage account with HTTPS-only transfer and TLS 1.2 minimum enforced from creation
- Public access scoped to exactly one container, everything else in the account stays private
- Uploads done with my own identity, not a shared account key
- Entire thing scripted with the Azure CLI inside VS Code, nothing clicked through a portal

Real cost to run this full time at personal traffic levels: under a dollar a month.

Architecture diagram and full cost breakdown attached.

#Azure #CloudEngineering #Serverless #PaaS #AzureCLI #CloudSecurity

---

## Post 2: The Troubleshooting Story

Deployed the storage account. Uploaded the file. Opened the site. Got a 403.

The file was there. The container was configured correctly. So why blocked?

Azure's newer storage accounts default public blob access to false now, a genuinely good security default, but it silently breaks static website hosting unless you explicitly turn it back on for that specific use case.

One flag fixed it:

```
az storage account create ... --allow-blob-public-access true
```

Small reminder that cloud defaults change over time, and a lab written even a year ago can hit a wall that wasn't there when it was written. Worth always reading the actual response from a create command, not just assuming it matched what you expected.

#Azure #CloudSecurity #Troubleshooting #AzureCLI #CloudEngineering

---

## Post 3: The Identity Problem

Second real issue this week, trying to grant myself permission to upload to my own storage account.

```
az role assignment create --assignee myemail@example.com ...
```

Result: "Cannot find user or service principal in graph database."

The account was completely real and already signed in. The email-based lookup itself was the problem, not the account.

Fix: skip the lookup entirely, use the actual Object ID instead.

```
az ad signed-in-user show --query id -o tsv
az role assignment create --assignee-object-id <that-id> --assignee-principal-type User ...
```

Also learned the hard way that a role assignment reporting success doesn't mean it works immediately. RBAC changes take real time to propagate, sometimes a couple of minutes, not instant like the CLI output makes it look.

#Azure #IAM #CloudSecurity #AzureCLI #CloudEngineering #Troubleshooting

---

# Skool Post

Just shipped Lab 01 of the Cloud Engineering Accelerator series: a fully serverless static website, hosted entirely on Azure Blob Storage.

No VM. No web server. No patching. HTTPS by default. Locked down from the start, HTTPS-only transfer, TLS 1.2 minimum, and public access scoped to exactly one container instead of the whole account.

Hit two real problems along the way worth sharing:

1. Azure's newer storage accounts block public blob access by default now, which silently breaks static website hosting unless you turn it back on explicitly.
2. Granting myself upload permission failed with a Graph lookup error, even though the account was completely valid. Using the account's actual Object ID instead of its email fixed it.

Full SOP, architecture diagram, cost breakdown, and the complete troubleshooting log are in the GitHub repo, linked below.

Anyone else run into the public access default change recently? Curious how many people got caught by that one.

[GitHub link]
