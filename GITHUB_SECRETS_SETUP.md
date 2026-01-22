# Adding GitHub Secrets for Environment Variables

Your `.env` file contains sensitive Supabase credentials that shouldn't be committed to GitHub. The CI/CD workflow now needs these values as GitHub Secrets.

## Required Secrets

You need to add the following secrets to your GitHub repository:

1. **SUPABASE_URL** - Your Supabase project URL
2. **SUPABASE_ANON_KEY** - Your Supabase anonymous/publishable key

## How to Add Secrets

### Step 1: Go to Repository Settings

1. Open your repository on GitHub: `https://github.com/souravDAS0/QuoteVault`
2. Click **Settings** tab (top navigation)
3. In the left sidebar, click **Secrets and variables** → **Actions**

### Step 2: Add Each Secret

For each secret:

1. Click **New repository secret** (green button)
2. Enter the **Name** (exactly as shown below)
3. Paste the **Value** from your local `.env` file
4. Click **Add secret**

#### Secret 1: SUPABASE_URL

- **Name:** `SUPABASE_URL`
- **Value:** `https://fdefvbqkxvqvmqdkpppg.supabase.co`

#### Secret 2: SUPABASE_ANON_KEY

- **Name:** `SUPABASE_ANON_KEY`
- **Value:** `sb_publishable_FmDQrjlHB8WPaPD5QLjymQ_zoIe3OMT`

## Verification

After adding the secrets:

1. Go to **Actions** tab
2. Find the failed workflow run (if any)
3. Click **Re-run all jobs**

OR

Make a small change and push to trigger a new build.

## How It Works

The workflow now includes this step before building:

```yaml
- name: Create .env file
  run: |
    cat > .env << EOF
    SUPABASE_URL=${{ secrets.SUPABASE_URL }}
    SUPABASE_ANON_KEY=${{ secrets.SUPABASE_ANON_KEY }}
    DEBUG=false
    EOF
```

This creates the `.env` file dynamically during the build process using your GitHub Secrets.

## Security Notes

✅ **Safe** - Secrets are encrypted and only exposed to your workflows
✅ **Not in logs** - Secret values are masked in workflow logs
✅ **Protected** - Secrets are not accessible to fork repositories

## Next Steps

1. Add the two secrets to your GitHub repository (see instructions above)
2. Wait for the current workflow to finish (or cancel it)
3. The next push will build successfully with the environment variables

---

**Important:** Make sure the secret names match EXACTLY (case-sensitive):

- `SUPABASE_URL` (not `supabase_url` or `SUPABASE_URL_`)
- `SUPABASE_ANON_KEY` (not `SUPABASE_KEY` or `ANON_KEY`)
