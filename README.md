# n8n Instance for Railway

This is a self-hosted n8n instance configured for Railway deployment.

## What is this?

This deploys a full n8n workflow automation platform to Railway with:
- ✅ Self-hosted (FREE)
- ✅ Full API access
- ✅ Persistent storage via Railway volumes
- ✅ HTTPS enabled automatically
- ✅ Unlimited workflows

## Deployment Steps

### 1. Create GitHub Repository

```bash
cd n8n-instance
git init
git add .
git commit -m "Initial n8n instance setup"
gh repo create n8n-instance --public --source=. --push
```

Or manually:
1. Go to https://github.com/new
2. Name: `n8n-instance`
3. Make it public
4. Push this code

### 2. Deploy to Railway

1. Go to https://railway.app/new
2. Click "Deploy from GitHub repo"
3. Select `n8n-instance` repository
4. Railway will auto-detect Dockerfile and deploy
5. **Add a volume for persistence**:
   - Go to your n8n service
   - Click "Variables" tab
   - Add a new volume:
     - Mount path: `/home/node/.n8n`
6. Wait for deployment (~2-3 minutes)

### 3. Access Your n8n Instance

Once deployed:
1. Railway will give you a URL like: `https://your-n8n-instance.up.railway.app`
2. Visit that URL
3. Create your admin account (first user becomes admin)

### 4. Generate API Key

1. Login to your n8n instance
2. Go to **Settings** → **n8n API**
3. Click **"Create an API key"**
4. Copy the key (format: `n8n_api_xxxxxxxxxxxxx`)

### 5. Update workflow-generator .env

Add to `workflow-generator/.env`:
```bash
N8N_API_URL=https://your-n8n-instance.up.railway.app
N8N_API_KEY=n8n_api_xxxxxxxxxxxxx
```

## Testing the Setup

From the workflow-generator directory:
```bash
node test-services.js
```

Should show:
- ✅ n8n API Service: PASSED

## What You Get

- **n8n Dashboard**: Full workflow editor
- **API Access**: Create/update/delete workflows programmatically
- **Webhook URLs**: For triggering workflows
- **500+ Integrations**: All n8n nodes available

## Cost

- **Railway**: Free tier includes 500 hours/month (enough for 24/7 operation)
- **n8n**: Community edition is 100% free

## Troubleshooting

### "Command 'node' not found" Error
This happens if Railway isn't properly building from the Dockerfile:
1. Make sure `railway.json` is present in the n8n-instance directory
2. In Railway dashboard, go to Settings → Build → ensure "Builder" is set to "Dockerfile"
3. Redeploy from Railway dashboard

### Can't access n8n URL
- Check Railway logs in the dashboard
- Ensure deployment succeeded (should show "Server started on port...")
- Wait 2-3 minutes for first deployment

### Container keeps restarting
1. Check Railway logs for specific errors
2. Ensure you've added a volume:
   - Service → Settings → Volumes
   - Mount path: `/home/node/.n8n`
3. Check environment variables are set correctly

### API key not working
- Make sure you're using the full URL including `https://`
- Verify API key is copied correctly (no extra spaces)
- Ensure n8n API is enabled in Settings

### Lost data after restart
- **Critical**: Add a Railway volume mounted to `/home/node/.n8n`
- Without this, all workflows and settings are lost on restart

## Next Steps

Once deployed, you can:
1. Create workflows in the n8n UI
2. Use the workflow-generator to auto-generate workflows
3. Use Playwright to record demo videos of workflows
