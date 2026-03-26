# 🔱 NEXUS PERSISTENT CONTEXT (V1.0)
# This file ensures ALL optimizations persist across conversations.
# Every new Antigravity session reads this to restore full context.

## SYSTEM IDENTITY
- User: Israel Realivazquez (PhD Candidate)
- Hardware: 4GB RAM, 64GB eMMC, Windows 11
- Accounts: israel.realivazquez@gmail.com (Claude/redactor), israel.realivazquez2811@gmail.com (all other IAs)
- Chrome Profile: "Profile 6" (I. NEXUS OMEGA)

## ACTIVE INFRASTRUCTURE
- Nexus Turbo: `23_nexus_turbo.ps1` runs at boot via Task Scheduler
- RAM Guardian: Scheduled task kills processes when RAM < 300MB
- Service Watchdog: `nexus_watchdog.py` auto-restarts Bridge + Crawler
- Silent Crawler: Harvests ChatGPT/Gemini/Claude every 15 min
- Bridge Server: localhost:8000 receives Nexus Link extension data
- Git Hooks: Auto-backup thesis on every commit (pre-commit + post-commit)
- Cold Backup: `23_nexus_cold_backup.ps1` pushes to GitHub
- Chrome TURBO shortcut on Desktop with speed flags

## CLOUD VMS
- GitHub Codespaces: devcontainer.json ready, Codespace Brain server script ready
- Oracle ARM: Auto-provisioner at `nexus_oracle_provisioner.py`
- GCP e2-micro: Available via Cloud Shell (60h/week)

## OPTIMIZATIONS APPLIED
- 18+ Windows services permanently disabled
- 10+ UWP bloatware apps removed
- Visual effects + transparency OFF
- High Performance power plan + USB suspend disabled
- Chrome Memory Saver enabled
- Process priorities elevated (chrome, python, Code = AboveNormal)
- Virtual Memory optimized
- DNS cache flushed regularly

## KEY FILES
- Master Thesis Hub: D:\nexus_work\MASTER_THESIS_HUB_V3.md
- Thesis Index: ESTRUCTURA_THESIS_NEXUS.md (in Drive)
- Credential Vault: NEXUS_CREDENTIAL_VAULT.md
- Extension: C:\Users\Lenovo\antigravity_link_ext\
- YouTube URLs: D:\nexus_work\youtube_discovered_urls.txt (44 videos)

## PENDING ITEMS
- [ ] Activate Codespace Brain (create Codespace + run server)
- [ ] Oracle ARM provisioning (keep auto-retrying)
- [ ] Google Docs API live sync
- [ ] Perplexity/NotebookLM full harvest
- [ ] Scholar auto-BibTeX lookup
- [ ] Whisper dictation in cloud
- [ ] n8n self-hosted automation
