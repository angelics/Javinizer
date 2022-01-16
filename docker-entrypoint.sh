#!/bin/sh
umask 000

# Add Persistent jvSettings Configuration Capability
if [ -f /config/jvSettings.json ]; then
  echo "Using existing jvSettings config file."
else
  echo "Copying default jvSettings file."
  cp /root/.local/share/powershell/Modules/Javinizer/2.5.10/jvSettings.json /config/jvSettings.json
fi

# Add Persistent jvUncensor Configuration Capability
if [ -f /config/jvUncensor.csv ]; then
  echo "Using existing jvUncensor config file."
else
  echo "Copying default jvUncensor file."
  cp /root/.local/share/powershell/Modules/Javinizer/2.5.10/jvUncensor.csv /config/jvUncensor.csv
fi

# Add Persistent jvHistory Configuration Capability
if [ -f /logs/jvHistory.csv ]; then
  echo "Using existing jvHistory config file."
else
  echo "Copying default jvHistory file."
  cp /root/.local/share/powershell/Modules/Javinizer/2.5.10/jvHistory.csv /logs/jvHistory.csv
fi

# Add Persistent jvLog Configuration Capability
if [ -f /logs/jvLog.log ]; then
  echo "Using existing jvLog config file."
else
  echo "Copying default jvLog file."
  cp /root/.local/share/powershell/Modules/Javinizer/2.5.10/jvLog.log /logs/jvLog.log
fi

# Add Persistent jvGenres Configuration Capability
if [ -f /config/jvGenres.csv ]; then
  echo "Using existing jvGenres config file."
else
  echo "Copying default jvGenres file."
  cp /root/.local/share/powershell/Modules/Javinizer/2.5.10/jvGenres.csv /config/jvGenres.csv
fi

# Add Persistent jvTags Configuration Capability
if [ -f /config/jvTags.csv ]; then
  echo "Using existing jvTags config file."
else
  echo "Copying default jvTags file."
  cp /root/.local/share/powershell/Modules/Javinizer/2.5.10/jvTags.csv /config/jvTags.csv
fi

# Add Persistent jvThumbs Configuration Capability
if [ -f /config/jvThumbs.csv ]; then
  echo "Using existing jvThumbs config file."
else
  echo "Copying default jvThumbs file."
  cp /root/.local/share/powershell/Modules/Javinizer/2.5.10/jvThumbs.csv /config/jvThumbs.csv
fi

# Start the powershell universal server
/home/Universal/Universal.Server
