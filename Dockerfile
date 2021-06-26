FROM python:3.9.2-buster

# Add docker entrypoint script
ADD docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

# Install dependencies
RUN apt-get update \
    && apt-get install -y unzip wget

# Create directories
RUN mkdir -p /home/data/Repository/.universal \
    && mkdir -p /home/Universal

# Add dashboard files
ADD src/Javinizer/Universal/Repository/javinizergui.ps1 /home/data/Repository
ADD src/Javinizer/Universal/Repository/dashboards.ps1 /home/data/Repository/.universal

# Download powershell universal
WORKDIR /home
RUN wget https://imsreleases.blob.core.windows.net/universal/production/1.5.13/Universal.linux-x64.1.5.13.zip

# Extract powershell universal to /home/Universal
RUN unzip -q /home/Universal.linux-x64.1.5.13.zip -d /home/Universal/ \
    && chmod +x /home/Universal/Universal.Server \
    && rm /home/Universal.linux-x64.1.5.13.zip

# Install mediainfo
RUN apt-get install -y mediainfo

# Install pwsh
RUN wget https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && apt-get update \
    && apt-get install -y powershell \
    && rm -rf /var/lib/apt/lists/*

# Install pwsh modules
RUN pwsh -c "Set-PSRepository 'PSGallery' -InstallationPolicy Trusted" \
    && pwsh -c "Install-Module UniversalDashboard.Style" \
    && pwsh -c "Install-Module UniversalDashboard.Charts" \
    && pwsh -c "Install-Module UniversalDashboard.UDPlayer" \
    && pwsh -c "Install-Module UniversalDashboard.UDSpinner" \
    && pwsh -c "Install-Module UniversalDashboard.UDScrollUp" \
    && pwsh -c "Install-Module UniversalDashboard.CodeEditor" \
    && pwsh -c "Install-Module Javinizer"

# Install python modules
RUN pip3 install pillow \
    google_trans_new \
    googletrans==4.0.0rc1

# Clean up
#RUN apt-get purge unzip \
#    wget \
#    && apt-get autoremove


RUN \
	mkdir -p /config && \
	mkdir -p /logs && \
	ln -s /root/.local/share/powershell/Modules/Javinizer/2.4.11/jvSettings.json /config/jvSettings.json && \
	ln -s /root/.local/share/powershell/Modules/Javinizer/2.4.11/jvGenres.csv /config/jvGenres.csv && \
	ln -s /root/.local/share/powershell/Modules/Javinizer/2.4.11/jvTags.csv /config/jvTags.csv && \
	ln -s /root/.local/share/powershell/Modules/Javinizer/2.4.11/jvThumbs.csv /config/jvThumbs.csv && \
	ln -s /root/.local/share/powershell/Modules/Javinizer/2.4.11/jvUncensor.csv /config/jvUncensor.csv && \
	ln -s /root/.local/share/powershell/Modules/Javinizer/2.4.11/jvHistory.csv /logs/jvHistory.csv && \
	ln -s /root/.local/share/powershell/Modules/Javinizer/2.4.11/jvLog.log /logs/jvLog.log

# Add powershell universal environmental variables
ENV Kestrel__Endpoints__HTTP__Url http://*:8600
ENV Data__RepositoryPath ./data/Repository
ENV Data__ConnectionString ./data/database.db
ENV UniversalDashboard__AssetsFolder ./data/UniversalDashboard
ENV Logging__Path ./data/logs/log.txt

EXPOSE 8600
ENTRYPOINT ["/docker-entrypoint.sh"]

# The config directory and logs config location
VOLUME ["/config", "/logs"]