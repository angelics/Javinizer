#!/bin/sh
umask 000

# Add Persistent jvSettings Configuration Capability
if [ -f /config/jvSettings.json ]; then
  echo "Using existing jvSettings config file."
else
  echo "Copying default jvSettings file."
  mkdir -p /config && pwsh -c "mv (Join-Path (Get-InstalledModule Javinizer).InstalledLocation -ChildPath jvSettings.json) /config/jvSettings.json"
  echo "[info] creating softlink from default config file to /config"
  pwsh -c "ln -s /config/jvSettings.json (Join-Path (Get-InstalledModule Javinizer).InstalledLocation -ChildPath jvSettings.json)"
fi

# Add Persistent jvUncensor Configuration Capability
if [ -f /config/jvUncensor.csv ]; then
  echo "Using existing jvUncensor config file."
else
  echo "Copying default jvUncensor file."
  mkdir -p /config && pwsh -c "mv (Join-Path (Get-InstalledModule Javinizer).InstalledLocation -ChildPath jvUncensor.csv) /config/jvUncensor.csv"
  echo "[info] creating softlink from default config file to /config"
  pwsh -c "ln -s /config/jvUncensor.csv (Join-Path (Get-InstalledModule Javinizer).InstalledLocation -ChildPath jvUncensor.csv)"
fi

# Add Persistent jvHistory Configuration Capability
if [ -f /logs/jvHistory.csv ]; then
  echo "Using existing jvHistory config file."
else
  echo "Copying default jvHistory file."
  mkdir -p /logs && pwsh -c "mv (Join-Path (Get-InstalledModule Javinizer).InstalledLocation -ChildPath jvHistory.csv) /logs/jvHistory.csv"
  echo "[info] creating softlink from default logs file to /logs"
  pwsh -c "ln -s /logs/jvHistory.csv (Join-Path (Get-InstalledModule Javinizer).InstalledLocation -ChildPath jvHistory.csv)"
fi

# Add Persistent jvLog Configuration Capability
if [ -f /logs/jvLog.log ]; then
  echo "Using existing jvLog config file."
else
  echo "Copying default jvLog file."
  mkdir -p /logs && pwsh -c "mv (Join-Path (Get-InstalledModule Javinizer).InstalledLocation -ChildPath jvLog.log) /logs/jvLog.log"
  echo "[info] creating softlink from default logs file to /logs"
  pwsh -c "ln -s /config/jvLog.log (Join-Path (Get-InstalledModule Javinizer).InstalledLocation -ChildPath jvLog.log)"
fi

# Add Persistent jvGenres Configuration Capability
if [ -f /config/jvGenres.csv ]; then
  echo "Using existing jvGenres config file."
else
  echo "Copying default jvGenres file."
  mkdir -p /config && pwsh -c "mv (Join-Path (Get-InstalledModule Javinizer).InstalledLocation -ChildPath jvGenres.csv) /config/jvGenres.csv"
  echo "[info] creating softlink from default config file to /config"
  pwsh -c "ln -s /config/jvGenres.csv (Join-Path (Get-InstalledModule Javinizer).InstalledLocation -ChildPath jvGenres.csv)"
fi

# Add Persistent jvTags Configuration Capability
if [ -f /config/jvTags.csv ]; then
  echo "Using existing jvTags config file."
else
  echo "Copying default jvTags file."
  mkdir -p /config && pwsh -c "mv (Join-Path (Get-InstalledModule Javinizer).InstalledLocation -ChildPath jvTags.csv) /config/jvTags.csv"
  echo "[info] creating softlink from default config file to /config"
  pwsh -c "ln -s /config/jvTags.csv (Join-Path (Get-InstalledModule Javinizer).InstalledLocation -ChildPath jvTags.csv)"
fi

# Add Persistent jvThumbs Configuration Capability
if [ -f /config/jvThumbs.csv ]; then
  echo "Using existing jvThumbs config file."
else
  echo "Copying default jvThumbs file."
  mkdir -p /config && pwsh -c "mv (Join-Path (Get-InstalledModule Javinizer).InstalledLocation -ChildPath jvThumbs.csv) /config/jvThumbs.csv"
  echo "[info] creating softlink from default config file to /config"
  pwsh -c "ln -s /config/jvThumbs.csv (Join-Path (Get-InstalledModule Javinizer).InstalledLocation -ChildPath jvThumbs.csv)"
fi

# Start the powershell universal server
/home/Universal/Universal.Server
