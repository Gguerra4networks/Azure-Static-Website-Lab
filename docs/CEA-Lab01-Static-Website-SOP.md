# CEA Lab 01 — Host a Static Website on Azure Blob Storage
## Full Step-by-Step SOP

Azure CLI · VS Code · PowerShell · Beginner · 30 to 45 minutes

---

## Before You Open VS Code

Open PowerShell on your laptop and check if your lab folder exists:

```powershell
Test-Path "C:\Users\Gguerra\Documents\Giovanni\REPOS\CLOUD ENGINEER\CEA LABS\LAB01\static-website-lab"
```

If `False`, create it:

```powershell
New-Item -ItemType Directory -Path "C:\Users\Gguerra\Documents\Giovanni\REPOS\CLOUD ENGINEER\CEA LABS\LAB01\static-website-lab" -Force
```

Open VS Code pointed at the lab folder:

```powershell
code "C:\Users\Gguerra\Documents\Giovanni\REPOS\CLOUD ENGINEER\CEA LABS\LAB01\static-website-lab"
```

Open the integrated terminal with `Ctrl + backtick`. Confirm location:

```powershell
Get-Location
```

**Should show:** `C:\Users\Gguerra\Documents\Giovanni\REPOS\CLOUD ENGINEER\CEA LABS\LAB01\static-website-lab`

---

## Step 0 — Save Your Variables First

Create the variables file:

```powershell
New-Item -ItemType File -Name "set-vars.ps1"
```

Open `set-vars.ps1` and paste this in:

```powershell
$rg       = "rg-lab01-yourname"     # Replace yourname with your actual name
$location = "eastus"
$storage  = "stlab01yourname"       # Lowercase, 3-24 chars, globally unique
```

Save with `Ctrl + S`. Load the variables:

```powershell
. .\set-vars.ps1
```

Confirm they loaded:

```powershell
echo $rg
echo $storage
```

> **NOTE:** Run `. .\set-vars.ps1` every time you open a new terminal session.

---

## Phase 1 — Sign In to Azure

```powershell
az login --use-device-code
```

A code appears in the terminal. Go to `https://microsoft.com/devicelogin` and enter it. Use InPrivate/Incognito if you have multiple Microsoft accounts.

Confirm the right subscription:

```powershell
az account show --query "{Name:name, ID:id}" -o table
```

---

## Phase 2 — Create the Resource Group

```powershell
az group create --name $rg --location $location
```

Confirm it exists:

```powershell
az group show --name $rg --query name -o tsv
```

---

## Phase 3 — Create the Storage Account

```powershell
az storage account create `
  --name $storage `
  --resource-group $rg `
  --location $location `
  --sku Standard_LRS `
  --kind StorageV2 `
  --https-only true `
  --min-tls-version TLS1_2
```

> **SECURITY:** `--https-only true` blocks all plain HTTP requests. `--min-tls-version TLS1_2` refuses weak encryption. Neither is on by default on older account types. Always add both at creation time.

Confirm the account was created:

```powershell
az storage account show --name $storage --resource-group $rg --query "{Name:name, HTTPS:enableHttpsTrafficOnly, TLS:minimumTlsVersion}" -o table
```

---

## Phase 4 — Enable Static Website Hosting

```powershell
az storage blob service-properties update `
  --account-name $storage `
  --static-website `
  --index-document index.html `
  --404-document 404.html
```

Get your live URL:

```powershell
$endpoint = (az storage account show `
  --name $storage `
  --resource-group $rg `
  --query primaryEndpoints.web `
  --output tsv)
```

```powershell
echo $endpoint
```

---

## Phase 5 — Create and Upload Your HTML Files

Create `index.html`:

```powershell
New-Item -ItemType File -Name "index.html"
```

Open `index.html` in VS Code and paste this in:

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Hello from the Cloud</title>
  <style>
    body { font-family: Arial, sans-serif; background: #f2f2f2;
           display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
    .card { text-align: center; background: white; padding: 60px 80px; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.1); }
    h1 { color: #0078d4; }
  </style>
</head>
<body>
  <div class="card">
    <h1>Hello from the Cloud!</h1>
    <p>This site is hosted on Azure Blob Storage.</p>
    <p>Deployed by: Giovanni Guerra</p>
  </div>
</body>
</html>
```

Save with `Ctrl + S`. Create `404.html`:

```powershell
New-Item -ItemType File -Name "404.html"
```

Open `404.html` and paste this in:

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>404 — Page Not Found</title>
  <style>
    body { font-family: Arial, sans-serif; background: #f2f2f2;
           display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
    .card { text-align: center; background: white; padding: 60px 80px; border-radius: 12px; }
    h1 { color: #cc0000; font-size: 4rem; }
    a  { color: #0078d4; }
  </style>
</head>
<body>
  <div class="card">
    <h1>404</h1>
    <h2>Page Not Found</h2>
    <p><a href="/">Go back home</a></p>
  </div>
</body>
</html>
```

Save with `Ctrl + S`. Upload both files:

```powershell
az storage blob upload-batch `
  --source . `
  --destination '$web' `
  --account-name $storage `
  --auth-mode login
```

---

## Phase 6 — Verify the Site Is Live

Open the site in your browser:

```powershell
Start-Process $endpoint
```

Check the status code:

```powershell
Invoke-WebRequest -Uri $endpoint -UseBasicParsing | Select-Object StatusCode
```

You should see `StatusCode: 200`.

Confirm your files uploaded:

```powershell
az storage blob list `
  --container-name '$web' `
  --account-name $storage `
  --query "[].name" `
  --output tsv
```

---

## Phase 7 — Push to GitHub

Initialize the repo:

```powershell
git init
```

```powershell
git add .
```

```powershell
git commit -m "Lab 01: Static website deployed on Azure Blob Storage"
```

```powershell
git remote add origin https://github.com/Gguerra4networks/Azure-static-website-lab.git
```

```powershell
git branch -M main
```

```powershell
git push -u origin main
```

---

## Clean Up

```powershell
az group delete --name $rg --yes --no-wait
```

This removes every resource at once. The `--no-wait` flag runs it in the background.

---

## Troubleshooting

| Problem | Fix |
|---|---|
| `az` command not found | Azure CLI not installed. Download from learn.microsoft.com/cli/azure |
| Storage account name already taken | Names must be globally unique. Add numbers to the end of yours. |
| Upload fails with auth error | Add `--auth-mode login` to the upload command |
| Site returns 404 on the endpoint URL | Check that the `$web` container exists and files were uploaded |
| Status code is not 200 | Wait 30 seconds and try again — propagation sometimes takes a moment |
| Variables not loading | Make sure you ran `. .\set-vars.ps1` in the current terminal session |

---

## What You Built

| Resource | Purpose |
|---|---|
| Resource group `rg-lab01-yourname` | Container for all lab resources |
| Storage account `stlab01yourname` | Hosts the static website files |
| `$web` container | Public blob container that serves HTML to the internet |
| `index.html` | Main page returned at the root URL |
| `404.html` | Custom error page for missing routes |
| `set-vars.ps1` | Variable file that makes every session faster |
