# Cloud Engineering Accelerator — Lab 01
# Azure Static Website Hosting
# LinkedIn Post Strategy — 4 Posts

Thumbnails for each post are in /assets/thumbnails/

---

## POST 1 — Loom Video Walkthrough
### Thumbnail: post1-loom.svg

You don't need a server to host a website.

In this lab I deployed a live site using nothing but Azure Blob Storage and the CLI. No VM. No web server. No patching.

One storage account. Two HTML files. A public endpoint. That's it.

Real teams use this same setup for portfolio sites, docs pages, and marketing sites. And it runs for less than a cup of coffee a month.

🎥 Full walkthrough → [Loom link]

Drop a 🔁 if you're building your cloud portfolio this year.

#Azure #CloudEngineering #AzureCLI #Serverless #BlobStorage #StaticWebsite #AZ104 #LabLife

---

## POST 2 — GitHub Repository
### Thumbnail: post2-github.svg

No server. No VM. No framework. Just the Azure CLI and a storage account.

Lab 01 is on GitHub. Here's what's inside:

✅ Storage account creation with HTTPS and TLS 1.2 locked in from the start
✅ Static website hosting enabled entirely from the CLI
✅ File upload, live endpoint check, and status 200 confirmed
✅ Full cost breakdown so there are no surprise bills
✅ Optional CDN upgrade path when you're ready to scale

10 minutes to deploy. Under $5 a month to run.

⭐ Star it if it helps.

🔗 GitHub link in the comments.

#Azure #AzureCLI #BlobStorage #StaticWebsite #GitHub #CloudEngineering #AZ104 #ITPortfolio

---

## POST 3 — One Thing I Learned
### Thumbnail: post3-learned.svg

HTTPS is not on by default. You have to turn it on yourself.

Two flags at account creation time:

--https-only true blocks plain HTTP before it ever reaches your files.
--min-tls-version TLS1_2 cuts off connections using weak, outdated encryption.

Skip them and your site runs wide open. No warning. No alert. Nothing.

Thirty seconds up front. Never worry about it again.

You only catch stuff like this when you're building it yourself instead of clicking through a portal that hides all the flags.

What's a security default you found off when it should have been on? 👇

#Azure #CloudSecurity #BlobStorage #HTTPS #AzureCLI #CloudEngineering #LabLife #AZ104

---

## POST 4 — What I Would Do Differently
### Thumbnail: post4-different.svg

I'd write a set-vars.ps1 file before running anything.

PowerShell variables die when you close the terminal. Mid-lab I had to dig back through the SOP, retype everything, and hope I remembered the storage account name correctly.

Simple fix:

$rg       = "rg-lab01-giovanni"
$location = "eastus"
$storage  = "stlab01giovanni47"

Save it. Run . .\set-vars.ps1 at the start of every session. Done.

Tiny habit. Saves a lot of frustration.

What's a small workflow fix that made your labs run smoother? 👇

#Azure #AzureCLI #PowerShell #CloudEngineering #LabLife #LessonsLearned #BlobStorage #AZ104

---

## POSTING NOTES

- Post 1: Upload post1-loom.svg as the post image. Replace [Loom link] with your actual URL.
- Post 2: Paste the repo URL into LinkedIn first, wait for thumbnail, delete URL, paste post text. Drop real link in first comment.
  Repo: https://github.com/Gguerra4networks/host_a_Static_Website
- Post 3: Upload post3-learned.svg as the post image.
- Post 4: Upload post4-different.svg as the post image.
- Tag @Microsoft Azure on Posts 1 and 2 for extra reach.
- Space posts 2 to 3 days apart for consistent feed presence.
