# Deploy n8n to Railway - Quick Guide

## ✅ Pre-Deployment Checklist

Make sure these files are in your `n8n-instance` directory:
- [ ] `Dockerfile` - Updated with proper startup configuration
- [ ] `start.sh` - Handles Railway's PORT variable
- [ ] `railway.json` - Tells Railway to use Dockerfile
- [ ] `README.md` - Full documentation

## 🚀 Deployment Steps

### Option 1: Deploy from GitHub (Recommended)

1. **Push to GitHub:**
   ```bash
   cd n8n-instance
   git init
   git add .
   git commit -m "n8n Railway deployment"
   gh repo create n8n-railway --public --source=. --push
   ```

2. **Deploy to Railway:**
   - Go to https://railway.app/new
   - Click "Deploy from GitHub repo"
   - Select your `n8n-railway` repository
   - Railway will auto-detect the Dockerfile and start building
   - Wait for build to complete (~2-3 minutes)

3. **Add Persistent Volume (IMPORTANT):**
   - Click on your n8n service
   - Go to "Settings" → "Volumes"
   - Click "New Volume"
   - Mount path: `/home/node/.n8n`
   - Click "Add"
   - Service will automatically restart

4. **Generate Public URL:**
   - In your service, go to "Settings"
   - Under "Networking" → "Public Networking"
   - Click "Generate Domain"
   - Copy the URL (e.g., `https://your-app.up.railway.app`)

### Option 2: Deploy from Railway CLI

```bash
cd n8n-instance

# Install Railway CLI (if not installed)
npm i -g @railway/cli

# Login to Railway
railway login

# Initialize project
railway init

# Deploy
railway up
```

## ✅ Post-Deployment Verification

### 1. Check Logs
In Railway dashboard:
- Click on your service
- Go to "Deployments" tab
- Click the latest deployment
- Check logs for: `Server started on port 5678`

If you see errors:
- Look for "Command 'node' not found" → Rebuild from scratch
- Look for permission errors → They're just warnings, ignore them
- Look for port binding errors → Check if volume is mounted

### 2. Access n8n
- Open the Railway-generated URL in your browser
- You should see the n8n setup page
- Create your admin account (first user = admin)

### 3. Generate API Key
1. Login to your n8n instance
2. Click your avatar (top right)
3. Go to "Settings"
4. Navigate to "n8n API" section
5. Click "Create an API key"
6. Copy the key (format: `n8n_api_xxxxxxxxxxxxx`)

### 4. Test API Connection
Update `workflow-generator/.env`:
```bash
N8N_API_URL=https://your-app.up.railway.app
N8N_API_KEY=n8n_api_xxxxxxxxxxxxx
```

Test it:
```bash
cd ../workflow-generator
node test-services.js
```

Should show: ✅ n8n API Service: PASSED

## 🔧 Common Issues & Fixes

### Issue: "Command 'node' not found"
**Fix:**
1. In Railway dashboard, go to your service settings
2. Under "Build" → ensure "Builder" is set to "Dockerfile"
3. Click "Redeploy" button

### Issue: Container keeps crashing/restarting
**Fix:**
1. Add a volume at `/home/node/.n8n` (see step 3 above)
2. Check Railway logs for specific error messages
3. Ensure you're on Railway's free tier with enough resources

### Issue: Can't access n8n URL
**Fix:**
1. Wait 2-3 minutes after deployment
2. Check deployment logs show "Server started"
3. Try accessing with `/healthz` endpoint: `https://your-app.up.railway.app/healthz`
4. Ensure "Public Networking" is enabled in settings

### Issue: Workflows disappear after restart
**Fix:**
- You MUST add a volume at `/home/node/.n8n`
- Without it, data is ephemeral and lost on restart

## 📊 Expected Railway Resource Usage

**Free Tier Limits:**
- 500 execution hours/month
- $5 credit/month
- n8n typically uses ~$2-3/month running 24/7

**Resource Usage:**
- CPU: ~0.1 vCPU (idle), up to 0.5 vCPU (active)
- Memory: ~200-300 MB
- Storage: ~100-500 MB (with volume)

## 🎉 Success Indicators

You'll know it's working when:
1. ✅ Railway logs show: "Server started on port 5678"
2. ✅ You can access the n8n web interface
3. ✅ You can create an admin account
4. ✅ API test passes in workflow-generator
5. ✅ Workflows persist after service restart

## Next Steps

Once deployed successfully:
1. ✅ Create your first workflow in n8n UI
2. ✅ Use workflow-generator to auto-create workflows
3. ✅ Set up webhooks for external integrations
4. ✅ Configure custom domains (optional)

